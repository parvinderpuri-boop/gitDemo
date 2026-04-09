public class MapQues {
    public static void QueMethod(){
/*
        Map<String, Decimal> productPriceMap = new Map<String, Decimal>();
        productPriceMap.put('Mobile', 12000);
        productPriceMap.put('Laptop', 35000);
        productPriceMap.put('IPad', 25000);
		
        if(productPriceMap.containsKey('Mobile')){
            System.debug('Mobile Price : '+ productPriceMap.get('Mobile'));
        }else{
            System.debug('Mobile not Found');
        }
*/


        // Mujhe ky karna hai ki Account = {AccountId, Account Name}---
/*
	   List<Account> accountList = [SELECT Id, Name FROM Account ORDER BY Name ASC LIMIT 5];
        
       Map<Id, String> accountMap = new Map<Id, String>();
        
        for(Account acc : accountList){
            accountMap.put(acc.Id, acc.Name);
        }
        
        
        for(Id accIds : accountMap.keySet()){
            System.debug('Account Id : '+ accIds +'Account Name : '+accountMap.get(accIds));
        }
        
*/

		// Mujhe iss mein ye karna hai ki Map<Id, Contact> store karo or Name + Email.
		
        //List<Contact> conList = [SELECT Id, Name, Email FROM Contact];
/*        
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        
        for(Contact con : [SELECT Id, Name, Email FROM Contact WHERE Email <> Null]){
            conMap.put(con.Id, con);
        }
        
        for(Id conId : conMap.keySet()){
            System.debug('Name :'+ conMap.get(conId).Name +'Email : '+ conMap.get(conId).Email);
        }
*/
        
/*        
        List<Contact> conList = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId <> Null LIMIT 5];
        
        Map<Id, List<Contact>> conAccMap = new Map<Id, List<Contact>>();
        for(Contact con : conList){
            if(!conAccMap.containsKey(con.AccountId)){
                conAccMap.put(con.AccountId, new List<Contact>());
                conAccMap.get(con.AccountId).add(con);
            }
            
            for(Id accId : conAccMap.keySet()){
                System.debug('AccountId: '+ accId +'Total Contacts '+ conAccMap.get(accId).size());
            }
        }
*/

/*        
        List<String> accName = new List<String>{'IBM', 'TCS', 'IBM', 'Infosys'};
        Map<String, Boolean> uniqueMap = new Map<String, Boolean>();
        
        for(String name : accName){
            uniqueMap.put(name, true);
        }
        
        for(String uniqueName : uniqueMap.keySet()){
            System.debug('Unique Account : '+ uniqueName);
        }
*/


/*        
        Map<String, List<String>> newMap2 = new Map<String, List<String>>();
        
        newMap2.put('Fruits', new List<String>{'Apple', 'Banana', 'Mango'});
        
        newMap2.put('Cities', new List<String>{'Uttar Pradesh', 'Noida', 'Delhi'});
        
        System.debug(newMap2.get('Fruits'));
        
        System.debug(newMap2.get('Cities'));
*/
        
        Map<String, Map<String, String>> newMap3 = new Map<String, Map<String, String>>();
        
        //Inner Map
        
        Map<String, String> indiaInfo = new Map<String, String>();
        indiaInfo.put('Capital', 'Delhi, Noida');
        indiaInfo.put('Currency', 'Rupee');
        
        //Insert
        newMap3.put('India', indiaInfo);
        
        System.debug(newMap3.get('India'));
        System.debug(newMap3.get('India').get('Capital'));
        System.debug(newMap3.get('India').get('Currency'));
        
    }
}