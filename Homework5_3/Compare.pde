public class Compare{
  
  Map map1;
  Map map2;
  boolean compareViewOn;
  Dropdown menu1;
  Dropdown menu2;
  Button close;
  ArrayList<Snapshot> snapshots;
  int x = 130;
  int y = 120;
  int dropdownW = 300;
  int top = 90;
  
  public Compare(){
    compareViewOn = false;
    
    menu1 = new Dropdown("Compare1", x, y , dropdownW, 350);
    menu2 = new Dropdown("Compare2", x + 560, y, dropdownW, 350);
    print("hello");
    
    menu1.setVisible(false);
    menu2.setVisible(false); 
    
  }
  
  void mousePressed(){
    if(close!=null && close.pressed()){
      close();
    }
  }
  
  void makeChart(){
    
  }
  
  void activate(ArrayList<Snapshot> snapshots){
    this.snapshots = snapshots;
    menu1.setVisible(true);
    menu2.setVisible(true);
    
    int buttonW = 40;
    close = new Button("X", widthW-buttonW, top, buttonW, buttonW,  red, 1);
    compareViewOn = true;
    sidebar.toggleDropdown(false);
    mapmenu.toggleSlider(false);
    int i = 0;
    for (Snapshot aSnapshot : snapshots){
      if(aSnapshot.getGradientLabel()!=null){
        menu1.addItem(aSnapshot.getGradientLabel()+" " + aSnapshot.getYear(),i);
        menu2.addItem(aSnapshot.getGradientLabel()+" " + aSnapshot.getYear(),i++);
      }
    }
    
    float size = 1.5;
    int relX = 1170;
    int relY = 780;
    int relXAlaska = 600;
    int relYAlaska = 770;
    int relXHawaii = 100;
    int relYHawaii = 770;
    
    map1 = new Map( size, relX, relY,  relXAlaska,  relYAlaska,  relXHawaii,  relYHawaii, x+dropdownW/4, y+30);
    map2 = new Map( size, relX + 600,  relY,  relXAlaska + 600,  relYAlaska,  relXHawaii,  relYHawaii+ 300, x+dropdownW/4+560, y+30);
  }
  
  void changeMap(int mapIndex, int snapshotIndex){
     Snapshot aSnapshot = snapshots.get(snapshotIndex);
     int year = aSnapshot.getYear()-1999;
     float gradient = aSnapshot.getGradientNumber();
     int relative = aSnapshot.getRelative();
     if(mapIndex==0){
       map1.changeYear(year);
       map1.setView( gradient);
       map1.setRelative(relative);
       //print(map1.relative);
     }
     else{
       map2.changeYear(year);
       map2.setView( gradient);
       map2.setRelative(relative);
      // print(map2.relative);
     }
     
    
  }

  
  void close(){
    compareViewOn = false;
    menu1.clear();
    menu2.clear();
    menu1.setVisible(false); 
    menu2.setVisible(false); 
    
    sidebar.toggleDropdown(true);
    mapmenu.toggleSlider(true);

  }
  
  void mouseMoved(){
    map1.mouseMoved();
    map2.mouseMoved();
  }
  
  void draw(){
    fill(96);
    rect(0,top,widthW,heightH-top, 30);
    if(close!=null)
      close.draw();
    if (map1!=null){
      map1.drawMap();
    }
   if (map2!=null){
      map2.drawMap();
    }
    
  }
  
  
}
