import java.util.*;

/*
 * Creates the menu at the bottom of the page with saved screenshots
 */
public class MapMenu{
  Map map;
  private ArrayList<Snapshot> snapshots = new ArrayList<Snapshot>();
  Button saveButton;
  ArrayList<Button> deleteButtons = new ArrayList<Button>();
  int y, x;
  int numberOfSnapshots;
  int deletedSnapshots;
  ArrayList<Integer> availableSlots = new ArrayList<Integer>();
  
  public MapMenu(Map map, int x, int y){
    this.map = map;
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
   availableSlots.add(0);
   availableSlots.add(1);
   availableSlots.add(2);
   availableSlots.add(3);
   availableSlots.add(4);
   availableSlots.add(5);
  }
  
  public void draw(){
    saveButton.draw();
    for (Snapshot aSnapshot : snapshots){
      aSnapshot.draw();
    }

    for (Button aDeleteButton : deleteButtons){
      aDeleteButton.draw();
    }
  }
  
  public void mousePressed(){
     int deleteIndex = 0;
     boolean deleted = false;
     PImage image;
     if (saveButton.pressed()) {
       if (availableSlots.size() < 1) {
         javax.swing.JOptionPane.showMessageDialog(null, "You may only save 6 views, please delete one or more views.");
       } else {
       image = get(0,150,800,400);
       Collections.sort(availableSlots);
       Integer slot = availableSlots.get(0);
       snapshots.add(new Snapshot(image, slot, (int)Math.round(cp5.getController("years").getValue()), map.getView())); 
       if (deleteButtons.size()<6){
       Button deleteButton = new Button("X",slot*200+190, heightH-130, 10,10, slot);
       deleteButtons.add(slot,deleteButton);
       } else {
         deleteButtons.get(slot).show();
       }
       availableSlots.remove(0);
       }
     }
     
     for (Button aDeleteButton : deleteButtons){
       if (aDeleteButton.pressed()) {
         int snapshotIndex = aDeleteButton.getIndex();
         Snapshot deletedSnapshot = snapshots.get(snapshotIndex);
         deleteIndex = deletedSnapshot.getSlot();
         deletedSnapshot.delete();
         availableSlots.add(0,snapshotIndex);
         deleted = true;
       }
     }

     if (deleted) {
       deleteButtons.get(deleteIndex).hide();
     }
  }
  
  public void drawYearSlider(){

  } 
}
