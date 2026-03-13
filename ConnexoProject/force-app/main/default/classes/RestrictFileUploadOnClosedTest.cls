/*
*********************************************************
Apex Trigger Name  : RestrictFileUploadOnClosed
Apex Test class name: RestrictFileUploadOnClosedTest
Object             : CMPL123QMS__Deviation__c
Created Date       : April 05 , 2025
@description       : This is trigger for object ContentDocumentLink to manage files upload allowed for certain public group users in state closed.
@author            : Amit
Modification Log:
Ver   Date         Author                               Modification
1.0   05-04-2025   Amit			                         Initial Version
*********************************************************
*/

@IsTest
public class RestrictFileUploadOnClosedTest {
    
    private static User createTestUser(Boolean addToAllowedGroup) {
        Profile prof = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        
        String orgId = UserInfo.getOrganizationId();
        String dateString =
            String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tempUser = new User(
            FirstName = 'Test',
            LastName = 'File',
            email = uniqueName + '@sfdc' + orgId + '.org',
            Username = uniqueName + '@sfdc' + orgId + '.org',
            EmailEncodingKey = 'ISO-8859-1',
            Alias = uniqueName.substring(18, 23),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            ProfileId = prof.Id
        );
        insert tempUser;
        
        if (addToAllowedGroup) {
            Group grup = new Group(Name = 'TestAllowedGroup', Type = 'Regular');
            insert grup;
            
            GroupMember groupmember = new GroupMember(UserOrGroupId = tempUser.Id, GroupId = grup.Id);
            insert groupmember;
            
            
        }
        
        return tempUser;
    }
    
    private static void createAndTestUpload(String objectPrefix, String status, Boolean shouldThrowError, Boolean isUserInAllowedGroup) {
        User testUser = createTestUser(isUserInAllowedGroup);
        
        SObject record;
        switch on objectPrefix {
            when 'a1f' {
                record = new CMPL123QMS__Deviation__c(CMPL123_WF_Status__c = status);
            }
            when 'a1X' {
                record = new CMPL123QMS__CAPA__c(CMPL123_WF_Status__c = status);
            }
            when 'a1b' {
                record = new CMPL123QMS__Change_Control__c(CMPL123_WF_Status__c = status, TWD_Short_Description__c = 'Test');
            }
            when 'a27' {
                record = new CMPL123QMS__Stand_Alone_CAPA__c(CMPL123QMS__CMPL123_WF_Status__c = status, CMPL123QMS__Short_Description__c = 'Test', CMPL123QMS__CAPA_Type__c = 'Corrective Action');
            }
        }
        
        
        System.runAs(testUser) {
            insert record;
            
            ContentVersion cv = new ContentVersion(
                Title = 'Test File',
                PathOnClient = 'testfile.txt',
                VersionData = Blob.valueOf('Test content')
            );
            insert cv;
            
            cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];
            
            ContentDocumentLink cdl = new ContentDocumentLink(
                ContentDocumentId = cv.ContentDocumentId,
                LinkedEntityId = record.Id,
                ShareType = 'V',
                Visibility = 'AllUsers'
            );
            
            if (shouldThrowError) {
                try {
                    insert cdl;
                    System.assert(false, 'Upload should have failed due to Closed status.');
                } catch (DmlException e) {
                    System.assert(e.getMessage().contains('not allowed to attach files'), 'Unexpected error: ' + e.getMessage());
                }
            } else {
                insert cdl;
                System.assertNotEquals(null, cdl.Id, 'Upload should be allowed.');
            }
        }
        
    }
    
    
    @isTest
    static void testUploadBehavior() {
        
        Test.startTest();
        createAndTestUpload('a1f', 'Open',false ,false);
        createAndTestUpload('a1X', 'Closed',true,false);
        createAndTestUpload('a1b', 'Open',false ,true);
        createAndTestUpload('a27', 'Open',false,false);
        Test.stopTest();
    }
    
    
    
}