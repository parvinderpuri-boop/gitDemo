@isTest
public class CorporateDocumentFlowTest {
    
    @isTest
    static void testupdateDMSRecords() {
        List<SPARTADMS__Corporate_Document__c> dmsList = new List<SPARTADMS__Corporate_Document__c>();

        for (Integer i = 0; i < 10; i++) {
            SPARTADMS.DMSUtils.isManualUpdate = false;
            SPARTADMS.DMSGlobalStatic.stopTriggerExecutionContext = true;

            SPARTADMS__Corporate_Document__c cd = new SPARTADMS__Corporate_Document__c(
                Name = 'Doc' + i,
                SPARTADMS__Version_Status__c = 'Effective',
                SPARTADMS__Document_Status__c = 'EFFECTIVE',
                SPARTADMS__Submission_Type__c = 'Sparta Data Import'
            );
            dmsList.add(cd);
        }
        insert dmsList;

        CMPL123QMS__Change_Control__c changeControl = new CMPL123QMS__Change_Control__c(
            CMPL123_WF_Status__c = 'Under Assessment',
            TWD_Department__c = 'Analytical Development',
            TWD_Short_Description__c = 'Test',
            TWD_Due_Date__c = Date.today(),
            Owner_Area__c = 'Analytical Development',
            CMPL123QMS__Type__c = 'Permanent Change',
            Assigned_To_Area__c = 'Engineering'
        );
        insert changeControl;

        CorporateDocumentFlow.InputWrapper input = new CorporateDocumentFlow.InputWrapper();
        input.documents = dmsList;
        input.recordId = changeControl.Id;

        List<CorporateDocumentFlow.InputWrapper> inputs = new List<CorporateDocumentFlow.InputWrapper>{ input };

        Test.startTest();
        CorporateDocumentFlow.updateDMSRecords(inputs);
        Test.stopTest();

        List<SPARTADMS__Corporate_Document__c> updatedDocs = [
            SELECT Id, Change_Control__c
            FROM SPARTADMS__Corporate_Document__c
            WHERE Id IN :dmsList
        ];

        for (SPARTADMS__Corporate_Document__c doc : updatedDocs) {
            System.assertEquals(changeControl.Id, doc.Change_Control__c, 'Change Control ID should be updated');
        }
    }

}