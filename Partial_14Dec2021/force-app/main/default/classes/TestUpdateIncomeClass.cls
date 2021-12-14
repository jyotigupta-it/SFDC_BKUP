@isTest


    Public Class TestUpdateIncomeClass
    {
    
    Static TestMethod Void UpdateIncomeClass()
    {
     Test.StartTest();
    
       Tour_Program__c tr=new Tour_Program__c();
            tr.From_Date__c=date.newinstance(2014, 3, 1);
             tr.To_Date__c=date.newinstance(2014, 3, 15);
       insert tr;
       
       List<Tour_Plan1__c > TourPlan=new List<Tour_Plan1__c >();
       
       Tour_Plan1__c tp=new Tour_Plan1__c();
       tp.Name='Tour Palan';
       tp.Tour_Program__c=tr.id;
       
       insert tp;
       update tp;
       
       TourPlan.add(tp);
       update TourPlan;
       
       Test.StopTest();
       
       
        PageReference pageRef = Page.TLTourPlan;
          Test.setCurrentPage(pageRef);
          pageRef.setredirect(true);
          pageRef.getParameters().put('id',tr.id);
          
        UpdateIncomeClass npm = new UpdateIncomeClass (new ApexPages.StandardController(tr)); 
        npm.Autorun();
        npm.getplans1();
        npm.GetID();
        npm.UpdateRecords();        
       }
    }