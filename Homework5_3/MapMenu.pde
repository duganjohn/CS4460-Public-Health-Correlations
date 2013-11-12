public class MapMenu{
  
  private ArrayList<Snapshot> snapshots = new ArrayList<Snapshot>();
  Button saveButton;
  ArrayList<Button> deleteButtons = new ArrayList<Button>();
  int y, x;
  int numberOfSnapshots;
  int deletedSnapshots;
  
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
       if (snapshots.size() > 5) {
         javax.swing.JOptionPane.showMessageDialog(null, "You may only save 6 views, please delete one or more views.");
       }
       image = get(0,150,800,400);
       snapshots.add(new Snapshot(image, numberOfSnapshots*200, heightH-130, 200, 120, 2000, "test")); 
       Button deleteButton = new Button("X",numberOfSnapshots*200+190, heightH-130, 10,10, numberOfSnapshots);
       deleteButtons.add(deleteButton);
       numberOfSnapshots += 1;       
     }
     
     for (Button aDeleteButton : deleteButtons){
       if (aDeleteButton.pressed()) {
         int snapshotIndex = aDeleteButton.getIndex(); 
//         println(snapshotIndex + " " + snapshots.size() + " " + numberOfSnapshots + " " + deletedSnapshots);
//         if (snapshotIndex < snapshots.size()){
//           deleteIndex = snapshotIndex - deletedSnapshots;
//         } else { deleteIndex = snapshotIndex;}
//         if (deleteIndex < 0){
//           deleteIndex = numberOfSnapshots - deletedSnapshots;
//         }
//         println("Delete Index: " + deleteIndex);
         snapshots.remove(deleteIndex);
         for (Button bDeleteButton : deleteButtons){
           if (deleteIndex < bDeleteButton.getIndex()){
             int aIndex = bDeleteButton.getIndex();
             bDeleteButton.setIndex(aIndex-1);
           }
         }
         deleted = true;
         numberOfSnapshots -= 1;
         deletedSnapshots += 1;
       }
     }
     if (deleted) {
       deleteButtons.remove(deleteIndex);
     }
  }
  
  
  public void drawYearSlider(){

  }
  

    


  
  
}
