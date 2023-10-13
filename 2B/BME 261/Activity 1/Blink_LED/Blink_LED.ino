int led = 9;
int brightness = 0;
int change = 5;

void setup() {
  pinMode(led, OUTPUT);
}

void loop() {
  analogWrite(led, brightness);
  brightness = brightness + change;

  if (brightness == 0 || brightness == 255) {
    change = -change;
  }
  delay(30);
}
