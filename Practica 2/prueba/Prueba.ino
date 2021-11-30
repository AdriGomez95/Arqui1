#include <Wire.h>            // include Arduino Wire library (required for I2C devices)
#include <LiquidCrystal.h>   // include Arduino LCD library


// LCD module connections (RS, E, D4, D5, D6, D7)
LiquidCrystal lcd(13,12,11,10,9,8);

// define DS1621 I2C slave address (1001+A2+A1+A0)
// A2, A1 & A0 connected to GND --> 1001000 = 0x48
#define DS1621_ADDRESS  0x48
const int E1 = 7;
const int E2 = 6;
int state = 0;


//----- de 1 motor-------
#define M2 2
#define M3 3



void setup(void) {
  lcd.begin(16, 2);     // set up the LCD's number of columns and rows
  lcd.setCursor(3, 0);  // move cursor to column 0, row 0 [position (0, 0)]
  lcd.print("APAGADO ");
   pinMode (E1, INPUT);
   pinMode (E2, INPUT);
  Wire.begin();           // join i2c bus
  // initialize DS1621 sensor
  Wire.beginTransmission(DS1621_ADDRESS); // connect to DS1621 (send DS1621 address)
  Wire.write(0xAC);                       // send configuration register address (Access Config)
  Wire.write(0);                          // perform continuous conversion
  Wire.beginTransmission(DS1621_ADDRESS); // send repeated start condition
  Wire.write(0xEE);                       // send start temperature conversion command
  Wire.endTransmission();                 // stop transmission and release the I2C bus
  
  //----- de 1 motor-------
  pinMode(M2,OUTPUT) ; 
  pinMode(M3,OUTPUT) ;
}

// variables
char c_buffer[8], f_buffer[8];

// main loop
void loop() {
   
  state = digitalRead(E1);
  delay(100);
  if(state == HIGH){
    //    // wait a second
    // get temperature in tenths °C
    int16_t c_temp = get_temperature();   
    if(c_temp <= 180) {// if temperature < 18 °C

       /*------MOTORES-------*/
      digitalWrite(M3,0);
      delay(100);
      digitalWrite(M2,0);
      delay(100);
      
      if (c_temp <0 ) {   // if temperature < 0 °C
        c_temp = abs(c_temp);  // absolute value
        sprintf(c_buffer, "-%02u.%1u%cC", c_temp / 10, c_temp % 10, 223);
      }
      else{
        sprintf(c_buffer, " %02u.%1u%cC", c_temp / 10, c_temp % 10, 223);
      }
      lcd.clear();
      lcd.setCursor(1,0);
      lcd.print("TEMP: ");
      lcd.print(c_buffer);  // print c_buffer (temperature in °C)
      lcd.setCursor(1,1);
      lcd.print("NIVEL : 1");
    }
    if ((c_temp > 180)&&(c_temp < 250)){    

       /*------MOTORES-------*/
      digitalWrite(M3,25);
      delay(100);
      digitalWrite(M2,0);
      delay(100);
      
      c_temp = abs(c_temp);  // absolute value
      sprintf(c_buffer, " %02u.%1u%cC", c_temp / 10, c_temp % 10, 223);
      lcd.clear();
      lcd.setCursor(1,0);
      lcd.print("TEMP: ");
      lcd.print(c_buffer);  // print c_buffer (temperature in °C)
      lcd.setCursor(1,1);
      lcd.print("NIVEL : 2");
    }
    if(c_temp >=250) {// if temperature >= 25.0 °C

       /*------MOTORES-------*/
      digitalWrite(M3,25);
      delay(100);
      digitalWrite(M2,25);
      delay(100);
      
      c_temp = abs(c_temp);  // absolute value
      sprintf(c_buffer, " %02u.%1u%cC", c_temp / 10, c_temp % 10, 223);
      lcd.clear();
      lcd.setCursor(1,0);
      lcd.print("TEMP: ");
      lcd.print(c_buffer);  // print c_buffer (temperature in °C)
      lcd.setCursor(1,1);
      lcd.print("NIVEL : 3");
    }
    if(state!= HIGH){
    lcd.clear();
    lcd.setCursor(3,0);
    lcd.print("APAGADO");
    }
  }
}

int16_t get_temperature() {
  Wire.beginTransmission(DS1621_ADDRESS); // connect to DS1621 (send DS1621 address)
  Wire.write(0xAA);                       // read temperature command
  Wire.endTransmission(false);            // send repeated start condition
  Wire.requestFrom(DS1621_ADDRESS, 2);    // request 2 bytes from DS1621 and release I2C bus at end of reading
  uint8_t t_msb = Wire.read();            // read temperature MSB register
  uint8_t t_lsb = Wire.read();            // read temperature LSB register

  // calculate full temperature (raw value)
  int16_t raw_t = (int8_t)t_msb << 1 | t_lsb >> 7;
  // convert raw temperature value to tenths °C
  raw_t = raw_t * 10/2;
  return raw_t;
}
