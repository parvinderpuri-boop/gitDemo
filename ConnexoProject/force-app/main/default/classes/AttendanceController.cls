public with sharing class AttendanceController {
    
    // Method to punch in
    @AuraEnabled
    public static Attendance__c markLogin(Id userId, String ipAddress) {
        // Check if IP is valid (optional, we’ll add logic later)
        
        Attendance__c att = new Attendance__c();
        att.User__c = userId;     // ya Candidate_c use karna hai to change karo
        att.Login_Time__c = System.now();
        att.Status__c = 'Logged In';
        att.IP_Address__c = ipAddress;  // agar field banayi hai to
        insert att;
        return att;
    }
    
    // Method to punch out
    @AuraEnabled
    public static Attendance__c markLogout(Id attId) {
        Attendance__c att = [SELECT Id, Login_Time__c, Logout_Time__c, Total_Hours__c 
                             FROM Attendance__c WHERE Id = :attId LIMIT 1];
        
        att.Logout_Time__c = System.now();
        
        
        att.Status__c = 'Logged Out';
        update att;
        return att;
    }
}