class Obj {
  float size;
  float rot = 0;
  float rotSpeed;
  float objY = 0;
  float angle;
  float sizeInc = 0;

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
    // objY = map(insAmp, 0, 1, 500, 400);
    int points = int(map(numofHarmonics, 0, 30, 3, 20));  
    size = _size;
    rot = rot + rotSpeed;
    int rgbB = 100; //150

    pushMatrix();
    translate(width/2, objY);
    noStroke();
    for (int i=0; i<10; i++) {
      //fill(255, 132+i*25, 100, 100);
      scale(0.8);
      rotate(radians(rot)); //rot
      //rect(0, 0, size, size);
      fill(255, 132 + i*c, rgbB, shineAmount);  //(i*10, 255-i*25, 255-i+10) //255-i+10, i*25, i*10
      //if (insNumber == 4) {
      //rect(0, 0, 300, 300);
      //} else {
      //ellipse(0, 0, sunLight + size, sunLight + size);  //(0, 0, size + sizeInc, size + sizeInc);
      // }
      polygon(0, 0, sunLight/2 + size, points);  // Icosagon
      //polygon(0, 0, sunLight/2, 3); 
      //triangle(120, 300, 232, 80, 344, 300);
      //fill(255, 132, 116, shineAmount);
      //arc(0, 0, sunLight, sunLight, rot, rot+radians(i));

      //fill(255-i+10, i*25, i*10, shineAmount); 
      //rect(0, 0, 200, 200);
      //fill(243, 149, 13);
      //ellipse(100, 100, 60, 60);
      //rect(0, 0, 100, 100);
    }
    popMatrix();

    angle+=0.1;
    sizeInc += 1;
  }

  void sunLight() { //code taken from my excersise 2
    if (sunLight != -400) { //expands the emitted light when the width is not -220
      sunLight = sunLight + 1;
      shineAmount = shineAmount + shineIncrement; //increases or decreases the opacity of the light circle as it changes size by shineIncrement which is either 1 or -1
    } else {              //resets width and height of the lighter circle to positive 220 when the width is -220
      sunLight = sunLight * -1;
      shineIncrement = 1;
    }
    if (sunLight > 500) { //decreases width and height of the lighter circle  
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
}
