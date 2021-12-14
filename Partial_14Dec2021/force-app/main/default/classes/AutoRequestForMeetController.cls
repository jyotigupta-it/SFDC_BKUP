/*  
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 * File Name  : AutoRequestForMeetController
 * Description: Batch Apex for raising the auto request for BDM's on 2nd of every month
 * Author     : vasanthi K N
 * Modification Log 
 * ===================================================================== 
 * Ver       Date            Author                      Modification 
 * ---------------------------------------------------------------------
 * 1.0    28-Aug-2015       Vasanthi K N                 Initial Code 
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/ 
global class AutoRequestForMeetController implements Database.Batchable<sObject>{

autoRequestBatchHelper helper = new autoRequestBatchHelper();

String currentMonth = helper.getCurrentMonth();
String variable1='Pending';
String variable2 ='Approved';
global String query ='select Mega_Meets_Column__c,Mega_Meets_Plumbing__c,Mega_Meets_Project__c, Mini_Meets_Column__c, Mini_Meets_Plumbing__c, Mini_Meets_Project__c,Approval_Status__c, ownerid, Month__c, Vertical__c from Target__c where (Approval_Status__c =: variable1 or Approval_Status__c =: variable2) and month__c =: currentMonth';

 global  database.QueryLocator start(Database.BatchableContext BC)
    {
        // Initiate the Batch context
       return Database.getQueryLocator(query);
       //return null;      
    }
    global void execute(Database.BatchableContext BC, List<Target__c> scope)
    {
       system.debug('scope::::' + scope);
       helper.executeAutoRequestForMeet(scope);
    }


 global void finish(Database.BatchableContext BC)
    {
       
    } 
}