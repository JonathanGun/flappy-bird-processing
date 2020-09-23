class Pillar{
  // Pillar dynamic prop
  float x = width;
  float gap = random(400,450);
  float gapY = random(100,height-this.gap-ground.h-100);
  
  // Pillar static prop
  float y = 0;
  float w = 145;
  float gapX = 2*width/3;
  
  
  void update(int i){ // move each pillar, check collision, if not add point, then add new pillar
    this.x -= vel;
    
    // when pillar X pos = bird
    if (this.x < bird.x+bird.sizeX/2 && this.x + w > bird.x-bird.sizeX/2){
      // check their Y pos, if same > collid> lose
      if (!bird.hit){
        this.checkCollision();
      } // if pillar X pos passes bird, add score
      if (this.x + w/2 - bird.x < 0 && this.x + w/2 - bird.x > -vel){
        ui.score.score++;
        if (ui.score.score % 10 == 0 && bird.life != 3){
          bird.life += 1;
        }
      } // spawn new pillar with defined gap
    } else if (pillar[i].x + w <= width - 2*gapX){
      pillar[i] = new Pillar();
    } else if (this.x + 2*w < bird.x-bird.sizeX/2){
      bird.hit = false;
    }
  }
  
  
  void show(){ // draw 2 rect, top + bottom
    fill(30,240,0); // green
    stroke(0,60,0); strokeWeight(8);
    rect(this.x, y, w, this.gapY);
    rect(this.x, this.gapY+this.gap, w, height-this.gap-this.gapY-ground.h);
    noStroke();
  }
  
  
  void checkCollision(){ // check if bird hits pillar
    if (bird.y-bird.sizeY/2 < this.gapY || bird.y+bird.sizeY/2 > this.gapY + this.gap){
      bird.life -= 1;
      
      if (bird.life <= 0){
        bird.yVel = 10;
        if (bird.y+bird.sizeY/2 > this.gapY + this.gap){
          bird.yVel = -5;
        }
        gameOver = true;
      } else if (bird.life > 0){
        bird.yVel -= 10;
        bird.hit = true;
      }
    }
  }
}