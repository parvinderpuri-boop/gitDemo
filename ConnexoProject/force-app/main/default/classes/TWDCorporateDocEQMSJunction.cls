/**
 * Created Date: 2025-06-01
 * Author: [Amit]
 * Version: 1.0
 * Description: Handler class which allows to select DMS records from eqms object and link them back to EQMS record.It runs from action button called 'Link Corporate Documents'.
 * Class Name:TWDCorporateDocEQMSJunction
 * Trigger Name: CMPL123QMS_Change_Control_c_123Trigger
 */

public class TWDCorporateDocEQMSJunction 
{
    @InvocableMethod(label='Link DMS with EQMS record' description='Link Corporate Document Record from EQMS record' )
    public static void DMSEQMSJunctionRecords(List<InputWrapper> inputList){  
        
        if (inputList == null || inputList.isEmpty()) return;
        
        List<SPARTADMS__Corporate_Document__c> documentsToUpdate = new List<SPARTADMS__Corporate_Document__c>();
        
        for (InputWrapper input : inputList) {
            if (input.documents != null && input.recordId != null) {
                for (SPARTADMS__Corporate_Document__c doc : input.documents) {
                    documentsToUpdate.add(new SPARTADMS__Corporate_Document__c(
                        Id = doc.Id,
                        Change_Control__c = input.recordId
                    ));
                }
            }
        }
        
        if (!documentsToUpdate.isEmpty()) {
            try {
                SPARTADMS.DMSGlobalStatic.stopTriggerExecutionContext = true;
                update documentsToUpdate;
            } finally {
                SPARTADMS.DMSGlobalStatic.stopTriggerExecutionContext = false;
            }
        }
        
    }
    
    public class InputWrapper {
        @InvocableVariable(required=true)
        public List<SPARTADMS__Corporate_Document__c> documents;
        
        @InvocableVariable(required=true)
        public Id recordId;
    }    
}