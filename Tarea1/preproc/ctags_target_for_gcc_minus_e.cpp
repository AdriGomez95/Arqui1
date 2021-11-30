# 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Tarea1\\tarea1.ino"

const int boton = 2;
const int ledN1 = 13;
const int ledN2 = 12;
const int ledN3 = 11;
const int ledN4 = 10;
const int ledN5 = 9;
const int ledN6 = 8;

int botonstate = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(ledN1,0x1);
  pinMode(ledN2,0x1);
  pinMode(ledN3,0x1);
  pinMode(ledN4,0x1);
  pinMode(ledN5,0x1);
  pinMode(ledN6,0x1);
  pinMode(boton,0x0);
}

void loop() {
  // put your main code here, to run repeatedly:
  botonstate = digitalRead(boton);

  if(botonstate==0x1){
    digitalWrite(ledN1,0x1);
    delay(500);
    digitalWrite(ledN1,0x0);
    digitalWrite(ledN2,0x1);
    delay(500);
    digitalWrite(ledN2,0x0);
    digitalWrite(ledN3,0x1);
    delay(500);
    digitalWrite(ledN3,0x0);
    digitalWrite(ledN4,0x1);
    delay(500);
    digitalWrite(ledN4,0x0);
    digitalWrite(ledN5,0x1);
    delay(500);
    digitalWrite(ledN5,0x0);
    digitalWrite(ledN6,0x1);
    delay(500);
    digitalWrite(ledN6,0x0);
  }
  else
  {
    digitalWrite(ledN6,0x1);
    delay(500);
    digitalWrite(ledN6,0x0);
    digitalWrite(ledN5,0x1);
    delay(500);
    digitalWrite(ledN5,0x0);
    digitalWrite(ledN4,0x1);
    delay(500);
    digitalWrite(ledN4,0x0);
    digitalWrite(ledN3,0x1);
    delay(500);
    digitalWrite(ledN3,0x0);
    digitalWrite(ledN2,0x1);
    delay(500);
    digitalWrite(ledN2,0x0);
    digitalWrite(ledN1,0x1);
    delay(500);
    digitalWrite(ledN1,0x0);
  }
}
