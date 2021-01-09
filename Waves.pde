class Waves{
  int locX;
  int locY;
  int size;
  int position = 0;
  int innerCircle;
  int heigth = 4;
  float wavelength;
  PImage imgm;
  Waves(float locX, float locY, int size){
    this.locX= (int) locX;
    this.locY= (int) locY;
    this.size=size;
    innerCircle = size/5;
    wavelength = size/40.9;
    this.imgm=createImage(800, 800, ARGB);
  }
  
  boolean animation(PImage img){
    if(position==size){
      return false;
    }
    imgm.loadPixels();
    img.loadPixels();
    int loc = locX + locY*imgm.width;
      for(int i = -position; i <= position; i++){
         for(int j = -position; j <= position; j++){
          if(position-innerCircle>0&&i*i+j*j<=(position-innerCircle)*(position-innerCircle)&&i+locX>=0&&j+locY>=0&&i+locX<imgm.width&&j+locY<imgm.height){
            imgm.pixels[loc+i+j*imgm.width] = color(0,0,0,0);
          }
          else if(i*i+j*j<=position*position&&i+locX>=0&&j+locY>=0&&i+locX<imgm.width&&j+locY<imgm.height){
            float r = red(img.pixels[loc+i+j*img.width]);
            float g = green(img.pixels[loc+i+j*img.width]);
            float b = blue(img.pixels[loc+i+j*img.width]);
            float m = (size-position)*sin((position-sqrt(i*i+(j*j)))/wavelength)/heigth;
            imgm.pixels[loc+i+j*imgm.width] = color(r-m,g-m,b-m);
          }
      }
    }
      imgm.updatePixels();
      position++;
      image(imgm,400,400);
      return true;
  }
}
