// to make an Instrument we must define a class
// that implements the Instrument interface.
public class myInstrument implements Instrument {
  Oscil wave, wave2, LFO;
  Pan pan;
  Line  ampEnv;
  Frequency  currentFreq;
  ddf.minim.ugens.Waveform w;

  myInstrument(float frequency, float lfoAmplitude) {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway

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
    LFO = new Oscil(440, lfoAmplitude, Waves.SINE);
    //wave.setFrequency(modulateFrequency);

    ampEnv = new Line();
    ampEnv.patch(wave.amplitude);
  }

  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.

  void noteOn(float duration) {
    // start the amplitude envelope
    ampEnv.activate(duration, insAmp, 0);
    // attach the oscil to the output so it makes sound
    // pan.patch(out);
    wave.patch(out);
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff() {
    wave.unpatch(out);
    //pan.unpatch(out);
  }
}

public class myInstrument2 {
  Oscil wave2;
  Line  ampEnv;
  Frequency  currentFreq;
  ddf.minim.ugens.Waveform w;

  myInstrument2(float frequency) {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway

    // wave = new Oscil(frequency, 0, w);

    currentFreq = Frequency.ofMidiNote(60);
    wave2 = new Oscil(currentFreq, 0, w);

    ampEnv = new Line();
    ampEnv.patch(wave2.amplitude) ;
  }

  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.

  void noteOn( float duration ) {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.1f, 0);
    // attach the oscil to the output so it makes soun
    println(currentFreq);
    wave2.patch(out3);
  }

  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff() {
    wave2.unpatch(out3);
  }
}
