const int switchPin = 2; // the number of the input pin
long startTime; // store starting time here
long duration; // variable to store how long the timer has been running
float secduration; // variable to store the duration in seconds

void setup()
{
Set the input pin as an input
Serial.begin(9600); //this will allow the Uno to comunicate with the serial monitor
}

void loop()
{
Read start state from pin
Serial.println("Button pushed"); // this will print to the serial monitor
startTime = millis(); // stores the number of millisceoncds since the Uno was last reset. See http://arduino.cc/en/Reference/millis
Read or Wait for a change in state of the input pin.  
duration = the time difference between the two states of the input pin (start of the program until you wish to stop the stopwatch)
secduration=(float)duration / (how many milliseconds in a second?) ; /* convert the integer value for the time differnce into a 
                                                    floating variable before calculating time lapsed in seconds keeps precision */
Serial.print("Button released after "); // print out your results
Serial.print(secduration);
Serial.println(" seconds");

}


