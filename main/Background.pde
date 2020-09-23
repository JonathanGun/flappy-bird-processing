class Cloud{
  float y = random(50,300);
  float len = random(1,6);
  float sizeX = random(80,120);
  float sizeY = random(50,70);
  float col = random(210,255);
  float x = width + this.sizeX*this.len;
  float vel = random(3, 6);
  
  
  void update(int i){
    if (gameOver && !gameStart){
      this.x -= 0.2*this.vel;
    } else {
      this.x -= this.vel;
    }
    if (this.x + this.sizeX*this.len < 0){
      cloud[i] = new Cloud();
    }
  }
  
  void show(){
    fill(this.col);
    ellipse(this.x, this.y, this.sizeX, this.sizeY);
    for (float i = 1; i <= this.len; i++){
      ellipse(this.x - this.sizeX/2 * i, this.y + this.sizeY/3, this.sizeX, this.sizeY);
      ellipse(this.x - this.sizeX/2 * i, this.y - this.sizeY/3, this.sizeX, this.sizeY);
    }
    ellipse(this.x - this.sizeX/2 *this.len, this.y, this.sizeX, this.sizeY);
  }
}



class Sky{
  float sunX, sunY, moonX, moonY;
  float sunSize = 150;
  float moonSize = 100;
  float dayLength = 2500;
  float r = width;
  
  float backR, backG, backB;
  float a = -PI-QUARTER_PI;
  float aVel = -(PI/dayLength);
  
  void update(){
    sunX = -r*cos(a);
    sunY = -r*sin(a);
    moonX = -sunX;
    moonY = -sunY;
    chgBGColor();
    a += aVel;
  }
  
  void show(){
    background(backR, backG, backB);
    noStroke();
    translate(width/2, height);
    drawSun();
    drawMoon();
    translate(-width/2, -height);
  }
  
  void chgBGColor(){
    if (sin(a) > 0){
      backR = map(sin(a), 0, 1, 210, 0);
      backG = map(sin(a), 0, 1, 0, 210);
      backB = map(sin(a), 0, 1, 100, 230);
    } else if (sin(a) > -0.4){
      backR = map(sin(a), 0, -0.4, 210, 0);
      backG = 0;
      backB = map(sin(a), 0, -0.4, 230, 100);
    } else {
      backR = 0;
      backG = 0;
      backB = map(sin(a), -0.4, -1, 100, 50);
    }
  }
    
  void drawSun(){
    fill(250, 230, 170, 30);
    ellipse(sunX, sunY, 3*sunSize, 3*sunSize);
    fill(220, 210, 0); 
    ellipse(sunX, sunY, sunSize, sunSize);
  }
    
  void drawMoon(){
    fill(250, 250, 250, 12);
    ellipse(moonX, moonY, 6*moonSize, 6*moonSize);
    fill(220, 220, 220, 18);
    ellipse(moonX, moonY, 3*moonSize, 3*moonSize);
    fill(200);
    ellipse(moonX, moonY, moonSize, moonSize);
    fill(185);
    ellipse(moonX, moonY, 3*moonSize/4, 3*moonSize/4);
  }
}
  
  
  
class Bush{
  float x;
  float h = 80;
  float sizeX = random(30,130);
  float sizeY = random(2*this.sizeX/3, this.sizeX);
  float bushVel = vel-2;
  
  Bush(){
    this.x = maxX + this.sizeX/2;
    maxX = this.x + this.sizeX/2;
  }
  
  void update(int i) {
    this.x -= bushVel;
    if (this.x + this.sizeX/2 < 0) {
      bush[i] = new Bush();
    }
  }
  
  void show(){
    translate(0, height-ground.h-h);
    fill(30, 100, 0);
    ellipse(this.x, 0, this.sizeX, this.sizeY);
    rect(0, 0, width, h);
    translate(0, -(height-ground.h-h));
  }
  
}



class Ground{
  float h = 60;
  
  void show(){
    fill(140,70,30); // brown
    rect(0, height-h, width, h);
  }
}