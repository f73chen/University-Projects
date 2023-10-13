//This program uses the timerInterrupt library for SAMD based boards https://github.com/khoih-prog/SAMD_TimerInterrupt
/*
This program reads the voltage of it's analog pins attached to pressure sensors. It works based off of timer interrupts. Every 10 milliseconds,
an interrupt service routine is triggered in which new data is read from the sensors. This data is then serial printed. Printing occurs only if 
the data is new and had just been read from the sensors. The centre of pressure is also calculated from the sensor data. The x and y coordinates 
of each sensor will need to be initialized by the user.
*/



//These preprocessor directives must be placed here before the #includes. I don't know what they do.
#define TIMER_INTERRUPT_DEBUG         0
#define _TIMERINTERRUPT_LOGLEVEL_     0

#include <SAMDTimerInterrupt.h>
#include <SAMD_ISR_Timer.h>
#include "math.h"

//Used to store the x-coordinate of each sensor. Initialize the sensor chosen as the origin to 0. Current values are in cm.
const float A0x = 3;    // Green
const float A1x = -4; 
const float A2x = 1;    // White
const float A3x = -3;
const float A6x = -2;   // Black
const float A7x = 3.5;

//Used to store the y-coordinate of each sensor. Initialize the sensor chosen as the origin to 0. Current values are in cm.
const float A0y = 13;    // Green
const float A1y = 23.5;
const float A2y = 21;    // White
const float A3y = 17;
const float A6y = 24;   // Black
const float A7y = 0;

const int noiseFactor = 25;//Any resistance reading above the noise factor will be outputted as 0
const float VCC = 4.5; // Voltage Source
const float R1 = 1000; // Resistor value in voltage divider with FSR

//This variable is set to true once new data is read inside the interrupt routine. The data will only be serial printed if it's set to true
volatile bool newData = false;

//Used to store the values read from the analog pins connected to the sensors. Initialized to 1 so the program doesn't divide by 0 when calculating centre of pressure.
volatile float v0 = 1;
volatile float v1 = 1;
volatile float v2 = 1;
volatile float v3 = 1;
volatile float v6 = 1;
volatile float v7 = 1;


SAMDTimer ITimer(TIMER_TC3);

//Interrupt routine
void TimerHandler()
{
  //Inside the loop, the data will only be serial printed if this is true
  newData = true;

  //reading the data from the analog pins connected to the sensors.
  //The value is given as a number from 0 to 1023 and the arduino has an input voltage of 4.5V
  //The value stored in the variable therefore corresponds to the voltage received.
  v0 = max(analogRead(A0) * (VCC/1023.0), 0.0001);
  v1 = max(analogRead(A1) * (VCC/1023.0), 0.0001);
  v2 = max(analogRead(A2) * (VCC/1023.0), 0.0001);
  v3 = max(analogRead(A3) * (VCC/1023.0), 0.0001);
  v6 = max(analogRead(A6) * (VCC/1023.0), 0.0001);
  v7 = max(analogRead(A7) * (VCC/1023.0), 0.0001);
  
}


/*
 * Setup the Serial Monitor and Interrupt Sequence
 */
void setup() {

  //Setting a timer interrupt for 10 000 microseconds (100 HZ) using the TimerHandler routine
  ITimer.attachInterruptInterval(10000, TimerHandler );
  
  Serial.begin(9600);    
  while (!Serial);

  
  //Turning on the orange light on the arduino
  pinMode(LED_BUILTIN, OUTPUT);

  digitalWrite(LED_BUILTIN, HIGH);
  
}

void loop() {

      //NewData is only ever set to true in the interrupt routine
      if (newData) {

          /*
           * Use voltage divider equation to calculate the FSR resistance using voltage as dependant variable.
           */
          float rfsr_0 = (R1 * VCC - v0 * R1) / (1000 * v0);          
          float rfsr_1 = (R1 * VCC - v1 * R1) / (1000 * v1);         
          float rfsr_2 = (R1 * VCC - v2 * R1) / (1000 * v2);          
          float rfsr_3 = (R1 * VCC - v3 * R1) / (1000 * v3);          
          float rfsr_6 = (R1 * VCC - v6 * R1) / (1000 * v6);
          float rfsr_7 = (R1 * VCC - v7 * R1) / (1000 * v7);
          
          //Adjust the noiseFactor variable on line 35 to change threashold that is considered noise.
          if (rfsr_0 > noiseFactor) rfsr_0 = 0;
          if (rfsr_1 > noiseFactor) rfsr_1 = 0;
          if (rfsr_2 > noiseFactor) rfsr_2 = 0;
          if (rfsr_3 > noiseFactor) rfsr_3 = 0;
          if (rfsr_6 > noiseFactor) rfsr_6 = 0;
          if (rfsr_7 > noiseFactor) rfsr_7 = 0;
          
          /*
           * If you want to output mass to the serial monitor, use the following section to convert resistance to mass by entering your equation.
           */
          float m0 = rfsr_0;
          float m1 = rfsr_1;
          float m2 = rfsr_2;
          float m3 = rfsr_3;
          float m6 = rfsr_6;
          float m7 = rfsr_7;
          
          //The total resistance at the analog pins. Used to calculate the centre of pressure and as a measure of the magnitude of the force on the sensors.
          float totalM = (m0 + m1 + m2 + m3 + m6 + m7);

          //Calculating the x and y coordinates of the centre of pressure. Max is used to prevent dividing by 0 when none of the sensors are pressed down
          float x = (m0*A0x + m1*A1x + m2*A2x + m3*A3x + m6*A6x + m7*A7x)/(max(totalM, 0.01));
          
          float y = (m0*A0y + m1*A1y + m2*A2y + m3*A3y + m6*A6y + m7*A7y)/(max(totalM, 0.01)); 

                 
          //Serial printing. This is read by the processing program
          Serial.println(String(m0) + " " + String(m1) + " " + String(m2) + " " + String(m3) + " " + String(m6) + " " + String(m7) + " " + String(x) + " " + String(y)+ " " + String(totalM) );
      
        //NewData is set to false. The loop wont serial print again until another interrupt occurs in 10 milliseconds
        newData = false;
      }     
}
