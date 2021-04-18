
// this class represent a bullet shot from the player
class Bullet {

  // bullet image, position and the speed.
  PImage image;
  PVector pos;
  int speed;

  // constructor
  public Bullet(PVector pos) {
    // initialize the bullet info
    this.pos = pos;
    image = loadImage("data\\images\\bullet.png");
    speed = -5;
  }

  // update the bullet
  public void update() {
    pos.x += speed;
  }

  // check wheather bullet is offscreen
  public boolean isOutOfFrame() {
    return this.pos.x < -10;
  }

  // draw the bullet
  public void draw() {
    image(image, pos.x, pos.y);
  }
}
