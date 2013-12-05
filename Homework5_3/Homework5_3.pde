import java.awt.Polygon; 
import controlP5.*;
import de.bezier.data.*; //Xlsreader library 
public Map map;
public MapMenu mapmenu;
public Sidebar sidebar;

public static color background;

public PFont font48, font36, font24, font14;

public static Draw draw;

public static int filterOn;
public float years;

private int widthW;
private int heightH;
String[] typeName = {"No Gradient", "Population","Health Expenditures","Percent Uninsured","Percent Insured","Median Household Income"};

// Reads in the data from Excel Spreadsheets
ControlP5 cp5;
XlsReader reader;
      
color[] typeColor;
color blue, green, purple, orange, magenta, red, lightGray, black, white, darkGray, lighterGray;



void setup(){
  draw = new Draw();

  colorMode(HSB,100);
  
  cp5 = new ControlP5(this);
  reader = new XlsReader(this, "Data1.xls");
  reader.firstRow();
  
  // --- Colors Setup ----
  blue = color(55,76,100); 
  green = color(24,100,100); 
  purple = color(77,80,100);
  orange = color(9,100,100);
  magenta = color(90,80,100);
  red = color(100,83,100);
  lightGray = color(80);
  lighterGray = color(90);
  darkGray = color(40);
  black = color(0);
  white = color(100);
  color[] typeColorTemp = {blue,green,purple,orange, magenta,red};
  typeColor= typeColorTemp;
  

  
  // --- Canvas Setup ----
  heightH = 720;
  widthW = 1200;
  size(widthW,heightH);
  background = lighterGray;
  noStroke();
  
  // --- Text Setup ----
  fontLoad();
  cp5.setControlFont(font14);
  cp5.setColorLabel(black);
  
  // --- Create Map ----
  int marginTop = 100;
  int mapWidth = 800;
  map = new Map();
  sidebar = new Sidebar();
  mapmenu = new MapMenu(map, 0,heightH-200);

}

/*
 * Loads all fonts
 */
void fontLoad(){
  font48 = loadFont("SofiaProLight-48.vlw");
  font36 = loadFont("SofiaProLight-36.vlw");
  font24 = loadFont("SofiaProLight-24.vlw");
  font14 = loadFont("SofiaProLight-14.vlw");
}

/* Trigged when mouse moves. Ideally smart 
*  enough to check bounds before going into function
*  calls
*/
void mouseMoved(){
  
  //if (draw.within(10,150,720,800)){
      map.mouseMoved();
  //}
 

}

/* 
* Trigged when mouse is pressed. Ideally smart 
*  enough to check bounds before going into
*  function calls
*/
void mousePressed(){
  
  // --- Mouse is pressed on Map ----
  map.mousePressed();
  mapmenu.mousePressed();
  draw.draw();
}


// --- Exists so Draw isn't called every time ----
void redraw(){
}

void draw(){
  //this wastes a lot of resources
  draw.draw();
}

float gradientCheck = 0.0;
float yearCheck = years;

void controlEvent(ControlEvent theEvent) {

  // check if the Event was triggered from a ControlGroup
  if(theEvent.isGroup() && theEvent.group().name() == "Variables") {
    
    // if Dropdown List is Clicked
   // if (theEvent.group().name() == "Variables") {
      
      //---Only changes map if a different value is selected--//
    if(theEvent.getGroup().getValue() != gradientCheck){
        gradientCheck = theEvent.getGroup().getValue();
        map.setView(gradientCheck);
      }
    }
    else if(theEvent.isController()){
      if(theEvent.controller().name()=="years"){
        if(years!=0.0 && years != yearCheck){
          yearCheck = years;
         
          map.changeYear((int)(years - 1999));
          
          //change gradient if year changes
          if(gradientCheck!=0){
            map.setView(gradientCheck);
          }
          
          
        }
      }
    }

    
    // check if the Event was triggered from a ControlGroup
    
   // println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  
  
}

