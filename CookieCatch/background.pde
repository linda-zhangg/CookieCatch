// cloud object for level 1
class Cloud {
  private PImage cloud = loadImage("cloud.png");
  private float xPos, yPos;

  public Cloud(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }

  //draw
  public void run() {
    image(cloud, xPos, yPos);
  }
  public float getX() {
    return xPos;
  }
  public void setX(float x) {
    xPos = x;
  }
  public void moveRight(float x) {
    xPos += x;
  }
  public void moveLeft(float x) {
    xPos -= x;
  }
}

//level 2 rainbow clouds
class Rainbow {
  private PImage cloud = loadImage("rainbow.png");
  private float xPos, yPos;

  public Rainbow(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }

  //draw
  public void run() {
    image(cloud, xPos, yPos);
  }
  public float getX() {
    return xPos;
  }
  public void setX(float x) {
    xPos = x;
  }
  public void moveRight(float x) {
    xPos += x;
  }
  public void moveLeft(float x) {
    xPos -= x;
  }
}

// sun object for background
class Sun {
  private PImage sun = loadImage("sun.png");
  private float xPos, yPos;
  private float angle = 0;

  public Sun(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }

  //draw
  public void run() {
    //rotate the sun
    angle += 0.01;
    translate(xPos+50, yPos+50);
    rotate(angle);
    image(sun, -50, -50);
    resetMatrix();
  }
}

//sea of milk
class Milk {
  private PImage milk = loadImage("milky.png");
  private float xPos, yPos;

  public Milk(float xPos, float yPos) {
    this.xPos = xPos;
    this.yPos = yPos;
  }

  //draw
  public void run() {
    image(milk, xPos, yPos);
  }

  //make it move
  public void animate() {
    xPos+=1.5;
    if (xPos > width) {
      xPos = -595;
    }
  }
}
