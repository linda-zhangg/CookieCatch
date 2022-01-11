class Bomb{

  //fields
  private float xPos;
  private float diam = 50;
  private float yPos = -diam/2;
  private float speed = 7;
  private PImage bomb = loadImage("bomb.png");
  private PImage bomblose = loadImage("bomblose.png");
  private float angle = 0;
  private int[] multipliers = {-1,1};
  private int direction;
  private int collideRange;
  
  public boolean isTouching = false;
  
  //contructor
  public Bomb(float x, float y){
    this.xPos = x;
    this.yPos = y;
    //random direction
    this.direction = multipliers[int(random(0,1.99))];
  }
  
  //INCREASE Y method
  public void fall(){
    yPos += speed;
  }
  
  //getters
  public float getX(){
    return xPos;
  }
  public float getY(){
    return yPos;
  }
  public float getDiam(){
    return diam;
  }
  
  //increase speed by
  public void fasterBy(float s){
    speed += s;
  }
 
 
  //lose by bomb screen 
  public void bomblose(){
    translate(xPos,yPos);
    imageMode(CENTER);
    // first 80 frames, shake more and more violently
    if(loseFrame < 80){
      image(bomblose,loseFrame * sin(loseFrame) / 2, 0);
    }
    // 160 frames, white circle grows beind
    else if(loseFrame < 160){
      noStroke();
      fill(255);
      circle(0, 0, (loseFrame-80)*12);
      image(bomblose,loseFrame * sin(loseFrame) / 2, 0);
    }
    // 200 frames, white circle fades away
    else{
      fill(255,255,255,255-(loseFrame-160)*6.375);
      rect(0,0,width,height);
    }
    imageMode(CORNER);
    resetMatrix();
  }
  
  //draw method
  public void run(){
  
    //rotation is relative to its speed 
    //random direction
    angle += speed*0.003*direction;
    
    //translate to centre
    translate(xPos,yPos);
    rotate(angle);
    //make the contact point of the powerup the bottom centre
    image(bomb,-diam/2,-diam/2);
    resetMatrix();
    
    if(hasPowerup && currentPowerup.equals("bigger cup")){
      collideRange = 50;
    }
    else{
      collideRange = 25;
    }
    
    //if the powerup yPos is at the yTouching pos for the glass
    //check if it is close enough to the glass on x axis
    if(yPos+diam/2 >= glass.touchingY && yPos+diam/2 <= glass.touchingY + 50){
      if(xPos >= glass.touchingX-collideRange && xPos <= glass.touchingX+collideRange){
        isTouching = true;
      }
    }
  }
}
  
