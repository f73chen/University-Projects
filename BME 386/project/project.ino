// Variables
int triggerPin = 3; // Digital out
int echoPin = 2;    // Digital in

long duration;  // Delay perceived by the sensor
int distance;   // Distance as a function of time

void setup() {
  pinMode(triggerPin, OUTPUT);
  pinMode(echoPin, INPUT);
  Serial.begin(9600); // Setup serial
 }
 
 void loop() {
  sendPulse();  // Send a pulse from the trigger pin
  duration = pulseIn(echoPin, HIGH); // Read the input pin
  distance = duration * 0.034 / 2;  // Multiply by the speed of sound and divide by the bounce
  printValues(duration, distance);
 }

// Send 1 pulse out of the trigger
void sendPulse() {
  digitalWrite(triggerPin, LOW); // Turns off the signal
  delayMicroseconds(2); // Wait 2 microseconds
  digitalWrite(triggerPin, HIGH); // Turns on the trigger
  delayMicroseconds(10); // Wait 10 microseconds
  digitalWrite(triggerPin, LOW); // Turns off the trigger
}

void printValues(long duration, int distance){
  Serial.print(duration);
  Serial.print("s, ");
  Serial.print(distance);
  Serial.println(" cm");
  delay(200);
}
