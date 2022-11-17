#include "limits.h"

// Variables for the ultrasound sensor
const int triggerPin = 3; // Digital out
const int echoPin = 2;    // Digital in
long duration;            // Delay perceived by the sensor
float distance;           // Distance as a function of time

// Variables for the stepper motor
const int control1Pin = A1;     // Mode selection
const int control2Pin = A2;     // Confirmation
const float manualTurn = 0.05;  // Manual turning radians (~3 deg)
const float turnDelay = 2.0;    // ms between successive coil activations (higher = slower)
const int motor1PinA = 4;
const int motor1PinB = 5;
const int motor1PinC = 6;
const int motor1PinD = 7;
const int motor2PinA = 8;
const int motor2PinB = 9;
const int motor2PinC = 10;
const int motor2PinD = 11;
const int stepsPerRev = 512;

// Variables for the detection array
const int gridPixels = 5;       // Pixels for hand detection
const float gridWidth = 20;     // (cm)
const float handDistance = 5;   // (cm)
const float pixelWidth = gridWidth / (gridPixels - 1);  // Width of each pixel (cm)
const float halfRadWidth = atan((gridWidth/2) / handDistance);  // Half of the total angular width (rad)
float rowAngle = -halfRadWidth; // Top is negative, gain angle as it goes down
float colAngle = -halfRadWidth; // Left is negative, gain angle as it goes right
float maxDistance = 0;          // Maximum detected distance
float minDistance = INT_MAX;    // Minimum detected distance
float distances[gridPixels][gridPixels];    // Numerical distance
bool binaryDist[gridPixels][gridPixels];    // Binary detection

void setup() {
  // Initialize ultrasound pins
  pinMode(triggerPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Initialize stepper motor pins
  pinMode(control1Pin, INPUT);
  pinMode(control2Pin, INPUT);
  pinMode(motor1PinA, OUTPUT);
  pinMode(motor1PinB, OUTPUT);
  pinMode(motor1PinC, OUTPUT);
  pinMode(motor1PinD, OUTPUT);
  pinMode(motor2PinA, OUTPUT);
  pinMode(motor2PinB, OUTPUT);
  pinMode(motor2PinC, OUTPUT);
  pinMode(motor2PinD, OUTPUT);
  
  Serial.begin(9600); // Setup serial

  // Make sure the sensor points at the starting pixel before data collection
  calibrate();  // Manually adjust the sensor to point at the center
  Serial.println("*** Manual calibrations complete ***");
  turnMotor(1, -halfRadWidth, turnDelay); // Set Motor 1 to the left
  turnMotor(2, -halfRadWidth, turnDelay); // Set Motor 2 to the top
  Serial.println("*** Sensor initialized: READY ***");
 }

 // Assume that both motors are set to the top left and scanning left-right / up-down
 void loop() {
  collect();        // Collect scanned distances (cast to perpendicular coordinates)
  printDistances(); // Print the distances array
  threshold();      // Convert numerical distances to a binary image
  delay(1000000);
 }

// Manually adjust the sensor to point at the center
void calibrate() {
  bool done = false;
  int mode = 0;
  bool pin1 = false;  // Mode selection pressed
  bool pin2 = false;  // Confirmation pressed
  
  sendPulse();                        // Send a pulse to the trigger pin
  duration = pulseIn(echoPin, HIGH);  // Read the input pin
  distance = duration * 0.034 / 2;    // Multiply by the speed of sound and divide by the bounce
  Serial.print("Radial distance: ");  
  Serial.println(distance);           // Radial distance
  
  while (!done) {    
    pin1 = false; // Reset buttons to the unpressed state
    pin2 = false;
    
    Serial.print("Current mode: ");
    switch(mode) {
      case 0: Serial.println("Finish"); break;
      case 1: Serial.println("Turn LEFT"); break;
      case 2: Serial.println("Turn RIGHT"); break;
      case 3: Serial.println("Turn UP"); break;
      case 4: Serial.println("Turn DOWN"); break;
      default: Serial.println("ERROR"); break;
    }
    
    while (!pin1 and !pin2) {   // Exit when at least one button has been pressed
      pin1 = digitalRead(control1Pin);
      pin2 = digitalRead(control2Pin);
    }
    if (pin1) { pin2 = false; } // Prevent both buttons from activating
    
    Serial.print("Button pressed: ");
    Serial.println(1*pin1 + 2*pin2);
    Serial.println();
    
    switch(mode) {
      case 0:
        if (pin1) { mode = 1; }
        if (pin2) { done = true; }
      break;
      case 1:
        if (pin1) { mode = 2; }
        if (pin2) { turnMotor(1, -manualTurn, turnDelay); } // Negative to go left
      break;
      case 2:
        if (pin1) { mode = 3; }
        if (pin2) { turnMotor(1, manualTurn, turnDelay); }  // Positive to go right
      break;
      case 3:
        if (pin1) { mode = 4; }
        if (pin2) { turnMotor(2, -manualTurn, turnDelay); } // Negative to go up
      break;
      case 4:
        if (pin1) { mode = 0; }
        if (pin2) { turnMotor(2, manualTurn, turnDelay); }  // Positive to go down
      break;
    }
    delay(100); // Wait a bit between cycles
  }
  
  sendPulse();                        // Send a pulse to the trigger pin
  duration = pulseIn(echoPin, HIGH);  // Read the input pin
  distance = duration * 0.034 / 2;    // Multiply by the speed of sound and divide by the bounce
  Serial.print("Radial distance: ");  
  Serial.println(distance);           // Radial distance
}

// Collect scanned distances
void collect() {
  for (int i = 0; i < gridPixels; i++) {
    for (int j = 0; j < gridPixels; j++) {
      sendPulse();                          // Send a pulse to the trigger pin
      duration = pulseIn(echoPin, HIGH);    // Read the input pin
      distance = duration * 0.034 / 2;      // Multiply by the speed of sound and divide by the bounce
      float castDistance = distance * cos(rowAngle) * cos(colAngle);  // Cast radial distance to perpendicular distance
      distances[i][j] = castDistance;       // Store the current distance in the array
      printValues(duration, castDistance);  // Display the calculated values
      
      if (castDistance > maxDistance) {     // Set new max distance
        maxDistance = castDistance;
      }
      if (castDistance < minDistance) {     // Set new min distance
        minDistance = castDistance;
      }
      
      if (j != gridPixels - 1) {
        turnMotor(1, angle(j), turnDelay);    // Turn right if not at the last column
        colAngle += angle(j);           // Update column angle
        delay(50);
      }
    }
    turnMotor(1, -2*halfRadWidth, turnDelay); // Return Motor 1 to the left
    colAngle = -halfRadWidth;           // Reset column angle
    delay(100);
    if (i != gridPixels - 1) {
      turnMotor(2, angle(i), turnDelay);        // Turn down if not at the last row
      rowAngle += angle(i);               // Update row angle
      delay(100);
    }
  }
  turnMotor(2, -2*halfRadWidth, turnDelay);     // Return Motor 2 to the top
  rowAngle = -halfRadWidth;               // Reset row angle
}

// Send 1 pulse out of the trigger
void sendPulse() {
  digitalWrite(triggerPin, LOW);  // Turns OFF
  delayMicroseconds(2);           // Wait 2 microseconds
  digitalWrite(triggerPin, HIGH); // Turns ON
  delayMicroseconds(10);          // Wait 10 microseconds
  digitalWrite(triggerPin, LOW);  // Turns OFF
}

// Print ping duration and distance
void printValues(long duration, int distance) {
  Serial.println();
  Serial.print(duration);
  Serial.print("mu-s, ");
  Serial.print(distance);
  Serial.println(" cm");
  delay(200);
}

// Print the distances array
void printDistances() {
  for (int i = 0; i < gridPixels; i++) {
    Serial.print("[");
    for (int j = 0; j < gridPixels; j++) {
      Serial.print(distances[i][j]);
      if (j != gridPixels - 1) {
        Serial.print(", ");
      }
    }
    Serial.println("]");
  }
}

// Prints the binary image
void threshold() {
  float pivot = (minDistance + maxDistance) / 2;
  for (int i = 0; i < gridPixels; i++) {
    for (int j = 0; j < gridPixels; j++) {
      if (distances[i][j] > pivot) {
        binaryDist[i][j] = 0; // Too far away: ignore
        Serial.print("-");
      } else {
        binaryDist[i][j] = 1; // Close enough: record
        Serial.print("#");
      }
    }
    Serial.println();
  }
}

// Calculate the next turning angle in radians (should add up to angularWidth per cycle)
float angle(int i) {
  float initialOffset = gridWidth/2 - pixelWidth * i;
  float nextOffset = initialOffset - pixelWidth;
  return atan(initialOffset / handDistance) - atan(nextOffset / handDistance);
}

// Turns the motor by one step counter-clockwise
void motorStep(float wait, int pinA, int pinB, int pinC, int pinD) {
  for (int i = 0; i < 8; i++) {
    digitalWrite(pinA, i==7 or i==0 or i==1);
    digitalWrite(pinB, i==1 or i==2 or i==3);
    digitalWrite(pinC, i==3 or i==4 or i==5);
    digitalWrite(pinD, i==5 or i==6 or i==7);
    delay(wait);
  }
}

// Turns motor [index] by [x] radians with [wait] ms between actions
// The if statements can be placed within the for loop to make the code shorter but less efficient
void turnMotor(int index, float rad, float wait) {
  int steps = int(stepsPerRev * rad / (2*PI));
  if (index == 1) {
    if (steps > 0) {  // Motor 1, CCW
      Serial.print("Motor 1, CCW for: ");
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor1PinA, motor1PinB, motor1PinC, motor1PinD);
      }
    } else {          // Motor 1, CW
      Serial.print("Motor 1,  CW for: ");
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor1PinD, motor1PinC, motor1PinB, motor1PinA);
      }
    }
  } else {
    if (steps > 0) {  // Motor 2, CCW
      Serial.print("Motor 2, CCW for: ");
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor2PinA, motor2PinB, motor2PinC, motor2PinD);
      }
    } else {          // Motor 2, CW
      Serial.print("Motor 2,  CW for: ");
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor2PinD, motor2PinC, motor2PinB, motor2PinA);
      }
    }
  }
  Serial.println(steps);
}
