@isTest
Public class TestTaskCreatelogacall
{
Static testMethod void testlogaCall()
      {
      Test.StartTest();
      Account a6=new Account();
      a6.Name='Task Account';
      a6.Contact_Number_Mobile__c='9898969694';
      insert a6;
      
      Feedback__c  f0=new Feedback__c ();
      f0.Name='Feedback Test task';
      f0.Account__c=a6.Id;
      f0.Date__c=System.Today();
      f0.Status__c='Wrong Number';
      insert f0;
      
      Task tk=new Task();
      //tk.OwnerId=f0.CreatedById;
      tk.WhatId =f0.Account__c;
      tk.ActivityDate=f0.Date__c;
      tk.Subject= 'Feedback Status - Wrong Number';
      insert tk;
      
      Test.StopTest();
      }
}