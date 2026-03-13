public class TWD_ChangeControl_CloseDate {
    public static void handleBeforeInsert(List<CMPL123__WF_History__c> newRecords) {
        Map<Id, CMPL123__WF_History__c> latestPerChangeControl = new Map<Id, CMPL123__WF_History__c>();
        Set<String> userNames = new Set<String>();

        Set<String> excludedNames = new Set<String>{'Amit Kamat', 'Amit Kumar', 'Amit Kamat - External', 'Sparta Admin'};

        // Iterate over workflow history records to find valid ones
        for (CMPL123__WF_History__c wf : newRecords) {
            if (
                wf.CMPL123__Object_API_Name__c == 'CMPL123QMS__Change_Control__c' &&
                wf.CMPL123__Status__c == 'Closed' &&
                wf.CMPL123__Related_Id__c != null &&
                String.isNotBlank(wf.CMPL123__Created_By_User_Name__c)
            ) {
                String trimmedName = wf.CMPL123__Created_By_User_Name__c.trim();

                // Only store first non-excluded WF per Change Control
                if (!excludedNames.contains(trimmedName) &&
                    !latestPerChangeControl.containsKey(wf.CMPL123__Related_Id__c)) {
                    
                    latestPerChangeControl.put(wf.CMPL123__Related_Id__c, wf);
                    userNames.add(trimmedName);
                }
            }
        }

        if (latestPerChangeControl.isEmpty()) return;

        // Map user names to user IDs
        Map<String, Id> userNameToId = new Map<String, Id>();
        for (User u : [
            SELECT Id, Name 
            FROM User 
            WHERE Name IN :userNames
        ]) {
            userNameToId.put(u.Name.trim(), u.Id);
        }

        // Prepare updates
        List<CMPL123QMS__Change_Control__c> updates = new List<CMPL123QMS__Change_Control__c>();
        for (Id ccId : latestPerChangeControl.keySet()) {
            CMPL123__WF_History__c wf = latestPerChangeControl.get(ccId);
            Id userId = userNameToId.get(wf.CMPL123__Created_By_User_Name__c?.trim());

            if (userId != null) {
                updates.add(new CMPL123QMS__Change_Control__c(
                    Id = ccId,
                    TWD_Closed_By__c = userId,
                    TWD_Closed_Date__c = wf.CMPL123__Last_Modified_DateTime__c
                ));
            }
        }

        // Perform update
        if (!updates.isEmpty()) {
            update updates;
        }
    }
}