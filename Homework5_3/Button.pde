import java.awt.Rectangle; 

/*
 * Button Class to create an easy to edit button
 */
public class Button extends java.awt.Rectangle {
  
    int w;
    int h;
    String text;
    int index;
    boolean isHidden = false;
    color col;
    
    /*overload*/
    public Button(String text, int x, int y, int w, int h, color col, int nothing) {
      this (text,  x,  y,  w,  h);
      this.col = col;
    }
    
    public Button(String text, int x,int y, int w, int h) {
      //call the java.awt.Polygon constructor
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      this.col = gray;
    }
    
    //used for delete buttons on the map snapshots
    public Button(String text, int x, int y, int w, int h, int index) {
      this (text,  x,  y,  w,  h);
      this.index = index;
      
    }
    
    /*
     *  Sets the color of the button
     *
     *@param color
     */
    public void setColor(color col){
     this.col = col;
    }   
    
    void draw() {
      if (isHidden) {
        fill(white);
        stroke(white);
      } else if (pressed()) {
        strokeWeight(1);
        stroke(black);
        fill(col);
        rect(x,y,w,h);
        fill(black); 
        textAlign(CENTER,CENTER);
        textFont(font24,18);
        text(text,x+w/2,y+h/2);
      }else {
      fill(col); 
      noStroke();
      rect(x,y,w,h);
      fill(black); 
      textAlign(CENTER,CENTER);
      textFont(font24,18);
      text(text,x+w/2,y+h/2);
      }
    }
    
    /*
     *  Sets the function of the button to be called upon pressed
     *
     *@return whether or not it is pressed
     */
    public boolean pressed(){
      boolean ans= false;
      if (mouseX >= x && mouseX < x+w) {
        if (mouseY >= (y) && mouseY < (y+h)){
          ans= true;
        }
      } 
      return ans;
    }

    /*
     *  Gets the index of the button
     *
     *@return index
     */    
    public int getIndex(){
      return index;
    }

    /*
     *  Sets the index of the button
     *
     *@param index
     */    
    public void setIndex(int newIndex){
      index = newIndex;
    }
    
    // used for the delete buttons
    public void hide(){
      isHidden = true;
    }
    
    // used for the delete buttons    
    public void show(){
      isHidden = false;
    }
}
