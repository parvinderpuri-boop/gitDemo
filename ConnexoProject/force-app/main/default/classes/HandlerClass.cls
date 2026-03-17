public class HandlerClass {
    public static void setIndustryOnInsert(List<Contact> contactList){
        Set<Id> accIds = new Set<Id>();
        for(Contact con : contactList){
            if(con.AccountId != null){
                accIds.add(con.AccountId);
            }
        }
        
        Map<Id, Account> accMap = new Map<Id, Account>(
        	[SELECT Id, Industry FROM Account WHERE Id IN :accIds]
        );
        
        for(Contact con : contactList){
            if(con.AccountId != null && accMap.containsKey(con.AccountId)){
                con.Industry__c = accMap.get(con.AccountId).Industry;
            }
        }
    }
    
    public static void setDefaultDescription(List<Contact> contactList){
        for(Contact con : contactList){
            if(con.Description == null){
                con.Description = 'Update via Trigger';
            }
        }
    }
    
    public static void preventLockedUpdate(List<Account> accList){
        
    }
    
}