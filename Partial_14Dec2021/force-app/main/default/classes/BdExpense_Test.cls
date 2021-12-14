@isTest
public class BdExpense_Test {
    static testMethod void BdExpenses() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
        User u1 = new User(Alias = 'standt1',Country='India',Email='demo2@kvpdomain.com',EmailEncodingKey='UTF-8', 
                           LastName='KVPTesting2', LanguageLocaleKey='en_US',LocaleSidKey='en_US',ProfileId = p.Id,TimeZoneSidKey='America/Los_Angeles',
                           UserName='demo2@kvpdomain.com', EmployeeNumber = '10');
        
        Insert u1;
		Tour_Program__c tp = new Tour_Program__c();
        tp.Expenses_Approved__c = true;
        Insert tp;
        BdExpense.fetchprofilename(tp.Id);
    }
}