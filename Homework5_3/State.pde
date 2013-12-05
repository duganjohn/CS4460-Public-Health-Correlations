import java.awt.Polygon; 

public class State{
  private String name;
  private Poly polygon;

  private boolean highlight;
  
  // --- If it's being accessed in another window
  private boolean brushing;
  private color stateColor;
  private int brightness;
  
  private StateData data;
  private int centerX;
  private int centerY;
  private String abb;
  
  public  color highlightColor= color(34,203,100);
  public  color brushingColor= color(0,10,100);



  
  public State(String name, String abb, Poly polygon, int centerX, int centerY,
          StateData data){
    this.name = name;
    this.abb = abb;
    this.data= data;
    this.polygon = polygon;
    this.centerX = centerX;
    this.centerY = centerY;

    this.abb = abb;
    
    this.centerX = centerX;
    this.centerY = centerY;

    highlight = false;
    brushing = false;
    createColor();
  }
  
  public String getName(){
    return name;
  }
  
  //Initial color.
  public void createColor(){
    stateColor = color(random(100), random(80)+20, random(10)+90); //random(10)+90
  }
  
  //Overriding of color. If gradient is turned on
  public void setColor(int H, int S, int B){

      H += (int)(B*.2);
      //S += (int)(B*.5);
    stateColor = color(H, S, B);
    brightness = B;
  }
    
  public void setHighlight(boolean tf){
    highlight = tf;
  }
  
  public void setBrushing(boolean tf){
    brushing = tf;
  }
  
  public boolean contains(int mx, int my){
    if (filterOn==0 && polygon.contains(mx,my)){
      highlight = true;
    }
    return highlight;
  }
  
  public State draw(color col){
    State ret = null;
      if (brushing){
        fill(brushingColor);
        strokeWeight(3);
        stroke(stateColor); //work on this
      }
      else if (highlight){
        fill(brushingColor);
        strokeWeight(3);
        stroke(70); //work on 
        ret = this;
      }
      else{
        fill(stateColor);
        noStroke();
      }
      
    
    polygon.draw(); 
    drawName(col);
    return ret;
  }
  
  public void drawName(color col){
     //-- Draw Names of State
     fill(col);
    textFont(font14, 14);
    textAlign(CENTER,CENTER);
    
    text(abb, centerX, centerY);
  }
  
  public int getCenterX(){
     return centerX;
  }
  
  public int getCenterY(){
     return centerY;
  }
  
  //If year changes, need to set to a different data
  public void setStateData(StateData data){     
    this.data = data;
  }
  
    public StateData getStateData(){
    return data;
  }

}


