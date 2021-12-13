class Obj {
  float size;
  float rot = 0;
  float rotSpeed;
  float objY = 0;

  float sunLight = 400;
  float shineAmount = 50;
  float shineIncrement = 1;

  Obj() {
  }

  void update() {
  }

  void display(float _size) {
    rotSpeed = map(bpm, 20, 500, 0.05, 15);
    objY = map(gainVal, -40, 0, 650, 400);
    int points = int(map(numofHarmonics, 0, 30, 3, 20));  
    size = _size;
    rot = rot + rotSpeed;

    pushMatrix();
    translate(width/2, objY);
    noStroke();
    for (int i=0; i<10; i++) {
      //fill(255, 132+i*25, 100, 100);
      scale(0.8);
      rotate(radians(rot));   
      fill(255, 132 + i*outAmp, 100, shineAmount);  
      polygon(0, 0, sunLight/2 + size, points);
    }
    popMatrix();
  }

  void sunLight() { 
    if (sunLight != -400) { 
      sunLight = sunLight + 1;
      shineAmount = shineAmount + shineIncrement; 
    } else {              
      sunLight = sunLight * -1;
      shineIncrement = 1;
    }
    if (sunLight > 500) { 
      sunLight = sunLight * -1;
      shineIncrement = -1;
    }
  }
  
  //https://processing.org/examples/regularpolygon.html
  void polygon(float x, float y, float radius, int npoints) {
    float angle = TWO_PI / npoints;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius;
      float sy = y + sin(a) * radius;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  void run(float s) {
    display(s);
    sunLight();
  }
}
