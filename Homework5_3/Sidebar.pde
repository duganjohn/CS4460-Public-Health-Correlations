

public class Sidebar {
  float x = widthW*.7;
  float y = heightH*.15;
  int myColorBackground = color(white);

  public Sidebar() {
    Dropdown vars = new Dropdown("Variables", x + 120, y + 100, 216, 500);
    
    // Add Items
    vars.addItem("None",0);
    for (int i = 0; i < typeName.length; i++) 
      vars.addItem(typeName[i],i+1);
      vars.setIndex(0);
   }

  public void drawSidebar() {
    // Creates the panel
    fill(darkGray);
    strokeWeight(3);
    noStroke();
    rect(x, y, widthW*.3, heightH*.7);
    
    // Creates the title
    fill(white);
    textFont(font36, 36);
    textAlign(CENTER);
    text("Control Center", x + widthW*.15, y*1.4);  
    
    // Creates the year label
    textFont(font36, 32);
    textAlign(CENTER);
    text((int)years+"", x + widthW*.15, y*2.1);  
    
    // Creates the label
    textSize(18);
    textAlign(LEFT);
    text("Gradient:", x + 26, y + 97);
    
    textSize(20);
    textAlign(CENTER);
    text("State", x + widthW*.15, y * 2.5);
    fill(white);
    rect(x, y*2.25, widthW*.3, 2);
    for (int i = 0; i < typeName.length; i++) {
      text(typeName[i], x + widthW*.15, y*3 + y*.5*i);
      rect(x, y*2.75 + y*i*.5, widthW*.3, 2);
    }
    
    // Highlighted state information
    textSize(18);
    fill(blue);
    textAlign(RIGHT);
    if (map.highlighted !=  null)
      for (int i = 0; i < map.highlighted.data.display.length; i++)
        if(map.highlighted.data.display[i] != null) {
          if (map.clicked != null && map.clicked.data.doubles != null && map.highlighted.data.doubles[i] > map.clicked.data.doubles[i]) textSize(30);
          text(map.highlighted.data.display[i], x + widthW*.14, y*2.7 + i*.5*y);
          textSize(18);
        }

    
    // Clicked state Information
    textSize(18);
    fill(red);
    textAlign(LEFT);


    if (map.clicked !=  null)
      for (int i = 0; i < map.clicked.data.display.length; i++)
        if(map.clicked.data.display[i] != null) {
          if (map.highlighted != null && map.highlighted.data.doubles != null && map.clicked.data.doubles[i] > map.highlighted.data.doubles[i]) textSize(30);
          text(map.clicked.data.display[i] , x + widthW*.16, y*2.7 + i*.5*y);
          textSize(18);
        }

  }
}

