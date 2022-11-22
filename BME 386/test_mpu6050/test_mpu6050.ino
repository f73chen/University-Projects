#include <Wire.h>
#include <MPU6050_light.h>

MPU6050 mpu(Wire);
unsigned long timer = 0;

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
    Serial.println(mpu.getAngleX());
    Serial.print("R : ");
    Serial.println(mpu.getAngleY());
    Serial.print("Y : ");
    Serial.println(mpu.getAngleZ());
    timer = millis();  
  }
}
