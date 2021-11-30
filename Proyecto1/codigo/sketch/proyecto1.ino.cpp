#include <Arduino.h>
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
#include <Servo.h>

String text;
int velocidad, vel1, vel2;
int Motor1 = 8;
int Motor2 = 9;
int Motor3 = 10;
int Motor4 = 11;

int R1 = 2;
int R2 = 3;
int R3 = 12;
int R4 = 13;

int R = 0;
int K = 0;

int valor_salida_pwm;

int LEDIZQ = 7;
int LEDDER = 6;
int LEDREV = 5;


/*ULTRASONICO*/
int ultrasonic = 4;
int distancia;


#define S1 3 //el pin del boton velocidad


#line 33 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
void setup();
#line 61 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
void loop();
#line 133 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
void adelante(String text);
#line 167 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
void retroceso(String text);
#line 204 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
void ultrason();
#line 221 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
long readUltrasonicDistance(int triggerPin, int echoPin);
#line 33 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
void setup() {

  Serial.begin(9600);
  pinMode (Motor1, OUTPUT);
  pinMode (Motor2, OUTPUT);
  pinMode (Motor3, OUTPUT);
  pinMode (Motor4, OUTPUT);
  
  pinMode (LEDIZQ, OUTPUT);
  pinMode (LEDDER, OUTPUT);
  pinMode (LEDREV, OUTPUT);

  pinMode (R1, OUTPUT);
  pinMode (R2, OUTPUT);
  pinMode (R3, OUTPUT);
  pinMode (R4, OUTPUT);

  pinMode (S1, INPUT);

  velocidad = 1;

  //*** agregado
  vel1 = 150;  //motor al 50%
  //vel2 = 200;   //motor al 75%
  //el 100% es 255

}

void loop() {
  ultrason();//****************************************
  while (Serial.available()) {
    delay(10);
    char c = Serial.read();
    text += c;
  }
  if(K == 1){
    analogWrite(LEDIZQ, 250);
    analogWrite(LEDDER, 0);
    analogWrite(LEDREV, 0);
    
  }else if(K ==2){
    analogWrite(LEDIZQ, 0);
    analogWrite(LEDDER, 250);
    analogWrite(LEDREV, 0);
  }else if (K == 3){
    analogWrite(LEDIZQ, 0);
    analogWrite(LEDDER, 0);
    analogWrite(LEDREV, 0);    
  }else if (K == 4){
    analogWrite(LEDIZQ, 0);
    analogWrite(LEDDER, 0);
    analogWrite(LEDREV, 250);
  }
  

  
  if (text.length() > 0) {

    Serial.print(text);
    /*Esto es para saber si esta yendo para adelante o para atras*/
    if (text == "atr") {
      R = 1;
    } else if (text == "ade")
    {
      R = 0;
    }

    if (R == 0)
    {
      Serial.println("Adelante");
      analogWrite(R1, LOW);
      analogWrite(R2, LOW);
      analogWrite(R3, LOW);
      analogWrite(R4, LOW);
      adelante(text);
    }

    if (R == 1)
    {
      analogWrite(Motor1, LOW);
      analogWrite(Motor2, LOW);
      analogWrite(Motor3, LOW);
      analogWrite(Motor4, LOW);
      Serial.println("Atras");
      retroceso(text);
    }

    if (text == "val") {
      vel1 = 255;
    }
    if (text == "vba") {
      vel1 = 150;
    }
    text = "";
    delay(100);
  }

}


void adelante(String text)
{

  if (text == "izq") {
    analogWrite(Motor1, LOW);
    analogWrite(Motor2, vel1);
    analogWrite(Motor3, vel1);
    analogWrite(Motor4, vel1);
    K = 1;
  }
  if (text == "der") {
    analogWrite(Motor1, vel1 );
    analogWrite(Motor2, LOW);
    analogWrite(Motor3, vel1);
    analogWrite(Motor4, vel1);
    K = 2;
  }
  if (text == "ade") {
    analogWrite(Motor1, vel1);
    analogWrite(Motor2, vel1);
    analogWrite(Motor3, vel1);
    analogWrite(Motor4, vel1);
    K = 3;
  }
  if (text == "det") {
    analogWrite(Motor1, LOW);
    analogWrite(Motor2, LOW);
    analogWrite(Motor3, LOW);
    analogWrite(Motor4, LOW);
    K = 4; 
  }
}


void retroceso(String text)
{
  if (text == "izq") {
    analogWrite(R1, LOW);
    analogWrite(R2, vel1);
    analogWrite(R3, vel1);
    analogWrite(R4, vel1);
    K = 1; 
  }
  if (text == "der") {
    analogWrite(R1, vel1 );
    analogWrite(R2, LOW);
    analogWrite(R3, vel1);
    analogWrite(R4, vel1);
    K = 2;
  }
  if (text == "atr") {
    analogWrite(R1, vel1);
    analogWrite(R2, vel1);
    analogWrite(R3, vel1);
    analogWrite(R4, vel1);
  }
  if (text == "det") {
    analogWrite(R1, LOW);
    analogWrite(R2, LOW);
    analogWrite(R3, LOW);
    analogWrite(R4, LOW);
    K = 4;
  }
}





//******** PARA EL ULTRASONIC

void ultrason(){
  distancia = 0.01723 * readUltrasonicDistance(ultrasonic, ultrasonic);
  if(distancia<20){
    analogWrite(Motor1, LOW);
    analogWrite(Motor2, LOW);
    analogWrite(Motor3, LOW);
    analogWrite(Motor4, LOW);
    K = 4;
  }else if(distancia>20){
    analogWrite(Motor1, vel1);
    analogWrite(Motor2, vel1);
    analogWrite(Motor3, vel1);
    analogWrite(Motor4, vel1);
    
  }
}

long readUltrasonicDistance(int triggerPin, int echoPin)
{
  pinMode(triggerPin, OUTPUT);  // Clear the trigger
  digitalWrite(triggerPin, LOW);
  delayMicroseconds(2);
  // Sets the trigger pin to HIGH state for 10 microseconds
  digitalWrite(triggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(triggerPin, LOW);
  pinMode(echoPin, INPUT);
  // Reads the echo pin, and returns the sound wave travel time in microseconds
  return pulseIn(echoPin, HIGH);
}

