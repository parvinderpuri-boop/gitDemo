public class SetClassQue {
	
//Set Questions -

//Q1. Add 5 unique integers to a Set and print them.

/*
Set<Integer> numSet = new Set<Integer>{1,2,3,4,5};
System.debug(numSet);
*/

//Q2. Add 5 integers including duplicates and see result.

/*
Set<Integer> numSet = new Set<Integer>{1,2,2,3,4};
System.debug(numSet);    
*/

//Q3. Create Set<String> of fruits. Add, remove, check contains.

/*
Set<String> fruits = new Set<String>();
fruits.add('Banana');
fruits.add('Apple');
fruits.add('Mango');

fruits.remove('Mango');
System.debug(fruits.contains('Banana'));
System.debug(fruits);
*/

//Q4. Loop through a Set using for loop.

/*
Set<String> colors = new Set<String>{'Red', 'Blue', 'Black', 'Pink'};
System.debug(colors);
*/

//Q5. Set of Emails – check if email exists.

/*
Set<String> emails = new Set<String>{'a@test.com', 'b@test.com'};
String newEmail = 'a@test.com';

if(emails.contains(newEmail)){
    System.debug('Duplicate Email');
}else{
    System.debug('Email is unique');
}
*/

//Q6. Set of phone numbers – only add if number length is 10.

/*
List<String> numbers = new List<String>{'12345', '1234567890', '3456667810'};
Set<String> validNumbers = new Set<String>();

for(String num : numbers){
    if(num.length() == 10){
        validNumbers.add(num);
    }
}
System.debug(validNumbers);
*/

//Q7. Find repeated cities using List + Set.

/*
List<String> cityList = new List<String>{'Delhi', 'Mumbai', 'Delhi', 'Chennai'};
Set<String> citySet = new Set<String>();
Set<String> duplicates = new Set<String>();

for(String city : cityList){
    if(!citySet.add(city)){
        duplicates.add(city);
    }
}
System.debug('Duplicate Cities: '+ duplicates);
*/

//Q8. Collect unique emails from Contacts.

/*
List<Contact> conList = [SELECT Email FROM Contact WHERE Email != null];
Set<String> uniqueEmails = new Set<String>();

for(Contact con : conList){
    uniqueEmails.add(con.Email);
}
System.debug(uniqueEmails);
*/

//Q9. From List of Contact, get all unique non-null AccountId.

/*
List<Contact> conList = [SELECT Id, Name, AccountId FROM Contact];
Set<Id> accIds = new Set<Id>();

for(Contact con : conList){
    if(con.AccountId != null){
        accIds.add(con.AccountId);
    }
}
System.debug(accIds);
*/

//Q10. From Account list, collect names starting with ‘A’.
/*
List<Account> accList = [SELECT Name FROM Account WHERE Name LIKE 'A%'];
Set<String> aNames = new Set<String>();

for(Account acc : accList){
    if(acc.Name != null){
        aNames.add(acc.Name);
    }
}
System.debug(aNames);
*/
    public static void setMethod(){
        Set<String> cityName = new Set<String>();
        cityName.add('Bulandshahr');
        cityName.add('Meerut');
        cityName.add('Noida');
        
        System.debug(cityName);
        
        
        cityName.remove('Meerut');     
        System.debug(cityName);

		System.debug(cityName.contains('Meerut'));
        
    }
    
}