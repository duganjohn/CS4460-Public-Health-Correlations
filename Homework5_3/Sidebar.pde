
public class Sidebar {
  float x = widthW*.7;
  float y = heightH*.15;
  int myColorBackground = color(white);

  public Sidebar() {
    Dropdown vars = new Dropdown("Variables", x + 120, y + 100, 216, 500);
    
    // Add Items
    for (int i = 0; i < typeName.length; i++) 
      vars.addItem(typeName[i],i);
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
    textFont(font48, 48);
    textAlign(CENTER);
    text("Control Center", x + widthW*.15, y*1.4);  
    
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
      for (int i = 0; i < map.highlighted.display.length; i++)
        if(map.highlighted.display[i] != null) {
          if (map.clicked != null && map.clicked.doubles != null && map.highlighted.doubles[i] > map.clicked.doubles[i]) textSize(30);
          text(map.highlighted.display[i], x + widthW*.14, y*2.7 + i*.5*y);
          textSize(18);
        }

    
    // Clicked state Information
    textSize(18);
    fill(red);
    textAlign(LEFT);
    if (map.clicked !=  null)
      for (int i = 0; i < map.clicked.display.length; i++)
        if(map.clicked.display[i] != null) {
          if (map.highlighted != null && map.highlighted.doubles != null && map.clicked.doubles[i] > map.highlighted.doubles[i]) textSize(30);
          text(map.clicked.display[i], x + widthW*.16, y*2.7 + i*.5*y);
          textSize(18);
        }

  }
}

