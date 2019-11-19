// Create a Plotter Drawing
//
// Sihwa Park
// sihwapark[at]ucsb.edu
// 11/18/2019
//

import processing.pdf.*;
import geomerative.*;

IntDict dictionary = new IntDict();
ArrayList<RPoint[]> pointsList = new ArrayList<RPoint[]>();

void setup() {
  size(792, 612);
  
  RG.init(this);
  
  String[] lines = loadStrings("PlottableDrawing.pde");
  for(int i = 0; i < lines.length; i++) {
    for(char ch : lines[i].toCharArray()) {
      if(ch == ' ') continue;
      if(dictionary.hasKey(str(ch)) == false) {
        dictionary.set(str(ch), 1);
      } else {
        dictionary.increment(str(ch));
      }
    }
  }
  
  dictionary.sortKeys();
  println(dictionary);
  
  int size = dictionary.size();
  int columns = (int)floor(sqrt(size));
  int rows = (int)ceil(sqrt(size));
  if(rows * columns < size) columns += 1;
  int margin = 5;
  int gridWidth = (width - margin) / columns;
  int gridHeight = (height - margin) / rows;
  int fontSize = (int)(gridHeight * 1.1); //min(gridWidth, gridHeight);
  
  println(columns, rows, gridWidth, gridHeight, fontSize); 
  
  RG.setPolygonizer(RG.UNIFORMLENGTH);
  RG.setPolygonizerLength(floor(fontSize * 0.11));
  for(int i = 0; i < dictionary.size(); i++) {
    RShape grp = RG.getText(dictionary.key(i), "Courier New Bold.ttf", fontSize, CENTER);
    //RShape grp = RG.getText(dictionary.key(i), "Verdana Bold.ttf", (int)(fontSize * 0.8), CENTER);
    
    RPoint[] points = grp.getPoints(); 
    pointsList.add(points);
  }

  noFill();
  stroke(0);
  randomSeed(1);
  int index = 0;
  
  beginRecord(PDF, "plot1" + String.format("%4d%02d%02d%02d%02d%02d", 
                                year(), month(), day(), hour(), minute(), second()) + ".pdf");
  
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < columns; j++) {
      if(index < size) {
        
        float centerX = margin * 0.5 + gridWidth * j + fontSize * 0.6;
        float centerY = margin * 0.5 + gridHeight * i + gridHeight * 0.8;
        
        RPoint[] points = pointsList.get(index);
        if(points != null){
          int pointCount = points.length;
          stroke(255, 0, 0);
          for(int k = 0; k < pointCount; k++) {
            ellipse(points[k].x + centerX, points[k].y + centerY, 3, 3);  
          }
        }
        index++;
      }
    }
  }
  endRecord();
  
  index = 0;
  beginRecord(PDF, "plot2" + String.format("%4d%02d%02d%02d%02d%02d",
                                year(), month(), day(), hour(), minute(), second()) + ".pdf");
  
  for(int i = 0; i < rows; i++) {
    for(int j = 0; j < columns; j++) {
      if(index < size) {
        
        float centerX = margin * 0.5 + gridWidth * j + fontSize * 0.6;
        float centerY = margin * 0.5 + gridHeight * i + gridHeight * 0.8;
        
        RPoint[] points = pointsList.get(index);
        if(points != null){
          int pointCount = points.length;
          
          noFill();
          stroke(0);
          int maxLines = min(dictionary.value(index), 100);
          //int maxLines = dictionary.value(index);
          int maxRange = 3;

          for(int k = 0; k < maxLines; k++) {
            beginShape();
            int p1 = (int)(random(1) * pointCount);
            curveVertex(points[p1].x + centerX, points[p1].y + centerY);
            curveVertex(points[p1].x + centerX, points[p1].y + centerY);
            
            int p2 = (int)(random(1) * maxRange * 2 + p1);
            while(p2 == p1) p2 = (int)(random(1) * maxRange * 2 + p1);
            while(p2 >= pointCount) p2 -= pointCount;
            curveVertex(points[p2].x + centerX, points[p2].y + centerY);
            
            int p3 = (int)(random(1) * maxRange + p2);
            while(p3 == p2 || p3 == p1) p3 = (int)(random(1) * maxRange + p2);
            while(p3 >= pointCount) p3 -= pointCount;
            
            curveVertex(points[p3].x + centerX, points[p3].y + centerY);
            curveVertex(points[p3].x + centerX, points[p3].y + centerY);
            endShape();
          }
        }
        index++;
      }
    }
  }
  endRecord();
  noLoop();
}
