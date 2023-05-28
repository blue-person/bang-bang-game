#include <Servo.h>

int canon1 = 5;
int canon2 = 6;
int botonF = 2;
int max = 1023;
int min = 21;
int VPV_1 = 0;
int VPA_1 = 0;
int angulo = 0;
int velocidad = 0;
int turno = 0;
int micro = 13;
int angulo_f1 = 0;
int angulo_f2 = 0;

Servo motor1;
Servo motor2;

void setup() {
  pinMode(botonF, INPUT);
  pinMode(canon1, OUTPUT);
  pinMode(canon2, OUTPUT);
  pinMode(13, OUTPUT);
  motor1.attach(canon1);
  motor2.attach(canon2);
  motor1.write(0);
  motor2.write(180);
  Serial.begin(9600);
}

void loop() {
  delay(250);
  digitalWrite(13,LOW);
  VPV_1 = analogRead(0);
  VPA_1 = analogRead(1);
  velocidad = map(VPV_1, min, max, 0, 150);
  angulo = map(VPA_1, min, max, -45, 50);
  angulo_f1 = map(VPA_1, min, max, 0, 90);
  angulo_f2 = map(VPA_1, min, max, 180, 90);

  if (digitalRead(botonF) == HIGH) {
    boton_presionado = 1;
    digitalWrite(13,HIGH);
    if (turno % 2 == 0) {
      motor1.write(angulo_f1);
      turno++;
    } else {
      motor2.write(angulo_f2);
      turno++;
    }
  } else {
    boton_presionado = 0;
  }

  Serial.print(boton_presionado);
  Serial.print(",");
  Serial.print(angulo);
  Serial.print(",");
  Serial.println(velocidad);
}