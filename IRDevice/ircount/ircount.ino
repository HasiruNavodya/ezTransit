#include "Arduino.h"


#define IROBJAVOID_1_PIN_OUT  5
#define IROBJAVOID_2_PIN_OUT  4
//#define IROBJAVOID_3_PIN_OUT  0
//#define IROBJAVOID_4_PIN_OUT  2


int ir1 = 5;
int ir2 = 4;
//int ir3 = 0;
//int ir4 = 2;


int count=0;
int i=1;
int sensorState1 = 0;
int sensorState2 = 0;

void setup() 
{
  Serial.begin(9600);
  
  pinMode(ir1, INPUT);
  pinMode(ir2, INPUT);
  //pinMode(ir3, INPUT);
  //pinMode(ir4, INPUT);
}

void loop() 
{ 
  
}
