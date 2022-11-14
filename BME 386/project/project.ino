// Variables for the ultrasound sensor
int triggerPin = 3; // Digital out
int echoPin = 2;    // Digital in
long duration;  // Delay perceived by the sensor
int distance;   // Distance as a function of time

// Variables for the stepper motor
int motor1PinA = 4;
int motor1PinB = 5;
int motor1PinC = 6;
int motor1PinD = 7;
int motor2PinA = 8;
int motor2PinB = 9;
int motor2PinC = 10;
int motor2PinD = 11;
int stepsPerRev = 512;

// Variables for the detection array
int gridWidth = 20;   // cm
int gridHeight = 20;  // cm
int handDistance = 20;

void setup() {
  // Initialize ultrasound pins
  pinMode(triggerPin, OUTPUT);
  pinMode(echoPin, INPUT);

  // Initialize stepper motor pins
  pinMode(motor1PinA, OUTPUT);
  pinMode(motor1PinB, OUTPUT);
  pinMode(motor1PinC, OUTPUT);
  pinMode(motor1PinD, OUTPUT);
  pinMode(motor2PinA, OUTPUT);
  pinMode(motor2PinB, OUTPUT);
  pinMode(motor2PinC, OUTPUT);
  pinMode(motor2PinD, OUTPUT);
  
  Serial.begin(9600); // Setup serial
 }
 
 void loop() {
//  sendPulse();                        // Send a pulse to the trigger pin
//  duration = pulseIn(echoPin, HIGH);  // Read the input pin
//  distance = duration * 0.034 / 2;    // Multiply by the speed of sound and divide by the bounce
//  printValues(duration, distance);    // Display the calculated values

  turnMotor(1, PI/2, 2.0);              // Turns motor 1 PI/2 radians CCW
  turnMotor(1, -PI/2, 2.0);             // Turns motor 1 PI/2 radians CW
  turnMotor(2, PI/2, 2.0);              // Turns motor 2 PI/2 radians CCW
  turnMotor(2, -PI/2, 2.0);             // Turns motor 2 PI/2 radians CW
  delay(100000);
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
  Serial.print(duration);
  Serial.print("s, ");
  Serial.print(distance);
  Serial.println(" cm");
  delay(200);
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
  Serial.print("Turning for: ");
  Serial.println(steps);
  if (index == 1) {
    if (steps > 0) {  // Motor 1, CCW
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor1PinA, motor1PinB, motor1PinC, motor1PinD);
        Serial.println(i);
      }
    } else {          // Motor 1, CW
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor1PinD, motor1PinC, motor1PinB, motor1PinA);
        Serial.println(i);
      }
    }
  } else {
    if (steps > 0) {  // Motor 2, CCW
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor2PinA, motor2PinB, motor2PinC, motor2PinD);
        Serial.println(i);
      }
    } else {          // Motor 2, CW
      for (int i = 0; i < abs(steps); i++) {
        motorStep(wait, motor2PinD, motor2PinC, motor2PinB, motor2PinA);
        Serial.println(i);
      }
    }
  }
}
