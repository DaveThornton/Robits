#include <Keyboard.h>
//Robits Controller ver 1.1
//Robits Player 07

const int coin_pin = 10;
const int up_pin = 2;
const int left_pin = 3;
const int down_pin = 4;
const int right_pin = 5;
const int pick_pin = 8;
const int shoot_pin = 6;
const int jump_pin = 7;
const int start_pin = 9;

char coin = '7';
char up = 240;
char left = 241;
char down = 242;
char right = 243;
char pick = 200;
char shoot = 202;
char jump = 203;
char start = 205;

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
  //Robit Start
  if (digitalRead(start_pin) == LOW) {
    Keyboard.press(start);
    }
  else{
    Keyboard.release(start);
  }
  
}
