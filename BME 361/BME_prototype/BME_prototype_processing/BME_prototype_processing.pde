/*
This program is meant to run in conjunction with the sketch on the Arduino. Note that neither the serial monitor nor the serial plotter (in the
arduino IDE) can run at the same time as this program. This program requires the Arduino to be connected via USB in order to function.
The program uses the serial library in processing to read the data being written to the serial port by the Arduino. The program represents
the amount of pressure at each sensor using circles that increase and decrease in size. The centre of pressure is represented with a green
coloured circle which moves around and whose size scales with the total amount of pressure at all sensors. The locations of the pressure sensors are
adjustable by assigning the x and y values to the variable of the corresponding sensor. By pressing "Enter", the program will write all the data received 
in a 2 second window to a text file titled "sensordata.txt". This uses a Java printwriter. Data can be written to the file multiple times by pressing Enter 
more than once. Pressing it twice in less than 2 seconds will cut off the first stream of data. Pressing Enter will delete the previous set of data, so remember 
to save the readings before pressing Enter again.

Pressing ESC will exit the program
*/


import processing.serial.*;    // Importing the serial library to communicate with the Arduino 

Serial myPort;      // Declaring a variable named 'myPort' for serial communication
Table rTable;       // Declaring a table named 'rTable' to read in and store values from serial monitor 
String fileName;    // Declaring a variable named filename to store name of file being written to

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
float A0x = 0;    // Green
float A1x = -4;
float A2x = -1;    // White
float A3x = -3;
float A6x = 4;    // Yellow
float A7x = 3.5;

// Use the following section to change the y coordinate of the sensors. Initialize sensor chosen as origin to 0. 
// Values should not be negative, as the origin is the bottom most point.
float A0y = 5;    // Green
float A1y = 23.5;
float A2y = 19;    // White
float A3y = 17;
float A6y = 18;    // Yellow
float A7y = 0;

//Coefficient
float a0;
float a1;

// Arrays to store the x and y coordinates.
float[] widthValues = { A0x, A1x, A2x, A3x, A6x, A7x};
float[] lengthValues = { A0y, A1y, A2y, A3y, A6y, A7y};

// Variables to store the max distance between two sensors in the x and y direction.
// These variables will be used to calculate the width to height ratio for the display.
float maxWidth = max( widthValues ) - min( widthValues );
float maxLength = max( lengthValues ) - min( lengthValues );

PrintWriter output;// Initializing a printwriter to write to a csv file

int dataPrinted = 200; // Variable is used to count how many times data was written to the file.
                       // The program will not write to the file if this variable is 200 or more
                       // At 100 Hertz, the program will print 200 times in 2 seconds
/* 
 * Setup the table and visualization window
 */
void setup ( ) {
  
  myPort  =  new Serial (this, "COM5",  9600); // Set the com port and the baud rate according to the Arduino IDE. Change the COM to match each time!
  
  //output = createWriter("sensordata.csv"); // Sets the printwriter up to write to a file titled "sensordata.csv"

  size(800, 1000); // Size of the initial serial window
  background(0,0,0); // Sets the background color of the window
  surface.setResizable(true); // Allows user to change size of window
  
  myPort.bufferUntil ( '\n' ); // Receives the data from the Arduino IDE
  
  rTable = new Table();
  rTable.addColumn("id");
  rTable.addColumn("r0");
  rTable.addColumn("r1");
  rTable.addColumn("r2");
  rTable.addColumn("r3");
  rTable.addColumn("r6");
  rTable.addColumn("r7");
  rTable.addColumn("x");
  rTable.addColumn("y");
  rTable.addColumn("TotalR");

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
    ellipse(int(width/2 + (A6x/maxWidth) * mappedWidth), int(height - 100 - A6y/maxLength * mappedHeight), m6 * 0.005, m6 * 0.005);
                                                                                                                                    
    ellipse(int(width/2 + (A7x/maxWidth) * mappedWidth), int(height - 100 - A7y/maxLength * mappedHeight), m7 * 0.005, m7 * 0.005); 
 
    ellipse(int(width/2 + (A0x/maxWidth) * mappedWidth), int(height - 100 - A0y/maxLength * mappedHeight), m0 * 0.005, m0 * 0.005);
  
    ellipse(int(width/2 + (A2x/maxWidth) * mappedWidth), int(height - 100 - A2y/maxLength * mappedHeight), m2 * 0.005, m2 * 0.005);
    
    ellipse(int(width/2 + (A3x/maxWidth) * mappedWidth), int(height - 100 - A3y/maxLength * mappedHeight), m3 * 0.005, m3 * 0.005);
   
    ellipse(int(width/2 + (A1x/maxWidth) * mappedWidth), int(height - 100 - A1y/maxLength * mappedHeight), m1 * 0.005, m1 * 0.005);
    
    // Draws the circle to represent the centre of pressure.
    fill(10, 200, 75, 200);
    
    // Changes the multiplier of totalR to increase or decrease the size of the circles.
    ellipse(int((width/2) + x*(mappedWidth/maxWidth)), int((height - 100) - y*(mappedHeight/maxLength)), totalM*0.0025, totalM*0.0025 ); 
}

/*
 * Recieves data from serial monitor 
 */
void serialEvent(Serial myPort){
   
  String val = myPort.readStringUntil('\n'); // Reads a line serial printed by the arduino

  float[] values = float(val.split(" ")); // Splits up the string into an array so it's data can be parsed for each value
  
  TableRow newRow = rTable.addRow(); 

  r0 = values[0];
  r1 = values[1];
  r2 = values[2];
  r3 = values[3];
  r6 = values[4];
  r7 = values[5];
  x = values[6];
  y = values[7];
  totalR = values[8];
  
  // Input your resistance to mass conversion equation here. 
  m0 = r0;
  m1 = r1;
  m2 = r2;
  m3 = r3;
  m6 = r6;
  m7 = r7;
  totalM = totalR;
  
  
  // dataPrinted is initialized to 200 and is set to 0 by pressing enter
  if (dataPrinted < 200) {
    
      newRow.setInt("id", dataPrinted);
      newRow.setFloat("r0", r0);
      newRow.setFloat("r1", r1);
      newRow.setFloat("r2", r2);
      newRow.setFloat("r3", r3);
      newRow.setFloat("r6", r6);
      newRow.setFloat("r7", r7);
      newRow.setFloat("x", x);
      newRow.setFloat("y", y);
      newRow.setFloat("rTotal", totalR);
      
      dataPrinted++;
      //output.println(dataPrinted + ": " + val); // Writes data to csv file
      //output.flush();
  }

}

void keyPressed (){
 
 //Sets dataPrinted to 0, allowing the program to write 200 more sets of data to the file
 if (key == ENTER){
   dataPrinted = 0;
   fileName = "sensor.csv";
   saveTable(rTable, fileName);
   //output.println(" ");
   //output.close(); //Finishes file 
   //exit(); //Stops program
 }
}
