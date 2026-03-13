public class CorporateDocumentFlow 
{
@InvocableMethod(label='Update DMS Record' description='adhoc update DMS record fields ' )
    public static void updateDMSRecords(List<SPARTADMS__Corporate_Document__c> cdId)
    
    {	
      //  system.debug('the new values available are:'+cdId.Name);
        //system.debug('the new values available are:'+cdId);
        
        SPARTADMS.DMSGlobalStatic.stopTriggerExecutionContext = true;
        update cdid;

        /*SET<string> st =new SET<string>();
        for(SPARTADMS__Corporate_Document__c str : cdId)
            
        {
            st.add(str.id);
        }
        //SPARTADMS__Corporate_Document__c upd = new SPARTADMS__Corporate_Document__c();
        SPARTADMS__Corporate_Document__c cd = [SELECT Id, Name , Security_Group__c FROM SPARTADMS__Corporate_Document__c WHERE Id IN :st LIMIT 1];
       system.debug('cd::::::'+cd);
        
        cd.Name = cd.Name;
        cd.Security_Group__c = cd.Security_Group__c; */
        //UPDATE cd;                 
    }    
}