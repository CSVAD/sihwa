## Final Project Proposal

### ARLooper

![ARLooper](ARLooper.gif)

As the final project, I will continue to work on my work-in-progress project, *ARLooper*, an AR-based iOS application for multi-user sound recording and performance, that aims to explore the possibility of actively using mobile AR technology in creating novel musical interfaces and collaborative audiovisual experience. *ARLooper* allows the user to record sound through microphones in mobile devices and, at the same time, visualizes and places recorded sounds as 3D waveforms in an AR space. The user can play, modify, and loop the recorded sounds with several audio filters attached to each sound.  Also, it enables multiple users to connect to the same AR space by sharing and synchronizing the world map data. In this shared AR space, the user can see each other’s 3D waveforms and activities, such as selection and manipulation of them, as a result, having a potential of collaborative AR performance.

Project link: https://sihwapark.com/ARLooper



The goals for the final project would be considered as below :

- Updating sound visualization<sup>**</sup> 
  - Visualizing and coloring according to the frequency spectrum of sound (as I did in the Sound Brush Library project)
  - Making the animation of a waveform while it is playing
    - A visual indicator showing a current playback position
    - Visualizing who is playing the waveform
    - Responding to the change of the parameters of sound filters/effects
      - Showing changes along with the original shape for a comparison purpose (e.g., wireframe)
        - Gain, rotation only?
- New drawing mode<sup>**</sup> 
  - Current: each vertex in drawing a 3D waveform is only relying on a device's position in a space
    - Problem: if there is no movement, the vertices of the waveform overlap in the same position
  - New: drawing reflecting movement and time changes
    - if the user moves the device, it draws a waveform along with the movement path
    - if not, it pushes the vertices of the current waveform outward (along z-axis) and draws the new vertex foremost to the screen
- Improving UI <sup>*,**</sup> 
  - GUIs for controlling the parameters used in the sound visualization
  - Improving the current sound control GUI
    - Feature for organizing the order of sliders
    - Updating the 2D waveform view
      - Selecting a playback range
      - Showing a playback position
    - (Optional)Sequencing the changes of sound parameters
  - Improving/adding multi-touch gesture interaction
- Saving/Loading audio and visual contents<sup>*</sup> 
  - Saving
    - Audio files
    - 3D waveforms
    - [AR WorldMap](https://developer.apple.com/documentation/arkit/arworldmap) data which is used by iOS ARKit
  - Loading
    - Showing a list of saved A/V contents along with the WorldMap data
    - Showing a image as a frame of reference to sync/match with a select WorldMap
    - Placing AR waveforms at locations where they are created



\* Primary implementation challenges

** Primary design challenges
