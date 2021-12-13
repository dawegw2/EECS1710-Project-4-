# EECS1710-Project-4-
Final Project: Synaesthetic Instrument - A Basic Drum and Synth Sequencer 

For this project I created a basic visual drum and synth sequencer that can be played use your computer keyboard, a midi keyboard and your mouse. 

The Instrument:
- 5 dfferent waveforms (Sine, triangle, saw, square and a random harmonic waves)
- Notes can be played using the keyboard, where the home row keys are the natural notes and the row of keys above are the sharp and flat notes. ('a' being C4 and 'k' being the octave)
- Adjustable note length, harmonics, volume and gain sliders and knobs 
-"GainMouseControl" toggles adjusting gain according the the mouseY position 
- "ClickNotes" toggles the ability to click and play notes

Drum Machine: 
- 4 different sounds including a open hi hat, hi hat, snare and kick
- Counts in 16th notes
- The BPM is adjustable (ranging from 20 - 500 BPM)
- Play/Pause button
- The drum machine has low pass filter mapped to the mouse x position

Visuals:
- Utalized the map function many times to map the audio to certain visual aspects
- Harmonics knob is mapped to the amount of points on the sun/polygon
- Stars and sun rotation speed up with the BPM 
- Size of sun gets bigger with the drum frequencies 
- Amplitude or Volume of the waveforms adjust the blue rgb setting of the colors (adds a blue tint when a note is played)
- Wave form frequencies map to sun color change 
- Gain knob is mapped to the height of the sun and color of the sky
- Shooting Stars fall from the sky every time a note is played

Extra Controls and Shortcuts:
- SPACEBAR to toggle drum machine play/pause button 
- '1, 2, 3, 4, 5' keys are mapped to the waves in order, where '1' is the sine wave, '2' is the triangle wave etc. 
- 'm' to play your midi keyboard using the instument, otherwise the midi keyboard will play notes using Microsoft's GS Wavetable Synth 
- Scroll wheel can adjust slider and knob settings

Libraries Used:
- Minim Library (For audio functions, such as triggering drum sounds notes, as well as the drum machine itsef and how to create and patch instruments)
- ControlP5 Library (For the GUI and controling audio functions, such as volume gain and harmonics) 
- The Midibus Library (For Midi keyboard support) 

Other Resources:
- Drum Sounds: https://arcadeerabeats.com/sound-kits/ultimate-lofi-drum-kit-43638
- Polygon: https://processing.org/examples/regularpolygon.html
- Rotate and Scale of Polygon: https://www.youtube.com/watch?v=AUddj9kzyyY&list=LL&index=3&ab_channel=thedotisblackcreativecoding
- Noise Wave: https://processing.org/examples/noisewave.html
- And Minim, Midibus and ControlP5 library examples
