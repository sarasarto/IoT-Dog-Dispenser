#include <Stepper.h>

int nStep = 2048;
int motor_speed = 10;
float basic_angle = 60;

int pinOne = 8;
int pinTwo = 9;
int pinThree = 10;
int pinFour = 11;

Stepper stepper(nStep, pinOne, pinTwo, pinThree, pinFour);

void setup() {
  Serial.begin(9600);
  stepper.setSpeed(motor_speed);
}

int command;

void loop() {
  if (Serial.available()>0){
    command = Serial.read();

    if(command=='1'){
      stepper.step(2048);
    }
  } // if (Serial.available()>0)
}
