public class myInstrument implements Instrument {
  Oscil wave, wave2, LFO;
  Pan pan;
  Line  ampEnv;
  Frequency  currentFreq;
  ddf.minim.ugens.Waveform w;

  myInstrument(float frequency) {
    if (insNumber == 1) {
      w = Waves.SINE;
    } else if (insNumber == 2) {
      w = Waves.triangleh(numofHarmonics);
    } else if (insNumber == 3) {
      w = Waves.sawh(numofHarmonics);
    } else if (insNumber == 4) {
      w = Waves.squareh(numofHarmonics);
    } else if (insNumber == 5) {
      w = Waves.randomNHarms(numofHarmonics);
    } 

    wave = new Oscil(frequency, 0, w);
    pan = new Pan(10);
    
    ampEnv = new Line();
    ampEnv.patch(wave.amplitude);
  }

  void noteOn(float duration) {
    //starting amplitude envelope
    ampEnv.activate(duration, insAmp, 0);
    //outputs wave sound
    wave.patch(out);
  }

  //stop making sound
  void noteOff() {
    wave.unpatch(out);
  }
}
