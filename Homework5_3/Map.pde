import java.awt.Polygon; 

/*
 * Creates the map
 */
public class Map{
  State highlighted = null;
  State clicked = null;
  String view;
  private int H = 100, S = 100, B = 100, minB = 0, maxB = 100;
  private int wid = 200, hig = 80, X = 620, Y = 420;
  int legendX, legendY;
  float size;
  float gradientActive;
  
  int average = 0;
  
  private ArrayList<State> stateList = new ArrayList<State>(50);
  // not exactly x and y
  
  XML xml;
  
 public Map(){ 
    this(2, 1550, 800, 700, 800, 2400, 700, 620, 400);
  }
  
  public Map(float size, int relX, int relY, int relXAlaska, int relYAlaska, int relXHawaii, int relYHawaii, int legendX, int legendY){
   this.legendX = legendX;
   this.legendY= legendY;
   this.size = size;
    
    xml = loadXML("statesCoord.xml");    
    XML[] state = xml.getChildren("state");

    int scaleX = (int)(6*size);
    int scaleY = (int)(-7*size);
    
   int stateLength = 51;
    //Hawaii and Alaska are on a different scale
    for(int i=0; i<stateLength; i++){
      if(i==1){
        //make Alaska
        makeState(state, 1, relXAlaska, relYAlaska, (int)(2*size), (int)(-3*size));
      }
      else if(i==11){
        //make Hawaii
         makeState(state, i, relXHawaii, relYHawaii, (int)(7*size), (int)(-7*size));
      }
      else{
        makeState(state, i, relX, relY, scaleX, scaleY);
      }
    }
 
     
    for (State st: stateList){
      st.draw(black);
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
       centerX = (int)(centerX+16*size);
       centerY = (int)(centerY+41*size);
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
  *@param i stateIndex
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

 public String getView(){
   return view;
 }
 
  
  // --- What Parameter is being looked at ----
  //@param gradient The index of variable to change color to
  // 0 = None
  // 1 = Population
  // 2 = health expend
  // 3 = percent uninsured
  // 4 = percent insured
  // 5 = household income
  public void setView(float gradient){
      gradientActive = gradient;
      view = typeName[(int)gradient];
      if (gradient==0){
        //creates random color
        for(State st: stateList){
          st.createColor();
        }
        view = "No Gradient";
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
     view = typeName[(int)gradient];
     if(gradient==1){
       H = 5;
       S = 100;
     }
     else if(gradient==2){
       H = 70;
       S = 60;
     }
     else if(gradient==3){
       H = 60;
       S = 80;
     }
     else if(gradient==4){
       H = 70;
       S = 80;
     }
     else{
       H = 80;
       S = 90;
     }
     //float max = -1;
     //float min = 900000000;
     /*for(State st: stateList){
       float num = st.getStateData().getNumFormat()[(int)gradient-1];
         if(num>max){
           max = num;
         }
         else if(num<min){
           min = num;
         }
     }*/
     
     int min = minMaxFixed[ (int)(2*(gradient)) ];
     int max = minMaxFixed[ (int)(2*(gradient))+1 ];
     //println(min + " " + max);
   
     int i = 0;
     for(State st: stateList){
         float num = st.getStateData().getNumFormat()[(int)gradient-1];
         average+=num;
         i++;
         B = getBrightness(gradient,  min,  max,  num);         
         /*if(B>maxB){
           maxB = B;
         }
         else if(B<minB){
           minB = B;
         }*/
          st.setColor(H,S,B);
        }
       
       average/=i;
       
  }
  
  public int getBrightness(float gradient, int min, int max, float num){
         int B = (int) ((num - min) / (max - min) * 100);
         
         if(num==0){
           B = 74;
         }
         //want to make sure B isn't too dark
         if (gradient==1){
           B= (int)(B*.75 +25);
         }
         else if(gradient==2){
           B= (int)(B*.75 +25);
         }
         
         return B;

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
   color textColor = white;
   if (gradientActive==0){
      textColor = black;
    }
    for (State st: stateList){
      if(st.draw(textColor)!=null){
        highlighted = st;
      }
    } 
    
    if(highlighted!=null){
      highlighted.draw(textColor);
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
    if(gradientActive==1){
      text("Population:  "+st.data.population ,x,  marginTop +  y + hig * 4 / 10);
    
    }
    if(gradientActive==2){
      text("Health Expenditures:  "+st.data.healthExp,x,  marginTop +  y + hig * 4 / 10);
    }
    if(gradientActive==3){
      text("Uninsured:  "+ st.data.noInsCoverage,x,  marginTop +  y + hig * 4 / 10);
    }
    if(gradientActive==4){
      text(st.data.insCoverage,x,  marginTop +  y + hig * 4 / 10);
    }
    if(gradientActive==5){
      text(st.data.medianIncome,x,  marginTop +  y + hig * 4 / 10);
    }
   // text("Population:      " + st.data.population, x , marginTop +  y + hig * 4 / 10);
  }
  
  /*
   * Creates the legend for the map
   */   
  public void drawLegend() {
    if(gradientActive!=0) {
      int wid = 200, hig = 110;
      int X = legendX;
      int Y = legendY;
      int marginTop = 20;
      String tex = "Legend";
      double[] minMax = minMax();
      fill(lightGray);
      noStroke();
      rect(X, Y, wid, hig);
      fill(black);
      textAlign(CENTER, CENTER);
      textSize(16);
      
      // Determine legend type
      
      tex = typeName[(int)gradientActive];
      /*if(gradientActive==1) tex = "Population";
      if(gradientActive==2) tex = "Health Expenditures";
      if(gradientActive==3) tex = "Uninsured";
      if(gradientActive==4) tex = "Insured";
      if(gradientActive==5) tex = "Median Income";*/
      
      // Create Title Text
      text(tex, X + wid/2, Y + 12);
  
      // Create Left Text
      textSize(14);
      textAlign(LEFT);
      text((int)Math.round(minMax[0])+"", X + 10, Y + 42);
      
      // Create Right Text
      textAlign(RIGHT);
      text((int)Math.round(minMax[1])+"", X + wid - 10, Y + 42);
      
      // Create gradient
      noFill();
      colorMode(HSB,100);
      int minB = (int)minMax[2];
      int maxB = (int)minMax[3];
      for (int i = X + 15; i <= X + wid - 15; i++) {
        float inter = map(i, X + 15, X + wid - 15, 0, 1);
        int B = (int)(Math.round(minMax[2]) * (1-inter) + Math.round(minMax[3]) * inter);
       
        int H2 = H+(int)(B*.2);
 
        stroke(color(H2, S, B));    // interpolate between colors on scale
        strokeWeight(20);
        line(i, Y + 60, i, Y + 60);
      }
          

      fill(0);
      textAlign(CENTER,CENTER);
      textFont(font14,14);
      
      String textAvg = ""+average;
      
      if(gradientActive==2 || gradientActive==5){
        textAvg = "$"+textAvg;
      }
      else if(gradientActive==3 || gradientActive==4){
        textAvg = textAvg+"%";
      }
      
      text("U.S. Average "+": "+textAvg,legendX+wid/2,legendY+hig-20);
    
    }
 }
  
  
  public ArrayList<State> getStateList(){
    return stateList;
  }
  
  /*
   * Finds the min and max values of the states' in the specific type, then in the brightness
   *
   * @return array containing: min of type, max of type, min brightness, max brightness
   */
   
   
   //An array of fixed values null, null, minPop, maxPop, minHealth, maxHealth, minUninsured, maxUninsured, minInsured...
  int[] minMaxFixed = {0,0,479602 , 38041430, 2794, 6803, 4, 26, 74, 96, 36641, 77506};

  public double[] minMax() {
    double[] minMax = new double[4];
    
    //for (int i = 0; i < 6; i++) {
    //  if(gradientActive == i){
        /* minMax[0] = stateList.get(0).data.doubles[i];
         minMax[1] = stateList.get(0).data.doubles[i];
         minMax[2] = 100;
         minMax[3] = 0;
         
        // Iterate through states
        for(State st: stateList){
           if(st.data.doubles[i] < minMax[0]) minMax[0] = st.data.doubles[i];
           if(st.data.doubles[i] > minMax[1]) minMax[1] = st.data.doubles[i];
           if(st.brightness < minMax[2]) minMax[2] = st.brightness;
           if(st.brightness > minMax[3]) minMax[3] = st.brightness;*/
       if(gradientActive != 0){   
         
           int min =  minMaxFixed[(int)gradientActive*2];
           int max =  minMaxFixed[2*(int)gradientActive+1];
           int minBrightness = getBrightness(gradientActive,  min,  max,  min);  
           int maxBrightness = getBrightness(gradientActive,  min,  max,  max);  
           
           
           double[] temp = { min, max, minBrightness, maxBrightness };
           minMax = temp;
        }    
    //  }
    //}
  
    return minMax;
  }
  
}
