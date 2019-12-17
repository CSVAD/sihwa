## A Drawing Tool with the DrawingManager library

This Processing sketch presents a brush tool based on my Week4 assgiment, Sound Reactive Generative Brush that allows the user to draw lines that visualize the frequency spectrum of audio data coming from a mic in real time. Based on the FFT analysis of the Processing audio library, Minim, it visualizes the frequency spectrum as a circular shape which is used as a basic brush pattern. 

The user can change the below parameters to vary a drawing pattern:

```java
float minStrokeWidth = 50, maxStrokeWidth = 300;
float brushPatternStartAngle = 0;
float spectrumScaleFactor = 3.0f;
int resolution = 100; 
int minHue = 0, maxHue = 255;
```