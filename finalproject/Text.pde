void textLabels() {
  fill(255);
  textSize(15);
  text("OP", 20, height - 110);
  text("HH", 20, height - 80);
  text("S", 20, height - 50);
  text("K", 20, height - 20);

  text("1", 50, height - 135);
  text("2", 170, height - 135);
  text("3", 290, height - 135);
  text("4", 410, height - 135);

  String wvform = "Sine";

  if (insNumber == 1) {
    wvform = "Sine";
  } else if (insNumber == 2) {
    wvform = "Triangle";
  } else if (insNumber == 3) {
    wvform = "Saw";
  } else if (insNumber == 4) {
    wvform = "Square";
  } else if (insNumber == 5) {
    wvform = "Random Harmonic";
  }

  text(wvform + " Wave", 825, 625);
  text("Drum Machine", 300, 625);

  if (!instrumentToMidi) { 
    //stroke(255);
    fill(255);
  } else {
    //stroke(0, 255, 0);
    fill(0, 255, 0);
  }
  text("MIDI", 630, 730);
}
