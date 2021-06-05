#include "Arduino.h"


#define IROBJAVOID_1_PIN_OUT  5
#define IROBJAVOID_2_PIN_OUT  4
//#define IROBJAVOID_3_PIN_OUT  0
//#define IROBJAVOID_4_PIN_OUT  2


int IR1 = 5;
int IR2 = 4;
//int IR3 = 0;
//int IR4 = 2;


int count=0;
int GateF=1;
int dn = 0;
int IR1S = 0;
int IR2S = 0;

void setup() 
{
  Serial.begin(9600);
  
  pinMode(IR1, INPUT);
  pinMode(IR2, INPUT);
  //pinMode(IR3, INPUT);
  //pinMode(IR4, INPUT);
}

void loop() 
{ 

  if(digitalRead(IR1) == 0){
    if(IR1S == 1){
      sendCount(count++);
      IR1S = 0;
      IR2S = 1; 
    } 
  } 

  if(digitalRead(IR2) == 0){
    if(IR2S == 1){
      sendCount(count--);
      IR2S = 0;
      IR1S = 1;     
    }
  }
  
  //delay(500);
  
}

void sendCount(int c){
  Serial.print("Count: ");
  Serial.print(c);
  Serial.println("");
}
