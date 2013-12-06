/* 
 * Class to grab screenshots of select areas
 */
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
  int relative;
  //the snapshot is first created empty
  public Snapshot(Integer slot){
    this.slot = slot;
  }
  
  //sets all the details of the snapshot
  public void setSnapshot(PImage image, int slot, int year, String gradientLabel, int relative) {
    this.relative = relative;
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
  
  //draws the snapshot if it's not hidden.
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
  
   /* 
  * Changes the image
  * @param  newImage new image to replace old snapshot image
  */
  public void setImage(PImage newImage) {
    image = newImage;
  }
  
  /* 
  * Deletes snapshot(hides it)
  * @return  isPressed
  */
  public void delete() {
    notHidden = false;
    draw();
  }
  
 /* 
  * Gets the slot index of the bottom
  *@return slot
  */
  public int getSlot() {
    return slot;
  }
  
 /* 
  * Gets the year of the snapshot
  @return year
  */
  public int getYear() {
    return year;
  }
  
 /* 
  * Gets the gradient of the snapshot
  *@return gradient
  */
  public float getGradientNumber() {
    return gradientNumber;
  }
  
 /* 
  * Gets the gradient label
  * @return  label
  */
  public String getGradientLabel(){
    return gradientLabel;
  }
  
  /* 
  * Gets whether the maps at this stage is in relative or absolute
  * @return  relative (1 if yes, 0 if no)
  */
  public int getRelative(){
    return relative;
  }


  /* 
  * Check whether snapshot is pressed
  * @return  isPressed
  */
  public boolean pressed(){
    boolean isPressed = false;
    if (mouseX >= x && mouseX < x+w) {
      if (mouseY >= (y) && mouseY < (y+h)){
        isPressed = true;
      }
    }
  return isPressed;
  }
}
