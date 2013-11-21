public class Snapshot{
  PImage image;
  int slot;
  int year;
  String gradientLabel;
  boolean textOn = true;
  int x;
  int y = heightH-130;
  int w = 200;
  int h = 120;
  
  
  public Snapshot(PImage image, Integer slot, int year, String gradientLabel){
    this.image = image;
    this.slot = slot;
    this.year = year;
    this.x = slot*200;
    this.gradientLabel = gradientLabel;
    
  }
  
  public void draw(){
    image(image, x, y, w, h);
    if (textOn){
      text(gradientLabel+", "+year, (x+(w/2)), y+h-10);
    }
  }
  
  public void setImage(PImage newImage){
    image = newImage;
  }
  
  public void delete(){
    image = new PImage(200,120,RGB);
    textOn = false;
    draw();
  }
  
  public int getSlot(){
    return slot;
  }
}
