
class SoundBrushStroke {
  private ArrayList<SoundBrushCirclePattern> brushStroke;
  private int patternCount;
  
  float minHue, maxHue;
  float minStrokeWidth, maxStrokeWidth;
  
  public SoundBrushStroke() {
    brushStroke = new ArrayList<SoundBrushCirclePattern>();
    patternCount = 0;

    initStrokeStatus(100, 255, 10, 50);
  }
  
  public SoundBrushStroke(float minHue, float maxHue, float minStrokeWidth, float maxStrokeWidth) {
    brushStroke = new ArrayList<SoundBrushCirclePattern>();
    patternCount = 0;
    initStrokeStatus(minHue, maxHue, minStrokeWidth, maxStrokeWidth);
  }
  
  private void initStrokeStatus(float minHue,float maxHue, float minStrokeWidth, float maxStrokeWidth) {
    this.minHue = minHue;
    this.maxHue = maxHue;
    this.minStrokeWidth = minStrokeWidth;
    this.maxStrokeWidth = maxStrokeWidth;
  }
  
  public void addVertex(float x, float y, float z, float[] audioSamples, float[] fftBands, float spectrumScaleFactor, float startAngle) {
    SoundBrushCirclePattern brushCirclePattern = new SoundBrushCirclePattern(resolution, x, y, z, spectrumScaleFactor, startAngle);    
    brushCirclePattern.setSpectrumRange(minStrokeWidth * 0.5, maxStrokeWidth * 0.5);
    brushCirclePattern.update(audioSamples, fftBands);
    brushStroke.add(brushCirclePattern);
    patternCount++;
  }
  
  public void updateAllPatterns(float[] audioSamples, float[] fftBands) {
    for(SoundBrushCirclePattern brushPattern: brushStroke) {
      brushPattern.update(audioSamples, fftBands);
    }
  }
  
  public void updatePatternOfIndex(int index, float[] audioSamples, float[] fftBands) {
    brushStroke.get(index).update(audioSamples, fftBands);
  }
  
  public int size() {
    return patternCount;
  }
  
  public SoundBrushCirclePattern get(int index) {
    return brushStroke.get(index);
  }
}
