#include <Stepper.h>

int nStep = 2048;
int motor_speed = 6;
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

// STATES: 0:FAR, 1:NEAR
int currentState;
int futureState;

void setup() {
  Serial.begin(9600);
  stepper.setSpeed(motor_speed);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  currentState = 0;
}

int command;

void loop() {
  futureState = 0;
  
  if(Serial.available() > 0){
    command = Serial.read();

    if(command == '1'){
      stepper.step(nStep);

      //invio ack al bridge
      Serial.write(0xff);
      Serial.write(0x02);
      Serial.write(0xfe);
    }
  }

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  

  duration = pulseIn(echoPin, HIGH);
  distance = duration*0.034/2;

  delay(200);

  if (currentState==0 && distance<15) futureState=1;
  if (currentState==0 && distance>=15) futureState=0;
  if (currentState==1 && distance>=15) futureState=0;
  if (currentState==1 && distance<15) futureState=1;


  //onEnter actions
  if(futureState==1 && currentState==0){
    Serial.write(0xff);
    Serial.write(0x01);
    Serial.write(0xfe);
  }

  currentState = futureState;
}
