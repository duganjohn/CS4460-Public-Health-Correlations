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
      ddl.setColorBackground(darkGray); 
      ddl.setColorLabel(white); 
      ddl.setSize(wid, hig);
 
      ddl.setItemHeight(20);
      ddl.setBarHeight(20);
      ddl.captionLabel().style().marginTop = 3;
      ddl.captionLabel().style().marginLeft = 3;
      ddl.valueLabel().style().marginTop = 3;
      ddl.valueLabel().style().marginBottom = 3;
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
  
  void setVisible(boolean bool){
     ddl.setVisible(bool);
  }
    
  void clear(){
     ddl.clear();
  }
//--Control Event Function Moved to Main.
//--Only works there

}
