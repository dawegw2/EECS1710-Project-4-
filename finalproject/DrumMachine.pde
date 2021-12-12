class Tick implements Instrument {
  void noteOn(float dur) {
    if (playToggle) {
      if (hatRow[dmBeat]) hat.trigger();
      if (snrRow[dmBeat]) snare.trigger();
      if (kikRow[dmBeat]) kick.trigger();
      if (ophatRow[dmBeat]) ophat.trigger();
    }
  }

  void noteOff() {
    // next beat
    if (playToggle) {
      dmBeat = (dmBeat+1)%16;
    } else {
      dmBeat = 0;
    }

    //println(dmBeat);
    // set the new tempo
    // out.setTempo( bpm );
    // play this again right now, with a sixteenth note duration
    out2.playNote( 0, 0.25f, this );
  }
}

// simple class for drawing the gui
class Rect {
  int x, y, w, h;
  boolean[] steps;
  int stepId;

  public Rect(int _x, int _y, boolean[] _steps, int _id) {
    x = _x;
    y = _y;
    w = 25;
    h = 25;
    steps = _steps;
    stepId = _id;
  }

  public void draw() {

    stroke(255);
    if ( steps[stepId] ) {

      fill(0, 200, 255, 150);
    } else {
      fill(0, 0, 200, 150);
    }

    rect(x, y, w, h, 10);

    if ( mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h ) {
      fill(255, 0, 255);
    }
  }

  public void mousePressed() {
    if ( mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h ) {
      steps[stepId] = !steps[stepId];
    }
  }
}
