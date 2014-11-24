class moving_points {
  float radius=0.5;
  float x, y, speed;

  moving_points(float  _x, float  _y, float _speed){
  x=_x;
  y=_y;
  speed=_speed;
  }

  void display() {
    x=x+speed;
    y=y+speed;
    if (x > width || x < 0) {
      speed = -speed;
    }
    x = x + speed;

    if (y > height || y < 0) {
      speed = -speed;
    }
    y = y + speed;
    noStroke();
    ellipse(x, y, 0, 0);
  }
}


