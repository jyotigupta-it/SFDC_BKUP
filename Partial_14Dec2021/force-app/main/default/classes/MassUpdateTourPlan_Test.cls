@isTest
public class MassUpdateTourPlan_Test {
    static testMethod void MassUpdateTour() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
        User u1 = new User(Alias = 'standt3',Country='India',Email='demo3@kvpdomain.com',EmailEncodingKey='UTF-8', 
                           LastName='KVPTesting3', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',
                           UserName='demo3@kvpdomain.com', EmployeeNumber = '10');
        Insert u1;
        
        Tour_Program__c tp = new Tour_Program__c();
        tp.Tour_Program_Approved__c = true;
        Insert tp;
        MassUpdateTourPlan.fetchTourProgramRecords(tp.Id);
    }
}