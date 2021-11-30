#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\sketch\\preproc\\ctags_target_for_gcc_minus_e.cpp"
#line 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\preproc\\ctags_target_for_gcc_minus_e.cpp"
# 1 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\CodigoArduino.ino"
# 2 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\CodigoArduino.ino" 2
# 3 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\CodigoArduino.ino" 2
# 4 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\CodigoArduino.ino" 2
# 5 "C:\\Users\\tracs\\Desktop\\Circuitos\\ARQUITECTURA1\\Practica 2\\CodigoArduino\\CodigoArduino.ino" 2

/******VARIABLES******/
char Contra;

/*******KEYPAD*******/
// Se definen las filas y columnas del Keypad
const byte Filas = 4;
const byte Columnas =3;

//Definimos la estructura del keypad
char keys [Filas][Columnas]={
  {'1','2','3'},
  {'4','5','6'},
  {'7','8','9'},
  {'*','0','#'}
  };
// Estructura de pines que van conectados al keypad
byte rowPins[Filas] = {10,9,8,7}; //PINES DE LAS COLUMNAS DEL TECLADO
byte colPins[Columnas] = {13,12,11}; //PINES DE LAS FILAS DEL TECLADO
//Teclado
Keypad pad = Keypad( ((char*)keys), rowPins, colPins, Filas, Columnas ); //METODO PARA OPTENER QUE TECLA SE PRESIONO




/******PANTALLA LCD******/
//Crear el objeto lcd  dirección  0x20 y 16 columnas x 2 filas
LiquidCrystal_I2C lcd(0x20,16,2); //






void setup() {
  // put your setup code here, to run once:
   Serial.begin(9600);// CONSOLA DE PRUEBA

   //para la comunicacion con el esclavo
   Wire.begin(); /*esto lo agrego osman*/
  // Inicializar el LCD
  lcd.init();
  lcd.init();
  lcd.backlight();
  lcd.setCursor(3,0);
  lcd.print("CASA ACYE1");
  lcd.setCursor(4,1);
  lcd.print("B-G04-S2");
  pinMode (6, 0x1);
  pinMode (5, 0x1);
}

void loop() {
  // put your main code here, to run repeatedly:
  lcd.clear();
  digitalWrite(5,0x0);
  lcd.setCursor(3,0);
  lcd.print("CASA ACYE1");
  lcd.setCursor(4,1);
  lcd.print("B-G04-S2");
  delay(100);
   String Contrasena = "";
   int Temp = 0;
   while(true){
      Contra = pad.getKey();
      if (Contra =='*'){ // * SIMBOLIZA EL FIN DE LA CONTRASEÑA
        break;
        //Serial.print('*');
      }
      if (Contra != NO_KEY){
          Contrasena += Contra;
          Serial.print(Contrasena);
          Serial.print(" ");
          Temp++;
      }
      if(Contra == '#'){ // SIMBOLIZA EL APAGADO DE LOS MOTORES
          digitalWrite(5,0x1);
      }
    }
    if (Contrasena == "202104"){
      //ContadorErrores=0;
      lcd.clear();
      lcd.setCursor(3,0);
      lcd.print("BIENVENIDO");
      lcd.setCursor(5,1);
      lcd.print("A CASA");
      digitalWrite(6,0x1);
      delay(500);

      /*esto lo agrego osman*/
      Wire.beginTransmission(1);
      Wire.write("Correcto x2");
      Wire.endTransmission();

    }else{
      lcd.clear();
      lcd.setCursor(4,0);
      lcd.print("ERROR EN");
      lcd.setCursor(3,1);
      lcd.print("CONTRASEÑA");
      digitalWrite(6,0x0);
      delay(500);
    }
}
