/******************************
 * Sanguino Test Script
 ******************************/

#define LED_SPEED 100

void setup()
{ 
  for (byte i=24; i<32; i++)
  {
    pinMode(i, OUTPUT);
    digitalWrite(i, LOW);
  }

  pinMode(16, OUTPUT);
}

void loop()
{
  int k;
  for (int j=0; j<1000; j++)
  {
    k = j / 4;
    
    digitalWrite(16, HIGH);
    delayMicroseconds(500 - k);
    digitalWrite(16, LOW);
    delayMicroseconds(500 - k);
  }

  while (1)
  {
    for (byte i=24; i<32; i++)
    {
      digitalWrite(i, HIGH);
      delay(LED_SPEED);
    }
    delay(LED_SPEED);

    for (byte i=24; i<32; i++)
    {
      digitalWrite(i, LOW);
      delay(LED_SPEED);
    }
    delay(LED_SPEED);

    for (byte i=24; i<32; i++)
    {
      digitalWrite(i, HIGH);
      delay(LED_SPEED);
      digitalWrite(i, LOW);
    }
    delay(LED_SPEED);
  }
}
