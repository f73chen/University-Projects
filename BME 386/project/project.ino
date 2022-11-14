// Variables for the ultrasound sensor
int triggerPin = 3; // Digital out
int echoPin = 2;    // Digital in
long duration;  // Delay perceived by the sensor
int distance;   // Distance as a function of time

// Variables for the stepper motor
int motorPinA = 8;
int motorPinB = 9;
int motorPinC = 10;
int motorPinD = 11;
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
  pinMode(motorPinA, OUTPUT);
  pinMode(motorPinB, OUTPUT);
  pinMode(motorPinC, OUTPUT);
  pinMode(motorPinD, OUTPUT);
  
  Serial.begin(9600); // Setup serial
 }
 
 void loop() {
//  sendPulse();                        // Send a pulse to the trigger pin
//  duration = pulseIn(echoPin, HIGH);  // Read the input pin
//  distance = duration * 0.034 / 2;    // Multiply by the speed of sound and divide by the bounce
//  printValues(duration, distance);    // Display the calculated values

  turnMotor(PI/2, 2.0);              // Turns the motor PI/2 radians CCW
  turnMotor(-PI/2, 2.0);             // Turns the motor PI/2 radians CW
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
void motorStepCCW(float wait) {
  for (int i = 0; i < 8; i++) {
    digitalWrite(motorPinA, i==7 or i==0 or i==1);
    digitalWrite(motorPinB, i==1 or i==2 or i==3);
    digitalWrite(motorPinC, i==3 or i==4 or i==5);
    digitalWrite(motorPinD, i==5 or i==6 or i==7);
    delay(wait);
  }
}

// Turns the motor by one step clockwise
void motorStepCW(float wait) {
  for (int i = 0; i < 8; i++) {
    digitalWrite(motorPinD, i==7 or i==0 or i==1);
    digitalWrite(motorPinC, i==1 or i==2 or i==3);
    digitalWrite(motorPinB, i==3 or i==4 or i==5);
    digitalWrite(motorPinA, i==5 or i==6 or i==7);
    delay(wait);
  }
}

// Turns the motor x radians
void turnMotor(float rad, float wait) {
  int steps = int(stepsPerRev * rad / (2*PI));
  Serial.print("Turning for: ");
  Serial.println(steps);
  for (int i = 0; i < abs(steps); i++) {
    Serial.println(i);
    if (steps < 0) {
      motorStepCW(wait);
    } else {
      motorStepCCW(wait);
    }
  }
}
