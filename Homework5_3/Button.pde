import java.awt.Rectangle; 

public class Button extends java.awt.Rectangle {
  
    int w;
    int h;
    String text;
    int snapshotIndex;
    
    public Button(String text, int x,int y, int w, int h) {
      //call the java.awt.Polygon constructor
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      
    }
    
    public Button(String text, int x, int y, int w, int h, int snapshotIndex) {
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      this.snapshotIndex = snapshotIndex;
    }
   
    void draw() {
  
      fill(66); 
      noStroke();
      rect(x,y,w,h);
      fill(black); 
      textAlign(CENTER,CENTER);
      textFont(font24,18);
      text(text,x+w/2,y+h/2);
      
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
    
    public int getSnapshotIndex() {
      return snapshotIndex;
    }
    
}
