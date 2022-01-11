class Glass{
  
  private float xPos, yPos;  // position of glass
  
  public float touchingX, touchingY;  // public to use for touching cookies
  
  private boolean fill = true;  // used for losing animation
  
  //contructor - x position
  public Glass(float yPos){
    this.yPos = yPos;
  }
  
  //get x position method
  public float getX(){
    return xPos;
  }
  
  //lose method to display when lives run out
  public void lose(){
    xPos = width/2;
    yPos = height/2;
    
    translate(xPos,yPos);
    noStroke();
    fill(255, 251, 241);
    beginShape();
    
    //toggle fill every 10 frames
    if(loseFrame%10 == 0){
      if(fill){
        fill = false;
      }
      else{
        fill = true;
      }
    }
    
    //filling cup animation
    if(fill){
      vertex(-46,0);
      vertex(-40,100);
      vertex(40,100);
      vertex(47,0);
    } else {
      vertex(-41,60);
      vertex(-40,100);
      vertex(40,100);
      vertex(42,60);
    }
    endShape(CLOSE);
    bezier(-40,100,-20,112,20,112,40,100);
    
    //draw outline
    noFill();
    stroke(128);
    strokeWeight(2);
    ellipse(0,-50,100,20);
    line(-50,-50,-40,100);
    line(50,-50,40,100);
    bezier(-40,100,-20,112,20,112,40,100);
    resetMatrix();
  }
  
  //draw method
  public void run(){
    //move along x-axis
    yPos = height*3/4;
    xPos = mouseX;
    
    //target position for cookies hitting
    touchingX = xPos;
    touchingY = yPos-50;
    
    //draw glass
    translate(xPos,yPos);
    
    //draw power up cup
    if(hasPowerup && currentPowerup.equals("bigger cup")){
      //draw milk inside cup
      noStroke();
      fill(255, 251, 241);
      beginShape();
      //decrease milk inside cup according to the number of lives
      if(lives >= 2){
        vertex(-47,-37);
        vertex(-40,100);
        vertex(40,100);
        vertex(48,-37);
      }
      else if(lives == 1){
        vertex(-46,0);
        vertex(-40,100);
        vertex(40,100);
        vertex(47,0);
      }
      else{
        vertex(-43,40);
        vertex(-40,100);
        vertex(40,100);
        vertex(44,40);
      } 
      endShape(CLOSE);
      bezier(-40,100,-20,112,20,112,40,100);
      
      //outline
      noFill();
      stroke(128);
      strokeWeight(2);
      ellipse(0,-50,100,20);
      line(-50,-50,-40,100);
      line(50,-50,40,100);
      bezier(-40,100,-20,112,20,112,40,100);
      
    }
    //draw normal size cup
    else{
      //draw milk inside cup - as the lives decrease, make the milk decrease
      noStroke();
      fill(255, 251, 241);
      beginShape();
      if(lives >= 2){
        vertex(-23,-30);
        vertex(-20,50);
        vertex(20,50);
        vertex(23.5,-30);
      }
      else if(lives == 1){
        vertex(-22.5,0);
        vertex(-20,50);
        vertex(20,50);
        vertex(22.5,0);
      }
      else{
        vertex(-21,30);
        vertex(-20,50);
        vertex(20,50);
        vertex(21,30);
      }
      endShape(CLOSE);
      bezier(-20,50,-10,55,10,55,20,50);
      
      //outline
      noFill();
      stroke(128);
      strokeWeight(2);
      ellipse(0,-50,50,10);
      line(-25,-50,-20,50);
      line(25,-50,20,50);
      bezier(-20,50,-10,55,10,55,20,50);
    }
    resetMatrix();
  }
  
  
}
