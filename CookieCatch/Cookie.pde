class Cookie{
  
  //cookie image attributed to: <a href='https://pngtree.com/so/Cartoon'>Cartoon png from pngtree.com/</a>
  //fields
  private float xPos;
  private float diam = 50;
  private float yPos = -diam/2;
  private float speed = 5;
  private PImage cookie = loadImage("cookie.png");
  private float angle = 0;
  private int[] multipliers = {-1,1};
  private int direction;
  private int collideRange;
  
  //public so it can be reached by other classes
  public boolean isTouching = false;
  
  //contructor
  public Cookie(float x){
    this.xPos = x;
    //random direction
    this.direction = multipliers[int(random(0,1.99))];
  }
  
  //setters
  public void setX(float x){
    xPos = x;
  }
  public void setSpeed(float s){
    speed = s;
  }
  public void fasterBy(float s){
    speed += s;
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
  public float getSpeed(){
    return speed;
  }
  
  //draw method
  public void run(){
  
    //rotation is relative to its speed 
    //random direction
    angle += speed*0.003*direction;
    //translate to centre
    translate(xPos,yPos);
    rotate(angle);
    //make the contact point of the cookie the bottom centre
    image(cookie,-diam/2,-diam/2);
    resetMatrix();
    
    if(hasPowerup && currentPowerup.equals("bigger cup")){
      collideRange = 50;
    }
    else{
      collideRange = 25;
    }
    
    //if the cookie yPos is at the yTouching pos for the glass
    //check if it is close enough to the glass on x axis
    if(yPos+diam/2 >= glass.touchingY && yPos+diam/2 <= glass.touchingY + 50){
      if(xPos >= glass.touchingX-collideRange && xPos <= glass.touchingX+collideRange){
        isTouching = true;
      }
    }
  }
}
