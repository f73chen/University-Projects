int led = 9;
int button = 2;

void setup() {
  pinMode(led, OUTPUT);
  pinMode(13, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  if (digitalRead(button) == LOW) {
    digitalWrite(led, LOW);
    digitalWrite(13, LOW);
    Serial.println("button OFF");
  } else {
    digitalWrite(led, HIGH);
    digitalWrite(13, HIGH);
    Serial.println("button ON");
  }
}
