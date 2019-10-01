// Hello World Portrait
//
// Sihwa Park
// Media Arts and Technology
// sihwapark@ucsb.edu
// 09/30/2019
//
// Description: Julian Opie style self-portrait

float centerX = width / 2;
float centerY = height / 2;
float faceWidth = width * 0.6;
float faceHeight = height * 0.7;

size(600, 600);
background(200, 80, 0);

rectMode(CENTER);
ellipseMode(CENTER);

// ears
fill(200, 140, 100);
strokeWeight(10);
ellipse(centerX - faceWidth * 0.5, centerY, 40, 120);
ellipse(centerX + faceWidth * 0.5, centerY, 40, 120);

// face outline
fill(200, 140, 100);
ellipse(centerX, centerY, faceWidth, faceHeight);

// eyes
fill(0);
circle(centerX - faceWidth * 0.2, centerY - faceHeight * 0.1, 10); 
circle(centerX + faceWidth * 0.2, centerY - faceHeight * 0.1, 10);

fill(200);
noStroke();
circle(centerX - faceWidth * 0.21, centerY - faceHeight * 0.1, 5); 
circle(centerX + faceWidth * 0.19, centerY - faceHeight * 0.1, 5);

// eyebrows
stroke(0);
strokeWeight(12);
strokeCap(SQUARE);
line(centerX - faceWidth * 0.35, centerY - faceHeight * 0.19, centerX - faceWidth * 0.25,  centerY - faceHeight * 0.21);
line(centerX + faceWidth * 0.35, centerY - faceHeight * 0.19, centerX + faceWidth * 0.25,  centerY - faceHeight * 0.21);

strokeWeight(12);
strokeCap(ROUND);
line(centerX - faceWidth * 0.25, centerY - faceHeight * 0.21, centerX - faceWidth * 0.1,  centerY - faceHeight * 0.19);
line(centerX + faceWidth * 0.25, centerY - faceHeight * 0.21, centerX + faceWidth * 0.1,  centerY - faceHeight * 0.19);

// nose
noStroke();
fill(0);
arc(centerX - 6, centerY + faceHeight * 0.15, 25, 15, -PI, -PI + QUARTER_PI);
arc(centerX + 6, centerY + faceHeight * 0.15, 25, 15, TWO_PI - QUARTER_PI, TWO_PI);

// glasses
strokeWeight(10);
stroke(0, 130, 200, 200);
noFill();
arc(centerX - faceWidth * 0.22, centerY - faceHeight * 0.08, 130, 100, PI, TWO_PI);
arc(centerX - faceWidth * 0.22, centerY - faceHeight * 0.08, 130, 130, 0, PI);
arc(centerX + faceWidth * 0.22, centerY - faceHeight * 0.08, 130, 100, PI, TWO_PI);
arc(centerX + faceWidth * 0.22, centerY - faceHeight * 0.08, 130, 130, 0, PI);

stroke(212, 175, 55);
arc(centerX, centerY - faceHeight * 0.09, 30, 20, PI, TWO_PI);

// lip
stroke(0);
line(centerX - faceWidth * 0.1, centerY + faceHeight * 0.295, centerX,  centerY + faceHeight * 0.3);
line(centerX, centerY + faceHeight * 0.3, centerX + faceWidth * 0.1,  centerY + faceHeight * 0.295);
line(centerX - faceWidth * 0.11, centerY + faceHeight * 0.298, centerX - faceWidth * 0.1,  centerY + faceHeight * 0.295);
line(centerX + faceWidth * 0.11, centerY + faceHeight * 0.298, centerX + faceWidth * 0.1,  centerY + faceHeight * 0.295);
line(centerX - faceWidth * 0.03, centerY + faceHeight * 0.34, centerX + faceWidth * 0.03,  centerY + faceHeight * 0.34);

//save("portrait.png");
