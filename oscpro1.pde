import oscP5.*;
import netP5.*;
import processing.serial.*;
import cc.arduino.*;
Arduino arduino;
PImage img;
int redLED = 5; 

int [] led = new int [2];    // TouchOsc için Toogle buton dizisi yapıldı.

OscP5 oscP5;

void setup()
{
   size(160,310);        // Processing ekran ölçüleri oluşturuldu.
  img = loadImage("offbulb.png");
   oscP5 = new OscP5(this,8000);
//println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[0], 57600);//Arduino firmata seriport nesnesi
arduino.pinMode(redLED, Arduino.OUTPUT);  //Arduino 5 nolu ucu çıkış yapıldı.
}
void oscEvent(OscMessage theOscMessage) {   //  Port dinleyerek bilgisayar toucosc bağlantısı için gerekli işlemler.

    String addr = theOscMessage.addrPattern();  //  Creates a string out of the OSC message
    if(addr.indexOf("/1/toggle") !=-1){   // toggle buttons ayarlamaları 
      int i = int((addr.charAt(9) )) - 0x30;   // dönüşüm  ASCII  0x30
      led[i]  = int(theOscMessage.get(0).floatValue());     //  led[i] butona değer atandı.
    
     
    }
}

void draw(){
 background(255); 
  image(img,5,5);
 if(led[1] == 0){   
   arduino.digitalWrite(redLED, Arduino.LOW); //Led Söndürüldü
   img = loadImage("offbulb.png");   //Ekrana imaj yüklendi
 }
   if(led[1] == 1){       
arduino.digitalWrite(redLED, Arduino.HIGH);   //Led yakıldı
img = loadImage("onbulb.png");  // Ekrana imaj yüklendi
 }
}
