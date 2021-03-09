#include <Stepper.h>

int nStep = 2048;
int motor_speed = 6;
float basic_angle = 60;

// parte motore
int pinOne = 8;
int pinTwo = 9;
int pinThree = 10;
int pinFour = 11;

//parte fotoresistore e luce
int pinLed = 6;
int fotor = A0;
int luce=0;
int val_min = 350;

const int trigPin = 13;
const int echoPin = 12;
long duration;
int distance;

Stepper stepper(nStep, pinOne, pinTwo, pinThree, pinFour);

// STATES: 0:FAR, 1:NEAR
int currentState;
int futureState;

// STATES: 0:COPERTO, 1:LUCE
int currentStateLight;
int futureStateLight;

void setup() {
  Serial.begin(9600);
  
  //motore
  stepper.setSpeed(motor_speed);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  currentState = 0;

  //fotoresistore
  pinMode(fotor, INPUT);
  pinMode(pinLed, OUTPUT);
  currentStateLight = 0;
}

int command;

void loop() {
  //idea: se c'è tanta luce (luce<200) non ho tanti croccantini
  //      se c'è poca luce (luce>=200) ho il sensore coperto dai croccantini
  futureStateLight = 0;
  luce=analogRead(fotor);

  if (currentStateLight==0 && luce>=val_min) futureStateLight=0;
  if (currentStateLight==0 && luce<val_min) futureStateLight=1;
  if (currentStateLight==1 && luce<val_min) futureStateLight=1;
  if (currentStateLight==1 && luce>=val_min) futureStateLight=0;


  //onEnter actions
  if(futureStateLight==1 && currentStateLight==0){
    Serial.write(0x06);
    
    digitalWrite(pinLed, HIGH);
  }

  if(futureStateLight==0 && currentStateLight==1){
    Serial.write(0x07);
 


  digitalWrite(pinLed, LOW);
  }
  //Serial.print(luce);
  //Serial.print('\n');

  currentStateLight = futureStateLight;

  //motore
  futureState = 0;
  
  if(Serial.available() > 0){
    command = Serial.read();

    if(command == '1'){
      stepper.step(nStep);

      //invio ack al bridge
      Serial.write(0x02);
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
    Serial.write(0x01);
  }

  currentState = futureState;
}
