class UI {
  Title title = new Title();
  Score score = new Score();
  Start start = new Start();
  Retry retry = new Retry();
  Box box = new Box();
  Life life = new Life();

  void show() {
    if (gameOver) {
      if (!gameStart) { // if lose
        bird.update();
        bird.show();
        if (onGround) { // then touches the ground
          title.show();
          box.show();
          score.show();
          retry.show();
        }
      } else { // if gameStart
        title.show();
        start.show();
      }
    }
    score.showCurrent(); // always shows score
    life.show();
  }


  class Title {
    String name = "Flappy Bird";
    PVector pos = new PVector(width/2, height/7);
    float size = width/6;
    PVector box = new PVector(size/4, pos.y-size/2);

    void show() {
      // title shade
      fill(100, 250, 0, 65); // trans green
      rect(box.x, box.y, width-2*box.x, size*1.2, 10);

      // title text
      textSize(size);
      fill(100, 50, 0);
      text(name, pos.x+5, pos.y+3);
      fill(250, 200, 0);
      text(name, pos.x-5, pos.y-3);
    }
  }

  class Score {
    int score = 0;
    int high = 0;

    void show() {
      fill(0); // black

      // score,
      textSize(80);
      text("Score: " + score, width/2, height/2 +60);

      // highscore,
      textSize(50);
      text("High: " + high, width/2, height/2 +130);
      if (score >= high) {
        high = score;
        textSize(70); fill(50,40,0); // dark orange
        text("New Highscore!", width/2 + 3, height/2 -40 +1);
        fill(250,200,0); // orange
        text("New Highscore!", width/2 - 3, height/2 -40 -1);
        saveScore();
      }
    }

    void showCurrent() {
      textSize(80);
      fill(0);
      text(score, width/2 + 3, height/4 + 2);
      fill(255);
      text(score, width/2 - 3, height/4 - 2);
      if (score == 10 || score == 30 || score == 50 || score == 75 || score == 100 
       || score == 150 || score == 200 || score == 300 || score == 400 || score == 500){
        life.drawHeart(0, 0, 0, width/2, height/3, life.sizeX*2, life.sizeY*2);
        if (frameCount % 40 < 20){
          life.drawHeart(255, 0, 0, width/2, height/3, 0.8*life.sizeX*2, 0.8*life.sizeY*2);
        } else {
          life.drawHeart(255, 255, 255, width/2, height/3, 0.8*life.sizeX*2, 0.8*life.sizeY*2);
        }
      }
    }
    
    void saveScore() {
      String[] savedScore = {str(ui.score.high)};
      saveStrings("score.txt",savedScore);
    }
  }


  class Box {
    float x = 85;
    float y = 425;
    float w = width - 2*x;
    float h = height - 2*y + 50 - ground.h;
    float r = 20; //roundness

    void show() {
      // gameOver box,
      stroke(80, 40, 20); // brown
      strokeWeight(10);
      fill(255, 250, 220); // milk brown
      rect(x, y, w, h, r);

      // gameOver text,
      textSize(100);
      fill(0);
      text("Game Over", width/2 +3, height/2 -140 +1);
      fill(255, 0, 0); //red
      text("Game Over", width/2 -3, height/2 -140 -1);
    }
  }

  class Start {
    void show() {
      // start shade,
      fill(80, 80, 80, 50);
      rect(0, height - 5*ground.h - 37, width, 80);

      // start text
      textSize(50);
      fill(250, 230, 10);
      if (frameCount % 150 < 50) {
        fill(250, 200, 10);
        textSize(55);
      }
      text("Tap anywhere to Start", width/2, height - 5*ground.h);
    }
  }  

  class Retry {
    float x = width/2-100;
    float y = height - 6.5*ground.h;
    float w = width-2*x;
    float h = 1.7*ground.h;
    boolean clicked = false;

    void show() {
      // retry box,
      strokeWeight(7);
      fill(250, 250, 220);
      rect(x, y, w, h, 20);

      // retry text,
      textSize(60);
      fill(20, 20, 20);
      text("Retry", width/2, y + h/2);
      clicked = gameOver && onGround &&
        mouseX > x && mouseX < x+w &&
        mouseY > y && mouseY < y+h;
      noStroke();
    }
  }
  
  
  class Life{
    float x = 50;
    float y = 50;
    float sizeX = 80;
    float sizeY = 40;
    float gapX = 80;
      
    void show(){
      for (int i = 0; i < 3; i++){
        drawHeart(0, 0, 0, x+i*gapX, y, sizeX, sizeY);
        drawHeart(255, 255, 255, x+i*gapX, y, 0.8*sizeX, 0.8*sizeY);
      }
      for (int i = 0; i < bird.life; i++){
        drawHeart(255, 0, 0, x+i*gapX, y, 0.8*sizeX, 0.8*sizeY);
      }
    }
    
    void drawHeart(int r, int g, int b,
                   float x, float y,
                   float sizeX, float sizeY){
      
      fill(r, g, b);
      translate(x,y);
      rotate(-QUARTER_PI);
      arc(0, 0, sizeX, sizeY, -3*QUARTER_PI/2, PI-3*QUARTER_PI/2+0.1);
      arc(0, 0, sizeY, sizeX, PI-QUARTER_PI/2-0.1, 2*PI-QUARTER_PI/2);
      rotate(+QUARTER_PI);
      translate(-x,-y);
    }
  }
}
