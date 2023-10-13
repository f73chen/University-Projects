int input = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  if (Serial.available() > 0) {
    input = Serial.read();

    if (input == 'e'){
      Serial.write('*');
    } else {
      Serial.write(input);
    }
  }
}
