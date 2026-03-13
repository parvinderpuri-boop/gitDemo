global class DMSMigration implements Database.Batchable<sObject>{
    global String email;
    global String query;
    global string toUserEmail;
    global string fromUserEmail;
    String MOVE_TO_EFFECTIVE = 'Move to Effective';
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<SPARTADMS__Corporate_Document__c> docs = new List<SPARTADMS__Corporate_Document__c>();
        
        for(Sobject s : scope){SPARTADMS__Corporate_Document__c cd = (SPARTADMS__Corporate_Document__c)s;
                               if(!String.isBlank(cd.SPARTADMS__Alphanumeric_Sequence__c)){
                                   cd.SPARTADMS__Approved_Document_Number__c = SPARTADMS.DMSUtils.getDocumentSequenceNumber(cd.SPARTADMS__Alphanumeric_Sequence__c, (Integer) cd.SPARTADMS__Document_Sequence_Number__c);
                               }
                               cd.SPARTADMS__Is_File_Uploaded__c = true;
                               cd.SPARTADMS__Document_Number_Major__c = '1';
                               cd.SPARTADMS__Document_Minor_Version__c = '0';
                               cd.SPARTADMS__Document_Version_Count__c = 1;
                               docs.add(cd);
                              }
        SPARTADMS.DMSUtils.setUserActionType(MOVE_TO_EFFECTIVE);
        update docs;
    }
    
    
    public void finish(Database.BatchableContext BC){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {email});
        mail.setReplyTo('tuoyo.omadeli@spartasystems.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
    }
    
}