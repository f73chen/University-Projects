int input = 0;
int led = 13;

void setup() {
  pinMode(led, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    input = Serial.read();

    if (input == '+'){
      Serial.write("Turn LED on\n");
      analogWrite(led, 255);
    } 
    if (input == '-') {
      Serial.write("Turn LED off\n");
      analogWrite(led, 0);
    }
  }
}
