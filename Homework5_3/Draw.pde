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
    //rect(0,0,width,100);
    //fill(background);
    textFont(font36, 36);
    textAlign(CENTER);
    text("U.S. Public Health Correlations", widthW/2, 55);  
  }
  
  /* 
  * Redraws Everything.
  */
  public void draw(){
    background(lighterGray);
    title();
    
    if(compare.compareViewOn){
      compare.draw();
    }
    else{
       sidebar.drawSidebar();
       map.drawMap();
       mapmenu.draw();  
    }
     
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
  
     /* 
  * Only enters if within these parameters
  */
  public boolean within(int x1, int y1, int x2, int y2){
    if(mouseX>x1 && mouseX<x2){
      if(mouseY>y1 && mouseY<y2){
        return true;
      }
    }
    return false;
  }
  
}

