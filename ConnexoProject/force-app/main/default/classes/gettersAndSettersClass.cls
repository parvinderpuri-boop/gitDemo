public class gettersAndSettersClass {
	private String accountName;
    private Integer noOfEmployees;
    
    public String rating {get; private set;}
    // Publically accessible
    // Private Set (within class)
    
    public String getName(){
        return this.accountName;
    }
    
    public void setName(String name){
        this.accountName = name;
    }
    
    public Integer getnoOfEmployees(){
        return this.noOfEmployees;
    }
    
    public void setnoOfEmployees(Integer noOfEmployees){
        this.noOfEmployees = noOfEmployees;
    }
}