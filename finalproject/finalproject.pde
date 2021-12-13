import controlP5.*;
import themidibus.*;
import java.util.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

ControlP5 cp5;

MidiBus bus;

Minim minim;
AudioOutput out, out2, out3;
LowPassFS lpf, lpf2, lpf3, lpf4;

Obj sun;

IntDict notes;
int insNumber = 1;
float insAmp = 0.1;
boolean instrumentToMidi;

ArrayList<Star> stars;
int numStars = 35;
ArrayList<ShootingStar> lines;

Sampler kick;
Sampler snare;
Sampler hat;
Sampler ophat;

boolean lpfOn = false;
boolean gainMouseOn = false;
boolean mouseActive = false;
boolean playToggle = false;
boolean switchKit = false;

boolean[] ophatRow = new boolean[16];
boolean[] hatRow = new boolean[16];
boolean[] snrRow = new boolean[16];
boolean[] kikRow = new boolean[16];

ArrayList<Rect> buttons = new ArrayList<Rect>();

int bpm = 120;//start bpm
int dmBeat; // which beat we're on
int noteLength = 1;
float gainVal = 0;
int numofHarmonics = 2;

int scaler = 2; //scaler for pixel array
float div = 1;
float yoff = 0.0;  

float starxPos;
float modulateFrequency;
float outAmp;

void setup() {
  size(1200, 800, P3D);

  cp5 = new ControlP5(this);

  MidiBus.list();
  bus = new MidiBus(this, 0, 2); //0 is the input for my midi keyboard an 2 is the output for the Microsoft GS Wavetable Synth, use -1 as input and ouput if you have no midi keyboard available 
  midiNotes();
  minim = new Minim(this);
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  out2 = minim.getLineOut();
  out3 = minim.getLineOut();

  lpf = new LowPassFS(2000, out2.sampleRate());
  lpf2 = new LowPassFS(2000, out2.sampleRate());
  lpf3 = new LowPassFS(2000, out2.sampleRate());
  lpf4 = new LowPassFS(2000, out2.sampleRate());

  kick  = new Sampler("Lofi Kick 003.wav", 4, minim);
  snare = new Sampler("Lofi Snare 006.wav", 4, minim);
  hat   = new Sampler("Lofi Hi Hat 014.wav", 4, minim);
  ophat = new Sampler("Lofi Open Hi Hat 004.wav", 4, minim);

  //patch samplers to the output
  kick.patch(lpf).patch(out2);
  snare.patch(lpf2).patch(out2);
  hat.patch(lpf3).patch(out2);
  ophat.patch(lpf4).patch(out2);

  for (int i = 0; i < 16; i++) {
    buttons.add(new Rect(50+i*30, height - 115, ophatRow, i));
    buttons.add(new Rect(50+i*30, height - 85, hatRow, i));
    buttons.add(new Rect(50+i*30, height - 55, snrRow, i));
    buttons.add(new Rect(50+i*30, height - 25, kikRow, i));
  }

  dmBeat = 0;
  //start the drum sequencer
  out2.playNote(0, 0.25f, new Tick());

  //CP5 controls
  settingControls();

  stars = new ArrayList<Star>();
  lines = new ArrayList<ShootingStar>();
  sun = new Obj();

  textAlign(CENTER);
  rectMode(CENTER);
  strokeWeight(2);
}

void draw() {
  background(110, 117, 130);

  stroke(255);
  loadPixels();
  float div = map(gainVal, -40, 0, 5, 1); 
  outAmp = map(getTheAmplitude(), 0, 1, 0, 255);

  //pixel array to add the gradient background
  for (int x = 0; x < width; x+= scaler) {
    for (int y = 0; y < height; y+= scaler) {
      int index = x + y * width;

      //float d = dist (x, y, mouseX, mouseY);
      pixels[index] = color (y/div, 132, 116 + outAmp);
    }
  }
  updatePixels();

  //adds stars to arraylist
  for (int i = 0; i < numStars; i++) {
    if (stars.size() < 35) {
      stars.add(new Star());
    }
  }

  for (int i = stars.size() - 1; i >= 0; i--) { 
    Star star = stars.get(i);
    star.run();
    //when star leaves frame, it is removed from the arraylist
    if (!star.inFrame()) {
      stars.remove(i);
    }
  }

  //shooting stars
  for (int i=lines.size()-1; i>=0; i--) {
    ShootingStar dot = lines.get(i);
    if (dot.alive) {
      dot.run();
    } else {
      lines.remove(i);
    }
  }

  //sun
  float r2 = out2.right.get(1);
  sun.run(r2*100);

  //drumMachine controls
  drumBpm(bpm);
  instrumentGain(gainVal);
  Harmonics(numofHarmonics);

  //https://processing.org/examples/noisewave.html
  beginShape(); 
  fill(112 + outAmp/4, 80, 128 + outAmp/4);
  noStroke();
  float xoff = 0; // Option #1: 2D Noise

  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x += 10) {
    // Calculate a y value according to noise, map to 
    float y = map(noise(xoff, yoff), 0, 1, 490, 590); // Option #1: 2D Noise

    // Set the vertex
    vertex(x, y); 
    // Increment x dimension for noise
    xoff += 0.02;
  }
  // increment y dimension for noise
  yoff += 0.02;
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);

  // draw the waveforms
  for (int i = 0; i < out.bufferSize() - 1; i++) {
    stroke(255);
    float r = out.right.get(i + 1); //returns value from -1 and 1
    //rectangle waveforms
    noStroke();
    fill(112 + outAmp/4, 80, 128 + outAmp/4);
    rect(i*10, height - 250, 10, 50 + r*200);
    fill(100 + outAmp/4, 70, 121 + outAmp/4);
    rect(i*10, height - 230, 10, 50 + r*100);
    fill(88 + outAmp/4, 61, 114 + outAmp/4);
    rect(i*10, height - 200, 10, 50 + r*100);
  }

  //panel
  fill (63, 51, 81);
  rect(width/2, height - 100, width, 200); 
  stroke(255);
  line(width/2, height - 100, width/2, height);

  //Drum machine buttons
  for (int i = 0; i < buttons.size(); ++i) {
    buttons.get(i).draw();
  }

  stroke(127);
  if ( dmBeat % 4 == 0 ) {
    fill(200, 0, 0);
  } else {
    fill(0, 200, 0);
  }

  //beat marker    
  rect(50+dmBeat*30, height - 150, 20, 1);

  textLabels(); 

  //mouseclick note output. Pitches are mapped to the mousex position
  float p = int(map(mouseX, 0, width, 60, 72));
  //insAmp = map(mouseY, 0, height, 0, 1);
  if (mousePressed && mouseY < 450 && mouseActive) {
    //println(p);
    out.playNote(0, noteLength, new myInstrument(Frequency.ofMidiNote(p).asHz()));
  } 
  //surface.setTitle("" + frameRate);
}

//MIDI Control
void noteOn(int channel, int pitch, int velocity) {
  //if instument isn't toggled on, midi notes are played using Microsoft GS Wavetable Synth
  if (!instrumentToMidi) {
    bus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
    lines.add(new ShootingStar(pitch));
  }

  String[] keys = notes.keyArray();
  if (instrumentToMidi) {
    for (String k : keys) {
      int notePitch = notes.get(k);
      if (notePitch == pitch) {
        out.playNote(0, noteLength, new myInstrument(Frequency.ofPitch(k).asHz()));
        lines.add(new ShootingStar(pitch));
      }
    }
    println("Note on: " + channel + ", " + pitch + ", " + velocity);
  }
}

void noteOff(int channel, int pitch, int velocity) { 
  bus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff
  //nm.releaseNote(new Note(channel, pitch, velocity));
  println("Note off: " + channel + ", " + pitch + ", " + velocity);
}

//returns the Amplitude of the AudioOutput out 
float getTheAmplitude() {
  float leftOutput = 0;
  for (int i = 0; i < out.bufferSize() - 1; i++) {
    leftOutput += abs(out.left.get(i));
  }
  leftOutput /= float(out.bufferSize());
  return leftOutput;
}
