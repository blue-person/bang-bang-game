static int canon1 = 5;
static int canon2 = 6;
static int botonF = 2;
static int potent_1 = 0;
static int potent_2 = 1;
static int max = 1023;
static int min = 21;


int V_1 = 0; 
int A_1 = 0;
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
V_1 = analogRead(potent_1);
A_1 = analogRead(potent_2); 
velocidad = map(V_1,min,max,0,999);
angulo = map(A_1,min,max,-45,50);
angulo_f1 = map(A_1,min,max,0,90);
angulo_f2 = map(A_1,min,max,180,90);
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