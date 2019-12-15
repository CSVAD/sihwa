// Create a Parametric 3D Form
//
// Sihwa Park
// Media Arts and Technology
// sihwapark@ucsb.edu
// 12/15/2019
//
// Parametric 3D Lissajous Figures Drawing 
// based on http://www.generative-gestaltung.de/1/M_2_4_01

import controlP5.*;

ControlP5 cp5;

ArrayList<PVector> lissajousPoints;
int maxPoints = 100;
float scaleFactor = 300;
float freqX = 4;
float freqY = 7;
float freqZ = 15;
float phaseX = 0;
float phaseY = 0;
color fillCenterColor = color(50);
color fillColor = color(200);
float lineWeight = 1;
color lineColor = color(255);
boolean showLine = true;

void setup() {
  size(1200, 960, P3D);
  initLissajousPoints();
  
  
  cp5 = new ControlP5(this);
  Group group = cp5.addGroup("Parameter Control")
                .setPosition(10,20)
                .setBackgroundHeight(100)
                .setSize(250, 700)
                .setBackgroundColor(color(255, 50));
  
  cp5.addSlider("maxPoints")
  .setGroup(group)
  .setPosition(10, 10)
  .setSize(160, 20)
  .setRange(1, 500)
  .setValue(100);
  
  cp5.addSlider("scaleFactor")
  .setGroup(group)
  .setPosition(10, 40)
  .setSize(160, 20)
  .setRange(1, height / 2)
  .setValue(300);
  
  cp5.addSlider("freqX")
  .setGroup(group)
  .setPosition(10, 70)
  .setSize(160, 20)
  .setRange(1, 200)
  .setValue(4);
  
  cp5.addSlider("freqY")
  .setGroup(group)
  .setPosition(10, 100)
  .setSize(160, 20)
  .setRange(1, 200)
  .setValue(7);
  
  cp5.addSlider("freqZ")
  .setGroup(group)
  .setPosition(10, 130)
  .setSize(160, 20)
  .setRange(1, 200)
  .setValue(15);
  
  cp5.addSlider("phaseX")
  .setGroup(group)
  .setPosition(10, 160)
  .setSize(160, 20)
  .setRange(0, 180)
  .setValue(0);
  
  cp5.addSlider("phaseY")
  .setGroup(group)
  .setPosition(10, 190)
  .setSize(160, 20)
  .setRange(0, 180)
  .setValue(0);
  
  cp5.addColorWheel("fillCenterColor")
  .setGroup(group)
  .setPosition(10, 220)
  .setRGB(fillCenterColor);
  
  cp5.addColorWheel("fillColor")
  .setGroup(group)
  .setPosition(10, 440)
  .setRGB(fillColor);
  
  cp5.addToggle("showLine")
  .setGroup(group)
  .setPosition(10, 660)
  .setSize(20,20)
  .setValue(true);
}

void maxPoints(int p) {
  maxPoints = p;
  initLissajousPoints();
}

void scaleFactor(float s) {
  scaleFactor = s;
  initLissajousPoints();
}

void freqX(float f) {
  freqX = f;
  initLissajousPoints();
}

void freqY(float f) {
  freqY = f;
  initLissajousPoints();
}

void freqZ(float f) {
  freqZ = f;
  initLissajousPoints();
}

void phaseX(float p) {
  phaseX = p;
  initLissajousPoints();
}

void phaseY(float p) {
  phaseY = p;
  initLissajousPoints();
}

void showLine(boolean s) {
  showLine = s;
}

void draw() {
  background(0);
  drawLissajous();
}

void initLissajousPoints() {
  lissajousPoints = new ArrayList<PVector>(maxPoints);
  
  for(int i = 0; i < maxPoints; i++) {
    float angle = map(i, 0, maxPoints - 1, 0, TWO_PI);
     
    float x = sin(angle * freqX + radians(phaseX)) * sin(angle * 2) * scaleFactor;
    float y = sin(angle * freqY + radians(phaseY)) * scaleFactor;
    float z = sin(angle * freqZ) * scaleFactor;
    
    lissajousPoints.add(new PVector(x, y, z));
  }
}

void drawLissajous() {

  pushMatrix();
  translate(width / 2, height / 2);
  rotateX(-rotationX);
  rotateY(rotationY); 
  beginShape(TRIANGLE_FAN);
  
  if(showLine) {
    stroke(lineColor); 
    strokeWeight(lineWeight);
  } else noStroke();
  
  for(int i = 0; i < maxPoints - 1; i++) {
      fill(fillCenterColor);
      vertex(0, 0, 0);
      fill(fillColor);
      PVector p1 = lissajousPoints.get(i);
      PVector p2 = lissajousPoints.get(i + 1);
      vertex(p1.x, p1.y, p1.z);
      vertex(p2.x, p2.y, p2.z);
  }
  
  endShape();
  
  popMatrix();
}

void keyPressed() {
 if(key == ' ') {
    saveImage();
  }
}

void saveImage() {
  save("screenshot_" + year() + month() + day() + hour() + minute() + second() +".png");
}

// the below mouse rotation code is adapted from http://www.generative-gestaltung.de/1/M_2_4_01
int offsetX = 0, offsetY = 0, clickX = 0, clickY = 0;
float rotationX = 0, rotationY = 0;
float targetRotationX = 0, targetRotationY = 0; 
float clickRotationX, clickRotationY; 

void mousePressed(){
  clickX = mouseX;
  clickY = mouseY;
  clickRotationX = rotationX;
  clickRotationY = rotationY;
}

void mouseDragged() {
  if (mousePressed && mouseButton==RIGHT) {
    offsetX = mouseX-clickX;
    offsetY = mouseY-clickY;
    targetRotationX = min(max(clickRotationX + offsetY/float(width) * TWO_PI, -HALF_PI), HALF_PI);
    targetRotationY = clickRotationY + offsetX/float(height) * TWO_PI;
  }
  
  rotationX += (targetRotationX-rotationX)*0.25; 
  rotationY += (targetRotationY-rotationY)*0.25;  
}
