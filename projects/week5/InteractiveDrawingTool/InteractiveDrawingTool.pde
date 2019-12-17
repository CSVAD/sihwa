import drawing.library.*;
import processing.pdf.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import controlP5.*;

Minim       minim;
FFT         fft;
AudioInput in;
float[] fftBands;

float minStrokeWidth = 50, maxStrokeWidth = 300;
float brushPatternStartAngle = 0;
float spectrumScaleFactor = 3.0f;
int resolution = 100; 
int minHue = 200, maxHue = 255;

DrawingManager drawingManager;

void setup() {
  size(1056, 816, P3D);
  background(255);
  smooth();
  
  drawingManager = new DrawingManager(this);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.window(FFT.HAMMING);
  fft.logAverages(22, resolution / 10);
   
  fftBands = new float[resolution];
} 

public void proccessNextAudioSamples() {
  fft.forward(in.mix);
  for(int i = 0; i < fft.avgSize(); i++) {
    fftBands[i] = fft.getAvg(i);
  }
}
  
void draw() {
  proccessNextAudioSamples();
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
}

void mousePressed(){
  SoundBrushCirclePattern brushCirclePattern = new SoundBrushCirclePattern(resolution, mouseX, mouseY, spectrumScaleFactor, brushPatternStartAngle);
  brushCirclePattern.setSpectrumRange(minStrokeWidth * 0.5, maxStrokeWidth * 0.5);
  brushCirclePattern.addPattern(fftBands);
}
  
void mouseDragged(){
  SoundBrushCirclePattern brushCirclePattern = new SoundBrushCirclePattern(resolution, mouseX, mouseY, spectrumScaleFactor, brushPatternStartAngle);
  brushCirclePattern.setSpectrumRange(minStrokeWidth * 0.5, maxStrokeWidth * 0.5);
  brushCirclePattern.addPattern(fftBands);
}
