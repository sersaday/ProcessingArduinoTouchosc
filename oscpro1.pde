import oscP5.*;
import netP5.*;
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
PImage img;
int redLED = 5; 

int [] led = new int [2];    //  Array allows us to add more toggle buttons in TouchOSC

OscP5 oscP5;

void setup()
{
   size(160,310);        // Processing screen size
  img = loadImage("offbulb.png");
   oscP5 = new OscP5(this,8000);
//println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[0], 57600);
arduino.pinMode(redLED, Arduino.OUTPUT);
}
void oscEvent(OscMessage theOscMessage) {   //  This runs whenever there is a new OSC message

    String addr = theOscMessage.addrPattern();  //  Creates a string out of the OSC message
    if(addr.indexOf("/1/toggle") !=-1){   // Filters out any toggle buttons
      int i = int((addr.charAt(9) )) - 0x30;   // returns the ASCII number so convert into a real number by subtracting 0x30
      led[i]  = int(theOscMessage.get(0).floatValue());     //  Puts button value into led[i]
    // Button values can be read by using led[0], led[1], led[2], etc.
     
    }
}

void draw(){
 background(255); 
  image(img,5,5);
 if(led[1] == 0){   
   arduino.digitalWrite(redLED, Arduino.LOW);
   img = loadImage("offbulb.png");
 }
   if(led[1] == 1){       
arduino.digitalWrite(redLED, Arduino.HIGH);
img = loadImage("onbulb.png");
 
}
  
}