@isTest
public class DMSTMSAuditTriggerTest {
    Static testMethod void DMSTMSAuditTriggerTestMethod() {
        Test.startTest();
        
        SPARTADMS__Corporate_Document__c dms = new SPARTADMS__Corporate_Document__c();
        
        SPARTADMS.DMSUtils.isManualUpdate = false;
        SPARTADMS.DMSGlobalStatic.stopTriggerExecutionContext = true;
        dms.SPARTADMS__Version_Status__c = 'Working';
        insert dms;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'Admin', Email='admin@testorg.com', 
                          EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                          LocaleSidKey='en_US', ProfileId = p.Id, 
                          TimeZoneSidKey='America/Los_Angeles', UserName='testtest1@andelyn.com');
        INSERT u;
        
        SPARTADMS__Box_Users__c bu =new SPARTADMS__Box_Users__c(Name='Test', SPARTADMS__Box_UserId__c='268453338',SPARTADMS__Related_Salesforce_User__c =u.Id, SPARTADMS__IsActive__c = true);
        INSERT bu;
        
        SPARTADMS__Document_Approvers__c docApp = new SPARTADMS__Document_Approvers__c();
        docApp.SPARTADMS__Related_Corporate_Document__c = dms.Id;
        docApp.SPARTADMS__Related_Box_User__c = bu.Id;        
        insert docApp;        
        delete docApp;
        undelete docApp;
        update docApp;
        
        SPARTADMS__Document_Reviewer__c docRev = new SPARTADMS__Document_Reviewer__c();
        docRev.SPARTADMS__Related_Corporate_Document__c = dms.Id;
        docRev.SPARTADMS__Related_Box_User__c = bu.Id;        
        insert docRev;
        delete docRev;
        undelete docRev;
        update docRev;
        
        SPARTADMS__Related_Document__c relDMS = new SPARTADMS__Related_Document__c();
        relDMS.SPARTADMS__Parent_Corporate_Document__c = dms.Id;
        insert relDMS;
        delete relDMS;
        undelete relDMS;
        update relDMS;
        
        SPARTADMS__Review_Justification__c justify = new SPARTADMS__Review_Justification__c();      
        justify.SPARTADMS__Related_Corporate_Document__c = dms.id;
        justify.SPARTADMS__Justification__c = 'Test';
        insert justify;
        delete justify;
        undelete justify;
        update justify;
        
        //SPARTADMS__Controlled_Printing__c controlPrint = new SPARTADMS__Controlled_Printing__c();
        //insert controlPrint;
        //delete controlPrint;
        //undelete controlPrint;
        //update controlPrint;   
        
        SPARTADMS__Document_Version__c docVersion = new SPARTADMS__Document_Version__c ();
        insert docVersion;
        delete docVersion;        
        undelete docVersion;
        update docVersion;
        
        CMPL123__Linked_Document_Change_Control__c linkedCC = new CMPL123__Linked_Document_Change_Control__c();
        insert linkedCC;
        delete linkedCC;
        undelete linkedCC;
        update linkedCC;
        
        CMPL123__Linked_Document_Audit__c linkedAudit = new CMPL123__Linked_Document_Audit__c();
        insert linkedAudit;
        delete linkedAudit;
        undelete linkedAudit;
        update linkedAudit;
        
        CMPL123__Linked_Document_CAPA__c linkedCAPA = new CMPL123__Linked_Document_CAPA__c();
        insert linkedCAPA;
        delete linkedCAPA;
        undelete linkedCAPA;
        update linkedCAPA;
        
        CMPL123__Linked_Document_Quality_Event__c linkedQE = new CMPL123__Linked_Document_Quality_Event__c();
        insert linkedQE;
        delete linkedQE;
        undelete linkedQE;
        update linkedQE;
        
        SPARTADMS__Controlled_Access__c cAccess = new SPARTADMS__Controlled_Access__c ();
        cAccess.SPARTADMS__Related_Corporate_Document__c = dms.Id;
        insert cAccess;
        delete cAccess;
        undelete cAccess;
        update cAccess;     
        
        delete dms;
        undelete dms;
        update dms;
    }
    
}