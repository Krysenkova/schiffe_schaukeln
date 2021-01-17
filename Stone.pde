class Stone {
  Playfield p;  //main playfield
  PImage stone;  //image of the stone
  boolean overStone = false; //value to determine if the cursor is over stone
  boolean locked = false; //vale to determine if the stone locked or not
  boolean stoneMoved; //value to determine if the stone was moved
  int positionX; //current position of the stone on x-Axis
  int positionY;  //current position of the stone on y-Axis
  int posXinitial; //initial position of the stone on x-Axis
  int posYinitial;  //initial position of the stone on y-Axis
  int stoneXOld;  //position of the stone on x-Axis before it was moved
  int stoneYOld;  //position of the stone on y-Axis before it was moved
  int stoneSize;  //size of the stone
  float transparency=100; //transparency value for stones in tint() 
  boolean transparencyOn; //value to determine if the stone should be transparent or not
  boolean fadedAway = false; //value to determin if the stne is still visible for user
  boolean isMovable = true; //value to determine if the user can move stone
  boolean canChooseWeight = false; //value to determine if the user can choose weight for the stone
  int stoneMin = 20; //the minimum size of the stone that is permitted
  int stoneMax = 120; //the maximum size of the stone that is permitted
  int weight; // weight of the stone 


  /**
  *stone constructor to initialize image and other parameters
  *
  *@param stoneXtemp
  *@param  stoneYtemp
  *@param size
  *@param weight
  *@param Playfield
  **/
  Stone(int stoneXtemp, int stoneYtemp, int size, int weight, 
    Playfield pf) {
    stone = loadImage("stone1.png");
    p = pf;
    positionX = stoneXtemp;
    positionY = stoneYtemp;
    this.weight = weight;
    posXinitial = stoneXtemp;
    posYinitial = stoneYtemp;
    imageMode(CENTER);
    stoneSize = size;
  }

/**
 *lets user create a stone by mouse movement
 **/
  void create() {
    System.out.println("" + isResizable+isResized+mousePressed);
    System.out.println(""+isResizable + isResized+mousePressed);
    if (isMovable) {
      stoneSize = mouseX;
      checkStoneSize(mouseX);
      isResized=true;
      canChooseWeight=true;
      noTint();
    }
  }

  boolean isResizable() {
    return isResizable&&bowl.inBowl();
  }

  void display() {
    if (isResizable()&&mousePressed) {
      create();
    }
    if (transparencyOn) {
      //sets transparency when the stone is in water
      tint(255, 100);
      if (!fadedAway) {

        fadeAway();
      }
    } 
    if (!transparencyOn) {
      //sets color when the weight is chosen
      if (weight==10) {
        tint(0, 0, 200);
      } else if (weight==20) {
        tint(0, 0, 225);
      } else if (weight==30) {
        tint(0, 0, 255);
      } else {
        noTint();
      }
    }
    image(stone, 
      positionX, positionY, 
      stoneSize, stoneSize);
  }

  void update() {
    if (mouseX > positionX - stoneSize / 2 &&
      mouseX < positionX + stoneSize / 2 &&
      mouseY > positionY - stoneSize / 2 && 
      mouseY < positionY + stoneSize / 2 &&isResized) {
      overStone = true;
    } else {
      overStone = false;
    }
    //removes stone from the playfield when it faded away
    for (int i = stones.size()-1; i >= 0; i--) {
      if (stones.get(i).fadedAway) {
        stones.remove(i);
      }
    }
  }
  void chooseWeight() {
    canCreateNewStone=false;
    //allows user to choose wieght for a stone by pressing keybord keys: 1 - light, 2 - medium, 3 - heavy
    if (canChooseWeight && !isResizable && keyPressed) {
      if (key == '1') {
        weight = 10;
      } else if (key == '2') {
        weight = 20;
      } else if (keyCode == '3') {
        weight = 30;
      }
      canChooseWeight  = false;
      isMovable = true;
    }
  }
  void displayWithShadow() {
    rectMode(CENTER);
    noStroke();
    fill(#083F48, 180);
    rect(positionX + 10, positionY+10, stoneSize, stoneSize, 10);
    display();
  }

  void initMove() {

    if (drag||!isResized||canChooseWeight) {
      //doesn't let user throw a stone that is not yet resized or without weight
      return;
    }
    if (overStone && mousePressed&&isMovable) {
      //initializes move
      locked = true;
      drag=true;
    } else {
      locked = false;
    }
  }

  //changes position of the stone
  void interact() { 
    if (drag&&locked&&isResized) {
      tint(230);
      positionX = mouseX;
      positionY = mouseY;
      displayWithShadow();
    } else
      noTint();
  }

  boolean stoneMoved() {
    return stoneMoved = (overStone&&!locked && positionX > stoneXOld + 100 && positionY > stoneYOld + 100);
  }

  //boolean overShip() {
  //  if (positionX+stoneSize >= ship.shipX && positionX <= ship.shipX +ship.shipWidth/2 &&
  //    positionY + stoneSize >= ship.shipY+15 && positionY <= ship.shipY+15 + ship.shipHeight/2) {
  //    return true;
  //  }
  //  return false;
  //}

  //boolean stoneOverStone() {
  //  //first&second
  //  if (stone1.positionX+stone1.stoneSize >= stone2.positionX && stone1.positionX <= stone2.positionX +stone2.stoneSize &&
  //    stone1.positionY + stone1.stoneSize >= stone2.positionY && stone1.positionY <= stone2.positionY + stone2.stoneSize) {
  //    return true;
  //  }
  //  // second&third
  //  if (stone3.positionX+stone3.stoneSize >= stone2.positionX && stone3.positionX <= stone2.positionX +stone2.stoneSize &&
  //    stone3.positionY + stone3.stoneSize >= stone2.positionY && stone3.positionY <= stone2.positionY + stone2.stoneSize) {
  //    return true;
  //  }
  //  // third&first
  //  if (stone3.positionX+stone3.stoneSize >= stone1.positionX && stone3.positionX <= stone1.positionX +stone1.stoneSize &&
  //    stone3.positionY + stone3.stoneSize >= stone1.positionY && stone3.positionY <= stone1.positionY + stone1.stoneSize) {
  //    return true;
  //  }
  //  return false;
  //}


  void afterMove() {
    if (canChooseWeight||!isResized) {
      return;
    }
    // if (overShip()) {
    //    setInitialPosition();
    //    locked = false;
    //   return;
    // }
    
    if (!drag&&locked) {
      //  //  if (stoneOverStone()) {
      //  setInitialPosition();
      //  locked=false;
      //  return;
      //}
      canCreateNewStone = true;
      waves.add(new Waves(positionX, positionY, stoneSize*2, new SoundFile(p, "plop.wav")));
      transparencyOn=true;
      locked = false;
      X = positionX;
      Y = positionY;
      ship.move();
    }
  }

  void checkStoneSize(int mouseX) {
    if (mouseX <= stoneMin) {
      stoneSize = stoneMin;
    }

    if (mouseX >= stoneMax) {
      stoneSize = stoneMax;
    }
  }
  
  void setInitialPosition() {
    positionX = posXinitial;
    positionY = posYinitial;
  }

  //gradualy changes the transparency of the stone till it dissapears
  void fadeAway() {
    System.out.println("In Fade Away");
    isMovable=false;
    if (transparency > 0) { 
      transparency -= 0.5;
    }
    tint(255, transparency);
    if (transparency<=0) {
      System.out.println("FADED HERE");
      fadedAway=true;
    }
  }

  int getSize() {
    return stoneSize;
  }
}

