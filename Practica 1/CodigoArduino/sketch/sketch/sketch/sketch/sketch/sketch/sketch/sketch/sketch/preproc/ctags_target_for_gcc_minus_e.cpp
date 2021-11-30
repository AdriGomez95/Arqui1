#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\sketch\\sketch\\sketch\\sketch\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\sketch\\sketch\\sketch\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\sketch\\sketch\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\sketch\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\preproc\\ctags_target_for_gcc_minus_e.cpp"
# 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\CodigoArduino.ino"
# 2 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\CodigoArduino.ino" 2
# 3 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\CodigoArduino.ino" 2


# 4 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 1\\CodigoArduino\\CodigoArduino.ino"
MatrizLed pantalla;

//para el switch



//para el manejo de velocidades del texto
int velocidad = 500;
int sensor = 0;// velocidad del potenciometro 
int poten = A0;//entrada del potenciometro
int led = 3; // muestra de vocidad





void setup() {
  pinMode (8, 0x0);
  pinMode (9, 0x0);
  //pinMode (led, OUTPUT);//es en lugar del display con el numero
  Serial.begin(9600);

  pinMode (2, 0x1);
  pinMode (3, 0x1);
  pinMode (4, 0x1);
  pinMode (5, 0x1);
  pinMode (6, 0x1);

 pantalla.begin(11, 13, 12, 2); // dataPin, clkPin, csPin, numero de matrices de 8x8
 pantalla.rotar(true);
}






void loop() {

  sensor= analogRead(poten);// asigan el porcentajeque tiene el potenciometro
  //digitalWrite(led,HIGH);
  if(sensor<204){
    digitalWrite(2,0x1);
    delay(1000-sensor);
    digitalWrite(2,0x0);
    //delay(1000-sensor);
    //Serial.print(sensor);
    Serial.print("1");
  }
  if((sensor>=204)&&(sensor<409)){
    digitalWrite(3,0x1);
    delay(1000-sensor);
    digitalWrite(3,0x0);
    //delay(1000-sensor);
    //Serial.print(sensor);
    Serial.print("2");
  }

  if((sensor>=409)&&(sensor<613)){
    digitalWrite(4,0x1);
    delay(1000-sensor);
    digitalWrite(4,0x0);
    //delay(1000-sensor);
    //Serial.print(sensor);
    Serial.print("3");
  }
  if((sensor>=613)&&(sensor<818)){
    digitalWrite(5,0x1);
    delay(1000-sensor);
    digitalWrite(5,0x0);
    //delay(1000-sensor);
    //Serial.print(sensor);
    Serial.print("4");
  }

  if((sensor>=818)){
    digitalWrite(6,0x1);
    delay(1000-sensor);
    digitalWrite(6,0x0);
    //delay(1000-sensor);
    //Serial.print(sensor);
    Serial.print("5");
  }



//------------------------------------------------------------------ MENSAJE A LA IZQUIERDA
if(digitalRead(8) == 0x1 && digitalRead(9) == 0x1){
    pantalla.borrar();
    for(int i=0; i<200; i++){
      pantalla.borrar();
      //* Primera Pantalla
      pantalla.setLed(0, 7, 0+i, true);
      pantalla.setLed(0, 7, 2+i, true);
      pantalla.setLed(0, 6, 1+i, true);
      pantalla.setLed(0, 5, 0+i, true);
      pantalla.setLed(0, 5, 2+i, true);

      pantalla.escribirFrase("P1", 16-i);

      //* Segunda Pantalla
      pantalla.setLed(1, 7, -6+i, true);
      pantalla.setLed(1, 7, -8+i, true);
      pantalla.setLed(1, 6, -7+i, true);
      pantalla.setLed(1, 5, -6+i, true);
      pantalla.setLed(1, 5, -8+i, true);

      //- Primera Pantalla
      pantalla.setLed(0, 4, -26+i, true);
      pantalla.setLed(0, 4, -27+i, true);
      pantalla.setLed(0, 4, -28+i, true);
      pantalla.setLed(0, 4, -29+i, true);
      pantalla.setLed(0, 3, -26+i, true);
      pantalla.setLed(0, 3, -27+i, true);
      pantalla.setLed(0, 3, -28+i, true);
      pantalla.setLed(0, 3, -29+i, true);

      //- Segunda Pantalla
      pantalla.setLed(1, 4, -34+i, true);
      pantalla.setLed(1, 4, -35+i, true);
      pantalla.setLed(1, 4, -36+i, true);
      pantalla.setLed(1, 4, -37+i, true);
      pantalla.setLed(1, 3, -34+i, true);
      pantalla.setLed(1, 3, -35+i, true);
      pantalla.setLed(1, 3, -36+i, true);
      pantalla.setLed(1, 3, -37+i, true);

      pantalla.escribirFrase("GRUPO 4", 46-i);

      //- Primera Pantalla
      pantalla.setLed(0, 4, -96+i, true);
      pantalla.setLed(0, 4, -97+i, true);
      pantalla.setLed(0, 4, -98+i, true);
      pantalla.setLed(0, 4, -99+i, true);
      pantalla.setLed(0, 3, -96+i, true);
      pantalla.setLed(0, 3, -97+i, true);
      pantalla.setLed(0, 3, -98+i, true);
      pantalla.setLed(0, 3, -99+i, true);

      //- Segunda Pantalla
      pantalla.setLed(1, 4, -104+i, true);
      pantalla.setLed(1, 4, -105+i, true);
      pantalla.setLed(1, 4, -106+i, true);
      pantalla.setLed(1, 4, -107+i, true);
      pantalla.setLed(1, 3, -104+i, true);
      pantalla.setLed(1, 3, -105+i, true);
      pantalla.setLed(1, 3, -106+i, true);
      pantalla.setLed(1, 3, -107+i, true);

      pantalla.escribirFrase("SECCION B", 116-i);

      //* Primera Pantalla
      pantalla.setLed(0, 7, -173+i, true);
      pantalla.setLed(0, 7, -175+i, true);
      pantalla.setLed(0, 6, -174+i, true);
      pantalla.setLed(0, 5, -173+i, true);
      pantalla.setLed(0, 5, -175+i, true);

      //* Segunda Pantalla
      pantalla.setLed(1, 7, -181+i, true);
      pantalla.setLed(1, 7, -183+i, true);
      pantalla.setLed(1, 6, -182+i, true);
      pantalla.setLed(1, 5, -181+i, true);
      pantalla.setLed(1, 5, -183+i, true);

      if(digitalRead(8) == 0x0 && digitalRead(9) == 0x1 || digitalRead(8) == 0x1 && digitalRead(9) == 0x0){
        pantalla.borrar();
        break;
      }
      delay(velocidad);
    }
  }



//------------------------------------------------------------------ MENSAJE A LA DERECHA
  if(digitalRead(8) == 0x1 && digitalRead(9) == 0x0){
    for(int i=0; i > -200; i++){
      pantalla.borrar();
      //* primera Pantalla
      pantalla.setLed(1, 7, 7-i, true);
      pantalla.setLed(1, 7, 5-i, true);
      pantalla.setLed(1, 6, 6-i, true);
      pantalla.setLed(1, 5, 7-i, true);
      pantalla.setLed(1, 5, 5-i, true);

      //* segunda Pantalla
      pantalla.setLed(0, 7, 13-i, true);
      pantalla.setLed(0, 7, 15-i, true);
      pantalla.setLed(0, 6, 14-i, true);
      pantalla.setLed(0, 5, 13-i, true);
      pantalla.setLed(0, 5, 15-i, true);

      pantalla.escribirFrase("SECCION B", -73+i);

      //- Primera Pantalla
      pantalla.setLed(1, 4, 84-i, true);
      pantalla.setLed(1, 4, 85-i, true);
      pantalla.setLed(1, 4, 86-i, true);
      pantalla.setLed(1, 4, 87-i, true);
      pantalla.setLed(1, 3, 84-i, true);
      pantalla.setLed(1, 3, 85-i, true);
      pantalla.setLed(1, 3, 86-i, true);
      pantalla.setLed(1, 3, 87-i, true);

      //- Segunda Pantalla
      pantalla.setLed(0, 4, 92-i, true);
      pantalla.setLed(0, 4, 93-i, true);
      pantalla.setLed(0, 4, 94-i, true);
      pantalla.setLed(0, 4, 95-i, true);
      pantalla.setLed(0, 3, 92-i, true);
      pantalla.setLed(0, 3, 93-i, true);
      pantalla.setLed(0, 3, 94-i, true);
      pantalla.setLed(0, 3, 95-i, true);

      pantalla.escribirFrase("GRUPO 4", -145+i);

      //- Primera Pantalla
      pantalla.setLed(1, 4, 154-i, true);
      pantalla.setLed(1, 4, 155-i, true);
      pantalla.setLed(1, 4, 156-i, true);
      pantalla.setLed(1, 4, 157-i, true);
      pantalla.setLed(1, 3, 154-i, true);
      pantalla.setLed(1, 3, 155-i, true);
      pantalla.setLed(1, 3, 156-i, true);
      pantalla.setLed(1, 3, 157-i, true);

      //- Segunda Pantalla
      pantalla.setLed(0, 4, 162-i, true);
      pantalla.setLed(0, 4, 163-i, true);
      pantalla.setLed(0, 4, 164-i, true);
      pantalla.setLed(0, 4, 165-i, true);
      pantalla.setLed(0, 3, 162-i, true);
      pantalla.setLed(0, 3, 163-i, true);
      pantalla.setLed(0, 3, 164-i, true);
      pantalla.setLed(0, 3, 165-i, true);

      pantalla.escribirFrase("P1", -176+i);

      //* primera Pantalla
      pantalla.setLed(1, 7, 185-i, true);
      pantalla.setLed(1, 7, 187-i, true);
      pantalla.setLed(1, 6, 186-i, true);
      pantalla.setLed(1, 5, 185-i, true);
      pantalla.setLed(1, 5, 187-i, true);

      //* segunda Pantalla
      pantalla.setLed(0, 7, 202-i, true);
      pantalla.setLed(0, 7, 204-i, true);
      pantalla.setLed(0, 6, 203-i, true);
      pantalla.setLed(0, 5, 202-i, true);
      pantalla.setLed(0, 5, 204-i, true);


      if(digitalRead(8) == 0x1 && digitalRead(9) == 0x1 ){
        pantalla.borrar();
        break;
      }
      delay(velocidad);
    }
  }







//------------------------------------------------------------------ MENSAJE EN 1 MATRIZ
 while(digitalRead(8) == 0x0 && digitalRead(9) == 0x1){
    pantalla.borrar();

    //* Primera Pantalla
    pantalla.setLed(1, 7, 5, true);
    pantalla.setLed(1, 7, 7, true);
    pantalla.setLed(1, 6, 6, true);
    pantalla.setLed(1, 5, 5, true);
    pantalla.setLed(1, 5, 7, true);

    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('P' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('1' , 0);
    delay(velocidad);

    pantalla.borrar();

    //- Primera Pantalla
    pantalla.setLed(1, 4, 2, true);
    pantalla.setLed(1, 4, 3, true);
    pantalla.setLed(1, 4, 4, true);
    pantalla.setLed(1, 4, 5, true);
    pantalla.setLed(1, 3, 2, true);
    pantalla.setLed(1, 3, 3, true);
    pantalla.setLed(1, 3, 4, true);
    pantalla.setLed(1, 3, 5, true);

    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('G' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('R' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('U' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('P' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('O' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('4' , 0);

    delay(velocidad);

    pantalla.borrar();

    //- Primera Pantalla
    pantalla.setLed(1, 4, 2, true);
    pantalla.setLed(1, 4, 3, true);
    pantalla.setLed(1, 4, 4, true);
    pantalla.setLed(1, 4, 5, true);
    pantalla.setLed(1, 3, 2, true);
    pantalla.setLed(1, 3, 3, true);
    pantalla.setLed(1, 3, 4, true);
    pantalla.setLed(1, 3, 5, true);

    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('S' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('E' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('C' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('C' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('I' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('O' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('N' , 0);
    delay(velocidad);

    pantalla.borrar();
    pantalla.escribirCaracter('B' , 0);
    delay(velocidad);

    pantalla.borrar();
    //* Primera Pantalla
    pantalla.setLed(1, 7, 5, true);
    pantalla.setLed(1, 7, 7, true);
    pantalla.setLed(1, 6, 6, true);
    pantalla.setLed(1, 5, 5, true);
    pantalla.setLed(1, 5, 7, true);

    delay(velocidad);

  }
}
