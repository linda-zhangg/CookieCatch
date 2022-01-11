//enable sound during the game
import processing.sound.*;
SoundFile level1, level2;  // different audio files for level 1 and 2
boolean enableMusic = true;  //SET TO FALSE TO HAVE NO MUSIC

//Cookie and cup fields
ArrayList<Cookie> cookies = new ArrayList<Cookie>(); // arrayList of all the cookies
//fields for cookies and glass
ArrayList<Cookie> temp = new ArrayList<Cookie>(); // remove cookie list
int count = 0; // used to generate new cookies
int numCookies = 0; // number of cookies that fell in a game
int frames = 50;
Glass glass; // glass of milk object

//fields for the background graphics
float[] cloudY = {50, 150, 250, 350}; //y values of cloud objects
ArrayList<Cloud> clouds = new ArrayList<Cloud>(); // list to store cloud objects
float[] rainbowY = {50, 150, 250, 350}; //y values of rainbow objects
ArrayList<Rainbow> rainbows = new ArrayList<Rainbow>(); // list to store rainbow objects
Sun sun; // sun object
Milk milk1;  // milk objects
Milk milk2;
int textMover = -250;  // the location of the banner to pause the game

//fields for the game play
int score = 0;  
int highscore = 0;
String mode = "home"; // current mode the game is set on, can be level 1, home, paused etc.
String level = "level 1";  // can be level 1 or 2
int lives = 2;  // number of lives when the game starts
int loseFrame = 0;  //a counter to determine the duration of the lose mode

//fields for power ups
boolean hasPowerup = false;  // if the game has power up ongoing
ArrayList<Powerup> powerups = new ArrayList<Powerup>();  //stored powerup objects
ArrayList<Powerup> tempP = new ArrayList<Powerup>();  // remove powerup list
String powerupType[] = {"extra life", "bigger cup", "double scores"};  // an array of all existing powerups
String currentPowerup;  // the current power up being used
boolean hasExtraLife = false;  // used to ensure life is only added once while powerup is enabled
int powerupCount = 0; //a counter to determine the duration of powerup text

//fields for level 2
ArrayList<Bomb> bombs = new ArrayList<Bomb>();  //stored bomb objects
ArrayList<Bomb> tempB = new ArrayList<Bomb>();  //remove bomb list
Bomb bomb;  // end screen bomb object

//-------------------------------------------------SETUP
void setup() {
  size(600, 600);
  //set up objects
  glass = new Glass(width*3/4);  //controlled by the mouse
  sun = new Sun(50, 30);  // rotating sun
  milk1 = new Milk(0, width*3/4);  //milk sea
  milk2 = new Milk(-600, width*3/4);
  bomb = new Bomb(width/2,height/2);  // losing screen bomb

  //normal clouds for level 1
  for (float y : cloudY) {
    clouds.add(new Cloud(width/2 - 50, y));
  }
  //rainbow clouds for level 2
  for (float y : rainbowY) {
    rainbows.add(new Rainbow(width/2 - 50, y));
  }
  
  //sound files
  if(enableMusic){
    level1 = new SoundFile(this, "level1.wav");
    level1.loop();
    level2 = new SoundFile(this, "level2.wav");
  }
}

void mouseClicked() {
  //begin game on selected level
  if (mode.equals("home")) {
    mode = level;
  }
}

void keyPressed() {
  //enable pause game by pressing space-bar
  if (mode.equals(level) && key == ' ') {
    mode = "paused";
  } else if (mode.equals("paused") && key == ' ') {
    mode = level;
  }

  //change to level 2
  if (mode.equals("home") && key == 'c' && level.equals("level 1")) {
    level = "level 2";
    //change music for level 2
    if(enableMusic){
      level1.stop();
      level2.loop();
    }
  }
  //change back to level 1
  else if (mode.equals("home") && key == 'c' && level.equals("level 2")) {
    level = "level 1";
    //change music for level 1
    if(enableMusic){
      level2.stop();
      level1.loop();
    }
  }
}

//-------------------------------------------------DRAW BACKGROUND
void draw() {
  background(181, 234, 234);

  //pan the audio to match the mouse - louder speakers when mouse is closer to one side
  if(enableMusic){
    level1.pan(map(mouseX,0,width,-1.0,1.0));
    level2.pan(map(mouseX,0,width,-1.0,1.0));
  }
  
  Integer sc = score;

  if (mode.equals("lose") || mode.equals("home") || mode.equals("level 1") || mode.equals("paused") || mode.equals("level 2") || mode.equals("bomb") || mode.equals("glass")) {

    //display score behind background if it is during game play
    if (mode.equals("level 1") || mode.equals("level 2")) {
      fill(171, 224, 224);
      textSize(200);
      textAlign(CENTER);
      text(sc.toString(), width/2, height/2 + 50);
    }

    //animate sun
    sun.run();

    //draw and animate the milk objects
    milk1.run();
    milk1.animate();
    milk2.run();
    milk2.animate();

    //level 1 - draw clouds
    if (level.equals("level 1")) {
      //animate clouds
      for (int i=1; i<=clouds.size(); i++) {
        Cloud current = clouds.get(i-1);
        current.run();
        if (i%2 == 0) {
          current.moveLeft(i*0.5);
          if (current.getX() < -100) {
            current.setX(width);
          }
        } else {
          current.moveRight(i*0.5);
          if (current.getX() > width) {
            current.setX(-100);
          }
        }
      }
    }
    //level 2 - draw rainbows
    else if (level.equals("level 2")) {
      //animate rainbows
      for (int i=1; i<=rainbows.size(); i++) {
        Rainbow current = rainbows.get(i-1);
        current.run();
        if (i%2 == 0) {
          current.moveLeft(i*0.5);
          if (current.getX() < -120) {
            current.setX(width);
          }
        } else {
          current.moveRight(i*0.5);
          if (current.getX() > width) {
            current.setX(-120);
          }
        }
      }
    }
  }

  //-------------------------------------------------LOSE
  if (mode.equals("lose")) {
    //display the lose game mode for 100 frames before returning to home
    loseFrame++;
    if (loseFrame > 100) {
      mode = "home";
    }
    fill(161, 214, 214);
    textSize(100);
    textAlign(CENTER);
    text("game over", width/2, height/2);
  }
  //-------------------------------------------------GLASS
  else if(mode.equals("glass")){
    //display mode for 200 frames before returning to home
    loseFrame++;
    if (loseFrame > 100) {
      loseFrame = 0;
      mode = "lose";
    } else{
      glass.lose();
    }
    
  }
  //-------------------------------------------------BOMB
  else if(mode.equals("bomb")){
    //display mode for 200 frames before returning to home
    loseFrame++;
    if (loseFrame > 200) {
      loseFrame = 0;
      mode = "lose";
    } else{
      bomb.bomblose();
    }
    
  }
  //-------------------------------------------------HOME
  else if (mode.equals("home")) {
    //reset variables
    lives = 2;
    loseFrame = 0;
    numCookies = 0;
    count = 0;
    hasPowerup = false;

    //calc high score
    if (score > highscore) {
      highscore = score;
    }

    //textbox
    fill(171, 224, 224);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height/2, width*3/5, height*2/5, 20);

    //home page
    textSize(90);
    text("Home", width/2, height/4);

    //text
    fill(237, 246, 229);
    textSize(25);
    textAlign(CENTER);
    text("click anywhere to start", width/2, height/2+20);

    //print score
    text("score: "+sc.toString(),width/2,height/2-70);
    
    
    //print high score
    textSize(30);
    Integer hc = highscore;
    text("high score: "+hc.toString(), width/2, height/2-30);

    //indicate level
    textSize(20);
    text(level, width/2, height/2+65);
    textSize(15);
    text("press c to change levels", width/2, height/2+90);

    //reset cookies, bomb and powerup animations
    cookies.clear();
    bombs.clear();
    powerups.clear();
  }
  //-------------------------------------------------PAUSED
  else if (mode.equals("paused")) {
    //textbox
    fill(171, 224, 224);
    noStroke();
    rectMode(CENTER);
    rect(width/2, height/2, width*3/5, height*2/5, 20);

    //home page
    textSize(90);
    text("Paused", width/2, height/4);

    //text
    fill(237, 246, 229);
    textSize(25);
    textAlign(CENTER);
    text("click space-bar to resume", width/2, height/2+50);

    //print score
    textSize(30);
    text("current score: "+sc.toString(), width/2, height/2-30);
  }
  //---------------------------------------------------------------------LEVEL 1 and LEVEL 2
  else if (mode.equals("level 1") || mode.equals("level 2")) {
    
    //reset score
    if(count == 0){
      score = 0;
    }

    //text prompt for pause
    fill(141, 204, 204);
    textSize(20);
    textAlign(LEFT);
    text("press space-bar to pause game", textMover+=2, 20);
    if (textMover >= width) {
      textMover = -250;
    }

    //display some text to indicate power up - set a 200 frame limit on how long the text is displayed
    if (hasPowerup) {
      powerupCount++;
      if (powerupCount < 200) {
        fill(255, 188, 188);
        textSize(30);
        textAlign(CENTER);
        if (hasPowerup && currentPowerup.equals("extra life")) {
          text("extra life!!", width/2, height-30);
        } else if (hasPowerup && currentPowerup.equals("bigger cup")) {
          text("bigger cup!!", width/2, height-30);
        } else if (hasPowerup && currentPowerup.equals("double scores")) {
          text("double scores!!", width/2, height-30);
        }
      }
    } else {
      powerupCount = 0;
    }

    //display the number of lives
    //add a life if the power up is enabled - hasExtra life ensures it is only called once in the drawing loop
    if (hasPowerup && currentPowerup.equals("extra life") && !hasExtraLife) {
      lives++;
      hasExtraLife = true;
    }
    Integer l = lives;
    fill(171, 224, 224);
    textSize(20);
    textAlign(LEFT);
    text("Lives: "+l.toString(), width-100, height-30);

    //draw the glass
    glass.run();

    //generate cookies every few frames
    count++;
    if (count%40 == 0) {
      numCookies++;
      Cookie c = new Cookie(random(25, width-25));
      cookies.add(c);
      //stop increasing speed after a certain point
      if(numCookies < 100){
        c.fasterBy(numCookies*0.05);
      } 
    }

    //make each cookie fall, if falls off the end, remove from list
    for (Cookie c : cookies) {
      //if touching glass, increment score and remove from cookie list
      if (c.isTouching) {
        //if double power up is enabled, increment score every 2
        if (hasPowerup && currentPowerup.equals("double scores")) {
          score += 2;
        } else {
          score++;
        }
        temp.add(c);
      } else {
        c.fall();
        c.run();
        //if falls below the screen, remove from cookie list and decrease lives
        if (c.getY() > height) {
          lives--;
          if (lives == -1) {
            mode = "glass";
          } else {
            temp.add(c);
          }
        }
      }
    }
    for (Cookie c : temp) {
      cookies.remove(c);
    }
    temp.clear();

    //if it is level 2, generate bombs every 160 frames
    if (mode.equals("level 2")) {
      //increase frequency as more cookies fall
      if (count%160-numCookies*2 == 0) {
        Bomb b = new Bomb(random(25, width-25),0);
        bombs.add(b);
        b.fasterBy(numCookies*0.05);
      }

      //make each bomb fall and check if touching
      for (Bomb b : bombs) {
        if (b.isTouching) {
          tempB.add(b);
          mode = "bomb";
        } else {
          b.fall();
          b.run();
          //if falls below the screen, remove from Bomb list
          if (b.getY() > height) {
            tempB.add(b);
          }
        }
      }
      for (Bomb b : tempB) {
        bombs.remove(b);
      }
      tempB.clear();
    }

    //every 900 frames, disable power up so another can be caught again
    if (hasPowerup && count%900 == 0) {
      hasPowerup = false;
      hasExtraLife = false;  // but keep the extra life
    }

    //generate a new powerup every few hundred frames
    if (count%500 == 0 && !hasPowerup) {
      Powerup p = new Powerup(random(25, width-25));
      powerups.add(p);
    }

    //make each power up fall and check if touching
    for (Powerup p : powerups) {
      //if touching glass, toggle powerup and add to tempP list
      if (p.isTouching) {
        hasPowerup = true;
        //set a random powerup from the power up array
        currentPowerup = powerupType[int(random(0, powerupType.length-0.001))];
        tempP.add(p);
      } else {
        p.fall();
        p.run();
        //if falls below the screen, remove from Powerup list
        if (p.getY() > height) {
          tempP.add(p);
        }
      }
    }
    for (Powerup p : tempP) {
      powerups.remove(p);
    }
    tempP.clear();
  }
}
