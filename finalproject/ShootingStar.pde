class ShootingStar {
  PVector position, position2, target;
  float size;
  int birthtime = 0;
  float a = 55;
  int lifetime = 3000;
  boolean alive = true;
  float delta;
  float x;
  float y;
  float x2;
  float y2;
  float targetY;

  float lerpSpeed;
  float lerpSpeed2;
  float ran;

  ShootingStar(float pitch_) {
    targetY = random(300, 500);
    float ranVal = random(0, width/2);
    float ranVal2 = random(-10, 0);
    x = ranVal;//map(pitch_, 36, 96, 0, width/2);
    y = ranVal2;
    x2 = ranVal;
    y2 = ranVal2;
    position = new PVector(x, y);
    position2 = new PVector(x2, y2);
    target = new PVector(1400, targetY);
    ran = random(1, 2);
    lerpSpeed = random(0.06, 0.1);
    lerpSpeed2 = random(0.008, 0.1);
    size = 3; 

    birthtime = millis();
  }

  void update() {
    position.lerp(target, lerpSpeed + lerpSpeed2);
    position2.lerp(target, lerpSpeed);
    if (alive) {
      position.y += delta;
      if (millis() > birthtime + lifetime) alive = false;
    }
    if (a > 150) {
      a = 55;
    }
  }

  void draw() {   
    strokeWeight(2);
    strokeCap(ROUND);
    stroke(255, 255, 255, 20 + outAmp);
    line(position.x, position.y, position2.x, position2.y);
    ellipse(position.x, position.y, size, size);
    a += 1;
  }

  void run() {
    update();
    draw();
  }
}
