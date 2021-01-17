class Stone {
  Playfield p;
  PImage stone;

  boolean overStone = false;
  boolean locked = false;
  boolean stoneMoved;
  int positionX;
  int positionY;
  int posXend;
  int posYend;
  int posXinitial;
  int posYinitial;
  int stoneXOld;
  int stoneYOld;
  int stoneSize;
  float transparency=100;
  boolean transparencyOn;
  boolean fadedAway = false;
  boolean isMovable = true;
  boolean canChooseWeight = false;
  int stoneMin = 20;
  int stoneMax = 120;
  int weight;

  Stone(int stoneXtemp, int stoneYtemp, int size, int weight, 
    Playfield pf) {
    stone = loadImage("stone.png");
    p = pf;
    positionX = stoneXtemp;
    positionY = stoneYtemp;
    this.weight = weight;

    posXinitial = stoneXtemp;
    posYinitial = stoneYtemp;

    //imageMode(CENTER);

    stoneSize = size;
  }
  void create() {
    System.out.println("" + isResizable+isResized+mousePressed);
    System.out.println(""+isResizable + isResized+mousePressed);
    stoneSize = mouseX;
    checkStoneSize(mouseX);
    isResized=true;
    canChooseWeight=true;
    noTint();
  }


  void display() {
    //System.out.println("weight:" + weight);
    if (isResizable&&mousePressed) {
      create();
    }
    //sets transparency if the stone is in water
    if (transparencyOn) {
      tint(255, 100);
      if (!fadedAway) {
        fadeAway();
      }
    } else {
      //Changes color of stones when the weight is chosen. Play with colors!!!
      if (weight==10) {
        tint(0, 0, 200);
      } else if (weight==20) {
        tint(0, 0, 225);
      } else if (weight==30) {
        tint(0, 0, 255);
      } else
        noTint();
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
      if (!locked&&!drag) {
      }
    } else {
      overStone = false;
    }
  }
  void chooseWeight() {
  //sets stone weight by pressing keys 1,2,3. 1 - light, 2 - medium, 3 - heavy. Only accessable once after the stone is resized
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
    noStroke();
    fill(#083F48, 180);
    rect(positionX + 10, positionY+10, stoneSize, stoneSize, 10);
    display();
  }

  void initMove() {
  //doest let user move stone before it was resized and the stone weight was chosen
    if (drag||!isResized||canChooseWeight) {
      return;
    }
     //initializes the move
    if (overStone && mousePressed&&isMovable) {
      locked = true;
      drag=true;
    } else {
      locked = false;
    }
  }

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

    //if (!drag&&locked) {
    //  //  if (stoneOverStone()) {
    //  setInitialPosition();
    //  locked=false;
    //  return;
    //}
    canCreateNewStone = true;
    transparencyOn=true;
    // waves.add(new Waves(positionX, positionY, stoneSize*2, new SoundFile(p, "plop.wav")));
    locked = false;
    X = positionX;
    Y = positionY;
    ship.move();

    // }
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

  //void appear() {
  //  setInitialPosition();
  //  if (transparency < 255) { 
  //    transparency += stoneAcceleration;
  //  }
  //  tint(255, transparency);
  //  if (transparency>=255) {
  //    System.out.println("APPEARED HERE");
  //    fadedAway=false;
  //    isMovable=true;
  //  }
  //}

  void fadeAway() {
    isMovable=false;
    if (transparency > 0) { 
      transparency -= stoneAcceleration;
    }
    tint(255, transparency);
    if (transparency<=0) {
      System.out.println("FADED HERE");
      fadedAway=true;
      //transparencyOn=false;
    }
  }

  int getSize() {
    return stone.width;
  }
}
