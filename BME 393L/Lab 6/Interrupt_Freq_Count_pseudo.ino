const int inPin = 2; //this pin receiving the signal to be measured
volatile int rising_edge_counter = 0; //stores the number of rising edges of the incoming signal (increamented by interrupt)
volatile int start_count = 0;
volatile int end_count = 0;
long counter_freq;
float period;
long startcount; //stores Timer0 count value at the first rising edge
long duration; // stores the difference in Timer0 counts between the first and second rising edges
float frequency; //stores the calculated frequency of the incoming signal

void setup()
{
  Setup input pin to measure incoming signal
//  TCCR0B = (_BV(CS02) | _BV(CS00)); //Set Timer0 prescaling factor
  counter_freq = 16e6/64; //Calculate actual counter frequency 16Mhz/prescale factor
  Serial.begin(9600);
  attachInterrupt(0, NAME YOUR HANDLER ROUTINE HERE, RISING); // interrupt 0 is mapped to pin 2 on the Uno, measure rising edges only
}

void loop()
{
  Let the program count at least 11 clycles of the incoming signal (use rising_edge_counter to keep track) before you calculate frequency 
  Check to make sure that the second count measurement is bigger than the first (end_count vs. start_count), if it is:
  calculate the number of Timer0 clocks between the first and second rising edges of the incoming signal
  calculate the period of the incoming signal (you have the number of clocks between rising edges and the frequency of Timer0)
  calculate the incoming signals frequency and print it.
  reset the count (rising_edge_counter) of the incoming signal


void YOUR HANDLER ROUTINE HERE()
{
  If this is the first rising edge of the incoming signal record the count of Timer0, register (TCNT0) - start time
  If this is the second rising edge of the incoming signal record the count of Timer0, register (TCNT0) - end time
 
  increase the count of how many rising edges have occurred
}