#include "Arduino.h"
#include "ESP8266WiFi.h" 
#include "FirebaseESP8266.h" 

#define FIREBASE_HOST "tma42-898f9-default-rtdb.firebaseio.com" 
#define FIREBASE_AUTH "M9XrPT5rh7YiU5PDJPTOXfPxpngbJEswOtAC6gcv" 

#define WIFI_SSID "SLT-4G-8490" 
#define WIFI_PASSWORD "1GQ7AG7B81F"


FirebaseData firebaseData;
FirebaseData ledData;
FirebaseJson json;

//#define IROBJAVOID_1_PIN_OUT  5
//#define IROBJAVOID_2_PIN_OUT  4
//#define IROBJAVOID_3_PIN_OUT  0
//#define IROBJAVOID_4_PIN_OUT  2
//#define LED 14  


int IR1 = 5;
int IR2 = 4;
//int IR3 = 0;
//int IR4 = 2;
int LEDR = 14;
int LEDG = 12;


int count=0;
int GateF=1;
int dn = 0;
int IR1S = 1;
int IR2S = 1;

void setup() 
{
  Serial.begin(9600);
  
  pinMode(IR1, INPUT);
  pinMode(IR2, INPUT);
  //pinMode(IR3, INPUT);
  //pinMode(IR4, INPUT);
  pinMode(LEDG, OUTPUT);
  pinMode(LEDR, OUTPUT);
  
  delay (1000);
  WiFi.begin (WIFI_SSID, WIFI_PASSWORD); 
  Serial.print ("Connecting to");
  Serial.print (WIFI_SSID);
  while (WiFi.status()!= WL_CONNECTED) {
    Serial.print (".");
    delay (500);
  }
  Serial.println ();
  Serial.print ("Connected to");
  Serial.print (" ");
  Serial.println (WIFI_SSID);
  Serial.print ("IP Address is:");
  Serial.println (WiFi.localIP ()); 
  Firebase.begin (FIREBASE_HOST, FIREBASE_AUTH);
  digitalWrite(LEDG, HIGH);
}

void loop() 
{ 

  if(digitalRead(IR1) == 0){
    if(dn==0){
      dn=1; 
      digitalWrite(LEDR, HIGH);
      digitalWrite(LEDG, LOW);
    }
    if(dn==2){
      sendCount(--count);
    }
  }

  if(digitalRead(IR2) == 0){
    if(dn==0){
      dn=2;
      digitalWrite(LEDR, HIGH);
      digitalWrite(LEDG, LOW); 
    }
    if(dn==1){
      sendCount(++count); 
    }
  }
  
  //delay(500);
  
}

void reset(){
  delay(500);
  dn=0;
  digitalWrite(LEDG, HIGH);
  digitalWrite(LEDR, LOW);
  Serial.println(" | Sensors Resetted");
}

void sendCount(int c){
  if(c >= 0){
    Serial.print("Count: ");
    Serial.print(c);
    Serial.print(" | ");
    if (Firebase.setFloat(firebaseData, "/PCount/GE-3412", c))
    {
      Serial.print("Database Updated");
    }
    else
    {
      Serial.print("Database Update Failed!"); 
    }
  }else{
    Serial.print("No passengers in bus");
  }
  reset();
}
