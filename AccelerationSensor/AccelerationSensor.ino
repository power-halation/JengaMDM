namespace {
  const int AVERAGE_NUM = 10;
}

bool first = true;
int basex,basey,basez;
void setup()
{
  Serial.begin(9600);
}

void readAccelerometer()
{
  int x = 0, y = 0, z = 0;
  if(first){
    first = false;   
    for (int i = 0; i < AVERAGE_NUM; ++i) {
      x += analogRead(3);
      y += analogRead(4);
      z += analogRead(5);
    }
    basex = x / AVERAGE_NUM;
    basey = y / AVERAGE_NUM;
    basez = z / AVERAGE_NUM;
  }
  x = y = z = 0;
  for (int i = 0; i < AVERAGE_NUM; ++i) {
    x += (analogRead(3) - basex) / 100;
    y += (analogRead(4) - basey) / 100;
    z += (analogRead(5) - basez) / 100;
  }

  Serial.print(x);
  Serial.print("\t");
  Serial.print(y);
  Serial.print("\t");
  Serial.print(z);
  Serial.print("\t");
  Serial.println("");
}

void loop()
{
  readAccelerometer();
}
