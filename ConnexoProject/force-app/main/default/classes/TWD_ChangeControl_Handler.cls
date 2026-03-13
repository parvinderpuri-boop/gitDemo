/********************************************************************************************************************
    Author: Amit
	Version: 1.0
	Test class name - CMPL123QMS_Change_Control_123TriggerTest
	Apex handler class - TWD_ChangeControl_Handler
	Test class name - CMPL123QMS_Change_Control_123TriggerTest
*********************************************************************************************************************/

public class TWD_ChangeControl_Handler {

    public static void InsertChangeAssessment(List<CMPL123QMS__Change_Control__c> newRecords) {
        
        List<CMPL123QMS__Change_Assessment__c> childRecordsToInsert = new List<CMPL123QMS__Change_Assessment__c>();
        
        for (CMPL123QMS__Change_Control__c parentRecord : newRecords) {
            if (parentRecord.CMPL123_WF_Status__c == 'Under Assessment') {
                List<String> departmentValues = (parentRecord.TWD_Department__c != null) 
                    ? parentRecord.TWD_Department__c.split(';') 
                    : new List<String>();
                
                Map<String, CMPL123QMS__Change_Assessment__c> existingChildRecordsMap = new Map<String, CMPL123QMS__Change_Assessment__c>();
                if (!departmentValues.isEmpty()) {
                    List<CMPL123QMS__Change_Assessment__c> existingChildRecords = [
                        SELECT Id, CMPL123QMS__Department__c 
                        FROM CMPL123QMS__Change_Assessment__c 
                        WHERE CMPL123QMS__Change_Control__c = :parentRecord.Id 
                          AND CMPL123QMS__Department__c IN :departmentValues
                    ];
                    
                    for (CMPL123QMS__Change_Assessment__c record : existingChildRecords) {
                        existingChildRecordsMap.put(record.CMPL123QMS__Department__c, record);
                    }
                }
                
                for (String department : departmentValues) {
                    if (!existingChildRecordsMap.containsKey(department)) {
                        CMPL123QMS__Change_Assessment__c childRecord = new CMPL123QMS__Change_Assessment__c();
                        childRecord.CMPL123QMS__Change_Control__c = parentRecord.Id;
                        childRecord.CMPL123QMS__Department__c = department;
                        childRecord.Department_Other__c = parentRecord.Department_Other__c;
                        childRecord.Assigned_To_Area__c = parentRecord.Assigned_To_Area__c;
                        childRecord.CMPL123QMS__Assigned_To__c = parentRecord.OwnerId;
                        
                        childRecordsToInsert.add(childRecord);
                    }
                }
            }
        }
        
        if (!childRecordsToInsert.isEmpty()) {
            insert childRecordsToInsert;
        }
    }
}