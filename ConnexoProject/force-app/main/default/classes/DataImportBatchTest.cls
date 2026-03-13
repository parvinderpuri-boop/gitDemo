@isTest
public class DataImportBatchTest {
    Static testMethod void DataImportBatchTestMethod() {
        
        SPARTADMS__Corporate_Document__c[] dmsList = new List<SPARTADMS__Corporate_Document__c>();
        for (Integer i=0;i<10; i++) {
            SPARTADMS.DMSUtils.isManualUpdate = false;
          SPARTADMS.DMSGlobalStatic.stopTriggerExecutionContext = true;        
            SPARTADMS__Corporate_Document__c cd = new SPARTADMS__Corporate_Document__c(Name='Doc'+i, SPARTADMS__Version_Status__c='Effective',SPARTADMS__Document_Status__c = 'EFFECTIVE', SPARTADMS__Submission_Type__c='Sparta Data Import');
            dmsList.add(cd);
        }        
        insert dmsList;        

        Test.startTest();
        DataImportBatch dmimport = new DataImportBatch();
        Database.executeBatch(dmimport);
        Test.stopTest();
    }
}