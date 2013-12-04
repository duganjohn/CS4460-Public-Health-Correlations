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
  float gradientNumber;
  
  public Snapshot(Integer slot){
    this.slot = slot;
  }
  
  public void setSnapshot(PImage image, int slot, int year, String gradientLabel) {
    this.image = image;
    this.slot = slot;
    this.year = year;
    this.x = slot*200;
    this.gradientLabel = gradientLabel;
    notHidden = true;
    if (gradientLabel == "No Gradient") {
      gradientNumber = 0;
    } else if (gradientLabel == "Population") {
      gradientNumber = 1;
    } else if (gradientLabel == "Health Expenditures") {
      gradientNumber = 2;
    } else if (gradientLabel == "Percent Uninsured") {
      gradientNumber = 3;
    } else if (gradientLabel == "Percent Insured") {
      gradientNumber = 4;
    }else if (gradientLabel == "Median Household Income") {
      gradientNumber = 5;
      
    }
  }
  
  public void draw() {
    if (notHidden){
      image(image, x, y, w, h);
      if (gradientLabel == "Median Household Income") {
        text("Median Income , "+year,(x+(w/2)),y+h-10);
      } else{
      text(gradientLabel+", "+year, (x+(w/2)), y+h-10);
      }
    }
  }
  
  public void setImage(PImage newImage) {
    image = newImage;
  }
  
  public void delete() {
    notHidden = false;
    draw();
  }
  
  public int getSlot() {
    return slot;
  }
  
  public int getYear() {
    return year;
  }
  
  public float getGradientNumber() {
    return gradientNumber;
  }

  public boolean pressed(){
    boolean isPressed = false;
    if (mouseX >= x && mouseX < x+w) {
      if (mouseY >= (y+10) && mouseY < (y+h)){
        isPressed = true;
      }
    }
  return isPressed;
  }
}
