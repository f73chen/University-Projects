#include <Wire.h>
#include <MPU6050_light.h>

MPU6050 mpu(Wire);
unsigned long timer = 0;
bool initialized;
float init_x = 0;
float init_y = 0;
float init_z = 0;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  mpu.begin();
  Serial.println("Calculating gyro offset, do not move MPU6050");
  mpu.calcGyroOffsets();  // Calibration
}

void loop() {
  mpu.update();
  if((millis()-timer)>1000) {                        // print data every 10ms                                                
    Serial.print("P : ");
    Serial.println(mpu.getAngleX() - init_x);
    Serial.print("R : ");
    Serial.println(mpu.getAngleY() - init_y);
    Serial.print("Y : ");
    Serial.println(mpu.getAngleZ() - init_z);
    Serial.println();
    timer = millis();  

    if (!initialized) {
      init_x = mpu.getAngleX();
      init_y = mpu.getAngleY();
      init_z = mpu.getAngleZ();
      initialized = true;
    }
  }

//  Serial.print("P : ");
//  Serial.println(mpu.getAngleX());
//  Serial.print("R : ");
//  Serial.println(mpu.getAngleY());
//  Serial.print("Y : ");
//  Serial.println(mpu.getAngleZ());
//  delay(10);
}
