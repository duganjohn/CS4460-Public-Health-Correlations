import java.awt.Polygon; 

public class Map{
  State highlighted = null;
  State clicked = null;

  private ArrayList<State> stateList = new ArrayList<State>(50);
  // not exactly x and y
  
  XML xml;
  private ArrayList<PImage> snapshots = new ArrayList<PImage>();
  boolean onButton;
  
  public Map(){ 
    
    xml = loadXML("statesCoord.xml");
    //JSONArray stateData = loadJSONArray("map.json");
    
    XML[] state = xml.getChildren("state");
    
    int relX = 1550;
    int relY = 900;
    int scaleX = 12;
    int scaleY = -15;
    
 
    //Hawaii and Alaska are on a different scale
    for(int i=0; i<state.length; i++){
      if(i==1){
        //make Alaska
        makeState(state, 1, 700, 850, 4, -6);
      }
      else if(i==11){
        //make Hawaii
         makeState(state, i, 2260, 750, 13, -13);
      }
      else{
        makeState(state, i, relX, relY, scaleX, scaleY);
      }
    }

     
    for (State st: stateList){
      st.draw();
    }  
  }
  
  /*
  * Called to make a state
  */
  public void makeState(XML[] state, int i, int relX, int relY, int scaleX, int scaleY){
      
      XML[] point = state[i].getChildren("point");
      int pointCount = point.length;
      
      int centerX = relX+int(scaleX* state[i].getFloat("lng"));
      int centerY = relY+int(scaleY* state[i].getFloat("lat"));
      
      int[] x = new int[pointCount];
      int[] y = new int[pointCount];
      for(int j=0; j<pointCount; j++){
        x[j]= relX+int(scaleX* point[j].getFloat("lng"));
        y[j]= relY+int(scaleY* point[j].getFloat("lat"));
        
      }
      Poly shape = new Poly(x,y,pointCount);
      String name = reader.getString(i+1,0);
      int year = reader.getInt(i+1,1);
      int population = reader.getInt(i+1,2);
      float medianIncome = reader.getFloat(i+1,3);
      int healthExp = 0;
      try {
        healthExp = reader.getInt(i+1,4);
      } catch (NullPointerException e) {
        healthExp = 0;
      }
      float noInsCoverage = reader.getFloat(i+1,5);
      float insCoverage = reader.getFloat(i+1,6);
      float employmentBased = reader.getFloat(i+1,7);
      float directPurchase = reader.getFloat(i+1,8);
      float government = reader.getFloat(i+1,9);
      float medicaid = reader.getFloat(i+1,10);
      float medicare = reader.getFloat(i+1,11);
      float military = reader.getFloat(i+1,12);
       State aState = new State(name, state[i].getString("abb"), 
          shape, centerX, centerY, year, population, medianIncome, healthExp,
          noInsCoverage, insCoverage, employmentBased, directPurchase,
          government, medicaid, medicare, military);
      
      stateList.add(aState);
  }
  
  /*
  * Deals with brushing of state. Will need to be implemented later
  */
  public void brush(State state){
    for (State aState: stateList){
      aState.setBrushing(false);
    }
    int index = stateList.indexOf(state);
    if (index!=-1){
      State myState = stateList.get(index);
      myState.setBrushing(true);
    }
  }
  
  // --- What Parameter is being looked at ----
  public void setView(){
  }
  
  /*
  * Resets so no states are highlighted
  * Called to prevent multiple states from being
  * highlighted at once.
  */
  public void reset(){
    for(State st: stateList){
      st.setHighlight(false);
      highlighted = null;
    }
  }
  
  /*
  * If mouse is on the map, it check if
  * the mouse is on any state. If so,
  * it redraws the map.
  * @return retMe State hovered or null
  */
  public State mouseMoved(){
    reset();
    State retMe = null;
    onSaveButton();
    for(State st: stateList){
      if (st.contains(mouseX, mouseY)){
        retMe = st;
        break;
      }
    }
    drawMap();
    
    return retMe;
  }
  
  /*
  * What happens if map is pressed
  * State should be highlighted on hover.
  * If user presses mouse, function will just
  * check if there's any states highlighted.
  * @return State state pressed or null
  */
  
  public State mousePressed(){
    reset();
    State retMe = null;
    for(State st: stateList){
      if (st.contains(mouseX, mouseY)){
        clicked = st;
        retMe = st;
        break;
      }
    }
    if (onButton) {
     snapshots.add(get(0,150,800,400)); 
    }
    drawMap();
    
    return retMe;
  }
  
  State currentHighlight = null;
  /*
  * Goes through every state and draws it
  * If the state is highlighted, it will return itself
  * If that's the case "highlight" will be that state.
  * Draws state data box after the entire map has been
  * drawn.
  */
 public void drawMap(){
    for (State st: stateList){
      if(st.draw()!=null){
        highlighted = st;
      }
    } 
    if(highlighted!=null){
      drawStateData(highlighted, mouseX, mouseY);
      //currentHighlight = highlighted;
    }
    drawSnapshots();
 }
  
  /*
  * Draws box with state's data. Centered and slightly under
  * the mouse.
  */
  public void drawStateData(State st, int x, int y) {
    int wid = 180, hig = 100;
    int marginTop = 20;
    fill(lightGray);
    noStroke();
    rect(x-wid/2,y + marginTop ,wid,hig);
     fill(black);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(st.name, x , marginTop + y + hig *2 / 10);
    text("Population:      " + st.population, x , marginTop +  y + hig * 4 / 10);
  }
  
  public void drawSnapshots(){
    int snapshotNum = 0;
    for (PImage aSnapshot : snapshots){
        image(aSnapshot, snapshotNum*170, heightH-100, 170, 120);
        snapshotNum += 1;
    }
    
  }
  
  public void drawSaveButton(){
    fill(lightGray);
    stroke(black);
    strokeWeight(1);
    rect(700,heightH-200,100,20);
    fill(black);
    text("Save This View", 750, heightH-190);
  }

  public ArrayList<State> getStateList(){
    return stateList;
  }
  
  public void onSaveButton(){
    
    if (mouseX >= 700 && mouseX < 800) {
      if (mouseY >= (heightH-200) && mouseY < (heightH-180)){
        onButton = true;
      }
    } else { 
    onButton = false;
  }
  }
}
