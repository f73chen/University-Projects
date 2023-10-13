int analogPin = A0;
int ledPin = 9;

int val = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  val = analogRead(analogPin);
  val = map(val, 0, 1023, 0, 255);
  Serial.println(val);
  analogWrite(ledPin, val);
}
