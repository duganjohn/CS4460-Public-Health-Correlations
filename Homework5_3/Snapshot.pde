public class Snapshot{
  PImage image;
  int x;
  int y;
  int w;
  int h;
  int year;
  String gradientLabel;
  
  public Snapshot(PImage image, int x, int y, int w, int h, int year, String gradientLabel){
    this.image = image;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.year = year;
    this.gradientLabel = gradientLabel;
    
  }
  
  public void draw(){
      image(image, x, y, w, h);
  }
  
  
  
}
