public class Dropdown {
    DropdownList ddl;
    String name;
    float X, Y;
    int wid, hig;

    Dropdown(String name, float X, float Y, int wid, int hig) {
      this.name = name;
      this.X = X;
      this.Y = Y;
      this.wid = wid;
      this.hig = hig;
      
      ddl = cp5.addDropdownList(name);
      ddl.setPosition(X, Y);
      ddl.setBackgroundColor(black); 
      ddl.setColorBackground(lightGray); 
      ddl.setSize(wid, hig);
      ddl.setBarHeight(14);    
      ddl.setItemHeight(14);   
    }
  
  // Currently just returns first item in list
  String getCurrentDropdown(DropdownList ddl2) {
    return ddl2.getItem(0).getText();
  }
  
  void addItem(String s, int n) {
    ddl.addItem(s, n);
  }
  
  void setIndex(int n) {
    ddl.setIndex(n);
  }
    
//--Control Event Function Moved to Main.
//--Only works there

}
