#include <Keyboard.h>
//Robits Controller ver 1.1
//Robits Player 01

const int coin_pin = 10;
const int up_pin = 2;
const int left_pin = 3;
const int down_pin = 4;
const int right_pin = 5;
const int pick_pin = 8;
const int shoot_pin = 6;
const int jump_pin = 7;
const int start_pin = 9;
const int menu_pin = 16;
const int vol_up_pin = 15;
const int vol_dn_pin = 14;

char coin = '1';
char up = 'w';
char left = 'a';
char down = 's';
char right = 'd';
char pick = 'q';
char shoot = 'e';
char jump = 'z';
char start = 'x';
char menu = 178;
char vol_up = 224;
char vol_dn = 221;
void setup() {
  // setting up pins for robit controller
    
  pinMode(coin_pin, INPUT_PULLUP);
  pinMode(up_pin, INPUT_PULLUP);
  pinMode(left_pin, INPUT_PULLUP);
  pinMode(down_pin, INPUT_PULLUP);
  pinMode(right_pin, INPUT_PULLUP);
  pinMode(pick_pin, INPUT_PULLUP);
  pinMode(shoot_pin, INPUT_PULLUP);
  pinMode(jump_pin, INPUT_PULLUP);
  //pinMode(hold_pin, INPUT_PULLUP);
  pinMode(start_pin, INPUT_PULLUP);
  pinMode(menu_pin, INPUT_PULLUP);
  pinMode(vol_up_pin, INPUT_PULLUP);
  pinMode(vol_dn_pin, INPUT_PULLUP);
  Keyboard.begin();
  
}

void loop() {
  //Robit Coin
  if (digitalRead(coin_pin) == LOW) {
    Keyboard.press(coin);
    }
  else{
    Keyboard.release(coin);
  }
  //Robit Up
  if (digitalRead(up_pin) == LOW) {
    Keyboard.press(up);
    }
  else{
    Keyboard.release(up);
  }
  //Robit Left
  if (digitalRead(left_pin) == LOW) {
    Keyboard.press(left);
    }
  else{
    Keyboard.release(left);
  }
  //Robit Down
  if (digitalRead(down_pin) == LOW) {
    Keyboard.press(down);
    }
  else{
    Keyboard.release(down);
  }
  //Robit Right
  if (digitalRead(right_pin) == LOW) {
    Keyboard.press(right);
    }
  else{
    Keyboard.release(right);
  }
  //Robit Pick
  if (digitalRead(pick_pin) == LOW) {
    Keyboard.press(pick);
    }
  else{
    Keyboard.release(pick);
  }
  //Robit Shoot
  if (digitalRead(shoot_pin) == LOW) {
    Keyboard.press(shoot);
    }
  else{
    Keyboard.release(shoot);
  }
  //Robit Jump
  if (digitalRead(jump_pin) == LOW) {
    Keyboard.press(jump);
    }
  else{
    Keyboard.release(jump);
  }
  /*
  //Robit Hold
  if (digitalRead(hold_pin) == LOW) {
    Keyboard.press(hold);
    }
  else{
    Keyboard.release(hold);
  }
  */
  //Robit Start
  if (digitalRead(start_pin) == LOW) {
    Keyboard.press(start);
    }
  else{
    Keyboard.release(start);
  }
  //Menu
  if (digitalRead(menu_pin) == LOW) {
    Keyboard.press(menu);
    }
  else{
    Keyboard.release(menu);
  }
   //Vol up
  if (digitalRead(vol_up_pin) == LOW) {
    Keyboard.press(vol_up);
    }
  else{
    Keyboard.release(vol_up);
  }
    //Menu
  if (digitalRead(vol_dn_pin) == LOW) {
    Keyboard.press(vol_dn);
    }
  else{
    Keyboard.release(vol_dn);
  }
}
