public class DataImportBatch implements Database.Batchable<SObject>, Database.Stateful{
    
    Set<Id> failedRecords = new Set<Id>();
    
    public Database.QueryLocator start(Database.BatchableContext param1) {
        return Database.getQueryLocator('select id,New_Major_Doc_Number__c,SPARTADMS__Document_Number__c,SPARTADMS__Alphanumeric_Sequence__c,SPARTADMS__Document_Sequence_Number__c from SPARTADMS__Corporate_Document__c WHERE SPARTADMS__Submission_Type__c = \'Sparta Data Import\' AND SPARTADMS__Is_File_Uploaded__c = FALSE and SPARTADMS__Version_Status__c =\'Effective\'');
    }
    
    public void execute(Database.BatchableContext param1, List<sObject> sObjects){
        String MOVE_TO_EFFECTIVE = 'Move to Effective';      
        
        List<SPARTADMS__Corporate_Document__c> cdList = (List<SPARTADMS__Corporate_Document__c>) sObjects;
        
        for(SPARTADMS__Corporate_Document__c c : cdList){
            if(!String.isBlank(c.SPARTADMS__Alphanumeric_Sequence__c)){
                c.SPARTADMS__Approved_Document_Number__c = SPARTADMS.DMSUtils.getDocumentSequenceNumber(c.SPARTADMS__Alphanumeric_Sequence__c, (Integer) c.SPARTADMS__Document_Sequence_Number__c);
            }
            c.SPARTADMS__Is_File_Uploaded__c = true;
            c.SPARTADMS__Document_Number_Major__c = c.New_Major_Doc_Number__c;
            c.SPARTADMS__Document_Minor_Version__c = '0';
            c.SPARTADMS__Document_Version_Count__c = 1;
            
        }
        SPARTADMS.DMSUtils.setUserActionType(MOVE_TO_EFFECTIVE);
        
        Database.SaveResult[] results = Database.update(cdList, false);
        
        for (Integer i=0; i < results.size(); i++) {
            Database.SaveResult result = results.get(i);
            if (!result.isSuccess()) {
                failedRecords.add(result.getId());
            }
        }
        
    }
    
    public void finish(Database.BatchableContext bc) {
        if(failedRecords.isEmpty()){
            System.debug('DataImport Batch successful');
        }else{
            System.debug('Ids for records that failed: ');
            for(Id failedRecordId : failedRecords){
                System.debug(failedRecordId);             
            }
        }
    }
}