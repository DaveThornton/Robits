#include <Keyboard.h>

const int coin_pin = 1;
const int up_pin = 2;
const int left_pin = 3;
const int down_pin = 4;
const int right_pin = 5;
const int pick_pin = 6;
const int shoot_pin = 7;
const int jump_pin = 8;
const int hold_pin = 9;
const int start_pin = 10;

char coin = '4';
char up = 218;
char left = 216;
char down = 217;
char right = 215;
char pick = 'p';
char shoot = 213;
char jump = 234;
char hold = 223;
char start = 235;

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
  pinMode(hold_pin, INPUT_PULLUP);
  pinMode(start_pin, INPUT_PULLUP);
  
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
  //Robit Hold
  if (digitalRead(hold_pin) == LOW) {
    Keyboard.press(hold);
    }
  else{
    Keyboard.release(hold);
  }
  //Robit Start
  if (digitalRead(start_pin) == LOW) {
    Keyboard.press(start);
    }
  else{
    Keyboard.release(start);
  }
  
}
