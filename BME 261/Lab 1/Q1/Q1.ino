int reds = 6;
int green1 = 10;
int green2 = 11;

int button = 2;

void setup() {
  pinMode(reds, OUTPUT);
  pinMode(green1, OUTPUT);
  pinMode(green2, OUTPUT);
}

void loop() {
  cycle(green1, reds);
  cycle(green2, reds);
}

void cycle(int green, int reds){
  // Reset button status to off
  boolean buttonPressed = LOW;
  int totalTime = 15000;
  
  for (int i = totalTime; i > 0; i-=5){
    if (i > 5000) { analogWrite(green, 255); }                  // Normal phase
    else if (i > 0){ analogWrite(green, int(255*(i/5000.0))); } // Ending phase
    delay(5);

    // Can only be activated if button not already pressed this round
    if (buttonPressed == LOW && digitalRead(button) == HIGH) {
      buttonPressed = HIGH;
      i -= 5000;
      if (i <= 0) { analogWrite(green, 0); }
    }
  }
  analogWrite(reds, 255);
  delay(3000);
  analogWrite(reds, 0);  
}
