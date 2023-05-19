int canon1 = 5;
int canon2 = 6;
int botonF = 2;
int max = 1023;
int min = 21;
int VPV_1 = 0; 
int VPA_1 = 0;
int angulo = 0;
int velocidad = 0;
int turno=0;
int angulo_f1 = 0;
int angulo_f2 = 0;
String datos;

#include<Servo.h>
Servo motor1;
Servo motor2;

void setup() {
pinMode(botonF,INPUT); 
pinMode(canon1,OUTPUT);
pinMode(canon2,OUTPUT);
motor1.attach(canon1);
motor2.attach(canon2);
motor1.write(0);
motor2.write(180);
Serial.begin(9600);
}

void loop() {
VPV_1 = analogRead(0);
VPA_1 = analogRead(1); 
velocidad = map(VPV_1,min,max,0,999);
angulo = map(VPA_1,min,max,-45,50);
angulo_f1 = map(VPA_1,min,max,0,90);
angulo_f2 = map(VPA_1,min,max,180,90);
if(digitalRead(botonF) == HIGH){
  Serial.print(angulo);
  Serial.print(",");
  Serial.println(velocidad);
  delay(500);
  if(turno%2==0){
    motor1.write(angulo_f1);
    turno++;
  }
  else{
    motor2.write(angulo_f2);
    turno++;
  }
 
}

}