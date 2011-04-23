void setup()
{ 
  pinMode(1, OUTPUT);
  Serial.begin(19200);
  Serial.println("Hello LED");
}

void loop()
{
    digitalWrite(1, HIGH);
    delay(1000);
    Serial.println((long)millis());
    digitalWrite(1, LOW);
    delay(1000);
    Serial.println((long)millis());
}
