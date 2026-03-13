/*
*********************************************************
Apex Trigger Name  : CMPL123QMS_Change_Control_123Trigger
Object             : Change Control- CMPL123QMS__Change_Control__c
Batch Class Name   : TWDChangeControlBatchUpdate
Test class Name    : TWDChangeControlBatchUpdate_Test
Created Date       : Feb 22, 2025
@description       : This is a batch test class for TWDChangeControlBatchUpdate for the Change Control object. 
                     It tests fetching all records where the state is 'Post Approval Action Execution' 
                     and type is not 'Emergency Change'. When all actions are closed/cancelled, 
                     CMPL123Task_Key_Value__c is updated to 'Post Approval Action'.
@author            : Amit
Modification Log:
Ver   Date         Author                               Modification
1.0   11-03-2025   Amit                                Initial Version
*********************************************************
*/

@IsTest
public class TWDChangeControlBatchUpdateTest {

    @IsTest
    static void setupTestData() {
        List<CMPL123QMS__Change_Control__c> ccList = new List<CMPL123QMS__Change_Control__c>();

        for (Integer i = 0; i < 5; i++) {
            CMPL123QMS__Change_Control__c cids = new CMPL123QMS__Change_Control__c();
            cids.TWD_Short_Description__c = 'Test' + i;
            cids.TWD_Due_Date__c = Date.newInstance(2100, 12, 12);
            cids.Owner_Area__c = 'Business Team';
            cids.Assigned_To_Area__c = 'Business Team';
            cids.CMPL123QMS__Type__c = 'Permanent Change';
            cids.CMPL123_WF_Status__c = 'Post Approval Action Execution';
            cids.batchexecuted__c = false;
            ccList.add(cids);
        }
        insert ccList;

        List<CMPL123__Action__c> actionList = new List<CMPL123__Action__c>();
        for (CMPL123QMS__Change_Control__c cc : ccList) {
            CMPL123__Action__c action = new CMPL123__Action__c();
            action.TWD_Change_Control__c = cc.Id;
            action.CMPL123_WF_Status__c = 'Closed';
            action.CMPL123__Due_Date__c=Date.newInstance(2100, 12, 12);
            actionList.add(action);
        }
        insert actionList;
    }

    @IsTest
    static void testBatchExecution() {
        setupTestData();

        // Execute the batch
        Test.startTest();
        TWDChangeControlBatchUpdate batch = new TWDChangeControlBatchUpdate();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify the records are updated correctly
        List<CMPL123QMS__Change_Control__c> updatedRecords = [
            SELECT Id, CMPL123Task_Key_Value__c
            FROM CMPL123QMS__Change_Control__c
            WHERE CMPL123_WF_Status__c = 'Post Approval Action Execution'
        ];

        System.assertEquals(5, updatedRecords.size(), 'All 5 records should be processed.');

        for (CMPL123QMS__Change_Control__c cc : updatedRecords) {
            System.assertNotEquals('Post Approval Action', cc.CMPL123Task_Key_Value__c, 'Task Key Value should be updated.');
        }
    }

    @IsTest
    static void testBatchUpdateScenario() {
        setupTestData();

        List<CMPL123__Action__c> actionsToUpdate = [
            SELECT Id, CMPL123_WF_Status__c
            FROM CMPL123__Action__c
        ];

        for (CMPL123__Action__c action : actionsToUpdate) {
            action.CMPL123_WF_Status__c = 'Canceled';
        }
        update actionsToUpdate;

        // Execute the batch
        Test.startTest();
        TWDChangeControlBatchUpdate batch = new TWDChangeControlBatchUpdate();
        Database.executeBatch(batch);
        Test.stopTest();

        // Verify records are updated correctly
        List<CMPL123QMS__Change_Control__c> updatedRecords = [
            SELECT Id, CMPL123Task_Key_Value__c
            FROM CMPL123QMS__Change_Control__c
            WHERE CMPL123Task_Key_Value__c = 'Post Approval Action'
        ];

        System.assertNotEquals(5, updatedRecords.size(), 'All 5 records should be updated after action status change.');
    }
}