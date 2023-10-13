const int trigPin = 8; //trigger piezo
const int echoPin = A0; // echo piezo
int val = 0; // variable to store the value read

void setup(){

  Serial.begin(9600); // setup serial
  pinMode(trigPin, OUTPUT); // Set buzzer - pin 9 as an output
  Serial.println("New test");

}

void loop(){
 
  tone(trigPin, 1000000); // Send 1MHz sound signal...
  delay(2);        // ...for 1 sec
  noTone(trigPin);     // Stop sound...
  delay(2);
  val = analogRead(echoPin); // read the input pin
  Serial.println(val);
  
}