import java.util.Iterator;

// represent the player
class Player {
  // props to keep player information
  PImage image;
  PVector pos;
  ArrayList<Bullet> bullets;
  int speed = 8;

  // constructor
  public Player(int x) {
    // initialize player info
    pos = new PVector(x, height/2);
    image = loadImage("data\\images\\player.png");
    image.resize(131, 150);
    bullets = new ArrayList<Bullet>();
  }

  // moves player up
  public void moveUp() {
    pos.y-=speed;
    pos.y = constrain(pos.y, 60, height-image.height);
  }

  // moves player down
  public void moveDown() {
    pos.y+=speed;
    pos.y = constrain(pos.y, 60, height-image.height);
  }

  // trigger the fire
  public void fire() {
    bullets.add(new Bullet(new PVector(pos.x-30, pos.y+30)));
  }

  // draw the player
  public void draw() {
    // draw the character in position
    image(image, pos.x, pos.y);

    // draw the bullets
    Iterator itr = bullets.iterator(); 
    while (itr.hasNext()) 
    { 
      Bullet bullet = (Bullet)itr.next(); 
      bullet.update();
      bullet.draw();
      if (bullet.isOutOfFrame()) {
        itr.remove();
      }
    }
  }
}
