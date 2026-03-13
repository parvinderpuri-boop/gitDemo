/*
*********************************************************
Apex Trigger Name  : Security_c_123Trigger
Object             : Security - Security__c
Created Date       : Feb 22, 2025
@description       : This is test class for Security_c object trigger.
@author            : Amit
Modification Log:
Ver   Date         Author                               Modification
1.0   22-02-2025   Amit			                         Initial Version
*********************************************************
*/

@isTest
public class Security_c_123TriggerTest {
        @testSetup   
        private static void testSetup() {
            List<Security__c> secList = new List<Security__c>();
            for (Integer i = 0; i < 5; i++) {
                Security__c sec = new Security__c(); // Create a new instance inside the loop
                sec.Short_Description__c = 'Test Security ' + i;
                sec.UserName__c = 'test.apex' + i; // Ensure unique UserName__c
                sec.System__c = 'LabChip';
                sec.Role__c = 'User';
                sec.Email_Long__c = '1.1+' + i + '@gmail.com'; // Ensure unique Email_Long__c
                sec.Action__c = 'Add';
                // sec.Functional_Area_Manager__c = 'Admin';
                sec.Training_Completed__c = 'Yes';
                secList.add(sec);
            }
            insert secList;
        }
    
    
        @IsTest    
    	private static void testUpdateCheck() {
        List<Security__c> secUpdateList = new List<Security__c>();
        secUpdateList=[select id,Short_Description__c,System__c,Role__c,Action__c from Security__c limit 5];      
        for(Security__c sec :secUpdateList)
        {
            sec.System__c='SAP';
            sec.Role__c='IQBO';
        }
        update secUpdateList;
        
        List<Security__c>secNewUpdateList=[select id,Short_Description__c,System__c,Role__c,Action__c from Security__c limit 5];
        for(Security__c updatesec :secNewUpdateList)
        {
            system.assertEquals('SAP',updatesec.System__c);
            system.assertEquals('IQBO',updatesec.Role__c);
        }
        
        }
    
    	@IsTest    
    	private static void testDeleteCheck() {
            
        List<Security__c> deleteList = [select id from Security__c limit 5];
            delete deleteList;
            
        List<Security__c> deleteListCheck = [select id from Security__c where id IN :deleteList];
            system.assertEquals(0,deleteListCheck.size());
            
        }
    
    	@IsTest    
    	private static void testUnDeleteCheck() {
            
        List<Security__c> deleteList = [select id from Security__c limit 5];
            delete deleteList;
            Undelete deleteList;
            
        List<Security__c> deleteListCheck = [select id from Security__c where id IN :deleteList];
            system.assertEquals(5,deleteListCheck.size());
            for(Security__c sec : deleteListCheck)
            {
                system.assertNotEquals(null,sec.Id);
            }
        }
}