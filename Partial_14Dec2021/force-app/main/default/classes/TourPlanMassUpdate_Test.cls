@isTest
public class TourPlanMassUpdate_Test {
    static testMethod void tourPlan() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
        User u1 = new User(Alias = 'standt1',Country='India',Email='demo1@kvpdomain.com',EmailEncodingKey='UTF-8', 
                           LastName='KVPTesting', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',
                           UserName='demo1@kvpdomain.com', EmployeeNumber = '10');
        
        Insert u1;
        Tour_Program__c tp = new Tour_Program__c();
        tp.Tour_Program_Approved__c = true;
        
        Insert tp;
       // TourPlanMassUpdate tpms = new TourPlanMassUpdate();
        TourPlanMassUpdate.fetchMassupdateTP(tp.Id);
    }
}