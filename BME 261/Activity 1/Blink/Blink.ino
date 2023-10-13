void setup() {
  pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13, HIGH);
  delay(2000);
  digitalWrite(13, LOW);
  delay(200);
  digitalWrite(13, HIGH);
  delay(500);
  digitalWrite(13, LOW);
  delay(200);
}
