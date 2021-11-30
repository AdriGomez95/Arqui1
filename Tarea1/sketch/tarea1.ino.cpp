#include <Arduino.h>
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Tarea1\\tarea1.ino"

const int boton =  2;
const int ledN1 = 13;
const int ledN2 = 12;
const int ledN3 = 11;
const int ledN4 = 10;
const int ledN5 = 9;
const int ledN6 = 8;

int botonstate = 0;

#line 12 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Tarea1\\tarea1.ino"
void setup();
#line 23 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Tarea1\\tarea1.ino"
void loop();
#line 12 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Tarea1\\tarea1.ino"
void setup() {
  // put your setup code here, to run once:
  pinMode(ledN1,OUTPUT);
  pinMode(ledN2,OUTPUT);
  pinMode(ledN3,OUTPUT);
  pinMode(ledN4,OUTPUT);
  pinMode(ledN5,OUTPUT);
  pinMode(ledN6,OUTPUT);
  pinMode(boton,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  botonstate = digitalRead(boton);

  if(botonstate==HIGH){
    digitalWrite(ledN1,HIGH);
    delay(500);
    digitalWrite(ledN1,LOW);
    digitalWrite(ledN2,HIGH);
    delay(500);
    digitalWrite(ledN2,LOW);
    digitalWrite(ledN3,HIGH);
    delay(500);
    digitalWrite(ledN3,LOW);
    digitalWrite(ledN4,HIGH);
    delay(500);
    digitalWrite(ledN4,LOW);
    digitalWrite(ledN5,HIGH);
    delay(500);
    digitalWrite(ledN5,LOW);
    digitalWrite(ledN6,HIGH);
    delay(500);
    digitalWrite(ledN6,LOW);
  }
  else
  {
    digitalWrite(ledN6,HIGH);
    delay(500);
    digitalWrite(ledN6,LOW);
    digitalWrite(ledN5,HIGH);
    delay(500);
    digitalWrite(ledN5,LOW);
    digitalWrite(ledN4,HIGH);
    delay(500);
    digitalWrite(ledN4,LOW);
    digitalWrite(ledN3,HIGH);
    delay(500);
    digitalWrite(ledN3,LOW);
    digitalWrite(ledN2,HIGH);
    delay(500);
    digitalWrite(ledN2,LOW);
    digitalWrite(ledN1,HIGH);
    delay(500);
    digitalWrite(ledN1,LOW);
  }
}

