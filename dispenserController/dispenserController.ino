#include <Stepper.h>

int nStep = 2048;
int motor_speed = 10;
float basic_angle = 60;

int pinOne = 8;
int pinTwo = 9;
int pinThree = 10;
int pinFour = 11;

const int trigPin = 13;
const int echoPin = 12;
long duration;
int distance;

Stepper stepper(nStep, pinOne, pinTwo, pinThree, pinFour);

void setup() {
  Serial.begin(9600);
  stepper.setSpeed(motor_speed);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

int command;

void loop() {
  
  if (Serial.available()>0){
    command = Serial.read();

    if(command=='1'){
      stepper.step(2048);
    }
  }// if (Serial.available()>0)

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);

  duration = pulseIn(echoPin, HIGH);
  distance = duration*0.034/2;

  delay(200);


  if(distance < 10){
    //invio al bridge la richiesta di controllo razione per quell'animale
    Serial.write(0xff);
    Serial.write(0x01);
    Serial.write(0xfe);
  } 
}
