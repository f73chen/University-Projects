const int echoPin = A0;
const int triggerPin = 3;
const int ledPin = 13;
const int knockThreshold = 100;

float val = 0;
float duration = 0;
int ledState = LOW;

void setup() {
  pinMode(echoPin, INPUT);
  pinMode(triggerPin, OUTPUT);
  pinMode(ledPin, OUTPUT);
  
  Serial.begin(9600); // Setup serial
}

void loop() {
//  digitalWrite(triggerPin, LOW);
//  delayMicroseconds(2);
//  digitalWrite(triggerPin, HIGH);
//  delayMicroseconds(10);
//  digitalWrite(triggerPin, LOW);

//  tone(triggerPin, 12000); // Send 1KHz sound signal...
//  delay(500);        // ...for 1 sec
//  noTone(triggerPin);     // Stop sound...
//  delay(1000);        // ...for 1sec
  
  val = analogRead(echoPin);
  duration = pulseIn(echoPin, HIGH);
  Serial.println(val);
  Serial.println(duration);
  Serial.println();
//  if (reading > knockThreshold) {
//    ledState = !ledState;
//    digitalWrite(ledPin, ledState);
//    Serial.println("KNOCK");
//  }

  delay(1000);
}
