/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:test class for createQuizChatter.
 ****************************************************************************************/ 
@isTest
private class createQuizChatter_UT{
static testMethod void testcreateQuizChattert() {
  Profile profileID = [select id from profile where Name='System Administrator' limit 1];
   User user1 = new User(LastName='XYZq',ProfileId=profileID.Id,Alias='testq',EmailEncodingKey='UTF-8',
                Email='othersq@infosys.com',UserName='othersq@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
  insert user1;
  
  Quiz_Attendee__c q1=new Quiz_Attendee__c(Quiz_Month__c='September - 2015',Quiz_status__c='Completed',Quiz_Attendee__c=user1.id
  ,Percentage__c=95,Quiz_Catagory__c='Plumbing Senior');
  insert q1;
  
  Quiz_Attendee__c q2=new Quiz_Attendee__c(Quiz_Month__c='September - 2015',Quiz_status__c='Completed',Quiz_Attendee__c=user1.id
  ,Percentage__c=95,Quiz_Catagory__c='Agriculture Junior');
  insert q2;
  
  Quiz_Attendee__c q3=new Quiz_Attendee__c(Quiz_Month__c='September - 2015',Quiz_status__c='Completed',Quiz_Attendee__c=user1.id
  ,Percentage__c=95,Quiz_Catagory__c='Agriculture Senior');
  insert q3;
  
  Quiz_Attendee__c q4=new Quiz_Attendee__c(Quiz_Month__c='September - 2015',Quiz_status__c='Completed',Quiz_Attendee__c=user1.id
  ,Percentage__c=95,Quiz_Catagory__c='Plumbing Junior');
  insert q4;
  
  test.starttest();    
  createQuizChatter quizChatter = new createQuizChatter();
  quizChatter.thisMonth='September - 2015';
  quizChatter.chatterpost();
  test.stoptest();
}
}