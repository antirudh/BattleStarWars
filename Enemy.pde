// enemy class represents a single enemy
class Enemy {

  // props to store enemy info
  PImage image;
  PVector pos;
  float speed;

  // constructor
  public Enemy() {
    // initialize enemy info
    pos = new PVector(random(-300, -5), random(90, 570));
    speed = difficulty / 1.75;
    image = loadImage("data\\images\\enemy"+(int)random(1, 3)+".png");
    image.resize(150, 150);
  }

  // update enemy position
  public void update() {
    pos.x += speed;
  }

  // check weather an enemy hit with a bullet or not
  public boolean hitOnBullet(Bullet bullet) {
    if (bullet.pos.x < this.pos.x+this.image.width && bullet.pos.y > this.pos.y && bullet.pos.y < this.pos.y+this.image.height) {
      return true;
    } else {
      return false;
    }
  }

  // check weather the enemy reach the base (players side)
  public boolean isReachBase() {
    return pos.x+image.width+20 > 580;
  }

  // respawn the enemy
  public void reSpawn() {
    pos = new PVector(random(-400, -5), random(90, 570));
    image = loadImage("data\\images\\enemy"+(int)random(1, 3)+".png");
    image.resize(150, 150);
  }

  // draw the enemy
  public void draw() {
    image(image, pos.x, pos.y);
  }
}
