void setup() {
  Serial.begin(9600);
  Serial.println('0');
  pinMode(2, OUTPUT);
}

void loop() {
  if(Serial.available()>0){
    char inByte=Serial.read();
    int sensor = analogRead(A0);
    delay(1);
    Serial.println(sensor);
    digitalWrite(2, inByte);
  }
}
