const int binaryDist[4][4] = {
  {0, 0, 0, 0},
  {0, 0, 0, 0},
  {1, 1, 1, 1},
  {1, 1, 1, 1},
};
const int gridPixels = 4;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  getGesture();
}

// Returns the gesture based on binaryDist[][] matrix
void getGesture() {
  int count = 0;
  int numRows = floor(gridPixels / 2);
  int numPixels = gridPixels * numRows;
  float ratio = 0.0;

  for (int i = 0; i < numRows; i++) {
    for (int j = 0; j < gridPixels; j++) {
      if (binaryDist[i][j] == 1) {
        count++;
      }
    }
  }

  ratio = float(count)/float(numPixels);
  
  if (ratio > 0.5) {
    Serial.println("PAPER");
    delay(1023);
  } else if (ratio <= 0.1) {
    Serial.println("ROCK");
    delay(1023);
  } else {
    Serial.println("SCISSORS");
    delay(1023);
  }
}
