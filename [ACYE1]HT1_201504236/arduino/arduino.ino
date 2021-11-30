
//0gfedcba
//201504236
byte digitOne[9] = {B00100100, B01000000, B01111001,  B00010010, B01000000, B00011001, B00100100, B00110000, B00000010};

//20210309
//0abcdefg
//byte digitOne2[8] = {B00100100, B01000000, B00100100,  B01111001, B01000000, B00110000, B01000000, B00010000};
byte digitOne2[8] = {B00010010, B00000001, B00010010,  B01001111, B00000001, B00000110, B00000001, B00000100};

void setup() {
  DDRD = B11111111;
  DDRB = B11111111;

}

void loop() {

  for(int i=0; i<9; i++)
  {
    PORTD = digitOne[i];
    delay(300);
  }
  
  for(int j=0; j<8; j++)
  {
    PORTB = digitOne2[j];
    delay(300);
  }

}
