#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

#define SWITCHPIN 8

int displayState = HIGH;
int oldState = LOW;

void setup() {
  pinMode(SWITCHPIN, INPUT);
  Serial.begin(9600);
  lcd.begin(16, 2);
  printLCD("Waiting for", "weather data...");
}

void loop() {
  readStr();
}

void printLCD(String temp, String desc) {
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print(temp);
  lcd.setCursor(0,1);
  lcd.print(desc);
}

void readStr() {
  while (Serial.available() < 32) { 
    //handleSwitch();
    delay(10); 
  }
  String tempStr = readChars(16);
  String descStr = readChars(16);
  printLCD(tempStr, descStr);
  while (Serial.available() != 0) { Serial.read(); }
} 

String readChars(int chars) {
  String out = "";
  for (int i = 0; i < chars; i++) { out += (char) Serial.read(); }
  return out;
}

void handleSwitch() {  
  int newState = digitalRead(SWITCHPIN);  
//  if ((newState == HIGH) && (oldState == LOW)) { toggleDisplay(); }
  lcd.clear();
  lcd.setCursor(0,0); 
  lcd.print(newState);
  oldState = newState;
}

void toggleDisplay() {
  lcd.clear();
  if (displayState == HIGH) {
    lcd.noDisplay();
    displayState = LOW;
  } else {
    lcd.display();
    displayState = HIGH;
  }
}

