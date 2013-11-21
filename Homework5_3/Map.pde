import java.awt.Polygon; 

public class Map{
  State highlighted = null;
  State clicked = null;

  private ArrayList<State> stateList = new ArrayList<State>(50);
  // not exactly x and y
  
  XML xml;
  
  public Map(){ 
    
    xml = loadXML("statesCoord.xml");
    //JSONArray stateData = loadJSONArray("map.json");
    
    XML[] state = xml.getChildren("state");
    
    int relX = 1550;
    int relY = 900;
    int scaleX = 12;
    int scaleY = -15;
    
   int stateLength = 51;
    //Hawaii and Alaska are on a different scale
    for(int i=0; i<stateLength; i++){
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
    
       StateData data = makeStateData(i);
  
    //hardcode center if D.C.
     if(i == 8){
       centerX = 655;
       centerY = 405;
     }     
       
       State aState = new State(state[i].getString("name"), state[i].getString("abb"), 
          shape, centerX, centerY, data );
      
      stateList.add(aState);
  }
  
  /*
  * Overloading
  * defaults to 13 b/c 2012-1999
  */
  public StateData makeStateData(int i){
    return makeStateData(i, 13);
  }
  
  /*
  *Created to reuse this reader 
  @param i stateIndex
  *@param yearIndex
  *@return stateData
  */
  public StateData makeStateData(int i, int yearIndex){
      
      //51 because of D.C.
       i = i+yearIndex*51 +1;
     
     
      String name = reader.getString(i,0);
   
      int year = reader.getInt(i,1);
      int population = reader.getInt(i,2);
      float medianIncome = reader.getFloat(i,3);
      int healthExp = 0;
      try {
        healthExp = reader.getInt(i,4);
      } catch (Exception e) {
        healthExp = 0;
      }
      
      
      float noInsCoverage = reader.getFloat(i,5);
      float insCoverage = reader.getFloat(i,6);
      float employmentBased = reader.getFloat(i,7);
      float directPurchase = reader.getFloat(i,8);
      float government = reader.getFloat(i,9);
      float medicaid = reader.getFloat(i,10);
      float medicare = reader.getFloat(i,11);
      float military = reader.getFloat(i,12);
      
      
     
      StateData data = new StateData(name, population, medianIncome, healthExp,
          noInsCoverage, insCoverage, employmentBased, directPurchase,
          government, medicaid, medicare, military);
      return data;
  }
  
  public void changeYear(int yearIndex){
    for(int i = 0; i< stateList.size(); i++){
      stateList.get(i).data = null;
      stateList.get(i).setStateData(makeStateData(i, yearIndex));
    }
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
  //@param gradient The index of variable to change color to
  // 0 = None
  // 1 = Population
  //needs to also get triggered when year changes
  public void setView(float gradient){
   
      if (gradient==0){
        //creates random color
        for(State st: stateList){
          st.createColor();
        }
      }
      else{
         //go through every state and find the min and max value;
         //give a hue
         //change color hue for all states
         changeAllColors(gradient);
         
         
        
          // st.setColor(0,0,0); //setColor
        }
   
  }
  
  void changeAllColors(float gradient){
    int H = 100;
    int S = 100;
     if(gradient==1){
       H = 10;
       S = 100;
     }
     else if(gradient==2){
       H = 40;
       S = 80;
     }
     else if(gradient==3){
       H = 60;
       S = 80;
     }
     else if(gradient==4){
       H = 80;
       S = 80;
     }
     else{
       H = 100;
       S = 80;
     }
     float max = -1;
     float min = 900000000;
     for(State st: stateList){
       float num = st.getStateData().getNumFormat()[(int)gradient-1];
         if(num>max){
           max = num;
         }
         else if(num<min){
           min = num;
         }
     }
     
     //println(min + " " + max);
   
     for(State st: stateList){
         float num = st.getStateData().getNumFormat()[(int)gradient-1];
         int B = (int) ((num - min) / (max - min) * 100);
         
         if(num==0){
           B = 74;
         }
         //want to make sure B isn't too dark
         if (gradient==1){
           B= (int)(B*.60 +40);
         }
         else{
           B= (int)(B*.75 +25);
         }
         st.setColor(H,S,B);
        }
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
      highlighted.draw();
      drawStateData(highlighted, mouseX, mouseY);
      //currentHighlight = highlighted;
    }
    
 }
  
  /*
  * Draws box with state's data. Centered and slightly under
  * the mouse.
  */
  public void drawStateData(State st, int x, int y) {
    int wid = 180, hig = 100;
    int marginTop = 20;
    fill(lightGray,80);
    noStroke();
    rect(x-wid/2,y + marginTop ,wid,hig);
     fill(black);
    textAlign(CENTER, CENTER);
    textSize(14);
    text(st.name, x , marginTop + y + hig *2 / 10);
   // text("Population:      " + st.data.population, x , marginTop +  y + hig * 4 / 10);
  }
  
  
  public ArrayList<State> getStateList(){
    return stateList;
  }

}
