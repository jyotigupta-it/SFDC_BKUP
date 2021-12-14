@isTest
Public Class TestTourProgramClass
{
    Static TestMethod Void TourProgram()
    {
        Test.StartTest();
        
        Profile p = [SELECT Id, Name FROM Profile Where Name='System Administrator'];
        User u = new User(Alias = 'st', Email='padmini@testorg.com', 
                              EmailEncodingKey='UTF-8', LastName='ashirvad123', LanguageLocaleKey='en_US', 
                              LocaleSidKey='en_US', ProfileId = p.Id, 
                              TimeZoneSidKey='America/Los_Angeles', UserName='ashirvad123@padmini.com');
          insert u;  
            
            Tour_Program__c t=new Tour_Program__c();            
             t.From_Date__c=date.newinstance(2014, 1, 1);
             t.To_Date__c=date.newinstance(2014, 1, 15);
             t.OwnerId=u.id;
            insert t; 
            
           Tour_Plan1__c tp=new  Tour_Plan1__c();
            tp.Name='tour plan1'; 
            tp.Tour_Program__c=t.id;
            tp.Date__c=System.Today();
            tp.State__c='Assam';
            
           insert tp;
           
         PageReference pageRef = Page.TourProgram;
          Test.setCurrentPage(pageRef);
          pageRef.setredirect(true);
          pageRef .getParameters().put('id',t.id);
          
        TorProgramClass atc = new TorProgramClass (new ApexPages.StandardController(t));   
            
        Test.StopTest();
    }
}