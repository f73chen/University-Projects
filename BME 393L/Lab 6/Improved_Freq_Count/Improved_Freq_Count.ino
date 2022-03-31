const int switchPin = 2;  // Input pin
long startTime = 0;       // The first value returned from millis
long duration;            // Duration in ticks
float period;             // Duration in seconds
float scaledPeriod;       // The scaled period due to timer clock changes
float frequency;          // The calculated frequency in Hz
int val = 1;              // Input state
int lastVal = 1;          // Default state is high


void setup() {
  Serial.begin(9600);
  pinMode(switchPin, INPUT);  // Set the input pin as an input
  TCCR0B = ( _BV(CS02) | _BV(CS00));/* Writes to Timer0 register to change it's clock rate
                                        this would sets bit CS02 and CS00 to 1 so timer clock = clkIO/1024 see "_BV Explained.pdf" on LEARN*/
}

void loop() {
  val = digitalRead(switchPin); // Read pin state
  
  if (val != lastVal) {
    lastVal = val;
    if (val == LOW) { // Falling edge
      duration = millis() - startTime;
      period = float(duration) / 1000;
      scaledPeriod = 
      frequency = 1 / period;
      Serial.print(" Frequency is = ");
      Serial.println(frequency);
      startTime = millis();
    }
  }
}
