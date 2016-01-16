#include <LiquidCrystal.h>
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  Serial.begin(9600);
  lcd.begin(16, 2);
}

void loop() {
  // put your main code here, to run repeatedly:
  readStr();
  delay(1000);
}

void printLCD(String temp, String desc) {
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print(temp);
  lcd.setCursor(0,1);
  lcd.print(desc);
}

void readStr() {
  String tempStr = "";
  String descStr = "";
  while (Serial.available() == 0) { delay(100); }
  delay(100);
  char c = Serial.read();
  while ((byte) c != 0xff) { c = Serial.read(); }
  c = Serial.read();
  while ((byte) c != 0xfe) {
    tempStr += c;
    c = Serial.read();
//    printLCD("temperature", tempStr);
//    delay(20);
 }
// delay(100);
 while ((byte) c != 0xfd) {
   descStr += c;
   c = Serial.read();
//   printLCD("description", descStr);
//   delay(20);
 }
// delay(100);
 printLCD(tempStr, descStr);
 return;
} 

