public class TWDDMS_DocumentVersionSharing {

    public static void shareWorkingVersion(List<Id> documentVersionIds) {
        List<SPARTADMS__Document_Version__Share> sharesToInsert = new List<SPARTADMS__Document_Version__Share>();

        // Get all working documents of type SOP
        List<SPARTADMS__Document_Version__c> docs = [
            SELECT Id, OwnerId, SPARTADMS__Version_Status__c, SPARTADMS__Document_Type__c
            FROM SPARTADMS__Document_Version__c
            WHERE Id IN :documentVersionIds
              AND SPARTADMS__Version_Status__c = 'Working'
              AND SPARTADMS__Document_Type__c IN ('Standard Operating Procedure (SOP)')
        ];

        Map<Id, SPARTADMS__Document_Version__c> docMap = new Map<Id, SPARTADMS__Document_Version__c>(docs);

        // Store related Box User IDs
        Set<Id> boxUserIds = new Set<Id>();

        // Map from Document Version to Box Users (Reviewers)
        Map<Id, Set<Id>> docToBoxUsers = new Map<Id, Set<Id>>();

        for (SPARTADMS__Document_Reviewer__c rev : [
            SELECT SPARTADMS__Related_Corporate_Document__c, SPARTADMS__Related_Box_User__c
            FROM SPARTADMS__Document_Reviewer__c
            WHERE SPARTADMS__Related_Corporate_Document__c IN :docMap.keySet()
                  AND SPARTADMS__Related_Box_User__c != null
        ]) {
            Id docId = rev.SPARTADMS__Related_Corporate_Document__c;
            Id boxId = rev.SPARTADMS__Related_Box_User__c;
            boxUserIds.add(boxId);
            if (!docToBoxUsers.containsKey(docId)) {
                docToBoxUsers.put(docId, new Set<Id>());
            }
            docToBoxUsers.get(docId).add(boxId);
        }

        // Map from Document Version to Box Users (Approvers)
        for (SPARTADMS__Document_Approvers__c app : [
            SELECT SPARTADMS__Related_Corporate_Document__c, SPARTADMS__Related_Box_User__c
            FROM SPARTADMS__Document_Approvers__c
            WHERE SPARTADMS__Related_Corporate_Document__c IN :docMap.keySet()
                  AND SPARTADMS__Related_Box_User__c != null
        ]) {
            Id docId = app.SPARTADMS__Related_Corporate_Document__c;
            Id boxId = app.SPARTADMS__Related_Box_User__c;
            boxUserIds.add(boxId);
            if (!docToBoxUsers.containsKey(docId)) {
                docToBoxUsers.put(docId, new Set<Id>());
            }
            docToBoxUsers.get(docId).add(boxId);
        }

        // Query Salesforce User Ids from Box Users
        Map<Id, Id> boxUserToSFUser = new Map<Id, Id>();
        for (SPARTADMS__Box_Users__c boxUser : [
            SELECT Id, SPARTADMS__Related_Salesforce_User__c
            FROM SPARTADMS__Box_Users__c
            WHERE Id IN :boxUserIds
                  AND SPARTADMS__Related_Salesforce_User__c != null
        ]) {
            boxUserToSFUser.put(boxUser.Id, boxUser.SPARTADMS__Related_Salesforce_User__c);
    }

        // Create shares using Salesforce User IDs
        for (Id docId : docMap.keySet()) {
            if (!docToBoxUsers.containsKey(docId)) continue;

            for (Id boxUserId : docToBoxUsers.get(docId)) {
                if (boxUserToSFUser.containsKey(boxUserId)) {
                    Id sfUserId = boxUserToSFUser.get(boxUserId);
                    SPARTADMS__Document_Version__Share shareRec = new SPARTADMS__Document_Version__Share();
                    shareRec.ParentId = docId;
                    shareRec.UserOrGroupId = sfUserId;
                    shareRec.AccessLevel = 'Read';
                    shareRec.RowCause = Schema.SPARTADMS__Document_Version__Share.RowCause.Manual;
                    sharesToInsert.add(shareRec);
                }
            }
        }

        if (!sharesToInsert.isEmpty()) {
            Database.insert(sharesToInsert, false);
        }
    }
}