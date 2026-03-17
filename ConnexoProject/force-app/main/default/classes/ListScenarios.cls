public class ListScenarios {
    
    public static void listMethod(){
        
/*        
        List<Integer> intList = new List<Integer>{3, 8, 2, 9, 7, 11};
        List<Integer> evenNumber = new List<Integer>();
        
        for(Integer n : intList){
            if(Math.Mod(n, 2)==0){
                evenNumber.add(n);
            }
        }
        
        System.debug(evenNumber);
*/


        List<String> stList = new List<String>{'Naveen', 'null', 'Gautam', 'null'};
        stList.remove(1);

		stList.remove(2);

		System.debug(stList);
        
        
		List<Contact> conList = [SELECT Id, LastName, Account.Name FROM Contact WHERE AccountId <> null];
        
        for(Contact con : conList){
            System.debug('Account '+ con.Account.Name);
        }

		
        //List<Account> accList = [SELECT Id, Name From Account ORDER BY Name ASC];
        
        /*for(Account acc : accList){
acc.Rating = 'Hot';
}
*/
        
        //System.debug(accList);
        
        /*List<String> stList = new List<String>{'Hey', 'Buddy', '!'};

System.debug(stList.size());
for(Integer i = 0; i <= stList.size() - 1; i++){
System.debug('Statement :'+ stList.get(i));
}
*/
        
        /*
List<String> stList = new List<String>{'Or', 'Bhai', 'ky haal chaal'};
stList.set(1, 'Bhen');

System.debug('Statement :'+ stList);
*/
        
        /*
List<String> stList = new List<String>{'Ek', 'Doo', 'Theen'};
stList.remove(stList.size()-1);
System.debug('Final Result :'+ stList);
*/
        /*
        List<String> Email = new List<String>{'abc@gmail.com', 'xyz@gmail.com', 'abc@gmail.com'};
            Set<String> uniqueEmail = new Set<String>(Email);
        
        Email = new List<String>(uniqueEmail);
        System.debug('Email :'+ Email);
        */

/*
        List<Integer> Numbers = new List<Integer>{23, 45, 32, 91};
            Numbers.sort();
        
        System.debug(Numbers);
*/

/*
        List<String> fruits = new List<String>{'Apple', 'chappal'};
        List<String> cloneList = fruits.clone();
		cloneList.add('chal be nikl');
		System.debug(cloneList);
*/

/*
		List<Contact> conList = [SELECT Id, LastName, Email FROM Contact WHERE Email <> Null LIMIT 5];
        for(Contact con : conList){
            System.debug('Contact Name: '+ con.LastName +'Contact Email:'+ con.Email);
        }
*/

        
    }
    
}