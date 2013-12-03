public class Snapshot{
  PImage image;
  int slot;
  int year;
  String gradientLabel;
  boolean notHidden = false;
  int x;
  int y = heightH-130;
  int w = 200;
  int h = 120;
  
  public Snapshot(Integer slot){
    this.slot = slot;
  }
  
  public void setSnapshot(PImage image, Integer slot, int year, String gradientLabel){
    this.image = image;
    this.slot = slot;
    this.year = year;
    this.x = slot*200;
    this.gradientLabel = gradientLabel;
    notHidden = true;
    
  }
  
  
  public void draw(){
    if (notHidden){
      image(image, x, y, w, h);
      text(gradientLabel+", "+year, (x+(w/2)), y+h-10);
    }
  }
  
  public void setImage(PImage newImage){
    image = newImage;
  }
  
  public void delete(){
    notHidden = false;
    draw();
  }
  
  public int getSlot(){
    return slot;
  }
}
