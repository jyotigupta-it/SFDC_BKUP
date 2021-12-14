@isTest(seeAllData=false)
Public Class TestAccountshareClass{
    Static TestMethod Void Accountshare(){
    Profile p = [SELECT Id FROM Profile WHERE Name='BD'];
   id  recordTypeId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Distributor'].id;  
        User usr = new User();
        usr.FirstName = 'TestFirst';
        usr.LastName = 'Testlast';
        usr.Email = 'testusr3@abc.com';
        usr.Username = 'test3435@mail.in';
        usr.Alias = 'gd34';
        usr.ProfileId = p.Id;
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        usr.languagelocalekey='en_US';
        usr.emailencodingkey='UTF-8';
        usr.localesidkey='en_US';
        insert usr;        
    Account acc2 = new Account();
         acc2.Name= 'Test Account26565';
         acc2.Type1__c='Distributor';
         acc2.No_of_Bathrooms__c=78;
         acc2.Contact_Number_Mobile__c='8787878787';
         acc2.RecordTypeId=recordTypeId  ;
        // acc2.ParentId = acc2.id;
        // acc.Order_Status__c='Order Loss';
      insert acc2;
      Test.StartTest();      
    Account acc = new Account();
         acc.Name= 'Test Account';
         acc.Type1__c='Distributor';
         acc.No_of_Bathrooms__c=98;
         acc.Contact_Number_Mobile__c='9746466143';
         acc.ParentId = acc2.id;
        // acc.Order_Status__c='Order Loss';
      insert acc;
     // acc = [SELECT id,Name,ParentId FROM Account WHERE id =: acc.id];    
     // System.AssertEquals(acc2.id ,acc.ParentId);              
         AccountShare share = new AccountShare();
                share.AccountId = acc.Id;
                share.UserOrGroupId =usr.id;
                share.AccountAccessLevel= 'Edit';
                share.OpportunityAccessLevel='Edit';
                insert share;
                update share;
                                
                Account acc1 = new Account();
         acc1.Name= 'Test Account11';
         acc1.Type1__c='Commercial';
         acc1.No_of_Bathrooms__c=7676;
         acc1.Contact_Number_Mobile__c='8095541601';
         acc1.ParentId = acc2.id;
         //acc1.Order_Status__c='Order Loss';
         
             insert acc1;
             update acc1;
           //  acc1 = [SELECT id,Name,ParentId FROM Account WHERE id =: acc1.id]; 
       // System.AssertEquals(acc2.id,acc1.ParentId ); 
    
       
         AccountShare share1 = new AccountShare();
                share1.AccountId = acc1.Id;
                share1.UserOrGroupId =usr.id;
                share1.AccountAccessLevel= 'Edit';
                share1.OpportunityAccessLevel='Edit';
                insert share1;
                update share1; 
                
         Share__c sh = new Share__c();
          sh.Account__c = acc2.Id;
          sh.Account_Access__c = 'Read';
          sh.User__c = usr.Id;
          
          Insert sh;
          update sh;   
          Test.StopTest();  
    }
    
    // Test method for class ToPopulateOrderValue 
    
    Public static TestMethod void test1(){




Task tasklist=new Task();
tasklist.OwnerId=UserInfo.getUserId();//'00530000007uDS6AAM';
tasklist.ActivityDate=Date.Today();

tasklist.RecordTypeId='01230000001DIvX';
tasklist.WhatId='a014C000000dJVmQAM';
tasklist.Order_value__c=123;

//Task tasklist1=[Select Owner.name,Order_value__c,ActivityDate,What.type ,RecordType.Name From Task where RecordType.Name='Normal' AND Order_value__c!=null AND What.type='Enquiry__c' limit 1];

Target__c newTarget =new Target__c();
newTarget.OwnerId=UserInfo.getUserId();//'00530000007uDS6AAM';
newTarget.End_Date__c=Date.Today();
newTarget.End_Date__c.addDays(37);
newTarget.Order_value_from_task__c =6;
test.StartTest();
try{
insert tasklist;
insert newTarget ;
system.debug('Target'+newTarget );
system.debug('Task'+tasklist);
ToPopulateOrderValueFromTask obj =new ToPopulateOrderValueFromTask();
Database.executeBatch(obj);
system.debug(Database.executeBatch(obj));
}
catch(Exception exs){
System.debug(exs.getMessage());
}
test.StopTest();
}
    
    }