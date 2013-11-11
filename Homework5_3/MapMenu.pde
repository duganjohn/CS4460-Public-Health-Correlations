public class MapMenu{
  
  private ArrayList<PImage> snapshots = new ArrayList<PImage>();
  Button saveButton;
  int y, x;
  
  public MapMenu(int x, int y){
    this.y =y;
    this.x =x;
    saveButton = new Button("Save This View", 650, y, 150, 40);
    cp5.addSlider("years")
       .setPosition(40, y)
       .setWidth(500)
       .setHeight(40)
       .setRange(1999,2012) // values can range from big to small as well
       .setValue(2012)
       .setNumberOfTickMarks(14)
        .setColorTickMark(0)
       .snapToTickMarks(true) 
       .setSliderMode(Slider.FLEXIBLE)
       .setTriggerEvent(Slider.RELEASE) 
       ;
       println(years);
  }
  
  public void draw(){
    saveButton.draw();
    drawSnapshots();
    
  }
  
  public void mousePressed(){
     if (saveButton.pressed()) {
       snapshots.add(get(0,150,800,400)); 
    }
  }
  
  public void drawSnapshots(){
    int snapshotNum = 0;
    for (PImage aSnapshot : snapshots){
        image(aSnapshot, snapshotNum*200, heightH-130, 200, 120);
        snapshotNum += 1;
    }
  }
  
  
  public void drawYearSlider(){

  }
    


  
  
}
