/******************************
* Sanguino Test Script
******************************/

void setup()
{
  Serial.begin(19200);
  Serial.println("Start");
}

void loop()
{
  int value = 0;
  for (byte i=0; i<8; i++)
  {
    value = analogRead(i);
    Serial.print("analog ");
    Serial.print(i, DEC);
    Serial.print(" is ");
    Serial.println(value, DEC);
    delay(500);
  }
}
