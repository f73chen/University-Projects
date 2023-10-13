/*
This program is meant to run in conjunction with the sketch on the Arduino. Note that the serial monitor, serial plotter (in the
arduino IDE) or csv file can run at the same time as this program. This program requires the Arduino to be connected via USB in order to function.
The program uses the serial library in processing to read the data being written to the serial port by the Arduino. The program represents
the amount of pressure at each sensor using circles that increase and decrease in size. The centre of pressure is represented with a green
coloured circle which moves around and whose size scales with the total amount of pressure at all sensors. The locations of the pressure sensors are
adjustable by assigning the x and y values to the variable of the corresponding sensor. By pressing "Enter", the program will write all the data received 
in a 2 second window to a text file titled "sensordata.csv". This uses a Java printwriter. Data can be written to the file multiple times by pressing Enter 
more than once. Pressing it twice in less than 2 seconds will cut off the first stream of data. Pressing Enter will delete the previous set of data, so remember 
to save the readings before pressing Enter again.

Pressing ESC will exit the program
*/


import processing.serial.*;    // Importing the serial library to communicate with the Arduino 

//Change the COM port to match the COM from the Arduino code
String portName = "COM4";

Serial myPort;      // Declaring a variable named 'myPort' for serial communication

// Variables to store the force and resistance on each FSR. The numbers correspond with the analog pins on the arduino
float m0, m1, m2, m3, m6, m7;
float r0, r1, r2, r3, r6, r7;

// Variables to store the coordinates of the centre of pressure, total mass, and total resistance at all of the sensors
float x;
float y;
float totalM;
float totalR;

// Use the following section to change the x coordinate of the sensors. Initialize sensor chosen as origin to 0. 
// Current values are in cm. Make values negative if to the left of the origin.
float A0x = 0;
float A1x = -4;
float A2x = -3;
float A3x = -3;
float A6x = -3;
float A7x = 3.5;

// Use the following section to change the y coordinate of the sensors. Initialize sensor chosen as origin to 0. 
// Values should not be negative, as the origin is the bottom most point.
float A0y = 0;
float A1y = 23.5;
float A2y = 22;
float A3y = 17;
float A6y = 15;
float A7y = 0;


// Arrays to store the x and y coordinates.
float[] widthValues = { A0x, A1x, A2x, A3x, A6x, A7x};
float[] lengthValues = { A0y, A1y, A2y, A3y, A6y, A7y};

//Change these values to ajust the size of circles in pop-up window
float sensor_factor = 5;
float centre_factor = 2;

// Variables to store the max distance between two sensors in the x and y direction.
// These variables will be used to calculate the width to height ratio for the display.
float maxWidth = max( widthValues ) - min( widthValues );
float maxLength = max( lengthValues ) - min( lengthValues );

PrintWriter output;// Initializing a printwriter to write to a csv file

/* 
 * Setup the visualization window
 */
void setup ( ) {
  
  myPort  =  new Serial (this, portName,  9600); // Set the com port and the baud rate according to the Arduino IDE. Change the COM to match each time!
  
  output = createWriter("sensordata.csv"); // Sets the printwriter up to write to a file titled "sensordata.csv"

  size(800, 1000); // Size of the initial serial window
  background(0,0,0); // Sets the background color of the window
  surface.setResizable(true); // Allows user to change size of window
  
  output.println("m0" + "," + "m1" + "," + "m2" + "," + "m3" + "," + "m6" + "," + "m7" + "," + "x" + "," + "y" + "," + "totalM"); 
  
  myPort.bufferUntil ( '\n' ); // Receives the data from the Arduino IDE

}

/*
 * Draws the circles to represent each sensor. The circle gets bigger the more pressure there is
 * The coordinates are determined by the coordinates of the actual sensors on the prototype. They should change when the sensor placement changes.
 * Ensure the sensor selected as the origin is the bottom most sensor. No other sensor should be below it.
 */
void draw(){
  
    //println(width,height); // Uncomment this line to check window dimensions for the display window, they will appear in the console below.
    
    // Variables to store the value of the container coorinates will be scaled to 
    // Offsets both the width and height to create a border of 200 pixels.
    float mappedWidth = width - 200;
    float mappedHeight = height - 200;
    
    //println(mappedWidth, mappedHeight); // Uncomment this line to check if properly bordered 
  
    // None of the shapes drawn will hava an outer stroke
    noStroke();
    
    // Resets the window to the background color and setting the dimensions.
    fill(0,0,0);
    rect(0,0,width,height);    
    
    // Updates the mapped height or width to remain consistent with the window size and the sensor placement ratio.
    if (height >= maxLength * width/maxWidth) mappedHeight = maxLength*mappedWidth/maxWidth; // Uses mappedwidth as guideline to update mapped height
    else mappedWidth = maxWidth*mappedHeight/maxLength;                                      // Uses mappedheight as guideline to update mapped width.  
     
    fill(255,255,255);  
    
    // Pixels are counted from left to right and top to bottom (reverse y direction means subtracting pixels will raise the display)
    // x coordinate starts half way and is adjusted by the scaling factor from cm to pixels.
    // y coordinate starts at 100 pixels from the bottom and is adjusted by the scaling factor.
    // Change the multiplier of r# (last two entries) to increase or decrease the size of the circles.
    ellipse(int(width/2 + (A6x/maxWidth) * mappedWidth), int(height - 100 - A6y/maxLength * mappedHeight), m6 * sensor_factor, m6 * sensor_factor);
                                                                                                                                    
    ellipse(int(width/2 + (A7x/maxWidth) * mappedWidth), int(height - 100 - A7y/maxLength * mappedHeight), m7 * sensor_factor, m7 * sensor_factor); 
 
    ellipse(int(width/2 + (A0x/maxWidth) * mappedWidth), int(height - 100 - A0y/maxLength * mappedHeight), m0 * sensor_factor, m0 * sensor_factor);
  
    ellipse(int(width/2 + (A2x/maxWidth) * mappedWidth), int(height - 100 - A2y/maxLength * mappedHeight), m2 * sensor_factor, m2 * sensor_factor);
    
    ellipse(int(width/2 + (A3x/maxWidth) * mappedWidth), int(height - 100 - A3y/maxLength * mappedHeight), m3 * sensor_factor, m3 * sensor_factor);
   
    ellipse(int(width/2 + (A1x/maxWidth) * mappedWidth), int(height - 100 - A1y/maxLength * mappedHeight), m1 * sensor_factor, m1 * sensor_factor);
    
    // Draws the circle to represent the centre of pressure.
    fill(10, 200, 75, 200);
    
    // Change the multiplier of totalR to increase or decrease the size of the circles.
    ellipse(int((width/2) + x*(mappedWidth/maxWidth)), int((height - 100) - y*(mappedHeight/maxLength)), totalM * centre_factor, totalM * centre_factor ); 
}

/*
 * Recieves data from serial monitor 
 */
void serialEvent(Serial myPort){
   
  String val = myPort.readStringUntil('\n'); // Reads a line serial printed by the arduino

  float[] values = float(val.split(" ")); // Splits up the string into an array so it's data can be parsed for each value

  //Assigning resistance values read by the Arduino to the corresponding variable
  r0 = values[0];
  r1 = values[1];
  r2 = values[2];
  r3 = values[3];
  r6 = values[4];
  r7 = values[5];
  x = values[6];
  y = values[7];
  totalR = values[8];
  
  //Prints readings to console below 
  for (int i = 0; i < 9; i++) {
    print(values[i] + " ");
  }
  println();
  
  // Replace each resistance with your conversion equation here. 
  m0 = r0;
  m1 = r1;
  m2 = r2;
  m3 = r3;
  m6 = r6;
  m7 = r7;
  totalM = totalR;
  
  // Writes data to csv file
  output.println(m0 + "," + m1 + "," + m2 + "," + m3 + "," + m6 + "," + m7 + "," + x + "," + y + "," + totalM); 
  output.flush();
}

void keyPressed (){
 
 if (key == ENTER){
   output.close();
   exit();
 }
}
