class Star {
  PImage stars;
  PVector position;
  float starSize;
  float x;
  float y;
  float xSpeed = 0.5;
  float val;
  boolean star1; 

  float rot = 0;
  float rotSpeed;
  float mult;

  Star() {
    val = random(1);
    if (val < 0.50) {
      star1 = true;
    } else {
      star1 = false;
    }
    starSize = 5;
    x = random(-1000, 0);
    y = random(10, 300);
    position = new PVector(x, y);
    mult = random(0.01, 0.05);
    imageMode(CENTER);
  }

  void draw() {
    noStroke();
    fill(255, random(100, 150) + outAmp); 
    tint(255, random(50, 150));
    rotSpeed = map(bpm, 20, 500, 0.05, 15);
    rot = rot + rotSpeed;

    float n = sin(frameCount*mult)*4;

    pushMatrix();
    translate(position.x, position.y);
    rotate(radians(rot)); //rot
    if (star1) { //draws basic square star
      rect(0, 0, starSize, starSize);
    } else { //draws second star
      rect(0, 0, n, n);
    }
    popMatrix();
  }

  //moves stars
  void update() {
    xSpeed = map(bpm, 60, 500, 3, 30);
    position.x += xSpeed;
  }

  //checks if star is still on screen and returns true when star leaves the screen
  boolean inFrame() {
    if (position.x > width) {
      return false;
    } else {
      return true;
    }
  }

  void run() {
    draw();
    update();
  }
}
