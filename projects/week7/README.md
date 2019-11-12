## Sound Brush Library

This Processing library is based on my week 4 project, *Sound Reactive Generative Brush based on FFT Analysis*. The main goal of this library is to help the user make their own brush that visualizes sound frequecy information, thereby creating artwoks or interactive programs based on the customized brush.

With `SoundBrushCirclePattern` class, the use can map sound frequency values to a circular formation. Here, it is possible to adjust a mapped value range by modifying a scale factor and min/max spectrum values through the methods, such as `setSpectrumRange()`. The class instances are reusable for the new FFT data by using `update()`.

`SoundBrushStroke` class enables the user to draw a line consisting of the multiple instances of `SoundBrushCirclePattern`. For that, it exposes the methods like `addVertex()` and `draw()`. To update drawn lines, the class has `updateAllPatterns()` and `updatePatternOfIndex()`. 

The user can use `SoundBrushManager` to create, manage, update, and draw multiple `SoundBrushStroke` instances. Once the use passes the intances of `AudioBuffer` and `FFT` of the Minim library to the `SoundBrushManager` class instance, the use can easily manage an audio proccesing part by simply calling `update()`. Creating a new stroke and adding new vertices can be done with the methods, such as `addStroke()` and  `addVertexToCurrentStroke()`. Through the use of the methods, `setLiveUpdate()` and `setSyncAll()` , it is possible to update lines responding to sound in real time.

The main approach to choose the key terminology described above is based on each class's prominent behavior or class parameters that affect visuals.

To use this library, [Minim](http://code.compartmental.net/tools/minim/) is required.

### Example Videos

#### 1) Overall demonstration

- https://youtu.be/GnLcdk68MgE

#### 2) Generative mode with real-time sound

- https://youtu.be/DA0-65dhjts
- https://youtu.be/nKSLC-egi04
- https://youtu.be/L0qfQwKpX1g