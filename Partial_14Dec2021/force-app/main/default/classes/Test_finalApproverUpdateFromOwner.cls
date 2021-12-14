/***************************************************
* Name:SudhaMurthy
* Description: Test class for finalApproverUpdateFromOwner to insert project and user
* Trigger:Update_Opp_Records 
* created date :09/04/2018***********************/

@isTest
public class Test_finalApproverUpdateFromOwner{
    
    @isTest static void testmethodappprover(){
        
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last',
            Email = 'puser000@amamama.com',
            Username = 'puser000@amamama.com' + System.currentTimeMillis(),
            CompanyName = 'TEST',
            Title = 'title',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            EmployeeNumber = '10'
        );
        Insert u;
        
        User u1 = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
            LastName = 'last1',
            Email = 'puser000@amamam1a.com',
            Username = 'puser000@amamam1a.com' + System.currentTimeMillis(),
            CompanyName = 'TEST1',
            Title = 'title1',
            Alias = 'alias1',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            Project_Approver__c = u.Id,
            EmployeeNumber = '10'
        );
        Insert u1;
        
        Test.startTest();
        opportunity opp = new opportunity();
        opp.name='test';
        opp.StageName='New';
        opp.Closedate=system.today();
        
        insert opp;
       /* user u1 = new user();
        //u1.name='Pranab mund';
        u1.Project_Approver__c='00530000003mVKn';
        u1.Email='Test@gmail.com';
        u1.Alias='test';
        u1.Username='Test@gmail.com';
        u1.LastName='test';
        insert u1;*/
        opp.Closedate=system.today() + 1;
        update opp;
        Test.stopTest();  
        
    }
}