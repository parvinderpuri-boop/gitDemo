public class mixedDMLexceptionHandling {
    
    public static void dmlOnSetupAndNonSetup(){
    
     // This method will perform on Setup and Non-Setup Object
     
     // Insert Account Record here.
		Account acc = new Account();
    	acc.Name = 'Account1';
    	insert acc;
        System.debug('Name : '+ acc);
        
        createUserRecord();
              
    }
    @future
    public static void createUserRecord(){
        
        try{
            // Insert User Record here.    
	  Profile p = [Select Id from Profile Where Name = 'Standard User'];
      UserRole r = [Select Id from UserRole Where Name = 'Manager'];
        
        User createUser = new User();
      	createUser.Alias = 'standt';
  		createUser.Email = 'standarduser@testsdfgorg.com';	
  		createUser.EmailEncodingKey = 'UTF-8';
  		createUser.LastName = 'Testingqwerty';
  		createUser.LanguageLocaleKey = 'en_US';
  		createUser.LocaleSidKey = 'en_US';
  		createUser.ProfileId = p.Id;
  		createUser.TimeZoneSidKey = 'America/Los_Angeles';
  		createUser.UserName = 'testetete12314sdfghj1@testorg.com';
  		createUser.UserRoleId = r.Id;
        
        Insert createUser;
        System.debug(createUser);
        }
        catch(Exception e){
            System.debug('Error -- '+ e.getStackTraceString());
            System.debug('Error Message -- '+ e.getMessage());
        }
    }
}