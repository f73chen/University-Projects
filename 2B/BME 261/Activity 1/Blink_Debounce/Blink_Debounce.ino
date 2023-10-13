int led = 9;
int button = 2;
boolean lastButton = LOW;
boolean currentButton = LOW;
boolean ledOn = false;

void setup() {
  pinMode(led, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  currentButton = debounce(lastButton);

  if (lastButton == LOW && currentButton == HIGH) {
    ledOn = !ledOn;
    Serial.println("Toggled");
  }
  lastButton = currentButton;
  digitalWrite(led, ledOn);
}

boolean debounce(boolean last) {
  boolean current = digitalRead(button);
  if (last != current) {
    delay(5);
    current = digitalRead(button);
  }
  return current;
}
