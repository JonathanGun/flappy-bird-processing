Bird bird;
Ground ground;
Sky sky;
UI ui;

Pillar[] pillar = new Pillar[2];
Cloud[] cloud = new Cloud[7];
Bush[] bush = new Bush[12];

boolean prevPress = false;
boolean gameOver = true;
boolean gameStart = true;
boolean onGround = false;

float maxX = 0;
float vel = 6;


void setup() {
  loadStartItems();

  // default setting
  noStroke();
  //fullScreen();
  size(500, 800);
  textAlign(CENTER, CENTER);
}

void draw() { 
  // Jump when mouse pressed, restart if gameOver
  if (mousePressed == true && prevPress != true) {
    if (ui.retry.clicked || gameStart) {
      restart();
    } else if (!gameOver) {
      bird.jump();
    }
    gameStart = false;
  }

  // Rendering and Drawing
  // sky,
  sky.update();
  sky.show();

  // clouds,
  for (int i = 0; i < cloud.length; i++) {
    cloud[i].update(i);
    cloud[i].show();
  } // bushes,
  for (int i = 0; i < bush.length; i++) {
    if (!gameOver || gameStart) {
      bush[i].update(i);
    }
    bush[i].show();
  } // pillars,
  for (int i = 0; i < pillar.length; i++) {
    if (!gameOver) {
      pillar[i].update(i);
    } 
    if (!gameStart) {
      pillar[i].show();
    }
  } // and the bird
  if (bird.y < height - ground.h - bird.sizeY/2 && !gameOver) { 
    bird.update();
  }
  bird.show();

  // other
  ground.show();
  ui.show();
  if (!gameOver || gameStart) {
    maxX -= vel-2;
  }
}



// Other Functions --------------------------------
void loadStartItems() { // load (bird, ground, title, clouds, bushes)
  bird = new Bird();
  ground = new Ground();
  ui = new UI();
  sky = new Sky();

  for (int i = 0; i < cloud.length; i++) {
    cloud[i] = new Cloud();
    cloud[i].x = random(width); // at random position
  }

  for (int i = 0; i < bush.length; i++) {
    bush[i] = new Bush();
  }

  ui.score.high = loadScore();
}

void restart() {
  bird.y = height/2;
  bird.jump();

  pillar[0] = new Pillar(); 
  pillar[0].x += 100;
  pillar[1] = new Pillar(); 
  pillar[1].x += 150 + pillar[1].gapX;

  gameOver = false;
  onGround = false;
  ui.score.score = 0;
  ui.retry.clicked = false;
  
  bird.life = 1;
  bird.hit = false;
}

int loadScore() {
  try {
    String[] scoreData = loadStrings("score.txt");
    return int(scoreData[0]);
  } 
  catch (Exception e) {
    return 0;
  }
}

void mouseReleased() { // Check if mouse not being held
  prevPress = false;
}
