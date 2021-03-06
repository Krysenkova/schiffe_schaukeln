import processing.sound.*;
import processing.video.*;
import java.util.List;
import java.util.Iterator;
Movie water;

ArrayList<Stone> stones = new ArrayList<Stone>();
Stone stone;

Bowl bowl;
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
ArrayList<Waves> waves = new ArrayList<Waves>();

void setup() {
  size(800, 800);
  water=new Movie(this, "Water.mp4");
  water.loop();
  stones.add(stone = new Stone(130, 130, 0, 0, this));
  bowl = new Bowl(130, 130);
  ship = new Ship(width/2, height/2);
}

void draw() {
  background(water); 

  bowl.display();

  Iterator<Waves> i = waves.iterator();
  while (i.hasNext()) {
    if (!i.next().animation(water)) {
      i.remove();
    }
  }

  for (int s = 0; s < stones.size(); s++) {
    stones.get(s).display();
    stones.get(s).update();
    if (stones.size()>0) {
      stones.get(s).interact();
    }
  }
  ship.display();
  ship.update();
}

void mousePressed() {
  if (bowl.inBowl()&&canCreateNewStone) {
    Stone temp = new Stone(130, 130, 0, 0, this);
    stones.add(temp);
    isResizable=true;
    return;
  }
  for (Stone s : stones) {
    s.chooseWeight();
    s.initMove();
  }
}

void movieEvent(Movie m) {
  m.read();
}

void mouseReleased() {
  isResizable = false;
  drag=false;
  for (int s = 0; s <= stones.size() - 1; s++) {
    stones.get(s).afterMove();
  }
}
//controls if the keyboard keys were typed and calls a methode to set weight for a stone
void keyPressed() {
  for (int s = 0; s <= stones.size() - 1; s++) {
    stones.get(s).chooseWeight();
  }
}
