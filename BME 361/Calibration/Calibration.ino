#include "math.h"

//Change the pin to the sensor you are testing.
const int analogPin = A0;


const int avgSize = 10;
const float R0 = 1000.0;
const float Vcc = 4.5;

#define MSG_LENGTH 10

/**
 * Setup the Arudino and Serial
 */
void setup() {
  Serial.begin(9600);
  while (!Serial);
}

void loop() {
  float sumVal = 0.0;
  float rfsr; 
  float mass = 0;


  /*
   * User input mass from Serial Window
   */
  while (mass < 1){
    Serial.println("Please enter the mass you are testing in grams.");
    while (Serial.available() < 1);
    //delay(3000); 
    while (Serial.available() > 0) {
      static char msg[MSG_LENGTH];
      static unsigned int msg_pos = 0;

      char temp = Serial.read();

      //Read Serial Input
      if(temp != '\n') {
          msg[msg_pos] = temp;
          msg_pos++;     
      } else {
          msg[msg_pos] = '\0';
          msg_pos = 0;
          mass = 1.0 * atoi(msg);
      }
    }
    Serial.print("Mass inputted: ");
    Serial.print(mass);
    Serial.print("g");
    Serial.println();

    //delay(3000);
  }

  /*
   * Confirm with user if weight has been placed on Sensor, waiting for input to continue.
   */
  // Check if weight is on the sensor
  Serial.println("Please place weight on the sensor then press enter to continue");
  while(!Serial.available());
  while(Serial.available() > 0){
    char temp = Serial.read();
  }


  /*
   * Data is read in from the sensors at 500 tick increments, then averaged.
   */
  Serial.println("Please wait a few seconds for data to load...");
  // Read voltage from the sensor
  for(int i = 0; i < avgSize; i++){
    delay(500);
    sumVal+=(analogRead(analogPin))*(Vcc/1023.0);
  }
  
  sumVal /= avgSize;

  //Calculates the FSR resistnace derived from voltage divider equation (converted to kohms from ohms)
  rfsr = (R0/1000.0)*((Vcc/sumVal)-1.0); 

  Serial.print("Resistance: ");
  Serial.print(rfsr);
  Serial.print("kohms\n");
  Serial.println();
  delay(100);
}
