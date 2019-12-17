class SoundBrushCirclePattern {
  private ArrayList<DPoint> initPoints;
  DShape shape;
  private int resolution;
  private float angleUnit;
  private float scaleFactor;
  DPoint center;
  private float minSpectrumValue, maxSpectrumValue;
  private float startAngle;
  
  public SoundBrushCirclePattern(int res, float centerX, float centerY) {
    resolution = res;
    
    center = new DPoint(centerX, centerY);
    scaleFactor = 1.0f;
    startAngle = 0;
    initCircleShape();
  }
  
  public SoundBrushCirclePattern(int res, float centerX, float centerY, float scale, float angle) {
    resolution = res;
    
    center = new DPoint(centerX, centerY);
    scaleFactor = scale;
    startAngle = angle; 
    initCircleShape(); 
  }
  
  private void initCircleShape() {
    initPoints = new ArrayList<DPoint>(resolution);
    
    angleUnit = TWO_PI / (float)resolution;
    for(int i = 0; i < resolution; i++) {
      float x = cos(angleUnit * i + startAngle);
      float y = sin(angleUnit * i + startAngle);
      DPoint p = new DPoint(x, y);
      this.initPoints.add(p);
    }
  }
  
  public void setSpectrumRange(float min, float max) {
    minSpectrumValue = min;
    maxSpectrumValue = max;
  }
  
  public void addPattern(float[] fft) {
    if(initPoints == null || initPoints.size() == 0) return;
    
    float maxMag = maxStrokeWidth * 0.5;
    
    for(int i = 0; i < fft.length - 1; i++) {
      
      DPoint initP1 = initPoints.get(i);
      DPoint initP2 = initPoints.get(i + 1);
      float r1 = min(minSpectrumValue + fft[i] * scaleFactor, maxSpectrumValue);
      float x1 = initP1.x * r1;
      float y1 = initP1.y * r1;
      
      float r2 = min(minSpectrumValue + fft[i + 1] * scaleFactor, maxSpectrumValue);
      float x2 = initP2.x * r2;
      float y2 = initP2.y * r2;
      
     
      int hue = int(map(i, 0, initPoints.size(), minHue, maxHue));
      int sat = 255;
      int bri = int(255 * min(r1 / maxMag, 1));
      
      colorMode(HSB, 255);
      color c = color(hue, sat, bri);
      colorMode(RGB, 255);
      int r = int(red(c));
      int g = int(green(c));
      int b = int(blue(c));
      
      drawingManager.stroke(r, g, b);
      
      shape = drawingManager.addShape();
      shape.translate(center.x, center.y);
      shape.addVertex(0, 0);
      shape.addVertex(x1, y1);
      shape.addVertex(x2, y2);
      shape.addVertex(0, 0);
    }
  }
}
