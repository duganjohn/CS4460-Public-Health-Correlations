/*
 * Creates the control panel
 */
public class Sidebar {
  float x = widthW*.7-10;
  float y = heightH*.11;
  int myColorBackground = color(white);
  
  float widthRec = widthW*.26;
  Dropdown vars;
  public Sidebar() {
     vars = new Dropdown("Variables", x + (widthRec-216)/2, y + 65, 216, 500);
    
    // Add Items
    vars.addItem("None",0);
    for (int i = 1; i < typeName.length; i++) 
      vars.addItem(typeName[i],i);
      vars.setIndex(0);
   }
   
   public void toggleDropdown(boolean bool){
     vars.setVisible(bool);
   }

  public void drawSidebar() {
    // Creates the panel
    fill(gray);
    strokeWeight(3);
    noStroke();
    rect(x, y, widthRec, heightH*.7-100);
    
    // Creates the title
    /*fill(darkGray);
    textFont(font24, 24);
    textAlign(CENTER);
    text("Control Center", x + widthW*.13, y*1.4);  
    */
    // Creates the year label
    fill(darkGray);
    textFont(font36, 32);
    textAlign(CENTER);
    text((int)years+"", x + widthRec/2, y*2.1+20);  
    
    // Creates the label
    textSize(18);
    textAlign(CENTER);
    text("Gradient:", x + widthRec/2, y + 37);
    
    int relY = (int)y +130;
    int lineSpacing = 50;
    
    textSize(20);
    textAlign(CENTER);
    text("State", x + widthW*.13, relY);
    fill(white);
    rect(x, y*2+40, widthW*.26, 2);
   
   
    for (int i = 1; i < typeName.length; i++) {
      fill(darkGray);
      text(typeName[i], x + widthW*.13, relY+lineSpacing*i);
      fill(white);
      rect(x, relY+lineSpacing*(i)+30, widthW*.26, 2);
    }
    
    // Highlighted state information
    textSize(18);
    fill(purple);
    textAlign(RIGHT,CENTER);
    if (map.highlighted !=  null)
      for (int i = 0; i < map.highlighted.data.display.length; i++)
        if(map.highlighted.data.display[i] != null) {
          if (map.clicked != null && map.clicked.data.doubles != null && map.highlighted.data.doubles[i] > map.clicked.data.doubles[i]) textSize(30);
          text(map.highlighted.data.display[i], x + widthW*.12, relY+lineSpacing*i+20);
          textSize(18);
        }

    
    // Clicked state Information
    textSize(18);
    fill(red);
    textAlign(LEFT,CENTER);
    if (map.clicked !=  null)
      for (int i = 0; i < map.clicked.data.display.length; i++)
        if(map.clicked.data.display[i] != null) {
          if (map.highlighted != null && map.highlighted.data.doubles != null && map.clicked.data.doubles[i] > map.highlighted.data.doubles[i]) textSize(30);
          text(map.clicked.data.display[i], x + widthW*.14, relY+lineSpacing*i+20);
          textSize(18);
        }

  }
}

