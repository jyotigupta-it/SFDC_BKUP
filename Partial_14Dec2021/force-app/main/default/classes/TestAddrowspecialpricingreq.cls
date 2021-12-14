@isTest
public class TestAddrowspecialpricingreq 
{
     Static TestMethod Void Addrowspecialpricingreq()
     {
     Profile p=[SELECT Id From Profile WHERE Name='Standard User'];
         User u2 =new User( Alias = 'newUser1' ,
                            Email ='newuser123456@testorg.com',
                            EmailEncodingKey = 'UTF-8',
                            LastName = 'Testing',
                            LanguageLocaleKey='en_US',
                            LocaleSidKey='en_US', 
                            UserName='newuser_Satya@testorg.com',
                            ProfileId=p.Id,
                            TimeZoneSidKey    = 'America/Los_Angeles');

    System.runAs(u2) {
         Test.StartTest();
         //RecordType rt = [SELECT Id,Name FROM RecordType WHERE SobjectType='Account' and Name='Projects' LIMIT 1];
         Account acc = new Account();
         acc.Name= 'Test AccountAAP';
         acc.Type1__c='Commercial';
         acc.No_of_Bathrooms__c=5;
         acc.Contact_Number_Mobile__c='9898969694';
         acc.Order_Status__c='Order Loss';
         //acc.RecordTypeId= rt.Id;
         insert acc;
         
         
         Order__c oc = new Order__c();
         oc.Order_Value__c=10000;
         oc.Projects__c=acc.Id;
         insert oc;
         
        ApexPAges.StandardController scon = new ApexPages.StandardController(acc);
        Addrowspecialpricingreq  testExt = new Addrowspecialpricingreq (scon);
        PageReference pageRef = Page.Specialpricingrequestorder;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        testExt.saveorder();
        testExt.cancelorder();
        testExt.AddRow();
        Test.StopTest();
       
       }
     }
     }