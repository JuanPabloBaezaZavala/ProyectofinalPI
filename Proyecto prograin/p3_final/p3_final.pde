PShape cabeza;
int x;
int y;
int radio = 100;
int r, g, b;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup () {
  size (800, 800, P3D);
  cabeza = loadShape ("cara.obj");
  frameRate(24);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 12001);
  noStroke();
  fill(200);
}


void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/direccion")==true) {
    int firstValue = theOscMessage.get(0).intValue();  
    x = firstValue;
    y = firstValue;
  } 
  if (theOscMessage.checkAddrPattern("/rojo")==true) {
    int firstValue = theOscMessage.get(0).intValue();  
    r = firstValue;
  } 
  if (theOscMessage.checkAddrPattern("/verde")==true) {
    int firstValue = theOscMessage.get(0).intValue();  
    g = firstValue;
  } 
  if (theOscMessage.checkAddrPattern("/azul")==true) {
    int firstValue = theOscMessage.get(0).intValue();  
    b = firstValue;
  } 
  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}

void draw () {
  noStroke();
  background(0);
  //float dirX = (x / float(width) - 0.5) * 2;
  //float dirY = (y / float(height) - 0.5) * 2;
  float dirX = (x / PI - 0.00001) - 0.0005;
  float dirY = (y / PI - 0.00001) - 0.0005;
  directionalLight (200, 200, 200, dirX, -CENTER * PI * 15/*rango dinamico*/, -CENTER);
  directionalLight (50, 50, 50, dirY, CENTER * PI/*rango dinamico*/, -CENTER);
  directionalLight (r, 0, 0, x, y * PI, -CENTER);
  directionalLight (0, g, 0, x, CENTER, -CENTER);
  directionalLight (0, 0, b, dirX, -CENTER, -CENTER);
  directionalLight (200, 200, 200, dirX, CENTER, CENTER);//luz relleno
  translate(width/2, height/2, 0);
  shape(cabeza);
  //sphere(200);
  //translate(200, 200, 0);
}
