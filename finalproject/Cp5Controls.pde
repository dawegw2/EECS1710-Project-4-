void drumBpm(int newBpm) {
  //drum sequencer bpm
  out2.setTempo(newBpm);
}

void bpmBox(int val) {
  bpm = val;
}

void noteLengthSlider(int val) {
  noteLength = val;
}

void instrumentGain(float newGain) {
  out.setGain(newGain);
}

void gain(int val) {
  gainVal = val;
}

public void controlEvent(ControlEvent theEvent) {
  for (int i=0; i<5; i++) {
    if (theEvent.getController().getName().equals("wave"+i)) {
      insNumber = i + 1;
    }
  }
}

void Harmonics(int val) {
  numofHarmonics = val;
}

void lpfToggle(boolean togVal) {
  lpfOn = togVal;
}

void PlayPause(boolean toggVal) {
  playToggle = toggVal;
}

void Volume(float val) {
  insAmp = val;
}

void gainMouseControl(boolean togVal) {
  gainMouseOn = togVal;
}

void mousePitchControl(boolean togVal) {
  mouseActive = togVal;
}

void settingControls() {
  cp5.addSlider("noteLengthSlider").setCaptionLabel("NoteLength")
    .setPosition(width/2 + 50, 710) 
    .setSize(300, 25)
    .setRange(1, 10)
    .setNumberOfTickMarks(10)
    .scrolled(5)
    ;

  cp5.addNumberbox("bpmBox").setCaptionLabel("BPM")
    .setPosition(12.5, height - 185)
    .setSize(65, 25)
    .setRange(20, 500)
    .setScrollSensitivity(2)
    .setDirection(controlP5.Controller.HORIZONTAL) //horizontal control
    .setValue(120)
    ;

  cp5.addKnob("gain")
    .setRange(-30, 6)
    .setValue(gainVal)
    .setPosition(1100, 705)
    .setRadius(35)
    .setDragDirection(Knob.VERTICAL)
    ;

  for (int i=0; i<5; i++) {
    cp5.addBang("wave"+i)
      .setPosition(650+i*75, 640)
      .setSize(40, 40)
      .setId(i)
      ;
  }

  cp5.addKnob("Harmonics")
    .setRange(1, 30)
    .setValue(30)
    .setPosition(1020, 630)
    .setRadius(27)
    .setDragDirection(Knob.VERTICAL)
    ;

  cp5.addToggle("lpfToggle").setCaptionLabel("LowPass")
    .setPosition(535, 710)
    .setSize(40, 20)
    .setValue(false)
    ;

  cp5.addToggle("PlayPause").setCaptionLabel("Play/Pause")
    .setPosition(535, 640)
    .setSize(40, 40)
    .setValue(false)
    //.setColorActive(color(0, 255, 0)) //when pressed
    //.setColorForeground(color(0, 255, 0))//hover val
    //.setColorLabel(color(0, 255, 0)) //letters
    ;

  cp5.addKnob("Volume")
    .setRange(0, 1)
    .setValue(insAmp)
    .setPosition(1100, 615)
    .setRadius(35)
    .setDragDirection(Knob.VERTICAL)
    ;

  cp5.addToggle("gainMouseControl").setCaptionLabel("GainMouseControl") 
    .setPosition(1025, 755)
    .setSize(60, 20)
    .setValue(false);
  ;

  cp5.addToggle("mousePitchControl").setCaptionLabel("ClickNotes") 
    .setPosition(1024, 710)
    .setSize(60, 20)
    .setValue(false)
    ;

  cp5.addTextarea("txt")
    .setPosition(650, 750)
    .setSize(355, 40)
    .setFont(createFont("arial", 12))
    .setLineHeight(14)
    .setColor(color(255))
    .setColorBackground(color(255, 100))
    .setColorForeground(color(255, 100))
    .setText("Controls & Shortcuts"
    + "\n" + "- Play notes using your keyboard. The home row keys are the natural notes and the row of keys above are the sharp and flat notes"
    + "\n" + "- 'a' is C4 while 'k' is an octave higher"
    + "\n" + "- '1, 2, 3, 4, 5' keys map to each waveform respectively"
    + "\n" + "- 'm' key toggles patching to midi on"
    + "\n" + "- 'n' key toggles patching to midi off, default midi sound comes from Microsoft GS Wavetable Synth"
    + "\n" + "- GainMouseControl Toggle maps gain to the y position of the mouse"
    + "\n" + "- SPACEBAR plays and stops drum machine"
    + "\n" + "- Low Pass Filter Toggle maps to the x mouse position"
    );
}
