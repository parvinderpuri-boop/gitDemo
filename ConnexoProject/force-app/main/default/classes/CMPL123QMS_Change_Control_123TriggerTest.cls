/********************************************************************************************************************
    Author: Amit
	Version: 1.0
	Test class name - CMPL123QMS_Change_Control_123TriggerTest
	Apex handler class - TWD_ChangeControl_Handler
	Trigger Name - CMPL123QMS_Change_Control_123Trigger
*********************************************************************************************************************/

@isTest
public class CMPL123QMS_Change_Control_123TriggerTest {

    // Setup common test data
    private static CMPL123QMS__Change_Control__c createTestChangeControl(String status) {
        return new CMPL123QMS__Change_Control__c(
            CMPL123_WF_Status__c = 'Action Planning',
            TWD_Department__c = 'DTS',
            TWD_Short_Description__c = 'Test Trigger',
            TWD_Due_Date__c = Date.today(),
            Owner_Area__c = 'DTS',
            CMPL123QMS__Type__c = 'Permanent Change',
            Assigned_To_Area__c = 'DTS'
        );
    }

    @isTest static void testAllTriggerScenarios() {
        // Insert record with non-batch-triggering status
        CMPL123QMS__Change_Control__c cc1 = createTestChangeControl('Under Assessment');
        insert cc1;

        // Validate before/after insert values
        CMPL123QMS__Change_Control__c inserted = [
            SELECT Id, Assigned_To_Area__c FROM CMPL123QMS__Change_Control__c WHERE Id = :cc1.Id
        ];
        System.assertEquals('DTS', inserted.Assigned_To_Area__c);

        // Update to trigger `before update`, `after update`, and batch condition
        cc1.CMPL123_WF_Status__c = 'Post Approval Action Execution';
        update cc1;

        // Validate update
        CMPL123QMS__Change_Control__c updated = [
            SELECT Id, CMPL123_WF_Status__c FROM CMPL123QMS__Change_Control__c WHERE Id = :cc1.Id
        ];
        System.assertEquals('Post Approval Action Execution', updated.CMPL123_WF_Status__c);

        // Delete the record to test before/after delete
        delete cc1;

        // Undelete to test after undelete
       // undelete cc1;
    }

    // Optional: Test batch-triggering path only when Actions are all Closed/Canceled
    @isTest static void testBatchTriggerEligibleRecord() {
        // Create a change control record
        CMPL123QMS__Change_Control__c cc = createTestChangeControl('Under Assessment');
        insert cc;

        // Create related CMPL123__Action__c with 'Closed' status to simulate no open actions
        CMPL123__Action__c action = new CMPL123__Action__c(
            TWD_Change_Control__c = cc.Id,
            CMPL123_WF_Status__c = 'Closed',
            CMPL123__Due_Date__c=Date.Today()
        );
        insert action;

        // Update status to trigger batch
        cc.CMPL123_WF_Status__c = 'Post Approval Action Execution';
        update cc;

        // Validate again
        CMPL123QMS__Change_Control__c postUpdate = [
            SELECT Id, CMPL123_WF_Status__c FROM CMPL123QMS__Change_Control__c WHERE Id = :cc.Id
        ];
        System.assertEquals('Post Approval Action Execution', postUpdate.CMPL123_WF_Status__c);
    }
}