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

//void lpfKnob(float val) {
//insAmp = val;
//}

void PlayPause(boolean toggVal) {
  playToggle = toggVal;
}

void Volume(float val) {
  insAmp = val;
}

void VolMouseControl(boolean togVal) {
  volMouseOn = togVal;
}

void settingControls() {
  cp5.addSlider("noteLengthSlider")
    .setPosition(width/2 + 50, 750) //+50 750
    .setSize(250, 20)
    .setRange(1, 10)
    .setNumberOfTickMarks(10)
    .scrolled(5)
    //.setSliderMode(Slider.FLEXIBLE)
    ;

  cp5.addNumberbox("bpmBox")
    .setPosition(5, height - 195)
    .setSize(75, 25)
    .setRange(20, 500)
    .setScrollSensitivity(2)
    .setDirection(controlP5.Controller.HORIZONTAL) //horizontal control
    .setValue(120)
    .setColorForeground(color(255, 0, 0))
    ;

  cp5.addKnob("gain")
    .setRange(-30, 6)
    .setValue(gainVal)
    .setPosition(1100, 700)
    .setRadius(35)
    .setDragDirection(Knob.VERTICAL)
    ;

  for (int i=0; i<5; i++) {
    cp5.addBang("wave"+i)
      .setPosition(650+i*75, 680)
      .setSize(40, 40)
      .setId(i)
      ;
  }

  cp5.addKnob("Harmonics")
    .setRange(1, 30)
    .setValue(30)
    .setPosition(1020, 670)
    .setRadius(25)
    .setDragDirection(Knob.VERTICAL)
    ;

  cp5.addToggle("lpfToggle")
    .setPosition(525, height - 150)
    .setSize(50, 20)
    .setValue(false)
    //.setMode(ControlP5.SWITCH)
    ;
  /*
  cp5.addKnob("lpfKnob")
   .setRange(60, 2000)
   .setValue(2000)
   .setPosition(525, height - 75)
   .setRadius(35)
   .setDragDirection(Knob.VERTICAL)
   ;
   */

  cp5.addToggle("PlayPause")
    .setPosition(450, height - 180)
    .setSize(30, 30)
    .setValue(false)
    //.setColorBackground(color(255, 255, 0))
    .setColorActive(color(0, 255, 0)) //when pressed
    //.setColorForeground(color(0, 255, 0))//hover val
    //.setColorLabel(color(0, 255, 0)) //letters
    ;

  cp5.addKnob("Volume")
    .setRange(0, 1)
    .setValue(insAmp)
    .setPosition(1100, 610)
    .setRadius(35)
    .setDragDirection(Knob.VERTICAL)
    ;

  cp5.addToggle("VolMouseControl")
    .setPosition(40, 100)
    .setSize(50, 20)
    ;
}
