import java.awt.Polygon; 

public class Map{
  State highlighted = null;
  State clicked = null;
  String view;
  private int H = 100, S = 100, B = 100, minB = 0, maxB = 100;
  
  private ArrayList<State> stateList = new ArrayList<State>(50);
  // not exactly x and y
  
  XML xml;
  
  public Map(){ 
    
    xml = loadXML("statesCoord.xml");
    //JSONArray stateData = loadJSONArray("map.json");
    
    XML[] state = xml.getChildren("state");
    
    int relX = 1550;
    int relY = 870;
    int scaleX = 12;
    int scaleY = -15;
    
   int stateLength = 51;
    //Hawaii and Alaska are on a different scale
    for(int i=0; i<stateLength; i++){
      if(i==1){
        //make Alaska
        makeState(state, 1, 700, 800, 4, -6);
      }
      else if(i==11){
        //make Hawaii
         makeState(state, i, 2260, 700, 13, -13);
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
       centerY = 375;
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
      
      
     
      StateData data = new StateData(name, population, (int)medianIncome, healthExp,
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
  // 2 = health expend
  // 3 = percent uninsured
  // 4 = percent insured
  // 5 = household income
  /*public void setView(float gradient){
      if (gradient==0){
        view = "None";
        for(State st: stateList){
        //creates random color
        st.createColor();
        }
      }
      if(gradient == 1){
         view = "Population";
         //go through every state and find the min and max value;
         //give a hue
         //change color hue for all states
         double max = stateList.get(0).data.doubles[1];
         double min = stateList.get(0).data.doubles[1];
        for(State st: stateList){
           if(st.data.doubles[1]<min)
             min = st.data.doubles[1];
           if(st.data.doubles[1]>max)
             max = st.data.doubles[1];
           //st.setColor(0,0,0); //setColor
        }
        colorMode(HSB,360,100,(int)max);
        for(State st:stateList){
          st.setColor(25, 100, (int)(st.data.doubles[1]*5));
        }
    }
    if(gradient == 2){
         view = "Health Expenditures";
         double max = stateList.get(0).data.doubles[2];
         double min = stateList.get(0).data.doubles[2];
        for(State st: stateList){
           if(st.data.doubles[2]<min)
             min = st.data.doubles[2];
           if(st.data.doubles[2]>max)
             max = st.data.doubles[2];
        }
        colorMode(HSB,360,100,(int)max);
        for(State st:stateList){
          st.setColor(80, 100, (int)(st.data.doubles[2]*1.05));
        }
    
    }
    
    if(gradient == 3){
        view = "Percent Uninsured";
         double max = stateList.get(0).data.doubles[3];
         double min = stateList.get(0).data.doubles[3];
        for(State st: stateList){
           if(st.data.doubles[3]<min)
             min = st.data.doubles[3];
           if(st.data.doubles[3]>max)
             max = st.data.doubles[3];
           //st.setColor(0,0,0); //setColor
        }
        colorMode(HSB,360,100,(int)max);
        for(State st:stateList){
          st.setColor(220, 100, (int)st.data.doubles[3]);
        }
    
    }
    if(gradient == 4){
    
        view = "Percent Insured";
         double max = stateList.get(0).data.doubles[4];
         double min = stateList.get(0).data.doubles[4];
        for(State st: stateList){
           if(st.data.doubles[4]<min)
             min = st.data.doubles[4];
           if(st.data.doubles[4]>max)
             max = st.data.doubles[4];
           //st.setColor(0,0,0); //setColor
        }
        colorMode(HSB,360,100,(int)max);
        for(State st:stateList){
          st.setColor(150, 100, (int)st.data.doubles[4]);
        }
    }
    if(gradient == 5){
        view = "Median Income";
         double max = stateList.get(0).data.doubles[5];
         double min = stateList.get(0).data.doubles[5];
        for(State st: stateList){
           if(st.data.doubles[5]<min)
             min = st.data.doubles[5];
           if(st.data.doubles[5]>max)
             max = st.data.doubles[5];
           //st.setColor(0,0,0); //setColor
        }
        colorMode(HSB,360,100,(int)max);
        for(State st:stateList){
          st.setColor(300, 100, (int)st.data.doubles[5]);
        }
    }
 //}
 */
 
 public String getView(){
   if (view == null){
     view = "No gradient";
   }
   return view;
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
     view = typeName[(int)gradient-1];
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
         B = (int) ((num - min) / (max - min) * 100);
         
         if(num==0){
           B = 74;
         }
         //want to make sure B isn't too dark
         if (gradient==1){
           B= (int)(B*.70 +30);
         }
         else{
           B= (int)(B*.75 +25);
         }
         st.setColor(H,S,B);
         
         if(B>maxB){
           maxB = B;
         }
         else if(B<minB){
           minB = B;
         }
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
    
    drawLegend();
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
    String detail = "";
    if(gradientCheck==1){
      text("Population:  "+st.data.population ,x,  marginTop +  y + hig * 4 / 10);
    
    }
    if(gradientCheck==2){
      text("Health Expenditures:  "+st.data.healthExp,x,  marginTop +  y + hig * 4 / 10);
    }
    if(gradientCheck==3){
      text("Uninsured:  "+ st.data.noInsCoverage,x,  marginTop +  y + hig * 4 / 10);
    }
    if(gradientCheck==4){
      text(st.data.insCoverage,x,  marginTop +  y + hig * 4 / 10);
    }
    if(gradientCheck==5){
      text(st.data.medianIncome,x,  marginTop +  y + hig * 4 / 10);
    }
   // text("Population:      " + st.data.population, x , marginTop +  y + hig * 4 / 10);
  }
  
  /*
   * Creates the legend for the map
   */   
  public void drawLegend() {
    if(gradientCheck!=0) {
      int wid = 200, hig = 80;
      int X = 620, Y = 420;
      int marginTop = 20;
      String tex = "Legend";
      double[] minMax = minMax();
      fill(lightGray);
      stroke(black);
      strokeWeight(2);
      rect(X, Y, wid, hig);
      fill(black);
      textAlign(CENTER, CENTER);
      textSize(18);
      if(gradientCheck==1) tex = "Population";
      if(gradientCheck==2) tex = "Health Expenditures";
      if(gradientCheck==3) tex = "Uninsured";
      if(gradientCheck==4) tex = "Insured";
      if(gradientCheck==5) tex = "Median Income";
      text(tex, X + wid/2, Y + 12);
  
      textSize(14);
      textAlign(LEFT);
      text((int)Math.round(minMax[0])+"", X + 10, Y + 42);
      
      textAlign(RIGHT);
      text((int)Math.round(minMax[1])+"", X + wid - 10, Y + 42);
      //line(X + 5, Y + 40, X + 5, Y + 60);
      //line(X + wid - 5, Y + 40, X + wid - 5, Y + 60);
      
      color c1, c2;
      c1 = color(H, S, minB);
      c2 = color(H, S, maxB);
      noFill();
      colorMode(HSB,100);
      for (int i = X + 15; i <= X + wid - 15; i++) {
        float inter = map(i, X + 15, X + wid - 15, 0, 1);
        stroke(color(H, S, minB * (1-inter) + maxB * inter));
        //stroke(lerpColor(c1,c2,inter));
        strokeWeight(20);
        line(i, Y + 60, i, Y + 60);
      }
    }
 }
  
  
  public ArrayList<State> getStateList(){
    return stateList;
  }
  
  public double[] minMax() {
    double[] minMax = new double[2];
    
    for (int i = 0; i < 6; i++) {
      if(gradientCheck == i){
         minMax[1] = stateList.get(0).data.doubles[i];
         minMax[0] = stateList.get(0).data.doubles[i];
        for(State st: stateList){
           if(st.data.doubles[i] < minMax[0])
             minMax[0] = st.data.doubles[i];
           if(st.data.doubles[i] > minMax[1])
             minMax[1] = st.data.doubles[i];
        }    
      }
    }
  
    return minMax;
  }
}
