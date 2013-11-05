import java.awt.Polygon; 

public class State{
  private String name;
  private Poly polygon;
  private int year;
  private int population, healthExp;
  private float medianIncome, noInsCoverage, insCoverage;
  private boolean highlight;
  
  // --- If it's being accessed in another window
  private boolean brushing;
  private color stateColor;
  
  private StateData data;
  private int centerX;
  private int centerY;
  private String abb;
  
  public  color highlightColor= color(34,203,100);
  public  color brushingColor= color(0,10,100);
  
  public color gray;
  
  private Object[] items;
  private String[] display;
  private double[] doubles;

  
  public State(String name, String abb, Poly polygon, int centerX, int centerY, int year,
          int population, float medianIncome, int healthExp, float noInsCoverage, float insCoverage,
          float employmentBased, float directPurchase, float government,
          float medicaid, float medicare, float military){
    this.name = name;
    this.abb = abb;
    this.polygon = polygon;
    this.centerX = centerX;
    this.centerY = centerY;
    
    this.year = year;
    
    this.healthExp = healthExp;
    this.population = population;
    float ratio = insCoverage / (insCoverage + noInsCoverage);
    this.insCoverage = ratio * 100;
    this.noInsCoverage = 100 - this.insCoverage;
    this.medianIncome = medianIncome;
    
    gray = color(random(75)+25);
    this.abb = abb;
    
    this.centerX = centerX;
    this.centerY = centerY;

    data = new StateData(name, year, population, medianIncome, healthExp, noInsCoverage, 
                    insCoverage, employmentBased, directPurchase, government,
                    medicaid, medicare, military);
   
    doubles = new double[]{0, this.population, this.healthExp, this.noInsCoverage, this.insCoverage, this.medianIncome};
    items = new Object[]{this.name, this.population, this.healthExp, this.noInsCoverage, this.insCoverage, this.medianIncome};
    display = new String[]{this.name, ""+this.population, "$ "+this.healthExp, this.noInsCoverage+" %", this.insCoverage+" %", "$ "+this.medianIncome};
    
    highlight = false;
    brushing = false;
    stateColor = createColor();
  }
  
  public String getName(){
    return name;
  }
  
  public color createColor(){
    return color(random(100), random(80)+20, random(10)+90); //random(10)+90
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
  
  public State draw(){
    State ret = null;
    drawName();
    if(filterOn==1){
      fill(gray);
      noStroke();
      polygon.draw();
    }
    else{
      if (brushing){
        fill(brushingColor);
        strokeWeight(3);
        stroke(stateColor); //work on this
      }
      else if (highlight){
        fill(brushingColor);
        strokeWeight(4);
        stroke(black); //work on 
        ret = this;
      }
      else{
        fill(stateColor);
        noStroke();
      }
      
    }
    
    polygon.draw(); 
    drawName();
    return ret;
  }
  
  public void drawName(){
     //-- Draw Names of State
    textFont(font14, 14);
    textAlign(CENTER,CENTER);
    fill(0);
    text(abb, centerX, centerY);
  }
  
  public void dataBox(){
    //data.drawBox(mouseX,mouseY);
    data.drawBox(centerX,centerY);
  } 
  
  public StateData getStateData(){
    return data;
  }
  
  public int getCenterX(){
     return centerX;
  }
  
  public int getCenterY(){
     return centerY;
  }

}


