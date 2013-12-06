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
    
    /**
     * An overload constructor that makes buttons with colored backgrounds
     *
     * @param  text  what text of button will say
     * @param  x  x coordinate on canvas
     * @param  y  y coordinate on canvas
     * @param  w  button width
     * @param  h  button height
     * @param  col  button background color
     * @param  nothing  extra parameter so program knows to call this constructor (not used)
     */
    public Button(String text, int x, int y, int w, int h, color col, int nothing) {
      this (text,  x,  y,  w,  h);
      this.col = col;
    }
    
    /**
     * Default constructor that makes buttons
     *
     * @param  text  what text of button will say
     * @param  x  x coordinate on canvas
     * @param  y  y coordinate on canvas
     * @param  w  button width
     * @param  h  button height
     */
    public Button(String text, int x,int y, int w, int h) {
      //call the java.awt.Polygon constructor
      super(x, y, w,h);
      this.text = text;
      this.w = w;
      this.h = h;
      this.col = gray;
    }
    
   /**
     * Used for Delete Buttons on Snapshot
     *
     * @param  text  what text of button will say
     * @param  x  x coordinate on canvas
     * @param  y  y coordinate on canvas
     * @param  w  button width
     * @param  h  button height
     * @param  index index within snapshot arraylist
     */
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
    
    /**
     * Changes visibility (hide) for Snapshot Delete Buttons
     */
    public void hide(){
      isHidden = true;
    }
    
   /**
     * Changes visibility (show) for Snapshot Delete Buttons
     */   
    public void show(){
      isHidden = false;
    }
}
