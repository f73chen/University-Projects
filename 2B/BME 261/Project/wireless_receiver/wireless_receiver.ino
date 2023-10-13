#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>

RF24 radio(9, 10); // CE, CSN
const byte address[6] = "00001";

void setup() {
  Serial.begin(9600);
  radio.begin();
  radio.openReadingPipe(0, address);   //Setting the address at which we will receive the data
  radio.setPALevel(RF24_PA_MIN);       //You can set this as minimum or maximum depending on the distance between the transmitter and receiver.
  radio.startListening();              //This sets the module as receiver
}

void loop(){
  if (radio.available()){              //Looking for the data.
    int curr_time = 0;                 //Saving the incoming data
    radio.read(&curr_time, sizeof(curr_time));    //Reading the data
    Serial.println(curr_time);
  }
  delay(5);
}
