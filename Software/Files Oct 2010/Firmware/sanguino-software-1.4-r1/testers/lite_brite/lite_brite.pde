/******************************
* Sanguino Test Script
******************************/

byte pwm[] = {3, 4, 12, 13, 14, 15};

#define LED_SPEED 100

void setup()
{
  //Serial.begin(19200);
  //Serial.println("start");
  
  for (byte i=0; i<32; i++)
  {
    pinMode(i, OUTPUT);
  }
}

void loop()
{
  for (byte i=0; i<32; i++)
  {
    digitalWrite(i, HIGH);
    delay(LED_SPEED);
  }
  delay(LED_SPEED);
  
  for (byte i=0; i<32; i++)
  {
    digitalWrite(i, LOW);
    delay(LED_SPEED);
  }
  delay(LED_SPEED);

  for (byte i=0; i<32; i++)
  {
    digitalWrite(i, HIGH);
    delay(LED_SPEED);
    digitalWrite(i, LOW);
  }
  delay(LED_SPEED);

  for (byte i=0; i<6; i++)
  {   
    for (byte j=0; j<255; j++)
    {
      analogWrite(pwm[i], j);
      delay(LED_SPEED/20);
    }
    analogWrite(pwm[i], 0);
  }
  delay(LED_SPEED);
}
