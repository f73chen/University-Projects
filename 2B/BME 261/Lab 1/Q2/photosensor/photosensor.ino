int sensor = A0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  Serial.println(analogRead(sensor));
  delay(100);
}
