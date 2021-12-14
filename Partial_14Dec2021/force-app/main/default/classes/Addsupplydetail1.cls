@isTest(seeAllData=false)
public class Addsupplydetail1
{
    static User u2;
    static Account acc;
    
    static void init() {
        Profile p=[SELECT Id From Profile WHERE Name='Standard User'];
        u2 =new User( Alias = 'newUser1' ,
                            Email ='newuser123@testorget.com',
                            EmailEncodingKey = 'UTF-8',
                            LastName = 'Testing',
                            LanguageLocaleKey='en_US',
                            LocaleSidKey='en_US', 
                            UserName='newuser_Sham@testorgET.com',
                            ProfileId=p.Id,
                            TimeZoneSidKey    = 'America/Los_Angeles');
        insert u2;
        acc = new Account();
        acc.Name= 'Test AccountET';
        acc.Type1__c='Commercial';
        acc.No_of_Bathrooms__c=5;
        acc.Contact_Number_Mobile__c='9898969694';
        acc.Order_Status__c='Order Loss';
        insert acc;
        Order__c order = new Order__c(Projects__c = acc.Id);
        insert order;
        Supply_Detail__c sup = new Supply_Detail__c(Projects__c=acc.Id,Supply_Quantity__c=40);
        insert sup;
    }
    static TestMethod void unitTest() {
        init();
        System.runAs(u2) {
            Test.StartTest();
            ApexPages.StandardController sc = new ApexPages.StandardController(u2);
            
            PageReference pageRef = Page.supplydetail;
            Test.setCurrentPage(pageRef);
            apexpages.currentpage().getparameters().put('id', acc.Id);
            Addsupplydetail testExt = new Addsupplydetail(sc);
            testExt.AddRow();
            testExt.cancelsupplydetail();
            testExt.savesupplydetail();
            Test.StopTest();

        }
        
    }
    /*
     Static TestMethod Void Addsupplydetail()
     {
     Profile p=[SELECT Id From Profile WHERE Name='Standard User'];
         User u2 =new User( Alias = 'newUser1' ,
                            Email ='newuser123@testorg.com',
                            EmailEncodingKey = 'UTF-8',
                            LastName = 'Testing',
                            LanguageLocaleKey='en_US',
                            LocaleSidKey='en_US', 
                            UserName='newuser123_baba@testorg.com',
                            ProfileId=p.Id,
                            TimeZoneSidKey    = 'America/Los_Angeles');

    System.runAs(u2) {
         
         //RecordType rt = [SELECT Id,Name FROM RecordType WHERE SobjectType='Account' and Name='Projects' LIMIT 1];
         Account acc = new Account();
         acc.Name= 'Test Account';
         acc.Type1__c='Commercial';
         acc.No_of_Bathrooms__c=5;
         acc.Contact_Number_Mobile__c='9898969694';
         acc.Order_Status__c='Order Loss';
         //acc.Total_Order_Quantity__c= 100;
         
         
         
         try {
             insert acc;
         }catch(exception e){
             system.debug('@@@@@@@@@@@@@@@@@22'+e);
         }
         
        Supply_Detail__c sc = new Supply_Detail__c();
        sc.Projects__c=acc.Id;
        sc.Supply_Quantity__c=40; 
        insert sc;
        
        Test.StartTest();
        ApexPAges.StandardController scon = new ApexPages.StandardController(acc);
        Addsupplydetail testExt = new Addsupplydetail(scon);
        PageReference pageRef = Page.supplydetail;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        testExt.AddRow();
        testExt.cancelsupplydetail();
        testExt.savesupplydetail();
        Test.StopTest();
          */
          /*
          Addsupplydetail controller=new Addsupplydetail();
          Supply_Detail__c sc1 = new Supply_Detail__c();
         sc1.Projects__c=acc.Id;
         sc1.Supply_Quantity__c=40;
         insert sc1;
        controller.AddRow();
        //controller.Addsupplydetail();
        controller.cancelsupplydetail();
        controller.savesupplydetail();
        */
         /*
       }
     } */
     }