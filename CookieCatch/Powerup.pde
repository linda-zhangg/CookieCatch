class Powerup{

  //fields
  private float xPos;
  private float diam = 50;
  private float yPos = -diam/2;
  private float speed = 7;
  private PImage powerup = loadImage("powerup.png");
  private float angle = 0;
  private int[] multipliers = {-1,1};
  private int direction;
  private int collideRange;
  
  public boolean isTouching = false;
  
  //contructor
  public Powerup(float x){
    this.xPos = x;
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
  
  //draw method
  public void run(){
  
    //rotation is relative to its speed 
    //random direction
    angle += speed*0.003*direction;
    
    //translate to centre
    translate(xPos,yPos);
    rotate(angle);
    //make the contact point of the powerup the bottom centre
    image(powerup,-diam/2,-diam/2);
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
  
