class Stone {
  Playfield p;
  PImage stone;

  boolean overStone = false;
  boolean locked = false;
  boolean stoneMoved;
  float positionX;
  float positionY;
  float posXinitial;
  float posYinitial;
  float stoneXOld;
  float stoneYOld;
  int stoneSize;
  float transparency=100;
  boolean transparencyOn;
  boolean fadedAway = false;
  boolean isMovable = true;

  Stone(float stoneXtemp, float stoneYtemp, 
    int stoneSizeTemp, Playfield pf) {
    stone = loadImage("stone.png");
    p = pf;

    positionX = stoneXtemp;
    positionY = stoneYtemp;
    stoneXOld = positionX;
    stoneYOld = positionY;

    posXinitial = stoneXtemp;
    posYinitial = stoneYtemp;

    imageMode(CENTER);
    stoneSize = stoneSizeTemp;
  }

  void display() {
    if (transparencyOn) {
      tint(255, 100);
      if (!fadedAway) {
        fadeAway();
      }
    } else if (fadedAway) {
      appear();
      if (transparency >=255) {
        fadedAway=false;
        transparency=100;
      }
    } else {
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
      mouseY < positionY + stoneSize / 2) {
      overStone = true;
      if (!locked&&!drag) {
      }
    } else {

      overStone = false;
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
    if (drag)
      return; 
    if (overStone && mousePressed&&isMovable) {
      locked = true;
      drag=true;
    } else {
      locked = false;
    }
  }

  void interact() {
    if (drag&&locked) {
      positionX = mouseX;
      positionY = mouseY;
      displayWithShadow();
    }
  }
  boolean stoneMoved() {
    return stoneMoved = (overStone&&!locked && positionX > stoneXOld + 100 && positionY > stoneYOld + 100);
  }

  boolean overShip() {
    //TODO
    return false;
  }

  void afterMove() {
    if (!drag&&locked) {
      X = mouseX;
      Y = mouseY;
      transparencyOn=true;
      waves.add(new Waves(positionX, positionY, stoneSize*2));
      locked = false;
      ship.move();
    }
  }

  void setInitialPosition() {
    positionX = posXinitial;
    positionY = posYinitial;
  }

  void appear() {
    setInitialPosition();
    if (transparency < 255) { 
      transparency += stoneAcceleration;
    }
    tint(255, transparency);
    if (transparency>=255) {
      System.out.println("APPEARED HERE");
      fadedAway=false;
      isMovable=true;
    }
  }

  void fadeAway() {
    isMovable=false;
    if (transparency > 0) { 
      transparency -= stoneAcceleration;
    }
    tint(255, transparency);
    if (transparency<=0) {
      System.out.println("FADED HERE");
      fadedAway=true;
      transparencyOn=false;
    }
  }
