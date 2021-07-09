int speakerPin = 8;
int chance = 360;   // 10 times in 1 hour; each time is 1 second

void setup() {
  Serial.begin(9600);
}

void loop() {
  int num = random(chance);       // Random number between 0 and 360
  if (chance == 0){
    // Args: pin#, frequency, duration
    tone(speakerPin, 1000, 1000); // Play the sound for 1s
    Serial.println(millis());     // Print the current time
  }
  delay(1000);                    // Run the next loop in 1s
}
