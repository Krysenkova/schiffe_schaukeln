class Ship {
  PImage ship;

  int counter = 0;

  float shipX;
  float shipY;
  int shipWidth;
  int shipHeight;

  float shipXSpeed;
  float shipYSpeed;

  float hoverAmount;
  float maxHover;
  float minHover;

  float shipXMiddle;
  float shipYMiddle;


  Ship(int tempShipX, int tempShipY) {
    shipX = tempShipX;
    shipY = tempShipY;

    ship = loadImage("ship.png");
    imageMode(CENTER);
    shipWidth = 196;
    shipHeight = 116;

    shipXSpeed = 0;
    shipYSpeed = 0;

    hoverAmount = 0.2;
    maxHover = shipY + 5;
    minHover = shipY - 5;
  }

  void display() {
    noTint();
    shipX += shipXSpeed;
    shipY += shipYSpeed;
    image(ship, shipX, shipY, shipWidth, shipHeight);
    hover();

    fill(255, 0);
  }

  void hover() {
    shipY += hoverAmount;
    if (shipY >= maxHover || shipY <= minHover) {
      hoverAmount *= -1;
    }
  }

  float moveTime = -1;

  void update() {
    if (counter <= moveTime) {
      if (X > shipX && Y < shipY) {
        shipXSpeed=-1;
        shipYSpeed=1;
      } else if (X > shipX && Y > shipY) {
        shipYSpeed=-1;
        shipXSpeed=-1;
      } else if (X < shipX && Y > shipY) {
        shipYSpeed=-1;
        shipXSpeed=1;
      } else if (X < shipX && Y < shipY) {
        shipXSpeed=1;
        shipYSpeed=1;
      }
      counter++;
    } else {
      shipXSpeed = 0;
      shipYSpeed = 0;
      counter=0;
      moveTime = -1;
    }
  }

  void move () {
    float distance = dist(X, shipX+(shipWidth/2), Y, shipY+(shipHeight/2));
    //Check distance!!!
    if (stone1.stoneMoved() && distance <= 300) {
      stoneAcceleration=0.25;
      moveTime = 100;
    }
    // System.out.println("2StMoved: " + stone2.stoneMoved()+"3StMoved: " + stone3.stoneMoved()+"1StMoved: " + stone1.stoneMoved());
    if (stone2.stoneMoved() && distance <= 230) {
      stoneAcceleration=0.4;
      moveTime = 50;
    }
    // System.out.println("3StMoved: " + stone3.stoneMoved() + "1StMoved: " + stone1.stoneMoved()+ "2StMoved: " + stone2.stoneMoved());
    if (stone3.stoneMoved() && distance <= 150) {
      stoneAcceleration=0.65;
      moveTime = 30;
    }
  }
}
