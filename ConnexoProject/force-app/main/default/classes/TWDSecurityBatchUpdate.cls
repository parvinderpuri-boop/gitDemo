/*
*********************************************************
Apex Trigger Name  : Security_c_123Trigger
Object             : Security - Security__c
Created Date       : Feb 22, 2025
@description       : This is batch class for Security_c object to fetch all records where state is Training Verification and action field with value 'Remove'.The identified records 
					CMPL123Task_Key_Value__c is updated to 123 task value 'remove'.
@author            : Amit
Modification Log:
Ver   Date         Author                               Modification
1.0   22-02-2025   Amit			                         Initial Version
*********************************************************
*/

global class TWDSecurityBatchUpdate implements Database.Batchable<SObject> {
        
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([
            SELECT Id FROM Security__c 
            WHERE Action__c = 'remove'  
            AND CMPL123_WF_Status__c = 'Process Owner Review']);
    }
    
    global void execute(Database.BatchableContext BC, List<Security__c> scope) {
        for (Security__c sec : scope) {
            sec.CMPL123Task_Key_Value__c = 'remove';
        }
        update scope;
    }
    
    global void finish(Database.BatchableContext BC) {
        System.debug('Batch Process Completed.');
    }
}