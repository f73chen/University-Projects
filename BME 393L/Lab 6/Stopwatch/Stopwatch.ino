const int switchPin = 2;  // Input pin number
long startTime;
long duration;            // Duration in ticks
float secDuration;        // Duration in seconds
int debounce = 5;             // ms to wait for debouncing
int val = 1;
int lastVal = 1;          // Default state is unpressed

void setup()
{
  Serial.begin(9600); 
  pinMode(switchPin, INPUT);  // Set the input pin as an input
}

void loop()
{
  val = digitalRead(switchPin); // Read pin state

  if (val != lastVal) {
    delay(debounce); // Debounce
    lastVal = val;
    if (val == LOW) { // Falling edge
      Serial.println("Button pushed");
      startTime = millis();
    }
    if (val == HIGH) {  // Rising edge
      duration = millis() - startTime;
      secDuration = float(duration + debounce) / 1000;
      Serial.print("Button released after "); // print out your results
      Serial.print(secDuration);
      Serial.println(" seconds");
    }
  }
}
