@isTest
public class ProjDetailOverrideControllerTest {
    @isTest static void test_method_one() {
        
        New_Special_Pricing_Request__c newPricing = new New_Special_Pricing_Request__c();
        
        Project_Tracker_Questions__c proCus=new Project_Tracker_Questions__c();
        proCus.Question__c='How';
        proCus.Name='Question 5';
        insert proCus;
        
        User us2=new User();
        us2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'System Administrator'].Id;
        us2.LastName='username1';
        us2.Email='username1@av.com';
        us2.Username='username1@av.com'+ System.currentTimeMillis();
        us2.CompanyName='Test';
        us2.TimeZoneSidKey='Asia/Kolkata';
        us2.Title='title';
        us2.Alias='use1';
        us2.LanguageLocaleKey='en_US';
        us2.EmailEncodingKey='UTF-8';
        us2.LocaleSidKey='en_IN';
        us2.IsActive=true;
        us2.Create_Attendance__c=true;
        us2.EmployeeNumber = 'Test1';
        insert us2;
        
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username122';
        User1.Email='bogala.meganath@ashirvad.com';
        User1.Username='username12@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true;
        User1.EmployeeNumber = 'Test1';
        User1.ManagerId=us2.Id;
        user1.Intial_Project_Approver__c=us2.Id;
        user1.Vertical_Type__c='Projects';
        insert User1;
        
        User User2=new User();
        User2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User2.LastName='username1221';
        User2.Email='user.meganath@ashirvad.com';
        User2.Username='username12@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User2.TimeZoneSidKey='Asia/Kolkata';
        User2.Title='title';
        User2.Alias='use11';
        User2.EmailEncodingKey='UTF-8';
        User2.LanguageLocaleKey='en_US';
        User2.LocaleSidKey='en_IN';
        User2.IsActive=true;
        User2.Create_Attendance__c=true;
        User2.EmployeeNumber = 'Test1';
        User2.ManagerId=us2.Id;
        user2.Intial_Project_Approver__c=us2.Id;
        user2.Vertical_Type__c='Plumbing';
        insert User2;
        
        //  System.runas(User1) {    
        Influencer_types__c  infCustom = new Influencer_types__c();
        infCustom.Type__c='Project Owner/Developer';
        infCustom.Name='Type 5';
        insert infCustom;
        
        Influencer_types__c  infCustom2 = new Influencer_types__c();
        infCustom2.Type__c='Architect';
        infCustom2.Name='Type 3';
        insert infCustom2;
        
        
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc = new Account();
        acc.Name='testAcc';
        acc.Contact_Number_Mobile__c = '9765433318';
        //acc.Email__c='sss@gmail.com';
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Accountant__c='No';
        acc.Party_Type__c ='Builder';
        acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.Email_Id__c='sss@gmail.com';
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
        acc1.Products__c='Air Admittance Valve';
        acc1.Business_Line__c='column';
        acc1.Year_Since_in_Business__c='2015';
        
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Blr Zone';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        
        //1st project
        Opportunity opp = new Opportunity();
        opp.OwnerId=User1.Id;
        opp.Name='TestClass';
        opp.StageName = 'Designing';
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
        opp.Taluk__c=ap.Id;
        opp.Freight__c='FOR';
        opp.Delivery__c='2 weeks';
        opp.Price_Basis__c='FOR Site';
        opp.Delivery_Lots__c='9 Lots';
        opp.Taxes__c='Included';
        opp.Offer_Valid_Till__c='60 Days';
        opp.Payment_Term__c='45 days after delivery';
        opp.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        opp.Order_Placement__c='Contractor';
        opp.BlazeMaster__c='No';
        opp.GSTN__c = '101010000000000';
        opp.Probability_New__c = '60%';
        opp.Street_Address__c ='whitefield';
        opp.Project_Location__c='Bangalore';
        insert opp;
        
           Opportunity opp1 = new Opportunity();
        opp1.OwnerId=User2.Id;
        opp1.Name='TestClass2';
        opp1.StageName = 'Designing';
        opp1.CloseDate =date.TODAY()+10;
        opp1.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp1.Project_Type__c='Commercial';
        opp1.Mixed_Type__c='Malls';
        opp1.No_of_Bathrooms__c = 12;
        opp1.No_of_Floors__c=5;
        opp1.Number_of_kitchens__c=6;
        opp1.Number_of_towers__c=1;
        opp1.Material_of_Stack__c='SWR';
        opp1.Internal_Plumbing_Mix__c='CPVC';
        opp1.Dimension_of_the_stack__c='110';
        opp1.Project_Area__c=2563;
        opp1.Standard_ORC__c=4;
        opp1.SWR_system_to_be_deployed__c='Conventional';
        opp1.Project_By__c=acc.Id;
        opp1.Distributor__c=acc1.Id;
        opp1.Special_Pricing_Request_Approval__c='Submitted';
        opp1.Taluk__c=ap.Id;
        opp1.Freight__c='FOR';
        opp1.Delivery__c='2 weeks';
        opp1.Price_Basis__c='FOR Site';
        opp1.Delivery_Lots__c='9 Lots';
        opp1.Taxes__c='Included';
        opp1.Offer_Valid_Till__c='60 Days';
        opp1.Payment_Term__c='45 days after delivery';
        opp1.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        opp1.Order_Placement__c='Contractor';
        opp1.BlazeMaster__c='No';
        opp1.HDPE__c='No';
        opp1.GSTN__c = '101010000000000';
        opp1.Street_Address__c ='whitefield';
        opp1.Project_Location__c='Bangalore';
        insert opp1;
        
        //inf insertion
        Influencer__c inf = new Influencer__c();
        
        inf.Influencer_Type__c=infCustom.Type__c;
        inf.Account__c=acc.Id;
        inf.Source__c='In House';
        inf.Update_of_Last_Visit__c='trtr';
        inf.Opportunity__c = opp.Id;
        insert inf;
        
        Influencer__c inf2 = new Influencer__c();
        
        inf2.Influencer_Type__c=infCustom2.Type__c;
        inf2.Account__c=acc.Id;
        inf2.Source__c='In House';
        inf2.Update_of_Last_Visit__c='trtr';
        inf2.Opportunity__c = opp.Id;
        insert inf2;
        
        Project_Tracker__c proTrack=new Project_Tracker__c();
        proTrack.Opportunity__c=opp.id;
        proTrack.Question__c='how';
        insert proTrack;
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='Aqualife';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Send_for_SPR__c=true;
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3; 
        
        New_Offer_Section__c newOff4=new New_Offer_Section__c();
        newOff4.Product_Name__c='Aqualife';
        newOff4.MRP_Value__c=56000;
        newOff4.APPL__c=15;
        newOff4.Extra_Discount__c=6;
        newOff4.Project__c=opp.Id;
        newOff4.Lost_to_brand__c='ACO';
        newOff4.Send_for_SPR__c=true;
        newOff4.Product_Status__c='Loss';
        newOff4.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff4; 
        
        
        Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Approved';
        un.L1_Approver__c = user1.id;
        un.L2_Approver__c = user1.id;
        un.Approval_date__c = date.today();
        insert un;
        List<Unique_SPR__c> unlist=new list<Unique_SPR__c>(); 
        unlist.add(un);
        
        New_Special_Pricing_Request__c newspr=new New_Special_Pricing_Request__c();
        newspr.Product_name__c='Concealed Valves';
        newspr.MRP_Value__c=56000;
        newspr.APPL__c=15;
        newspr.Unique_SPR__c=un.Id;
        newspr.Project__c=opp.id;
        newspr.Competitors_name__c = 'ACO';
        insert newspr;
        
        New_Special_Pricing_Request__c newspr1=new New_Special_Pricing_Request__c();
        newspr1.Product_name__c='Concealed Valves';
        newspr1.MRP_Value__c=56000;
        newspr1.APPL__c=15;
        newspr1.Unique_SPR__c=un.Id;
        newspr1.Project__c=opp.id;
        newspr1.Product_Status__c='Loss';
        newspr1.Competitors_name__c = 'ACO';
        insert newspr1;
        List<New_Special_Pricing_Request__c> nlist=new List<New_Special_Pricing_Request__c>();
        nlist.add(newspr1);
        nlist.add(newspr);
        Approval.ProcessResult result=null;
        Approval.ProcessResult result2=null;
        System.runas(User1) {  
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Submitting request for approval');
            req.setObjectId(un.Id);
            result = Approval.process(req);
            
            
            
        }
        List<Id> newWorkItemIds = result.getNewWorkitemIds();
        
        // Instantiate the new ProcessWorkitemRequest object and populate it
        Approval.ProcessWorkitemRequest req2 = 
            new Approval.ProcessWorkitemRequest();
        req2.setComments('Approving request.');
        req2.setAction('Approve');
        req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
        req2.setWorkitemId(newWorkItemIds.get(0));
        result2 = Approval.process(req2);
        
        New_Order__c orderObj=new New_Order__c();
        orderObj.Order_Number__c=1;
        orderObj.Project__c=opp.Id;
        orderObj.Account__c=acc1.Id;// it should be project by--check with clientt
        insert orderObj;
        
        New_Order__c orderObj1=new New_Order__c();
        orderObj1.Order_Number__c=2;
        orderObj1.Project__c=opp.Id;
        orderObj1.Account__c=acc1.Id;// it should be project by--check with clientt
        insert orderObj1;
        
        Order_Line_Item__c oli=new Order_Line_Item__c();
        
        oli.Product_Name__c='CPVC';
        oli.New_Order__c=orderObj.Id;
        oli.Project__c=opp.Id;
        oli.Distributor__c=acc1.Id;
        oli.Competitors_name__c='Astral'; //Competitor's Name
        oli.Supply_Start_Date__c=system.today(); //Delivery Start Date
        oli.ORC_MARGIN_TO_DLR_DIST__c =5; //ORC
        oli.Payment_Terms__c = '100% advance with PO'; //Payment Terms
        oli.ORC_Markup__c='2';
        oli.Product_Name__c='CPVC';
        oli.Extra_Discount__c=5;
        oli.MRP_Post_Discount__c=400;
        oli.APPL__c=23;
        oli.MRP_Value__c=500;
        oli.Offer_Probability__c='80%' ;
        oli.Tentative_Order_Date__c=system.today(); 
        oli.Price_List_Date__c=system.today(); 
        oli.Validity_for_the_Price__c=system.today(); 
        insert oli;
        
        Supply__c supply=new Supply__c();
        supply.New_Order__c=orderObj.Id;
        supply.Project__c=opp.Id;
        insert supply;
        
        SupplyLineItem__c sli=new SupplyLineItem__c();
        sli.Project__c=opp.Id;
        sli.SupplyDetails__c=supply.Id;
        sli.Product_name__c='CPVC'; //product from ORDER to SUPPLY
        sli.Distributor_Name__c=acc1.id;
        
        insert sli;
         pagereference pg=new pagereference('/apex/EmailToCustomerVF?projectId='+opp.Id);
            pg.getParameters().put('projectId',opp.Id);
        Blob pdf;
        pdf=blob.valueOf('hiii');
    // pdf=pg.getContentAsPDF();
         List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>(); 
          Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName('SpecialPricingRequest_Distributor.pdf');
            efa.setContentType('application/pdf');
            efa.setBody(pdf);     
         String ccaddressEmails='suryapriya.s@kvpcorp.com,username1@av.com';
        String[] toAddresses=ccaddressEmails.split(',');
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(toAddresses); 
           // email.setCcAddresses(toAddresses);
          //email.setHtmlBody('hii');
            email.setSubject('-Approved SPRs');
            email.setHtmlBody('Dear'+'user'+','+'<br/>' +'<br/>' +'Special Pricing Request for '+' '+'project has been approved.'+'<br/>'+'PDF is attached to the Email that contains a detail information of Project. '+'<br/>'+'<br/>'+'<br/>'+'<br/>'+'Thank You'+'<br/>'+UserInfo.getName()); 
            email.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            emails.add(email);
            Messaging.sendEmail(emails);

        PageReference pageRef1 = Page.ProjectDetailPageOverride;
        pageRef1.getParameters().put('id',opp.id);
        Test.setCurrentPage(pageRef1);

        ApexPages.StandardController sc1 = new ApexPages.StandardController(opp);
        ProjDetailOverride_Controller s1=new ProjDetailOverride_Controller(sc1);
        s1.oppId = opp.Id;
            s1.unsprId = un.Id;
      
        s1.approvalActions();
        s1.getOrderLossProducts();
       // s1.getOfferListPro();
        s1.getProjectTrackerList();
        s1.uniqueSprOfferId=un.id;
        s1.UniuesprIdMethod();
        // s1.getOrderListPro();
        s1.emailCustomer();
        s1.emailDP();
        s1.generateOrder();
        s1.orderList1[0].generateSupplyOnClick = true;
        s1.generateSupply();
        s1.getSupplyListPro();
        s1.offerPdf();
        s1.getInfluencerList();
        s1.editInfluencer();
        s1.editProjectTrack();
        s1.pagref();
        
         PageReference pageRef2 = Page.ProjectDetailPageOverride;
        pageRef2.getParameters().put('id',opp1.id);
        Test.setCurrentPage(pageRef2);
       ApexPages.StandardController sc2 = new ApexPages.StandardController(opp1);
        ProjDetailOverride_Controller s2=new ProjDetailOverride_Controller(sc2);
        s2.oppId = opp1.Id;
            s2.unsprId = un.Id;
      
        s2.approvalActions();
        s2.getOrderLossProducts();
       // s1.getOfferListPro();
        s2.getProjectTrackerList();
        s2.uniqueSprOfferId=un.id;
        s2.UniuesprIdMethod();
        // s1.getOrderListPro();
        s2.emailCustomer();
        s2.emailDP();
        s2.generateOrder();
        //s2.orderList1[1].generateSupplyOnClick = true;
        s2.generateSupply();
        s2.getSupplyListPro();
        s2.offerPdf();
        s2.getInfluencerList();
        s2.editInfluencer();
        s2.editProjectTrack();
        s2.pagref();
        
        
        
        
    }
    
}