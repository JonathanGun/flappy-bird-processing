class Bird {
  // Bird props
  float x = 100;
  float y = height/2;
  float sizeX = 90;
  float sizeY = 80;
  float eyeSizeX = (sizeX + sizeY)/9;
  float eyeSizeY = eyeSizeX * 1.2;
  float wingSizeX = sizeX/2;
  float normalWingSizeY = sizeY/3.5;
  float wingSizeY = normalWingSizeY;
  float life = 1;
  boolean hit = false;
  
  // color
  int r = 250;
  int g = 250;
  int b = 0;
  
  // initial speed, etc
  float yVel = 0;
  float yAcc = 1.2;
  float yVelLimit = -27;
  float jumpSpeed = 40;
  
  // other prop
  float rotateDeg = yVel/50 - 0.3;
  float dampening = 0.994;


  void jump() { // jumps up to speedlimit
    if (yVel-jumpSpeed < yVelLimit){
      yVel = yVelLimit;
    } else {
      yVel -= jumpSpeed;
    }
    prevPress = true; // ensure not drag
  }

  void update() { // add acc->spd, if offscreen->stop, adjust wing, add spd->y
      yVel += yAcc; // add acxc ->spd

      // if offscreen->stop
      if (y - sizeY/2 <= 0) { // if exceed upper bound
        y = sizeY/2 - yVel; // stop
        yVel += 3 * yAcc; // drag down
        if (yVel > 0) { // if move down
          y -= 0.1; // exit the loop
        } // if exceed lower bound
      } else if (y >= height - ground.h - sizeY/2 - yVel) {
        life -= 1;
        bird.hit = true;
        if (bird.life <= 0){
          yVel = 0;                        // stop
          y = height - ground.h - sizeY/2; // put on ground
          gameOver = true;
          onGround = true;
        } else {
          if (pillar[0].x > x){
            y = pillar[0].gapY + pillar[0].gap;
          } else {
            y = pillar[1].gapY + pillar[1].gap;
          }
          yVel = -10;
        } 
      }
    
      // adjust wing size
      if (yVel<0){
        wingSizeY = map(-yVel, 0, yVelLimit, 1.5*normalWingSizeY, 2*normalWingSizeY);
      } else {
        wingSizeY = normalWingSizeY;
      }
    
      y += yVel; // add spd->y
      yVel *= dampening; // apply air force
    
  }
    

  void show() { // draws the bird + the rotation
    if (onGround) { // fixes rotation on ground
      rotateDeg = 0.5;
    } else {
      rotateDeg = yVel/50 - 0.3;
    }
    translate(x, y);
    rotate(rotateDeg);
    drawBody(hit);
    drawEye(hit);
    drawBeak(hit);
    drawWing(hit);
    rotate(-rotateDeg);
    translate(-x, -y);
    noStroke();
  }
  
  void drawBody(boolean inv){
    stroke(0); strokeWeight(4);
    fill(r, g, b); // yellow
    if (inv){
      if (frameCount % 30 < 15){
        fill(r, g, b, 70);
      }
    }
    ellipse(0, 0, sizeX, sizeY);
    
    noStroke();
    fill(r, g-100, b);
    if (inv){
      if (frameCount % 30 < 15){
        fill(r, g-100, b, 70);
      }
    }
    arc(0, sizeY/7, 6*sizeX/7, 2*sizeY/3, -QUARTER_PI, PI, PIE);
  }
  
  void drawEye(boolean inv){
    stroke(0); strokeWeight(4);
    fill(255); // white
    if (inv){
      if (frameCount % 30 < 15){
        fill(255, 255, 255, 70);
      }
    }
    arc(sizeX/3.5, -sizeY/8, eyeSizeX*2, eyeSizeY*2, PI-QUARTER_PI, 2*PI+QUARTER_PI, CHORD);
    
    fill(0); // black dot inside the eye
    if (inv){
      if (frameCount % 30 < 15){
        fill(0, 0, 0, 70);
      }
    }
    ellipse(sizeX/4 + 12, -sizeY/4 + 12, eyeSizeX/3, eyeSizeY/3);
  }
  
  void drawBeak(boolean inv){
    stroke(0); strokeWeight(4);
    fill(255, 0, 0); // red
    if (inv){
      if (frameCount % 30 < 15){
        fill(255, 0, 0, 70);
      }
    }
    arc(sizeX/3+3, sizeY/4-sizeY/10, sizeX/1.8, sizeY/5, -(PI-QUARTER_PI), PI-QUARTER_PI, OPEN); // up
    arc(sizeX/3-4, sizeY/4+sizeY/10, sizeX/1.8, sizeY/5, -(PI-QUARTER_PI), PI-QUARTER_PI, OPEN); // down
    arc(sizeX/3-13, sizeY/4, 30, 30, HALF_PI, PI+HALF_PI, OPEN); // back
  }
  
  void drawWing(boolean inv){
    stroke(0); strokeWeight(4);
    fill(r, g, 150); // orange
    if (inv){
      if (frameCount % 30 < 15){
        fill(r, g, 150, 70);
      }
    }
    translate(0, wingSizeY/4);
    arc(-sizeX/3, sizeY/20, wingSizeX, wingSizeY, -QUARTER_PI, PI+QUARTER_PI, CHORD);
    translate(0, -wingSizeY/4);
  }
}
