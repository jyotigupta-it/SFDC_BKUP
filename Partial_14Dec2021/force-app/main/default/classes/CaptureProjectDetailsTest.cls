@isTest
public class CaptureProjectDetailsTest {
    @isTest static void test_method_one() {
        
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
        
        
        //System.runas(User1) {    
        /* Influencer_types__c  infCustom = new Influencer_types__c();
infCustom.Type__c='Project Owner/Developer/Builder';
infCustom.Name='Type 5';
insert infCustom;

Influencer_types__c  infCustom2 = new Influencer_types__c();
infCustom2.Type__c='Architect';
infCustom2.Name='Type 3';
insert infCustom2;*/
        
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc = new Account();
        acc.Name='testAcc';
        acc.Contact_Number_Mobile__c = '9765433318';
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        //insert ap;
        
        
        //1st project
        Opportunity opp = new Opportunity();
        opp.Name='TestClass';
        opp.StageName = 'Mockup Process';
        opp.CloseDate =date.TODAY()+10;
        opp.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp.Project_Type__c='Commercial';
        opp.Mixed_Type__c='Malls';
        opp.No_of_Bathrooms__c = 12;
        opp.No_of_Floors__c=5;
        opp.Number_of_kitchens__c=6;
        opp.Number_of_towers__c=1;
        opp.Material_of_Stack__c='SWR';
        opp.Internal_Plumbing_Mix__c='CPVC';
        opp.Dimension_of_the_stack__c='110';
        opp.Project_Area__c=2563;
        opp.Standard_ORC__c=4;
        opp.SWR_system_to_be_deployed__c='Conventional';
        opp.Project_By__c=acc.Id;
        opp.Distributor__c=acc1.Id;
        opp.Special_Pricing_Request_Approval__c='Submitted';
        // opp.Taluk__c=ap.Id;
        opp.Freight__c='FOR';
        opp.Delivery__c='2 weeks';
        opp.Price_Basis__c='FOR Site';
        opp.Delivery_Lots__c='9 Lots';
        opp.Taxes__c='Included';
        opp.Offer_Valid_Till__c='60 Days';
        opp.Payment_Term__c='45 days after delivery';
        opp.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        opp.Order_Placement__c='Contractor';
        opp.GSTN__c = '101010000000000';
        opp.Project_Location__c='Bangalore';
        opp.Street_Address__c='whitefield';
        insert opp;
        
        //inf insertion
        Influencer__c inf = new Influencer__c();
        
        inf.Influencer_Type__c=cus.Type__c;
        //inf.Account__c=acc.Id;
        //inf.Source__c=;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp.Id;
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        
        inf2.Influencer_Type__c=cus1.Type__c;
        //inf2.Account__c=acc.Id;
        // inf2.Source__c='In House';
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp.Id;
        insert inf2;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        PageReference pageRef = Page.AddProjectDetails;
        pageRef.getParameters().put('id',opp.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        CaptureProjectDetails s=new CaptureProjectDetails(sc);
        s.getRequestInformation(opp.id);
        //  CaptureProjectDetails.getAccountInfo('testAcc');
        //  s.projectCategoryVal();
        s.stageBasedInfluencerDetails();
        s.calRender();
        s.cancel();
        s.saveProject();
        s.getTalukDetails();
        
        
    }
    
    @isTest static void test_method_four() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 4
        Opportunity opp2 = new Opportunity();
        //opp.OwnerId=User1.Id;
        opp2.Name='TestClass';
        opp2.StageName = 'Order Receipt';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hdjw';
        opp2.Project_Location__c='gdhw';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        insert inf5;
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //4nd project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //    CaptureProjectDetails.method32();
        
        
    }
    
    // with mockup process-----------
    @isTest static void test_method_fifth() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 5
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Mockup Process';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000'; 
        opp2.Street_Address__c='wjhk';
        opp2.Project_Location__c='gdvhea';
        insert opp2;
        Project_Tracker__c p22= new Project_Tracker__c();
        p22.Opportunity__c=opp2.id;
        insert p22;
        Project_Tracker__c p33= new Project_Tracker__c();
        p33.Opportunity__c=opp2.id;
        insert p33;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        inf.Account__c=acc.id;
        inf.Source__c='In House';
        insert inf;
        
        Influencer__c inf77 = new Influencer__c();
        inf77.Influencer_Type__c=cus5.Type__c;
        inf77.Update_of_Last_Visit__c='trtr';
        inf77.Opportunity__c = opp2.Id;
        inf77.Account__c=acc.id;
        inf77.Source__c='In House';
        insert inf77;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        inf3.Account__c=acc.id;
        inf3.Source__c='In House';
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        inf4.Account__c=acc.id;
        inf4.Source__c='In House';
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        inf5.Account__c=acc.id;
        inf5.Source__c='In House';
        insert inf5;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        inf7.Account__c=acc.id;
        inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        inf6.Account__c=acc.id;
        inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //5th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        
        
        
    }
    @isTest static void test_method_sixth() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        
        //project 5
        Opportunity opp2 = new Opportunity();
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hfje';
        opp2.Project_Location__c='heejh';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        inf2.Source__c='In House';
        inf2.Account__c=acc.id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        inf3.Account__c=acc.id;
        inf3.Source__c='In House';
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        inf4.Account__c=acc.id;
        inf4.Source__c='In House';
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        inf5.Account__c=acc.id;
        inf5.Source__c='In House';
        insert inf5;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        inf7.Account__c=acc.id;
        inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        inf6.Account__c=acc.id;
        inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //   CaptureProjectDetails.method32();
        
        
    }
    @isTest static void test_method_seventh() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 5
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Offer Submitted';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000'; 
        opp2.Project_Location__c='hfvh';
        opp2.Street_Address__c='hedvje';
        insert opp2;
        
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        // inf3.Account__c=acc.id;
        //inf3.Source__c='In House';
        insert inf3;
        
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        
        
        
    }
    @isTest static void test_method_eight() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 8
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Tendering';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';   
        opp2.Project_Location__c='whitefield';
        opp2.Street_Address__c='hfejhf';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        inf.Source__c='In House';
        inf.Account__c=acc.id;
        
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        inf2.Source__c='In House';
        inf2.Account__c=acc.id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        inf3.Account__c=acc.id;
        inf3.Source__c='In House';
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        // inf4.Account__c=acc.id;
        // inf4.Source__c='In House';
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        inf5.Account__c=acc.id;
        inf5.Source__c='In House';
        insert inf5;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        inf7.Account__c=acc.id;
        inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        inf6.Account__c=acc.id;
        inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        
        
        
    }
    @isTest static void test_method_nine() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 8
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Mockup Process';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000'; 
        opp2.Project_Location__c='hjdgj';
        opp2.Street_Address__c='hfbej';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        inf.Source__c='In House';
        inf.Account__c=acc.id;
        
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        inf2.Source__c='In House';
        inf2.Account__c=acc.id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        inf3.Account__c=acc.id;
        inf3.Source__c='In House';
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        inf4.Account__c=acc.id;
        inf4.Source__c='In House';
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        inf5.Account__c=acc.id;
        inf5.Source__c='In House';
        insert inf5;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        // inf7.Account__c=acc.id;
        //  inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        inf6.Account__c=acc.id;
        inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //       CaptureProjectDetails.method32();
        
        
    }
    @isTest static void test_method_tenth() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 8
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Mockup Process';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';   
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        inf.Source__c='In House';
        inf.Account__c=acc.id;
        
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        inf2.Source__c='In House';
        inf2.Account__c=acc.id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        inf3.Account__c=acc.id;
        inf3.Source__c='In House';
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        inf4.Account__c=acc.id;
        inf4.Source__c='In House';
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        inf5.Account__c=acc.id;
        inf5.Source__c='In House';
        insert inf5;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        inf7.Account__c=acc.id;
        inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        // inf6.Account__c=acc.id;
        //inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        s1.codeCoverage();
        
        
    }
    @isTest static void test_method_eleven() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 11
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Mockup Process';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';   
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        inf.Source__c='In House';
        inf.Account__c=acc.id;
        
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        inf2.Source__c='In House';
        inf2.Account__c=acc.id;
        insert inf2;
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=cus3.Type__c;
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp2.Id;
        inf3.Account__c=acc.id;
        inf3.Source__c='In House';
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=cus2.Type__c;
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp2.Id;
        inf4.Account__c=acc.id;
        inf4.Source__c='In House';
        insert inf4;
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus1.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        inf5.Account__c=acc.id;
        inf5.Source__c='In House';
        insert inf5;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        inf7.Account__c=acc.id;
        inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        inf6.Account__c=acc.id;
        inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        
        //    CaptureProjectDetails.method32();
        
    }
    // stage tendering 
    @isTest static void test_method_tender12() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 11
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Tendering';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';  
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        
        Influencer__c inf2 = new Influencer__c();
        inf2.Influencer_Type__c=cus4.Type__c;
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp2.Id;
        // inf2.Source__c='In House';
        //  inf2.Account__c=acc.id;
        insert inf2;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        
        
        
    }
    @isTest static void test_method_tender13() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';

        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 11
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Tendering';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        Influencer__c inf = new Influencer__c();
        inf.Influencer_Type__c=cus5.Type__c;
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp2.Id;
        //   inf.Source__c='In House';
        // inf.Account__c=acc.id;
        
        insert inf;
        
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        
        //  CaptureProjectDetails.method32();
        
    }
    
    @isTest static void test_method_tender14() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 11
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Tendering';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=cus.Type__c;
        //  inf6.Account__c=acc.id;
        // inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //       CaptureProjectDetails.method32();
        
        
    }
    @isTest static void test_method_tender16() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 11
        Opportunity opp2 = new Opportunity();
        opp2.Name='TestClass';
        opp2.StageName = 'Tendering';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';  
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=cus6.Type__c;
        // inf7.Account__c=acc.id;
        // inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp2.Id;
        insert inf7;
        
        
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        //6th project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //     CaptureProjectDetails.method32();
        
        
    }
    
    // designing stage project
    @isTest static void test_method_two() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
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
        insert inf2;
        
        Influencer__c inf1 = new Influencer__c();
        inf1.Influencer_Type__c=cus4.Type__c;
        inf1.Update_of_Last_Visit__c='trtr';
        inf1.Opportunity__c = opp2.Id;
        inf1.Account__c=acc.id;
        inf1.Source__c='In House';
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
        
    }
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        User_Taluk_Master_Junction__c ut = new User_Taluk_Master_Junction__c();
        ut.Name='test';
        insert ut;
        
        
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
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
    @isTest static void test_method_three() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 3
        Opportunity opp2 = new Opportunity();
        //opp.OwnerId=User1.Id;
        opp2.Name='TestClass';
        opp2.StageName = 'Order issue to contractor';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        insert inf5;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        //3rd project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //s1.getsourceInfluPick('Project Manager');
        //   CaptureProjectDetails.method32();
        
    } 
    @isTest static void test_method_orderissue2() {
        
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
        cus4.Type__c='Project Owner/Developer';
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 3
        Opportunity opp2 = new Opportunity();
        //opp.OwnerId=User1.Id;
        opp2.Name='TestClass';
        opp2.StageName = 'Order issue to contractor';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';    
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus6.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        insert inf5;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        //3rd project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //s1.getsourceInfluPick('Project Manager');
        //    CaptureProjectDetails.method32();
        
    } 
    @isTest static void test_method_orderissue3() {
        
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
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Accountant__c='No';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Contact_Number_Mobile__c='6231456879';
        acc1.State__c='Assam';
        acc1.Street_Address__c='test';
        acc1.No_of_Salesmen__c=1;
        acc1.No_of_Vehicles__c=2;
        acc1.Approx_Size_of_shop_in_Sq_ft__c=20;
        acc1.Display_of_our_product__c='Prominent';
        acc1.Media__c='Outshop';
        acc1.Conversion_Probability__c='High';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        
        //project 3
        Opportunity opp2 = new Opportunity();
        //opp.OwnerId=User1.Id;
        opp2.Name='TestClass';
        opp2.StageName = 'Order issue to contractor';
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
        opp2.Dimension_of_the_stack__c='110';
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
        opp2.GSTN__c = '101010000000000';   
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=cus5.Type__c;
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        insert inf5;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp2.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        //3rd project test
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        s1.getRequestInformation(opp2.id);
        CaptureProjectDetails.getAccountInfo('testAcc');
        //s.projectCategoryVal();
        s1.stageBasedInfluencerDetails();
        s1.calRender();
        s1.cancel();
        s1.saveProject();
        s1.getTalukDetails();
        s1.runQuery();
        //s1.getsourceInfluPick('Project Manager');
        //    CaptureProjectDetails.method32();
        
    } 
    @isTest static void test_method_design1() {
        State__c st = new State__C();
        st.Name = 'Karnataka';
        insert st;
        
        District__c dt = new District__C();
        dt.Name = 'Bangalore';
        dt.State__c = st.Id;
        insert dt;
        
        City__c ct = new City__c();
        ct.Name = 'Bangalore South';
        ct.District__c  = dt.Id;
        insert ct; 
        
        Pincode__c pc = new Pincode__c();  
        pc.Name = 'a3U7b000000OIQZEA4';
        pc.City__c = ct.id;
        pc.District__c = dt.id;
        pc.State__c = st.id; 
        insert pc;  
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc = new Account();
        acc.Name='testAcc';
        acc.Contact_Number_Mobile__c = '9765433318';
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Party_Type__c='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Party_Type__c='Builder';
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        //project 2
        Opportunity opp2 = new Opportunity();
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
        opp2.GSTN__c = '101010000000000';
        opp2.Pincode__c = pc.Id;
        opp2.gst_Status_Code__c = 1;
        opp2.Street_Address__c='hegfje';
        opp2.Project_Location__c='hfje';
        insert opp2;
        
        PageReference pageRef1 = Page.AddProjectDetails;
        pageRef1.getParameters().put('id',opp2.id);
        Test.setCurrentPage(pageRef1);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp2);
        CaptureProjectDetails s1=new CaptureProjectDetails(sc1);
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorGSTIN()); 
        s1.stageName = 'Designing';
        
        Test.startTest();
        s1.saveProject();
        s1.validateGSTIN(); 
        s1.getPincodeDetails(); 
        Test.stopTest(); 
    }
}