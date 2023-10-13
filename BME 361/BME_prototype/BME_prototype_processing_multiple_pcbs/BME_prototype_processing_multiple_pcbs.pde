/*
This program is meant to run in conjunction with the sketch on the Arduino. Note that the serial monitor, serial plotter (in the
 arduino IDE) or csv file can run at the same time as this program. This program requires the Arduino to be connected via USB in order to function.
 The program uses the serial library in processing to read the data being written to the serial port by the Arduino. This program is used to read from two Arduinos
 at the same time. Both prototype sketches must be open but not running for each COM. The program represents the amount of pressure at each sensor using circles that increase and
 decrease in size. The centre of pressure is represented with a green coloured circle which moves around and whose size scales with the total amount of pressure at all
 sensors. The locations of the pressure sensors are adjustable by assigning the x and y values to the variable of the corresponding sensor. By pressing "Enter", the
 program will write all the data received in a 2 second window to a text file titled "sensordata.csv". This uses a Java printwriter. Data can be written to the file
 multiple times by pressing Enter more than once. Pressing it twice in less than 2 seconds will cut off the first stream of data. Pressing Enter will delete the
 previous set of data, so remember to save the readings before pressing Enter again.
 
 Pressing Enter will exit the program
 */


import processing.serial.*;    // Importing the serial library to communicate with the Arduino

//Change the COM port to match the COM from both of the Arduino codes
String port_1_name = "COM5";
String port_2_name = "COM10";

// Declaring a variable named 'myPort' for serial communication
Serial port_1;
Serial port_2;

// Variables to store the force and resistance on each FSR. The numbers correspond with the analog pins on the arduino
// Arduino 1
float m0_1, m1_1, m2_1, m3_1, m6_1, m7_1;
float r0_1, r1_1, r2_1, r3_1, r6_1, r7_1;

// Arduino 2
float m0_2, m1_2, m2_2, m3_2, m6_2, m7_2;
float r0_2, r1_2, r2_2, r3_2, r6_2, r7_2;

// Variables to store the coordinates of the centre of pressure, total mass, and total resistance at all of the sensors
// Arduino 1
float x_1;
float y_1;
float totalM_1;
float totalR_1;

//Arduino 2
float x_2;
float y_2;
float totalM_2;
float totalR_2;

boolean p1_out = false;
boolean p2_out = false;

// Variables to store the coordinates of the center of pressure from the combined data of both Arduinos
float x = 0;
float y = 0;
float totalM = 0;

// Use the following section to change the x and y coordinate of the sensors on Arduino 1. Initialize sensor chosen as origin to 0.
// Current values are in cm. Make values negative if to the left of the origin. Y coordinate values should not be negative as the origin is the bottom most point.
float A0x_1 = 0;    // Green
float A1x_1 = -4;
float A2x_1 = -1;   // White
float A3x_1 = -3;
float A6x_1 = 4;   // Yellow
float A7x_1 = 3.5;

float A0y_1 = 0;    // Green
float A1y_1 = 23.5;
float A2y_1 = 14;   // White
float A3y_1 = 17;
float A6y_1 = 13;   // Yellow
float A7y_1 = 0;

// Use the following section to change the x and y coordinate of the sensors on Arduino 2. Initialize sensor chosen as origin to 0.
// Current values are in cm. Make values negative if to the left of the origin. Y coordinate values should not be negative as the origin is the bottom most point.
float A0x_2 = 3;    // Green2
float A1x_2 = -4;
float A2x_2 = 1;    // White2
float A3x_2 = -3;
float A6x_2 = -2;   // Black
float A7x_2 = 3.5;

float A0y_2 = 8;    // Green2
float A1y_2 = 23.5;
float A2y_2 = 16;   // White2
float A3y_2 = 17;
float A6y_2 = 19;   // Black
float A7y_2 = 0;

// Arrays to store the x and y coordinates.
float[] widthValues = { A0x_1, A1x_1, A2x_1, A3x_1, A6x_1, A7x_1, A0x_2, A1x_2, A2x_2, A3x_2, A6x_2, A7x_2};
float[] lengthValues = { A0y_1, A1y_1, A2y_1, A3y_1, A6y_1, A7y_1, A0y_2, A1y_2, A2y_2, A3y_2, A6y_2, A7y_2};

//Change these values to adjust to size of circles in pop-up window 
float sensor_factor = 50;
float centre_factor = 20;

// Variables to store the max distance between two sensors in the x and y direction.
// These variables will be used to calculate the width to height ratio for the display.
float maxWidth = max( widthValues ) - min( widthValues );
float maxLength = max( lengthValues ) - min( lengthValues );

PrintWriter output;// Initializing a printwriter to write to a csv file

/*
 * Setup the table and visualization window
 */
void setup ( ) {

  port_1  =  new Serial (this, port_1_name, 9600);
  port_2 = new Serial (this, port_2_name, 9600);

  output = createWriter("sensordata.csv"); // Sets the printwriter up to write to a file titled "sensordata.csv"

  size(800, 1000); // Size of the initial serial window
  background(0, 0, 0); // Sets the background color of the window
  surface.setResizable(true); // Allows user to change size of window

  output.println("r0_1" + "," + "r1_1" + "," + "r2_1" + "," + "r3_1" + "," + "r6_1" + "," + "r7_1" + "," + "x_1" + "," + "y_1" + "," + "totalR_1" + "," + "r0_2" + "," + "r1_2" + "," + "r2_2" + "," + "r3_2" + "," + "r6_2" + "," + "r7_2" + "," + "x_2" + "," + "y_2" + "," + "totalR_2" + "," + "centre_x" + "," + "centre_y" + "," + "totalM");

  port_1.bufferUntil ( '\n' ); // Receives the data from the Arduino IDE
  port_2.bufferUntil ( '\n' );
}

/*
 * Draws the circles to represent each sensor. The circle gets bigger the more pressure there is
 * The coordinates are determined by the coordinates of the actual sensors on the prototype. They should change when the sensor placement changes.
 * Ensure the sensor selected as the origin is the bottom most sensor. No other sensor should be below it.
 */
void draw() {

  //Centre of pressure calculations accounting for the sensors from all the arduino's
  x = (A0x_1 * m0_1 + A1x_1 * m1_1 + A2x_1 * m2_1 + A3x_1 * m3_1 + A6x_1 * m6_1 + A7x_1 * m7_1 + A0x_2 * m0_2 + A1x_2 * m1_2 + A2x_2 * m2_2 + A3x_2 * m3_2 + A6x_2 * m6_2 + A7x_2 * m7_2)/max(totalM, 0.1);
  y = (A0y_1 * m0_1 + A1y_1 * m1_1 + A2y_1 * m2_1 + A3y_1 * m3_1 + A6y_1 * m6_1 + A7y_1 * m7_1 + A0y_2 * m0_2 + A1y_2 * m1_2 + A2y_2 * m2_2 + A3y_2 * m3_2 + A6y_2 * m6_2 + A7y_2 * m7_2)/max(totalM, 0.1);

  //println(width,height); // Uncomment this line to check window dimensions for the display window, they will appear in the console below.

  // Variables to store the value of the container coorinates will be scaled to
  // Offsets both the width and height to create a border of 200 pixels.
  float mappedWidth = width - 200;
  float mappedHeight = height - 200;

  //println(mappedWidth, mappedHeight); // Uncomment this line to check if properly bordered

  // None of the shapes drawn will hava an outer stroke
  noStroke();

  // Resets the window to the background color and setting the dimensions.
  fill(0, 0, 0);
  rect(0, 0, width, height);

  // Updates the mapped height or width to remain consistent with the window size and the sensor placement ratio.
  if (height >= maxLength * width/maxWidth) mappedHeight = maxLength*mappedWidth/maxWidth; // Uses mappedwidth as guideline to update mapped height
  else mappedWidth = maxWidth*mappedHeight/maxLength;                                      // Uses mappedheight as guideline to update mapped width.

  fill(255, 255, 255);

  // Pixels are counted from left to right and top to bottom (reverse y direction means subtracting pixels will raise the display)
  // x coordinate starts half way and is adjusted by the scaling factor from cm to pixels.
  // y coordinate starts at 100 pixels from the bottom and is adjusted by the scaling factor.
  // Change the multiplier of r# (last two entries) to increase or decrease the size of the circles.

  //Arduino 1
  ellipse(int(width/2 + (A0x_1/maxWidth) * mappedWidth), int(height - 100 - A0y_1/maxLength * mappedHeight), m0_1 * sensor_factor, m0_1 * sensor_factor);

  ellipse(int(width/2 + (A1x_1/maxWidth) * mappedWidth), int(height - 100 - A1y_1/maxLength * mappedHeight), m1_1 * sensor_factor, m1_1 * sensor_factor);

  ellipse(int(width/2 + (A2x_1/maxWidth) * mappedWidth), int(height - 100 - A2y_1/maxLength * mappedHeight), m2_1 * sensor_factor, m2_1 * sensor_factor);

  ellipse(int(width/2 + (A3x_1/maxWidth) * mappedWidth), int(height - 100 - A3y_1/maxLength * mappedHeight), m3_1 * sensor_factor, m3_1 * sensor_factor);

  ellipse(int(width/2 + (A6x_1/maxWidth) * mappedWidth), int(height - 100 - A6y_1/maxLength * mappedHeight), m6_1 * sensor_factor, m6_1 * sensor_factor);

  ellipse(int(width/2 + (A7x_1/maxWidth) * mappedWidth), int(height - 100 - A7y_1/maxLength * mappedHeight), m7_1 * sensor_factor, m7_1 * sensor_factor);

  //Arduino 2
  ellipse(int(width/2 + (A0x_2/maxWidth) * mappedWidth), int(height - 100 - A0y_2/maxLength * mappedHeight), m0_2 * sensor_factor, m0_2 * sensor_factor);

  ellipse(int(width/2 + (A1x_2/maxWidth) * mappedWidth), int(height - 100 - A1y_2/maxLength * mappedHeight), m1_2 * sensor_factor, m1_2 * sensor_factor);

  ellipse(int(width/2 + (A2x_2/maxWidth) * mappedWidth), int(height - 100 - A2y_2/maxLength * mappedHeight), m2_2 * sensor_factor, m2_2 * sensor_factor);

  ellipse(int(width/2 + (A3x_2/maxWidth) * mappedWidth), int(height - 100 - A3y_2/maxLength * mappedHeight), m3_2 * sensor_factor, m3_2 * sensor_factor);

  ellipse(int(width/2 + (A6x_2/maxWidth) * mappedWidth), int(height - 100 - A6y_2/maxLength * mappedHeight), m6_2 * sensor_factor, m6_2 * sensor_factor);

  ellipse(int(width/2 + (A7x_2/maxWidth) * mappedWidth), int(height - 100 - A7y_2/maxLength * mappedHeight), m7_2 * sensor_factor, m7_2 * sensor_factor);

  // Draws the circle to represent the centre of pressure.
  fill(10, 200, 75, 200);

  // Changes the multiplier of totalR to increase or decrease the size of the circles.
  ellipse(int((width/2) + x*(mappedWidth/maxWidth)), int((height - 100) - y*(mappedHeight/maxLength)), totalM * centre_factor, totalM * centre_factor);
}

/*
 * Recieves data from serial monitor
 */
void serialEvent(Serial myPort) {

  String val = myPort.readStringUntil('\n');

  //Error checking ensuring the String read is not NULL
  if (val != null) {
    float[] values = float(val.split(" "));

    //Error checking: ensuring that there are 9 values being read in
    if (values.length >= 9) {

      if (myPort == port_1) {
        r0_1 = values[0];
        r1_1 = values[1];
        r2_1 = values[2];
        r3_1 = values[3];
        r6_1 = values[4];
        r7_1 = values[5];
        x_1 = values[6];
        y_1 = values[7];
        totalR_1 = values[8];

        print(port_1_name);
        print(": ");

        p1_out = true;
      }

      if (myPort == port_2) {
        r0_2 = values[0];
        r1_2 = values[1];
        r2_2 = values[2];
        r3_2 = values[3];
        r6_2 = values[4];
        r7_2 = values[5];
        x_2 = values[6];
        y_2 = values[7];
        totalR_2 = values[8];

        print(port_2_name);
        print(": ");
        p2_out = true;
      }

      //Uncomment to print readings to console below
      //for (int i = 0; i < 9; i++) {
      //  print(values[i] + " ");
      //}
      //println();
      
    } else {

      //If NULL, values will be set to 0
      r0_1 = 0;
      r1_1 = 0;
      r2_1 = 0;
      r3_1 = 0;
      r6_1 = 0;
      r7_1 = 0;
      x_1 = 0;
      y_1 = 0;
      totalR_1 = 0;

      r0_2 = 0;
      r1_2 = 0;
      r2_2 = 0;
      r3_2 = 0;
      r6_2 = 0;
      r7_2 = 0;
      x_2 = 0;
      y_2 = 0;
      totalR_2 = 0;
    }

    //Replace each resistance with your conversion equation.
    m0_1 = 1.4694 * pow(r0_1, -0.449);
    m1_1 = r1_1;
    m2_1 = 1.6239 * pow(r2_1, -0.315);
    m3_1 = r3_1;
    m6_1 = 1.4571* pow(r6_1, -0.309); 
    m7_1 = r7_1;
    totalM_1 = m0_1 + m1_1 + m2_1 + m3_1 + m6_1 + m7_1;

    m0_2 = 1.2637 * pow(r0_2, -0.323);
    m1_2 = r1_2;
    m2_2 = 1.2362 * pow(r2_2, -0.341);
    m3_2 = r3_2;
    m6_2 = 1.2756 * pow(r6_2,-0.387);
    m7_2 = r7_2;
    totalM_2 = m0_2 + m1_2 + m2_2 + m3_2 + m6_2 + m7_2;
    
    totalM = totalM_1 + totalM_2;
    
    if (myPort == port_1) {
      print (m0_1 + " " + m1_1 + " " + m2_1 + " " + m3_1 + " " + m6_1 + " " + m7_1);
      println();
    }
    
    if (myPort == port_2) {
      print (m0_2 + " " + m1_2 + " " + m2_2 + " " + m3_2 + " " + m6_2 + " " + m7_2);
      println();
    }

    if (p1_out && p2_out) {
      //Output values to csv file
      output.println(m0_1 + "," + m1_1  + "," + m2_1 + "," + m3_1 + "," + m6_1 + "," + m7_1 + "," + x_1 + "," + y_1 + "," + totalM_1 + "," + m0_2 + "," + m1_2  + "," + m2_2 + "," + m3_2 + "," + m6_2 + "," + m7_2 + "," + x_2 + "," + y_2 + "," + totalM_2+"," + x + "," + y + "," + totalM);
      output.flush();
      p1_out = false;
      p2_out = false;
    }
  }
}


void keyPressed () {

  if (key == ENTER) {
    output.close();  // Finishes file
    exit();  // Stops the program
  }
}
