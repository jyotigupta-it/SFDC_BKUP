@isTest()
Public Class TestDeleteTasksClass{
    Static TestMethod Void Emailpromotion(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='BD'];
        
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
        
        User usr1 = new User();
        usr1.FirstName = 'TestFirst';
        usr1.LastName = 'Testlast';
        usr1.Email = 'testusr@abc.com';
        usr1.Username = 'test3fs435@mail.com';
        usr1.ManagerId = usr.Id;
        usr1.Alias = 'gd54';
        usr1.ProfileId = p.Id;
        usr1.TimeZoneSidKey = 'America/Los_Angeles';
        usr1.languagelocalekey='en_US';
        usr1.emailencodingkey='UTF-8';
        usr1.localesidkey='en_US';
        insert usr1;
        
        
            Tour_Program__c tr=new Tour_Program__c();
            tr.From_Date__c=date.newinstance(2014, 3, 1);
            tr.To_Date__c=date.newinstance(2014, 3, 15);
            insert tr;



Task t= new Task();
t.OwnerId=usr1.Id;
//t.WhatId=tr.Id;
t.Status='Progress';
t.Subject='call';
t.Priority='High';

insert t;

System.runAs(usr1) {
try
   {
    delete t;
   }
   catch (Exception e) {
   system.debug('You are not authorized to delete tasks');
   // Boolean expectedExceptionThrown =  e.getMessage().contains('You are not authorized to delete tasks') ? true : false;
   //        System.assertEquals(expectedExceptionThrown , true);
       }
       }



}
}