public class Draw{
  
  public Draw(){
    //draw();
  }
  
  
  /* 
  * Draws the gray bar with the title
  */
  public void title(){
    fill(darkGray);
    noStroke();
    rect(0,0,width,100);
    fill(background);
    textFont(font48, 48);
    textAlign(CENTER);
    text("U.S. Public Health Correlations", width/2, 65);  
  }
  
  /* 
  * Redraws Everything.
  */
  public void draw(){
    background(background);
    title();
    sidebar.drawSidebar();
    map.drawMap();
    map.drawSaveButton();    
  }
  
  /* 
  * Redraws Everything when filter changes

  public void filterChange(){
    draw.draw();
  }
  */
  
  public void setWindowState(State state){
    //map.brush(state);
    //stateWindow.setState(state);
  }
  
}

