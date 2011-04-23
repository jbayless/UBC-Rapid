void setup()
{
  Serial.begin(19200);
  Serial.println("Started");
  
  attachInterrupt(0, button0, RISING);
  attachInterrupt(1, button1, RISING);
  attachInterrupt(2, button2, RISING);
}

void loop()
{
  Serial.println("tick");
  delay(2000);
}

void button0()
{
  Serial.println("button 0 pressed");
}

void button1()
{
  Serial.println("button 1 pressed");
}

void button2()
{
  Serial.println("button 2 pressed");
}
