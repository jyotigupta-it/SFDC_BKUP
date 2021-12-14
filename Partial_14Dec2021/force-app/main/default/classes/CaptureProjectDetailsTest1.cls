@isTest
public class CaptureProjectDetailsTest1 {

     @isTest static void test_method_design2() {
        
        Project_Tracker_Questions__c proCus=new Project_Tracker_Questions__c();
        proCus.Question__c='How';
        proCus.Name='Question 5';
        insert proCus;
        
        Influencer_types__c cus=new Influencer_types__c();
        cus.Type__c='Plumbing Contractor';
        cus.Name='Type 4';
        insert cus;
        
        Influencer_types__c cus1=new Influencer_types__c();
        cus1.Type__c='Site Engineer';
        cus1.Name='Type 1';
        insert cus1;
        
        Influencer_types__c cus2=new Influencer_types__c();
        cus2.Type__c='Project Manager';
        cus2.Name='Type 7';
        insert cus2;
        
        Influencer_types__c cus3=new Influencer_types__c();
        cus3.Type__c='Purchase Manager';
        cus3.Name='Type 6';
        insert cus3;
        
        Influencer_types__c cus4=new Influencer_types__c();
        cus4.Type__c='Project Owner/Developer/Builder';
        cus4.Name='Type 5';
        insert cus4;
        
        Influencer_types__c cus5=new Influencer_types__c();
        cus5.Type__c='Architect';
        cus5.Name='Type 3';
        insert cus5;
        
        Influencer_types__c cus6=new Influencer_types__c();
        cus6.Name='Type 2';
        cus6.Type__c='Consultant';
        insert cus6;
        
        
       
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc = new Account();
        acc.Name='testAcc';
        acc.Contact_Number_Mobile__c = '9765433318';
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='qweqwe';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
         
        
        
        //project 2
        Opportunity opp2 = new Opportunity();
        //opp.OwnerId=User1.Id;
        opp2.Name='TestClass';
        opp2.StageName = 'Designing';
        opp2.CloseDate =date.TODAY()+10;
        opp2.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp2.Project_Type__c='Commercial';
        opp2.Mixed_Type__c='Malls';
        opp2.No_of_Bathrooms__c = 12;
        opp2.No_of_Floors__c=5;
        opp2.Number_of_kitchens__c=6;
        opp2.Number_of_towers__c=1;
        opp2.Material_of_Stack__c='SWR';
        opp2.Internal_Plumbing_Mix__c='CPVC';
        opp2.Dimension_of_the_stack__c='160';
        opp2.Project_Area__c=2563;
        opp2.Standard_ORC__c=4;
        opp2.SWR_system_to_be_deployed__c='Conventional';
        opp2.Project_By__c=acc.Id;
        opp2.Distributor__c=acc1.Id;
        opp2.Special_Pricing_Request_Approval__c='Submitted';
        opp2.Taluk__c=ap.Id;
        opp2.Freight__c='FOR';
        opp2.Delivery__c='2 weeks';
        opp2.Price_Basis__c='FOR Site';
        opp2.Delivery_Lots__c='9 Lots';
        opp2.Taxes__c='Included';
        opp2.Offer_Valid_Till__c='60 Days';
        opp2.Payment_Term__c='45 days after delivery';
        opp2.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        opp2.Order_Placement__c='Contractor';
        insert opp2;
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus5.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
          inf2.Account__c=acc.id;
       inf2.Source__c='In House';
        insert inf2;
     
      Influencer__c inf1 = new Influencer__c();
        inf1.Influencer_Type__c=cus4.Type__c;
        inf1.Update_of_Last_Visit__c='trtr';
        inf1.Opportunity__c = opp2.Id;
       // inf1.Account__c=acc.id;
       // inf1.Source__c='In House';
        insert inf1;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        //2nd project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.stageName = 'Designing';
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        // s1.getsourceInfluPick('Project Manager');
   //     CaptureProjectDetails.method32();
         
          CaptureProjectDetails s12=new CaptureProjectDetails(sc1);
        s12.stageName = 'Tendering';
        s12.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s12.stageBasedInfluencerDetails();
         
          CaptureProjectDetails s123=new CaptureProjectDetails(sc1);
        s123.stageName = 'Order issue to contractor';
        s123.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s123.stageBasedInfluencerDetails();
         
          CaptureProjectDetails s1234=new CaptureProjectDetails(sc1);
        s1234.stageName = 'Mockup Process';
        s1234.getRequestInformation(opp2.id); 
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1234.stageBasedInfluencerDetails();
        
    }
}