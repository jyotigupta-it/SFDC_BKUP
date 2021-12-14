@isTest
Public Class TestDisplayTourPlansClass 
{
    Static TestMethod Void DisplayTourPlansClass()
    {
        Test.StartTest();
            
            Tour_Program__c tpg=new Tour_Program__c();
              tpg.From_Date__c=date.newinstance(2010,1,1);  
              tpg.To_Date__c=date.newinstance(2010,1,15);
            insert tpg;
            
            Tour_Plan1__c tp=new Tour_Plan1__c();
              tp.Name='sssss';
              tp.Tour_Program__c=tpg.id;
            insert tp;
            
            PageReference pageRef = Page.DisplayTourPlans;
              Test.setCurrentPage(pageRef);
              pageRef.setredirect(true);
              pageRef .getParameters().put('id',tpg.id);
              
            DisplayTourPlansClass t= new DisplayTourPlansClass(new ApexPages.StandardController(tpg));   
        Test.StopTest();
    } 
}