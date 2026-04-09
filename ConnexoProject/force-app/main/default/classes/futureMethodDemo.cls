public class futureMethodDemo {
    
    public futureMethodDemo(){
        System.debug('This is a futureMethodDemo Construtor');
        method1();
        method2();
        method4(12, 'XYZ');
        
        List<String> nameList = new List<String>{
            'Veer',
            'Ravi',
            'Gautam',
            'Alias'
           };
                    
        Set<Id> nameSet = new Set<Id>();
        nameSet.add('001gK00000BhExT');
        nameSet.add('001gK00000JrrfA');
        
        method3(nameList, nameSet);                     
                                
    }
    
    public void method1(){
        System.debug('This is a void method1');
    }
    
    public void method2(){
        System.debug('This is a void method2');
        //method3();
    }
    
    //Future are only available if method is static.
    @future(callout = true)
    public static void method3(List<String> stList, Set<Id> idSet){
        System.debug('This is a static method3');
        
        System.debug('nameList: '+ stList +'nameSet: '+ idSet);
        //method4();
    }
    
    @future
    public static void method4(Integer i, String s){
        
        System.debug('I == '+i);
        System.debug('S == '+s);
    }
}