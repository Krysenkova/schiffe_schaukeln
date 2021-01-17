class Bowl {
  PImage stoneBowl;
  float positionX;
  float positionY;
  Bowl(int posX, int posY) {
    stoneBowl=loadImage("stoneBowl.png");
    positionX=posX;
    positionY=posY;
  }

  void display() {

    image(stoneBowl, positionX, positionY);
  }

  boolean inBowl() {
    float px;
    float py;
    float cx=positionX;
    float cy=positionY;
    float radius = stoneBowl.width/2;
    px=mouseX;
    py=mouseY;
    float distX = px - cx;
    float distY = py-cy;
    float distance = sqrt((distX*distX)+(distY*distY));
    System.out.println("d: "+ distance + " r: " + radius);
    if (distance <=radius) {
      return true;
    } else
      return false;
  }
}
