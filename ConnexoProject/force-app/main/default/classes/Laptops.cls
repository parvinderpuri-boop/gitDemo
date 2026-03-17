public class Laptops {
	public String companyName;
    public static String name;
    
    private Laptops(String companyName){
        System.debug('Company Name in Constructor is =>'+ companyName);
        this.companyName = companyName;
        // this.ClassVariableName = <constructor parameter name>
    }
    // Instance Method / Object Method
    public void printCompanyName(){
        System.debug('Company Name withing printCompanyName is =>'+ companyName);
        System.debug('Company Name withing printCompanyName is =>'+ name);
    }
    // Class Method / Static Methods
    public static void printName(){
        System.debug('Company Name withing printCompanyName is =>'+ name);
    }
}