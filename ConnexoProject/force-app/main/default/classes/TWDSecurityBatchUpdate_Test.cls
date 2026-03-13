/*
*********************************************************
Apex Trigger Name  : Security_c_123Trigger
Object             : Security - Security__c
Batch Class Name   : TWDSecurityBatchUpdate
Test class Name    : TWDSecurityBatchUpdate_Test
Created Date       : Feb 22, 2025
@description       : This is test class for batch class TWDSecurityBatchUpdate for Security_c object to fetch all records where state is Training Verification and action field with value 'Remove'.The identified records 
					CMPL123Task_Key_Value__c is updated to 123 task value 'remove'.
@author            : Amit
Modification Log:
Ver   Date         Author                               Modification
1.0   22-02-2025   Amit			                         Initial Version
*********************************************************
*/

@isTest
private class TWDSecurityBatchUpdate_Test {
    @testSetup
    static void setupTestData() {
        List<Security__c> securityRecords = new List<Security__c>();
        
        for (Integer i = 0; i < 5; i++) {
            Security__c sec = new Security__c();
            sec.Action__c = 'remove';
            sec.CMPL123_WF_Status__c = 'Training Verification';
            sec.Email_Long__c='1.1@gmail.com';
            securityRecords.add(sec);
        }
        insert securityRecords;
    }
    
    @isTest
    static void testBatchExecution() {
        Test.startTest();
        
        TWDSecurityBatchUpdate batchJob = new TWDSecurityBatchUpdate();
        Database.executeBatch(batchJob, 5);
        
        Test.stopTest();
        
        // Verify the update occurred
        for (Security__c sec : [SELECT CMPL123Task_Key_Value__c FROM Security__c WHERE Action__c = 'remove' AND CMPL123_WF_Status__c = 'Training Verification']) {
            System.assertEquals('remove', sec.CMPL123Task_Key_Value__c, 'CMPL123Task_Key_Value__c should be updated to remove');
        }
    }
}