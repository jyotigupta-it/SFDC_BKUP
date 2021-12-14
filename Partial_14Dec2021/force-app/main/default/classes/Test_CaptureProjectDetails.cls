/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :29-Jan-2015
Modified Date   :
Version         :1.0
Description     :Test class for CaptureProjectDetails class

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_CaptureProjectDetails {
    
    

    @isTest static void test_method_one() {
    
    
      Influencer_types__c  infCustom = new Influencer_types__c();
        infCustom.Type__c='Site Engineer';
        infCustom.Name='Type 1';
      
       
        //infCustom.
        insert infCustom;
    
    
    String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
    Account acc = new Account();
    acc.Name='testAcc';
    acc.Contact_Number_Mobile__c = '9765433318';
    acc.recordTypeId = strRecordTypeId;
    acc.Firm_Name__c = 'et';
    insert acc;
    
     AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
     ap.name='Bangalore';
     ap.Cluster__c='qweqwe';
     ap.District__c='bangalore';
     ap.State__c = 'karnataka';
     insert ap;
    
    
      Opportunity opp = new Opportunity();
      opp.Name='TestClass';
      opp.StageName = 'Designing';
      opp.CloseDate =date.TODAY()+10;
      opp.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
      
      opp.Project_Type__c='Commercial';
      opp.No_of_Bathrooms__c = 12;
     
      opp.Project_By__c=acc.Id;
      opp.Special_Pricing_Request_Approval__c='Submitted';
      opp.Taluk__c=ap.Id;
      insert opp;
      
        Influencer__c inf = new Influencer__c();
     
       // inf.Influencer_Type__c='Site Architect';
        inf.Account__c=acc.Id;
        inf.Update_of_Last_Visit__c='trtr';
     inf.Opportunity__c = opp.Id;
        insert inf;
      
    Project_Tracker__c pro = new Project_Tracker__c();  
    pro.Question__c='wewqeqe';
     pro.Response__c='yes';
       pro.Opportunity__c = opp.Id;
               insert pro; 
   
    

    Project_Tracker_Questions__c   projectCustom = new Project_Tracker_Questions__c();
        projectCustom.Question__c='All Product range approved';
        projectCustom.Name='Question 1';
        insert projectCustom;
       
     

            Test.startTest();
               Apexpages.currentPage().getParameters().put('Id',null);
            Apexpages.currentPage().getParameters().put('firstParam','Rs.0 – Rs.5Lakhs');
               ApexPages.StandardController sc = new ApexPages.StandardController(opp );
               CaptureProjectDetails oppController = new CaptureProjectDetails(sc);
              // CaptureProjectDetails.wrapperInfluencer win = new CaptureProjectDetails.wrapperInfluencer();
    
                    //     win.influ=inf;
                      //   oppController.wrapInfuList.add(win);
                         
                         
                         // win.influ.Account__c=acc.id;
                         //  win.influ.Influencer_Type__c='Site Architect';
                           
                         //  win.influ.Update_of_Last_Visit__c='qweq';
                     // opp.No_of_Bathrooms__c = 1;     
                        
             oppController.saveProject();
               CaptureProjectDetails.getAccountInfo('testAcc');
               oppController.projectCategoryVal();
               Apexpages.currentPage().getParameters().put('firstParam','Rs.5Lakhs – Rs.20Lakhs');
               oppController.projectCategoryVal();
               Apexpages.currentPage().getParameters().put('firstParam','Rs.20Lakhs and Above');
               oppController.calRender();
               oppController.cancel();
               oppController.projectCategoryVal();
               oppController.getTalukDetails();
             
               oppController.saveProject();
               oppController.getTalukDetails();
               oppController.opportunityRecord.taluk__c = ap.id ;
               oppController.getTalukDetails();
               oppController.getRequestInformation(opp.id);
              oppController.saveProject();
        		oppController.runQuery();
         
            Test.stopTest();
            
       
    }
    
   
    
}