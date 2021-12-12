
//COMPUTER KEYBOARD
void keyPressed() {
  //rectangles.add(new Rec(channel, pitch, velocity));
  //first two arguments set the start time and the duration, while the frequency class to get note names and pitches 
  lines.add(new ShootingStar(10, 50));
  if ( key == 'a' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("C4").asHz(), 1));
  if ( key == 'w' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("C#4").asHz(), 1));
  if ( key == 's' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("D4").asHz(), 1));
  if ( key == 'e' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("D#4").asHz(), 1));
  if ( key == 'd' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("E4").asHz(), 1));
  if ( key == 'f' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("F4").asHz(), 1));
  if ( key == 't' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("F#4").asHz(), 1));
  if ( key == 'g' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("G4").asHz(), 1));
  if ( key == 'y' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("G#4").asHz(), 1));
  if ( key == 'h' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("A4").asHz(), 1));
  if ( key == 'u' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("A#4").asHz(), 1));
  if ( key == 'j' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("B4").asHz(), 1));
  if ( key == 'k' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("C5").asHz(), 1));
  if ( key == 'o' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("C#5").asHz(), 1));
  if ( key == 'l' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("D5").asHz(), 1));
  if ( key == 'p' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("D#5").asHz(), 1));
  if ( key == ';' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("E5").asHz(), 1));
  if ( key == '[' ) out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch("F5").asHz(), 1));
}

void mousePressed() {
  for (int i = 0; i < buttons.size(); ++i) {
    buttons.get(i).mousePressed();
  }
}

void keyReleased() {
  //instrument toggles
  if (key == 'x') {
    toggleInstument = false;
  }
  if (key == 'z') {
    toggleInstument = true;
  }
  if (key == '1') {
    insNumber = 1;
  }
  if (key == '2') {
    insNumber = 2;
  }
  if (key == '3') {
    insNumber = 3;
  }
  if (key == '4') {
    insNumber = 4;
  }
  if (key == '5') {
    insNumber = 5;
  }
  if (key == ' ') {
    if (!playToggle) {
      playToggle = true;
    } else {
      playToggle = false; 
    }
    
  }
}

float currentAmplitude() {
  float total = 0;
  for (int i = 0; i < out.bufferSize() - 1; i++) {
    total += abs(out.left.get(i));
  }
  total /= float(out.bufferSize());
  return total;
}

void mouseMoved() {
  if (mouseY < 600 && lpfOn) {
    float cutoff = map(mouseX, 0, width, 60, 2000);
    lpf.setFreq(cutoff);
    lpf2.setFreq(cutoff);
    lpf3.setFreq(cutoff);
    lpf4.setFreq(cutoff);
  }

  if (volMouseOn) {
    float amp = map(mouseY, 0, 600, 1, 0 );
    insAmp = amp;
  }
}
