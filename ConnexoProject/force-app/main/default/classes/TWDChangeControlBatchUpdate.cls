/*
*********************************************************
Apex Trigger Name  : CMPL123QMS__Change_Control__c
Object             : Change Control
Batch Class Name   : TWDChangeControlBatchUpdate
Test class Name    : TWDChangeControlBatchUpdate_Test
Created Date       : Feb 22, 2025
@description       : This is batch class TWDSecurityBatchUpdate for Change Control object to fetch all records where state is Post Approval Action Execution and type !=Emergency Change
					and all actions are closed/cancelled then CMPL123Task_Key_Value__c is updated to 123 task value 'Post Approval Action'.
@author            : Amit
Modification Log:
Ver   Date         Author                               Modification
1.0   11-03-2025   Amit			                         Initial Version
*********************************************************
*/

global class TWDChangeControlBatchUpdate implements Database.Batchable<sObject>,Schedulable  {
global Database.QueryLocator start(Database.BatchableContext BC) {
    return Database.getQueryLocator([
SELECT Id, CMPL123Task_Key_Value__c,CMPL123QMS__Type__c 
        FROM CMPL123QMS__Change_Control__c
        WHERE CMPL123_WF_Status__c = 'Post Approval Action Execution'
        AND batchexecuted__c=false
        AND Id NOT IN (SELECT TWD_Change_Control__c FROM CMPL123__Action__c where CMPL123_WF_Status__c != 'Closed' and CMPL123_WF_Status__c !='Canceled')]);
}
    
global void execute(Database.BatchableContext BC, List<CMPL123QMS__Change_Control__c> scope) {
    Set<Id> changeControlIds = new Set<Id>();
    for (CMPL123QMS__Change_Control__c cc : scope) {
        changeControlIds.add(cc.Id);
    }

    if (!changeControlIds.isEmpty()) {
        Map<Id, CMPL123QMS__Change_Control__c> changeControlMap = new Map<Id, CMPL123QMS__Change_Control__c>(scope);

        List<CMPL123__Action__c> relatedActions = [
            SELECT Id, TWD_Change_Control__c  
            FROM CMPL123__Action__c 
            WHERE TWD_Change_Control__c IN :changeControlIds
        ];

        Set<Id> changeControlWithOpenActions = new Set<Id>();
        for (CMPL123__Action__c action : relatedActions) {
            changeControlWithOpenActions.add(action.TWD_Change_Control__c);
        }

        List<CMPL123QMS__Change_Control__c> updates = new List<CMPL123QMS__Change_Control__c>();
        for (CMPL123QMS__Change_Control__c cc : scope) {
            if (changeControlWithOpenActions.contains(cc.Id)) {
                if (cc.CMPL123QMS__Type__c == 'Emergency Change') {
                    cc.CMPL123Task_Key_Value__c = 'complete';
                    cc.batchexecuted__c=true;
                } else {
                    cc.CMPL123Task_Key_Value__c = 'Post Approval Action';
                    cc.batchexecuted__c=true;
                }
                updates.add(cc);
            }
        }

        if (!updates.isEmpty()) {
            update updates;
        }
    }
}

global void finish(Database.BatchableContext BC) {
}
        // Schedulable interface method
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new TWDChangeControlBatchUpdate(), 200); // You can change batch size as needed
    }
    
}