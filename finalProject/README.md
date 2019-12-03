## ARLooper - Final Project Proposal (Revised)

### Feedback

To extend ARLooper for collaborative performance settings and to think about each goal in the context of collaborative performance:

- What information is essential to communicate to each performer?
- How should the UI be designed to best facilitate collaborative performance?
- Are sliders the best option? Could you give people control over some parameters of the visualization through forms of interaction that would not interfere with live performance?

Overall, trying to highlight some of the primary challenges of collaborative performance, and design the features of your app to address these challenges could help to distinguish it from other AR-based drawing apps.

### Progress Report

- **Technical challenges (that significantly affected a design decision)**
  - **The unstable network connection of multiple users** has been the biggest problem of ARLooper. For example, after two or more users establish peer-to-peer connections among the users, the connections of the peers irregularly get disconnected in a couple of minutes. This disconnection usually happens after drawing some waveforms and sharing the vertices data and recorded sound files of them.
  - I figured out that it is mainly because of **the excessive use of threads** for multiple tasks such as drawing and sharing vertices, sending and receiving sound files, and sharing interaction/sound parameter data. 
  - In general, ARKit works properly with a given **frame rate** (of which the default is **120 fps**), tracking physical environments, combining them with motion sensor data, and rendering AR Anchors which are 3D AR objects. But, if an app cannot guarantee the frame rate for ARKit by executing other tasks, it may not properly track and render an AR scene, causing a deadlock or the re-initialization of the current AR session. It may also disconnect multi peer networking services running as a background task.

- **Workaround for the challenges**
  - I reduced the ARKit frame rate to **30 fps**. It would not give the smooth rendering of an AR scene but it could secure a better networking performance.
  - To lessen the load of threading, I re-organized **the threading structure of ARLooper**; Using a TCP streaming for sharing vertices, using a dedicated thread queue for user interaction data, in which tasks are executed concurrently with a high priority, sharing files with a lower priority global background thread.
  - **A background thread for reading microphone input** in real time had been always on even when the user is not recording. So, I made it turn on only when the user records sound otherwise it is off.
  - The use of FFT analysis also caused a severe delay in rendering and processing. So, I decided **not to use FFT information** for drawing 3D waveforms. 

### Revised Goals

For the final project, I will mainly focus on the design features that can support collaborative aspects in performance settings.

- **3D waveform re-design**
  - The previous version was a flat and 3D line-like waveform based on amplitude values.
  - A new design will be **a 3D tunnel/tube waveform**; This new design could help the user guess how recorded/shared waveforms would sound by seeing the waveforms from various angles.

- **Visualization and coloring to reflect the ownership of waveforms**
  - Each user will have **an identifiable color**; for example, user A is red and user B is blue. A GUI for selecting an ID color and showing joined users' ID colors will be given.
  - An ID color is also used as a based color for waveforms **to indicate the status of waveforms**:
    - Waveform **default/idle status:** filled with a darker ID color indicating the user with the ID color created and no one is owning, controlling or playing.
    - **Selected**: Showing a bounding box with an ID color; the user with the ID color is selected and may control sound parameters.
    - **Playing**: The upper half of the waveform will be the ID color of the user who plays the sound and the lower half of the waveform will maintain the ID color of the user who created.
    - The possible user scenario of a combined status: 
      - User A creates a waveform (with A's ID color)
      - User B selects and plays the waveform and then deselects the waveform. (Its upper half now becomes B's ID color; Its sound comes out from B's device)
      - User C selects the waveform and changes parameters. (A bounding box with C's ID color appears; The sound still plays through B's device)

  - When a waveform is playing, **an animation effect** will be applied to it **to represent a playback position.**

- **Improving UI for sound parameter control**
  - Showing what sound parameters are changing and giving immediate control for parameters of interest will be one of the key design aspects for collaborative performance.
  - Considering **the current slider-based GUI is for precise control**, **a multitouch-based GUI for immediate control** will be given:
    - If the user taps a waveform, **1-5 draggable circles** will show up around the center of the screen; these circles work as 2D GUI that sticks to the screen regardless of an AR physical scene. They also indicate locations where the user can place fingers. Each circle is mapped to a sound filter parameter. A distance from the center to each circle represents the parameter value; The longer the distance is, the higher the value is.
    - If the user double-taps a waveform, the slider-based GUI will appear. With checkboxes on the GUI, the user can choose parameters that will be used in the immediate control mode.
    - For the other users who watch someone controlling a waveform with the multitouch UI, it will draw 3D circles around a waveform.
  - (Optional idea) In playing a waveform, triggering of audio samples by moving a device though the waveform itself would increase the direct manipulation capability. This mode will give the user a better and intuitive understanding of where the other users are playing sound through their gestures. It will be an option in the GUI to turn on and off this mode.