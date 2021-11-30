# 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino"
# 2 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Proyecto1\\codigo\\proyecto1\\proyecto1.ino" 2

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





void setup() {

  Serial.begin(9600);
  pinMode (Motor1, 0x1);
  pinMode (Motor2, 0x1);
  pinMode (Motor3, 0x1);
  pinMode (Motor4, 0x1);

  pinMode (LEDIZQ, 0x1);
  pinMode (LEDDER, 0x1);
  pinMode (LEDREV, 0x1);

  pinMode (R1, 0x1);
  pinMode (R2, 0x1);
  pinMode (R3, 0x1);
  pinMode (R4, 0x1);

  pinMode (3 /*el pin del boton velocidad*/, 0x0);

  velocidad = 1;

  //*** agregado
  vel1 = 150; //motor al 50%
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
      analogWrite(R1, 0x0);
      analogWrite(R2, 0x0);
      analogWrite(R3, 0x0);
      analogWrite(R4, 0x0);
      adelante(text);
    }

    if (R == 1)
    {
      analogWrite(Motor1, 0x0);
      analogWrite(Motor2, 0x0);
      analogWrite(Motor3, 0x0);
      analogWrite(Motor4, 0x0);
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
    analogWrite(Motor1, 0x0);
    analogWrite(Motor2, vel1);
    analogWrite(Motor3, vel1);
    analogWrite(Motor4, vel1);
    K = 1;
  }
  if (text == "der") {
    analogWrite(Motor1, vel1 );
    analogWrite(Motor2, 0x0);
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
    analogWrite(Motor1, 0x0);
    analogWrite(Motor2, 0x0);
    analogWrite(Motor3, 0x0);
    analogWrite(Motor4, 0x0);
    K = 4;
  }
}


void retroceso(String text)
{
  if (text == "izq") {
    analogWrite(R1, 0x0);
    analogWrite(R2, vel1);
    analogWrite(R3, vel1);
    analogWrite(R4, vel1);
    K = 1;
  }
  if (text == "der") {
    analogWrite(R1, vel1 );
    analogWrite(R2, 0x0);
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
    analogWrite(R1, 0x0);
    analogWrite(R2, 0x0);
    analogWrite(R3, 0x0);
    analogWrite(R4, 0x0);
    K = 4;
  }
}





//******** PARA EL ULTRASONIC

void ultrason(){
  distancia = 0.01723 * readUltrasonicDistance(ultrasonic, ultrasonic);
  if(distancia<20){
    analogWrite(Motor1, 0x0);
    analogWrite(Motor2, 0x0);
    analogWrite(Motor3, 0x0);
    analogWrite(Motor4, 0x0);
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
  pinMode(triggerPin, 0x1); // Clear the trigger
  digitalWrite(triggerPin, 0x0);
  delayMicroseconds(2);
  // Sets the trigger pin to HIGH state for 10 microseconds
  digitalWrite(triggerPin, 0x1);
  delayMicroseconds(10);
  digitalWrite(triggerPin, 0x0);
  pinMode(echoPin, 0x0);
  // Reads the echo pin, and returns the sound wave travel time in microseconds
  return pulseIn(echoPin, 0x1);
}
