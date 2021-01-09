import processing.video.*;
import java.util.List;
import java.util.Iterator;
Movie water;

Stone stone1, stone2, stone3;

PImage img;

boolean drag = false;

Ship ship;
ArrayList<Waves> waves = new ArrayList<Waves>();

void setup(){
  size(800, 800);
  water=new Movie(this,"Water.mp4");
  water.loop();

  stone1=new Stone(70, 70, 100,this);
  stone2=new Stone(180, 70, 80,this);
  stone3=new Stone(270, 70, 60,this);
  
  ship = new Ship(width/2, height/2);
}

void draw() {
  background(water); 
  
   Iterator<Waves> i = waves.iterator();
  while(i.hasNext()){
    if(!i.next().animation(water)){
      i.remove(); }
    }
    
  
  stone1.display();
  stone2.display();
  stone3.display();

  stone1.update();
  stone2.update();
  stone3.update();

  stone1.interact();
  stone2.interact();
  stone3.interact();
  
  ship.display();
  //ship.move();
 
}

void mousePressed() {
  stone1.initMove();
  stone2.initMove();
  stone3.initMove();
}

void movieEvent(Movie m){
  m.read();
}

void mouseReleased() {
  drag=false;
  stone1.afterMove();
  stone2.afterMove();
  stone3.afterMove();
}
