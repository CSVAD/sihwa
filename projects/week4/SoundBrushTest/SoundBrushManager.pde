enum FFTAveragingMode {
    LINEAR, LOGARITHM;
}

class SoundBrushManager {
  private ArrayList<SoundBrushStroke> soundBrushStrokes;
  private SoundBrushStroke lastStroke;
  private SoundBrushStroke updateStroke;
  private int resolution;
  
  private FFTAveragingMode avgMode;
  private FFT fft;
  private AudioBuffer audioBuffer;
  private float[] audioSamples;
  private float[] fftBands;
  private float spectrumScaleFactor;
  
  private boolean liveUpdate = false;
  private boolean syncAll = false;
  private boolean showWireFrame = false;
  
  private int strokeIndex = 0;
  private int patternIndex = -1;
  private float patternStartAngle = 0;
  
  public SoundBrushManager(AudioBuffer audioBuffer, FFT fft, FFTAveragingMode avgMode, int resolution, float spectrumScaleFactor) {
    
    soundBrushStrokes = new ArrayList<SoundBrushStroke>();
    this.avgMode = avgMode;
    
    this.resolution = resolution;
    this.fft = fft;
    this.audioBuffer = audioBuffer;
    this.spectrumScaleFactor = spectrumScaleFactor;
    
    if(avgMode == FFTAveragingMode.LINEAR) fft.linAverages(resolution);
    else if(avgMode == FFTAveragingMode.LOGARITHM) fft.logAverages(22, resolution / 10);
    fftBands = new float[resolution];
  }
  
  public void addStroke() {
    SoundBrushStroke stroke = new SoundBrushStroke();
    soundBrushStrokes.add(stroke);
    lastStroke = stroke;
  }
  
  public void addStroke(float minHue, float maxHue, float minStrokeWidth, float maxStrokeWidth) {
    SoundBrushStroke stroke = new SoundBrushStroke(minHue, maxHue, minStrokeWidth, maxStrokeWidth);
    soundBrushStrokes.add(stroke);
    lastStroke = stroke;
  }
  
  public void addVertexToCurrentStroke(float x, float y, float z) {
    if(lastStroke != null)
      lastStroke.addVertex(x, y, z, audioSamples, fftBands, this.spectrumScaleFactor, patternStartAngle);
  }
  
  public void proccessNextAudioSamples() {
    audioSamples = in.mix.toArray();
  
    fft.forward(audioSamples);
    for(int i = 0; i < fft.avgSize(); i++) {
      fftBands[i] = fft.getAvg(i);
    }
  }
  
  public void update() {
    proccessNextAudioSamples();
    
    if(liveUpdate) {
      if(syncAll) {
        for(SoundBrushStroke brushStroke: soundBrushStrokes) {
          brushStroke.updateAllPatterns(audioSamples, fftBands);
        }
      } else if(soundBrushStrokes.size() > 0) {
        if(patternIndex == -1) {
          updateStroke = soundBrushStrokes.get(strokeIndex);
          patternIndex = 0;
        }
        
        updateStroke.updatePatternOfIndex(patternIndex, audioSamples, fftBands);
        
        patternIndex++;
        if(patternIndex == updateStroke.size()) {
          patternIndex = -1;
          strokeIndex++;
          
          strokeIndex %= soundBrushStrokes.size();
        }
      }
    }
  }
  
  public void draw() {
    if(showWireFrame) {
      colorMode(RGB, 255);
      stroke(255, 100);
    } else noStroke();
    
    colorMode(HSB, 255);
    
    for(SoundBrushStroke brushStroke: soundBrushStrokes) {
      beginShape(QUAD_STRIP);
      
      for(int i = 1; i < brushStroke.size(); i++) {
        SoundBrushCirclePattern bpPrev = brushStroke.get(i - 1);
        SoundBrushCirclePattern bp = brushStroke.get(i);
        
        ArrayList<PVector> pointsPrev = bpPrev.points;
        ArrayList<PVector> points = bp.points;
        
        int lastIndex = points.size() - 1;
        float hueMax = brushStroke.maxHue;
        float hueMin = brushStroke.minHue;
        float maxMag = brushStroke.maxStrokeWidth * 0.5;
        
        for(int j = 0; j < lastIndex; j++) {
          float hue1 = map(j, 0, points.size(), hueMin, hueMax);
          float hue2 = map(j + 1, 0, points.size(), hueMin, hueMax);
          float sat1 = 255;
          float sat2 = 255;
          float bri1 = 255 * min(pointsPrev.get(j).mag() / maxMag, 1.0);
          float bri2 = 255 * min(points.get(j).mag() / maxMag, 1.0);
          float bri3 = 255 * min(pointsPrev.get(j + 1).mag() / maxMag, 1.0);
          float bri4 = 255 * min(points.get(j + 1).mag() / maxMag, 1.0);
          
          fill(hue1, sat1, bri1);   
          vertex(pointsPrev.get(j).x + bpPrev.center.x, pointsPrev.get(j).y + bpPrev.center.y, bpPrev.center.z);
          fill(hue1, sat1, bri2);
          vertex(points.get(j).x + bp.center.x, points.get(j).y + bp.center.y, bp.center.z);
          
          fill(hue2, sat2, bri3);
          vertex(pointsPrev.get(j + 1).x + bpPrev.center.x, pointsPrev.get(j + 1).y + bpPrev.center.y, bpPrev.center.z);
          fill(hue2, sat2, bri4);
          vertex(points.get(j + 1).x + bp.center.x, points.get(j + 1).y + bp.center.y, bp.center.z);
          
          
        }
        
        float sat1 = 255;
        float sat2 = 255;
        float bri1 = 255 * min(pointsPrev.get(lastIndex).mag() / maxMag, 1.0);
        float bri2 = 255 * min(points.get(lastIndex).mag() / maxMag, 1.0);
        float bri3 = 255 * min(pointsPrev.get(0).mag() / maxMag, 1.0);
        float bri4 = 255 * min(points.get(0).mag() / maxMag, 1.0);
        
        fill(hueMax, sat1, bri1);
        vertex(pointsPrev.get(lastIndex).x + bpPrev.center.x, pointsPrev.get(lastIndex).y + bpPrev.center.y, bpPrev.center.z);
        fill(hueMax, sat1, bri2);
        vertex(points.get(lastIndex).x + bp.center.x, points.get(lastIndex).y + bp.center.y, bp.center.z);
        
        fill(hueMin, sat2, bri3);
        vertex(pointsPrev.get(0).x + bpPrev.center.x, pointsPrev.get(0).y + bpPrev.center.y, bpPrev.center.z);
        fill(hueMin, sat2, bri4);
        vertex(points.get(0).x + bp.center.x, points.get(0).y + bp.center.y, bp.center.z);
      }

      endShape();
    }
  }

  public void setSpectrumScaleFactor(float s) {
    spectrumScaleFactor = s;
  }
  
  public void setPatternStartAngle(float a) {
    patternStartAngle = a;
  }

  public void setLiveUpdate(boolean liveUpdate) {
    this.liveUpdate = liveUpdate;
  }
  
  public void setSyncAll(boolean syncAll) {
    this.syncAll = syncAll;
  }
  
  public void setShowWireFrame(boolean showWireFrame) {
    this.showWireFrame = showWireFrame;
  }
  
  public void clearAllStrokes() {
    soundBrushStrokes.clear();
    lastStroke = null;
    strokeIndex = 0;
    patternIndex = -1;
  }
}
