#include <LiquidCrystal.h>   
#include <piezo-music.h>

//(RS, E, D4, D5, D6, D7)
LiquidCrystal lcd(13,12,11,10,9,8);

// Pin del parlante
const int pinB = 7;


//***** RITMO Y MELODIA PARA ELISA - RICHARD CLAYDERMAN *****
int melodia_Para_Elisa[] = {
  NOTE_E6, NOTE_DS6, NOTE_E6, NOTE_DS6,
  NOTE_E6, NOTE_B5, NOTE_D6, NOTE_C6,
  NOTE_A5, PAUSE, NOTE_C5, NOTE_E5,
  NOTE_A5, NOTE_B5, PAUSE, NOTE_E5,
  NOTE_GS5, NOTE_B5, NOTE_C6, PAUSE,
  NOTE_E5, NOTE_E6, NOTE_DS6, NOTE_E6,
  NOTE_DS6, NOTE_E6, NOTE_B5, NOTE_D6,
  NOTE_C6, NOTE_A5, PAUSE, NOTE_C5,
  NOTE_E5, NOTE_A5, NOTE_B5, PAUSE,
  NOTE_E5, NOTE_C6, NOTE_B5, NOTE_A5,
  PAUSE, NOTE_B5, NOTE_C6, NOTE_D6,
  NOTE_E6, NOTE_G5, NOTE_F6, NOTE_E6,
  NOTE_D6, NOTE_F5, NOTE_E6, NOTE_D6,
  NOTE_C6, NOTE_E5, NOTE_D6, NOTE_C6,
  NOTE_B5, PAUSE, NOTE_E5, NOTE_E6,
  PAUSE, PAUSE, NOTE_E6, NOTE_E7,
  PAUSE, NOTE_DS6, NOTE_E6, PAUSE,
  NOTE_DS6, NOTE_E6, NOTE_DS6, NOTE_E6,
  NOTE_DS6, NOTE_E6, NOTE_B5, NOTE_D6,
  NOTE_C6, NOTE_A5, PAUSE, NOTE_C5,
  NOTE_E5, NOTE_A5, NOTE_B5, PAUSE,
  NOTE_E5, NOTE_GS5, NOTE_B5, NOTE_C6,
  PAUSE, NOTE_E5, NOTE_E6, NOTE_DS6,
  NOTE_E6, NOTE_DS6, NOTE_E6, NOTE_B5,
  NOTE_D6, NOTE_C6, NOTE_A5, PAUSE,
  NOTE_C5, NOTE_E5, NOTE_A5, NOTE_B5,
  PAUSE, NOTE_E5, NOTE_C6, NOTE_B5,
  NOTE_A5, PAUSE
};

int ritmo_Para_Elisa[] = {
  6, 6, 6, 6,
  6, 6, 6, 6,
  4, 6, 6, 6,
  6, 4, 6, 6,
  6, 6, 4, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 4, 6, 6,
  6, 6, 4, 6,
  6, 6, 6, 4,
  6, 6, 6, 6,
  3, 6, 6, 6,
  3, 6, 6, 6,
  3, 6, 6, 6,
  4, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 4, 6, 6,
  6, 6, 4, 6,
  6, 6, 6, 4,
  6, 6, 6, 6,
  6, 6, 6, 6,
  6, 6, 4, 6,
  6, 6, 6, 4,
  6, 6, 6, 6,
  2, 4
};



//***** RITMO Y MELODIA ZELDA'S LULLABY - THE LEGEND OF ZELDA (Ocarina of Time) *****
int melodia_Zelda[] = {
  NOTE_E4, NOTE_G4, NOTE_D4, NOTE_C4, NOTE_D4, 
  NOTE_E4, NOTE_G4, NOTE_D4,   0,     NOTE_E4, 
  NOTE_G4, NOTE_D5, NOTE_C5, NOTE_G4, NOTE_F4, 
  NOTE_E4, NOTE_D4,    0,    NOTE_E4, NOTE_G4, 
  NOTE_D4, NOTE_C4, NOTE_D4, NOTE_E4, NOTE_G4, 
  NOTE_D4,    0,    NOTE_E4, NOTE_G4, NOTE_D5, 
  NOTE_C5, NOTE_G4,

  NOTE_D5, NOTE_C5, NOTE_G4, NOTE_F4, NOTE_E4,
  NOTE_F4, NOTE_E4, NOTE_C4, NOTE_F4, NOTE_E4, 
  NOTE_D4, NOTE_E4, NOTE_D4, NOTE_A3, NOTE_G4, 
  NOTE_F4, NOTE_E4, NOTE_F4, NOTE_E4, NOTE_C4, 
  NOTE_F4, NOTE_C5, 0,
  
};

int ritmo_Zelda[] = {
  2,4,2,8,8,                                                         
  2,4,2,4,2,                                                        
  4,2,4,2,8,                                               
  8,2,4,2,4,
  2,8,8,2,4,
  2,4,2,4,2,
  4,1,

  8,4,2,4,2,
  8,2,8,8,2,
  2,2,2,8,4,
  8,2,8,2,8,
  8,8,1
  
};


int cantidad_Para_Elisa = sizeof(melodia_Para_Elisa)/sizeof(melodia_Para_Elisa[0]);
int cantidad_Zelda = sizeof(melodia_Zelda)/sizeof(melodia_Zelda[0]);




void setup() {
  
  lcd.begin(16, 2);     // columns and rows
  lcd.print("PARA ELISA");
  lcd.setCursor(0, 1);     // columns and rows
  lcd.print("EN CURSO ");

  playSong(pinB, melodia_Para_Elisa, ritmo_Para_Elisa, cantidad_Para_Elisa, 50);




  lcd.begin(16, 2);     
  lcd.print("ZELDAS LULLABY");
  lcd.setCursor(0, 1);     
  lcd.print("EN CURSO ");
  
  playSong(pinB, melodia_Zelda, ritmo_Zelda, cantidad_Zelda, 30);
  

  

  lcd.begin(16, 2);     
  lcd.print("SIN MAS");
  lcd.setCursor(0, 1);     
  lcd.print("CANCIONES");
}





void loop() {

}
