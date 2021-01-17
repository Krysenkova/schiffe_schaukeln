import processing.sound.*;
import processing.video.*;
import java.util.List;
import java.util.Iterator;
Movie water;

ArrayList<Stone> stones = new ArrayList<Stone>();
Stone stone;

//Bowl bowl;
boolean drag = false;
boolean isResizable = true;
boolean isResized = false;
boolean canCreateNewStone = false;
float stoneAcceleration;
float X;
float Y;
int stoneSize;
int stoneIndex;
Ship ship;
//ArrayList<Waves> waves = new ArrayList<Waves>();

void setup() {
  size(800, 800);
  water=new Movie(this, "Water.mp4");
  water.loop();
  stones.add(stone = new Stone(65, 65, 0, 0, this));
  //bowl = new Bowl(0, 0);
  ship = new Ship(width/2, height/2);
}

void draw() {
  background(water); 
  //  bowl.display();
  //Iterator<Waves> i = waves.iterator();
  //while (i.hasNext()) {
  //  if (!i.next().animation(water)) {
  //    i.remove();
  //  }
  //}
  stone.display();
  stone.update();
  stone.interact();

  ship.display();
  ship.update();
}

void mousePressed() {
  stone.chooseWeight();
  stone.initMove();
}

void movieEvent(Movie m) {
  m.read();
}

void mouseReleased() {
  isResizable = false;
  drag=false;
  stone.afterMove();
  if (canCreateNewStone) {
    stones.add(new Stone(65, 65, 0, 0, this));
  }

}
void keyPressed() {
  stone.chooseWeight();
}
