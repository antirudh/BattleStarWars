/*
Anirudh Bindal
200383604
CTCH 204
Dr. Trevor M. Tomesh

As a computer science student, I have dedicated most of my work towards developing websites and writing general code.
I have grown up watching amazing action Hollywood movies. During my childhood days I would love to draw. So, I believe I do have an artistic side of me.
I have developed a shooting arcade game where user has to defeat the enemies by shooting them. My game is inspired from a movie series. Star Wars.
The protagonist in my game is Luke Skywalker who is controlled by the user. As for the enemies I have included Darth Vader and Emperor Palpatine. 
The user has to shoot down the enemies to go through the game. The user gets a chance to decide difficulty of the game. I have been a big fan of shooting games. 
It can be noticed that I have used a car background for my game, my unparallel love for cars inspired me to use that. I have also used music to hype people up.
Including some of my favourite characters in a shooting game is a dream come true for me. Initially my thought was to do a light saber fight but that wouldn’t 
give much time for user to move around to kill other enemies so I decided to let Luke Skywalker shoot them. My fellow classmates would be really happy to see 
some of their favorite characters in a game. Though I imagine that some might be unhappy to see Darth Vader die. This is my first work where I have incorporated
music, Images and my thoughts to amuse the audience. I don’t expect my work to be as refined as professionals but this is my first of many steps towards 
interactive art. My work is certainly not made to be in an arts center but to be at an arcade gaming centre. 

Since Star Wars has a big fan base, my goal was to hit my audience with nostalgia reminding them of one of their favourite movies.
Interacting with the Luke Skywalker is supposed to provide users with a sense of happiness and control that they could have had 
when they watched the movies. As an artist I believe in sharing my art with people so everyone can enjoy it. 

Image references
https://www.pngaaa.com/detail/3748944
https://www.deviantart.com/spartannjones/art/Mini-Darth-Vader-Pixel-Art-513016540
http://pixelartmaker.com/art/fe2ae3f1e901427
https://wallpaperaccess.com/pixel-car



*/
// import minim library to work with sounds
import ddf.minim.*;

// bunch of variables and arrays to keep track of game objects and states
PImage imgBackground;

int lives = 3;
int score = 0;

Minim minim;
AudioPlayer musicBackground;
AudioPlayer musicHit;

boolean instructions = false;

Player player;

ArrayList<Enemy> enemies;

PFont gameFont;

boolean playMode;
boolean gameOverMode;
boolean menuMode;

int difficulty = 1; // 1 EASY, 2 MEDIUM, 3 HARD

// processing's setup method
void setup() {
  // set canvas size
  size(700, 700);

  // initialize minim object with the background music and set it to play on a loop
  minim = new Minim(this);
  musicBackground = minim.loadFile("data\\music\\background.mp3");
  musicBackground.loop();

  // initialize the game
  init();
}

// processing's draw method
void draw() {
  // set background
  image(imgBackground, 0, 0);

  // if the game is in menu
  if (menuMode) {
    // draw menu items
    textAlign(CENTER);
    textSize(100);
    fill(0);
    text("BATTLE STAR", width/2, height/2-150);
    text("WARS", width/2, height/2-80);
    textSize(45);
    fill(255);

    // if instructions enabled, show instructions. otherwise draw difficulty levels.
    if (instructions) {
      drawInstructions();
    } else {

      text("PRESS SPACE TO START!", width/2, height-50);
      if (difficulty == 1) {
        text("DIFFICULTY: EASY", width/2, height-85);
      } else if (difficulty == 2) {
        text("DIFFICULTY: MEDIUM", width/2, height-85);
      } else {
        text("DIFFICULTY: HARD", width/2, height-85);
      }
      textSize(25);
      text("Press i for instructions.", width/2, height-15);
    }
  }

  // if the game is in play mode
  if (playMode) {
    textAlign(NORMAL);

    // draw the player
    player.draw();

    // loop though all the enemies
    for (Enemy enemy : enemies) {
      // if the enemy reach players area
      if (enemy.isReachBase()) {
        // respawn the enemy
        enemy.reSpawn();
        // remove a life from player
        lives--;

        // if no lives left
        if (lives == 0) {
          // set game over
          playMode = false;
          gameOverMode = true;
          menuMode = false;
        }
      }

      Iterator itr = player.bullets.iterator(); 
      // iterate through bullets shoot by the player
      while (itr.hasNext()) 
      { 
        Bullet bullet = (Bullet)itr.next(); 
        // if enemy collide with a bullet
        if (enemy.hitOnBullet(bullet)) {
          // remove the bullet from the scene
          itr.remove();
          // respawn the enemy
          enemy.reSpawn();
          // increase the score
          score += 10;
        }
      }

      // update and draw the enemy
      enemy.update();
      enemy.draw();
    }

    // this method will draw the score and lives status on canvas
    displayScoreAndLives(new PVector(30, 60));

    if (keyPressed) {
      keyPressing();
    }
  }

  // draw game over screen
  if (gameOverMode) {
    textAlign(CENTER);
    text("PRESS SPACE TO RESTART!", width/2, height-40);
    text("SCORE : "+score, width/2, height-80);
  }
}

// this will draw instructions
void drawInstructions() {
  textSize(25);
  text("PRESS space to SHOOT.", width/2, height-110);
  text("PRESS up arrow to MOVE UP.", width/2, height-90);
  text("PRESS down arrow to MOVE DOWN.", width/2, height-70);
  text("If you miss to kill enemy, you lose a life.", width/2, height-50);
  text("GOOD LUCK!", width/2, height-30);
}

// initialize the game
void init() {
  score = 0;
  lives = 3;

  // load background image
  imgBackground = loadImage("data\\images\\background.png");

  // load the font
  gameFont = createFont("data\\font\\disposabledroid-bb.bold.ttf", 40);
  textFont(gameFont);

  // set the initial modes
  playMode = false;
  gameOverMode = false;
  menuMode = true;

  // set default defficulty
  difficulty = 1;

  // create new player object
  player = new Player(580);

  // resize the background image to match the canvas size
  imgBackground.resize(width, height);

  // initialize enemies array
  enemies = new ArrayList<Enemy>();

  // populate enemies
  for (int i=0; i<5; i++) {
    enemies.add(new Enemy());
  }
}

// this method just draw the game status
void displayScoreAndLives(PVector pos) {
  pushMatrix();
  translate(pos.x, pos.y);
  text("SCORE : "+score, 0, 0);
  text("LIVES : "+lives, 0, 40);
  popMatrix();
}

// processing's keyPressed method
void keyPressed() {
  // if playMode and space pressed
  if (playMode && key == ' ') {
    player.fire();
  }

  // if menuMode and space pressed
  if (menuMode) {
    if (key == ' ' && !instructions) {
      playMode = true;
      gameOverMode = false;
      menuMode = false;

      // generate enemies based in difficulty
      // initialize enemies array
      enemies = new ArrayList<Enemy>();

      // populate enemies
      for (int i=0; i<5*difficulty; i++) {
        enemies.add(new Enemy());
      }
    }

    if (key == 'i' || key=='I') {
      instructions = !instructions;
    }
  }

  // if gameOver and space pressed
  if (gameOverMode && key == ' ') {
    // reset all and start over
    playMode = true;
    gameOverMode = false;
    menuMode = false;

    init();
  }
}

// move character while pressing directional keys
void keyPressing() {
  if (keyCode == UP) {
    player.moveUp();
  }
  if (keyCode == DOWN) {
    player.moveDown();
  }
}

// processing's mousePressed method
void mousePressed() {
  // if in a menu mode, change the difficulty levels
  if (menuMode) {
    if (difficulty == 1) {
      difficulty = 2;
    } else if (difficulty == 2) {
      difficulty = 3;
    } else {
      difficulty = 1;
    }
  }
}
