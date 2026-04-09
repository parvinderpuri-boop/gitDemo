public class MapClassQue {
/*
 //Q1. Create a Map of roll numbers and student names
 
Map<Integer, String> studentMap = new Map<Integer, String>();
studentMap.put(1, 'Ravi');
studentMap.put(2, 'Aman');
System.debug(studentMap);  // {1=Ravi, 2=Aman}

 //Q2. Get value from a Map using key

String name = studentMap.get(1); // Output: Ravi
System.debug(name);

 //Q3. Check if Map contains a key or value

System.debug(studentMap.containsKey(2)); // true
System.debug(studentMap.containsValue('Aman')); // true

 //Q4. Remove an entry from Map

studentMap.remove(2);
System.debug(studentMap);  // {1=Ravi}

 //Q5. Store employee names with salaries in Map. Get salary of 'Ravi'.

Map<String, Decimal> empSalary = new Map<String, Decimal>{
    'Ravi' => 55000,
    'Amit' => 62000
};
System.debug(empSalary.get('Ravi'));  // 55000

 //Q6. Loop through Map keys and values

for(String emp : empSalary.keySet()){
    System.debug(emp + ' earns ' + empSalary.get(emp));
}

 //Q7. Print only salaries (values)

for(Decimal salary : empSalary.values()){
    System.debug('Salary: ' + salary);
}


 //Q8. Map Account Id to Account Name

List<Account> accList = [SELECT Id, Name FROM Account];

Map<Id, String> accMap = new Map<Id, String>();
for(Account acc : accList){
    accMap.put(acc.Id, acc.Name);
}
System.debug(accMap);

//Q9. Map of Account Id to Account record

Map<Id, Account> accMap = new Map<Id, Account>(
    [SELECT Id, Name FROM Account]
);

For(Id accId : [SELECT Id FROM Account]){
    System.debug(accMap.get(accId).Name);
}

//Q10. Map of Contact Email to Contact record

Map<String, Contact> emailToContact = new Map<String, Contact>();
for(Contact con : [SELECT Id, Email FROM Contact WHERE Email != null]){
    emailToContact.put(con.Email, con);
}

//Q11. Given List of Contacts, get matching Accounts via Map

List<Contact> conList = [SELECT Id, Name, AccountId FROM Contact];
Set<Id> accIds = new Set<Id>();
for(Contact c : conList){
    if(c.AccountId != null){
        accIds.add(c.AccountId);
    }
}

Map<Id, Account> accMap = new Map<Id, Account>(
	[SELECT Id, Name FROM Account WHERE Id IN : accIds]
);

for(Contact c : conList){
    if(accMap.containsKey(c.AccountId)){
        System.debug('Contact '+ c.Name +' belongs to Account '+ accMap.get(c.AccountId).Name);
    }
}

 * */


    Public Static void mapMethod(){
/*        
        Map<Integer, String> studentMap = new Map<Integer, String>();
        studentMap.put(1, 'Gautam');
		studentMap.put(3, 'Nidhi');
		studentMap.put(2, 'Naveen');
		studentMap.put(4, 'Naveen');
		studentMap.remove(2);

		System.debug(studentMap.get(2));
		System.debug(studentMap.containsKey(2));
        System.debug('RollNumber :'+ studentMap.keySet());
		System.debug(studentMap);


        for(String name : studentMap.values()){
            System.debug('Student Name :'+ name);
        }

		Integer studentCount = studentMap.values().size();
		System.debug('Count:'+ studentCount);
*/

/*
//Que - Employee Salary Record

	Map<Integer, Integer> empSalary = new Map<Integer, Integer>();
	empSalary.put(1, 40000);
    empSalary.put(2, 40000);
	empSalary.put(3, 40000);

    System.debug('Salary of Employee-2 : '+ empSalary.get(2));
*/


/*
//Contact → Account mapping

List<Contact> conList = [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId <> Null LIMIT 5];

Map<Id, Id> conAccMap = new Map<Id, Id>();

        for(Contact con : conList){
            conAccMap.put(con.Id, con.AccountId);
        }
		System.debug(conAccMap);
*/


//Q2. Duplicate Account Names ko Handle karna

List<Account> accList = [SELECT Id, Name FROM Account LIMIT 5];
Map<String, List<Account>> accMap = new Map<String, List<Account>>();
	
        for(Account acc : accList){
            If(!accMap.containsKey(acc.Name)){
                accMap.put(acc.Name, new List<Account>());
            }
            accMap.get(acc.Name).add(acc);
        }
		System.debug(accMap);
    }
}