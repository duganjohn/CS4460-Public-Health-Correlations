import java.text.DecimalFormat;

public class StateData{
  // --- Called during app to populate all states. ----
    private String name;
    
  private int population, healthExp, 
    employmentBased,directPurchase,
    government,medicaid,medicare,military;
  private float medianIncome, noInsCoverage, insCoverage;
    
  private Object[] items;
  private String[] display;
  private double[] doubles;
  
  public StateData(String name, int population, float medianIncome, int healthExp,
          float noInsCoverage, float insCoverage, float employmentBased,
          float directPurchase, float government, float medicaid, float medicare,
          float military){
          
          this.name = name;
          
          //I don't think state needs to know year
          updateData( population,  medianIncome,  healthExp,
           noInsCoverage,  insCoverage,  employmentBased,
           directPurchase,  government,  medicaid,  medicare,
           military);
    
    }
    
    public void updateData(int population, float medianIncome, int healthExp,
          float noInsCoverage, float insCoverage, float employmentBased,
          float directPurchase, float government, float medicaid, float medicare,
          float military){
            
    this.healthExp = healthExp;
    
    this.population = population;
    this.medianIncome = (int)Math.round(medianIncome);      
    this.healthExp = healthExp;
    
    
   
    this.noInsCoverage = (int)Math.round(noInsCoverage);

    float ratio = insCoverage / (insCoverage + noInsCoverage);

    this.insCoverage = (ratio * 100);
    this.noInsCoverage = 100 - this.insCoverage;
    
    this.employmentBased = (int)Math.round(employmentBased*1000);
    this.directPurchase = (int)Math.round(directPurchase*1000);
    this.government = (int)Math.round(government*1000);
    this.medicaid = (int)Math.round(medicaid*1000);
    this.medicare = (int)Math.round(medicare*1000);
    this.military = (int)Math.round(military*1000);
     
    updateArray();
  }
 
 public void updateArray(){
   
    //String output = ""+myFormatter.format(map.clicked.data.display[i]);
    this.doubles = new double[]{0, this.population, this.healthExp, this.noInsCoverage, this.insCoverage, this.medianIncome};
    this.items = new Object[]{this.name, this.population, this.healthExp, this.noInsCoverage, this.insCoverage, this.medianIncome};
    this.display = new String[]{this.name, ""+this.population, "$ "+this.healthExp, this.noInsCoverage+" %", this.insCoverage+" %", "$ "+this.medianIncome};
    
 }
  
}
