import java.awt.Rectangle; 

public class Button extends java.awt.Rectangle {
  
    int w;
    int h;
    String text;
    int index;
    boolean isHidden = false;
    
    public Button(String text, int x,int y, int w, int h) {
      //call the java.awt.Polygon constructor
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      
    }
    
    //used for delete buttons on the map snapshots
    public Button(String text, int x, int y, int w, int h, int index) {
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      this.index = index;
    }
   
    void draw() {
      if (isHidden) {
        fill(white);
        stroke(white);
      } else {
      fill(66); 
      noStroke();
      rect(x,y,w,h);
      fill(black); 
      textAlign(CENTER,CENTER);
      textFont(font24,18);
      text(text,x+w/2,y+h/2);
      }
    }
    
    public boolean pressed(){
      boolean ans= false;
      if (mouseX >= x && mouseX < x+w) {
        if (mouseY >= (y) && mouseY < (y+h)){
          ans= true;
        }
      } 
      return ans;
    }
    
    public int getIndex(){
      return index;
    }
    
    public void setIndex(int newIndex){
      index = newIndex;
    }
    
    public void hide(){
      isHidden = true;
    }
    
    public void show(){
      isHidden = false;
    }
}
