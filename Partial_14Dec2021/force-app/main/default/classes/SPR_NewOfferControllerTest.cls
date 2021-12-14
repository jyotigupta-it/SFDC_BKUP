@isTest
public class SPR_NewOfferControllerTest {
    
    
    @isTest static void test_method_one() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        list<id> proId=new list<id>();
        Test.startTest();
        User us2=new User();
        us2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'System Administrator'].Id;
        us2.LastName='username1';
        us2.Email='username1@av.com';
        us2.Username='username1@av.com'+ System.currentTimeMillis();
        us2.CompanyName='Test';
        us2.TimeZoneSidKey='Asia/Kolkata';
        us2.Title='title';
        us2.Alias='use1';
        us2.EmailEncodingKey='UTF-8';
        us2.LanguageLocaleKey='en_US';
        us2.LocaleSidKey='en_IN';
        us2.IsActive=true;
        us2.Create_Attendance__c=true;
        us2.EmployeeNumber = 'Test1';
        insert us2;
        
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username122';
        User1.Email='username12@av.com';
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
        user1.Project_Approver__c=us2.id;
        insert User1;
        
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
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Party_Type__c ='Borer';
        acc.Accountant__c ='Yes';
         acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Accountant__c='Yes';
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
        Discount_Master__c disc=new Discount_Master__c();
        disc.Products__c='CPVC-PIPE';
        disc.Distributor__c=acc1.Id;
        disc.Std_APPL_Discount_Percent__c=56.56;
        insert disc;
        
        String sproBathroom = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c pro=new Probability_Master__c();
        pro.RecordTypeId=sproBathroom;
        pro.SWR_System_to_be_Deployed__c='Conventional';
        pro.Dimension_of_Stack__c='160mm';
        pro.Internal_Plumbing_Mix__c='CPVC';
        pro.Price__c=1300;
        pro.Property_Type__c ='Commercial';
        pro.Product_Category__c='AQUA-PIPE';
        insert pro;
        
        String sproKitchen = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c pro2=new Probability_Master__c();
        pro2.RecordTypeId=sproKitchen;
        pro2.SWR_System_to_be_Deployed__c='Conventional';
        pro2.Dimension_of_Stack__c='160mm';
        pro2.Internal_Plumbing_Mix__c='CPVC';
        pro2.Price__c=1300;
        pro2.Property_Type__c ='Commercial';
        pro2.Product_Category__c='AQUA-PIPE';
        insert pro2;
        
        String sproProjectArea = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Project Area'].Id;
        Probability_Master__c pro3=new Probability_Master__c();
        pro3.RecordTypeId=sproProjectArea;
        pro3.SWR_System_to_be_Deployed__c='Conventional';
        pro3.Dimension_of_Stack__c='160mm';
        pro3.Internal_Plumbing_Mix__c='CPVC';
        pro3.Price__c=1300;
        pro3.Property_Type__c ='Commercial';
        pro3.Product_Category__c='AQUA-PIPE';
        insert pro3;
        
        String proKRecordTypeId113 = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Length of Pipeline'].Id;
        Probability_Master__c prob213=new Probability_Master__c();
        prob213.RecordTypeId=proKRecordTypeId113;
        prob213.Product_Category__c='AQUA-PIPE';
        
        prob213.Price__c=2000;
        prob213.Dimension_of_Stack__c='110mm';
        prob213.Internal_Plumbing_Mix__c='CPVC';
       // prob2.Material__c='SWR';
        prob213.SWR_System_to_be_Deployed__c='Conventional';
        prob213.Property_Type__c='Commercial';
        prob213.Number_of_Floors_Max__c=18;
        prob213.Number_of_Floors_Min__c=0;
        prob213.Product_Category__c='AQUA-PIPE';
        insert prob213;
         
        
        
        
        
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
        opp.HDPE__c='Yes';
        opp.Length_of_Pipeline_Meters__c=10;
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
        insert opp;
        
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
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='Aqualife';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3; 
        
        New_Offer_Section__c newOff1=new New_Offer_Section__c();
        newOff1.Product_Name__c='Aqualife';
        newOff1.MRP_Value__c=56000;
        newOff1.APPL__c=15;
        newOff1.Extra_Discount__c=6;
        newOff1.Project__c=opp.Id;
        newOff1.Lost_to_brand__c='ACO';
        newOff1.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff1; 
        list<New_Offer_Section__c> nlist=new List<New_Offer_Section__c>();
        nlist.add(newOff1);
        
       /* Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Pending';
        insert un;
        List<Unique_SPR__c> unlist=new list<Unique_SPR__c>(); 
        unlist.add(un);
        
        New_Special_Pricing_Request__c newspr=new New_Special_Pricing_Request__c();
        newspr.Product_name__c='Concealed Valves';
        newspr.MRP_Value__c=56000;
        newspr.APPL__c=15;
        newspr.Unique_SPR__c=un.Id;
        newspr.Project__c=opp.id;
        insert newspr;
        
        
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
        System.debug('Opp Id' +opp.Id); */
        String oppProId = opp.Id;
        Map<id,opportunity> mapOppId=new  Map<id,opportunity>();
        mapOppId.put(oppProId,opp);
        Test.setCurrentPageReference(new PageReference('Page.SPR_NewOffer')); 
        System.currentPageReference().getParameters().put('id', oppProId);
        
        SPR_NewOfferController controller = new SPR_NewOfferController() ;
       
        //controller.giveUniqueName();
        // controller.removeSelectedRow();
        NewOfferSectionDMLHandler.calcMatrixMap(mapOppId,'SpecialPriceRequestInsert');
         controller.newOffSectUniqueList.addAll(nlist);
        controller.submitApproval();
        controller.cancelProcess();
        
        
        
        test.stopTest();
        
    }
     @isTest static void test_method_two() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        list<id> proId=new list<id>();
        Test.startTest();
        User us2=new User();
        us2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'System Administrator'].Id;
        us2.LastName='username1';
        us2.Email='username1@av.com';
        us2.Username='username1@av.com'+ System.currentTimeMillis();
        us2.CompanyName='Test';
        us2.TimeZoneSidKey='Asia/Kolkata';
        us2.Title='title';
        us2.Alias='use1';
        us2.EmailEncodingKey='UTF-8';
        us2.LanguageLocaleKey='en_US';
        us2.LocaleSidKey='en_IN';
        us2.IsActive=true;
        us2.Create_Attendance__c=true;
        us2.EmployeeNumber = 'Test1';
        insert us2;
        
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username122';
        User1.Email='username12@av.com';
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
        user1.Project_Approver__c=us2.id;
        insert User1;
        
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
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Party_Type__c ='Borer';
        acc.Accountant__c ='Yes';
         acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Accountant__c='Yes';
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
        Discount_Master__c disc=new Discount_Master__c();
        disc.Products__c='CPVC-PIPE';
        disc.Distributor__c=acc1.Id;
        disc.Std_APPL_Discount_Percent__c=56.56;
        insert disc;
        
        String sproBathroom = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c pro=new Probability_Master__c();
        pro.RecordTypeId=sproBathroom;
        pro.SWR_System_to_be_Deployed__c='Conventional';
        pro.Dimension_of_Stack__c='160mm';
        pro.Internal_Plumbing_Mix__c='CPVC';
        pro.Price__c=1300;
        pro.Property_Type__c ='Commercial';
        pro.Product_Category__c='AQUA-PIPE';
        insert pro;
        
        String sproKitchen = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c pro2=new Probability_Master__c();
        pro2.RecordTypeId=sproKitchen;
        pro2.SWR_System_to_be_Deployed__c='Conventional';
        pro2.Dimension_of_Stack__c='160mm';
        pro2.Internal_Plumbing_Mix__c='CPVC';
        pro2.Price__c=1300;
        pro2.Property_Type__c ='Commercial';
        pro2.Product_Category__c='AQUA-PIPE';
        insert pro2;
        
        String sproProjectArea = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Project Area'].Id;
        Probability_Master__c pro3=new Probability_Master__c();
        pro3.RecordTypeId=sproProjectArea;
        pro3.SWR_System_to_be_Deployed__c='Conventional';
        pro3.Dimension_of_Stack__c='160mm';
        pro3.Internal_Plumbing_Mix__c='CPVC';
        pro3.Price__c=1300;
        pro3.Property_Type__c ='Commercial';
        pro3.Product_Category__c='AQUA-PIPE';
        insert pro3;
        
        
        
        
        
        
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
        insert opp;
        
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
        
        New_Offer_Section__c newOff1=new New_Offer_Section__c();
        newOff1.Product_Name__c='Aqualife';
        newOff1.MRP_Value__c=56000;
        newOff1.APPL__c=15;
        newOff1.Extra_Discount__c=6;
        newOff1.Project__c=opp.Id;
        newOff1.Lost_to_brand__c='ACO';
        newOff1.Send_for_SPR__c=false;
        newOff1.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff1; 
        list<New_Offer_Section__c> nlist=new List<New_Offer_Section__c>();
        nlist.add(newOff1);
          nlist.add(newOff3);
        String oppProId = opp.Id;
        Map<id,opportunity> mapOppId=new  Map<id,opportunity>();
        mapOppId.put(oppProId,opp);
        Test.setCurrentPageReference(new PageReference('Page.SPR_NewOffer')); 
        System.currentPageReference().getParameters().put('id', oppProId);
        
        SPR_NewOfferController controller = new SPR_NewOfferController() ;
        controller.newOffSectUniqueList.addAll(nlist);
        controller.giveUniqueName();
        controller.removeSelectedRow();
        NewOfferSectionDMLHandler.calcMatrixMap(mapOppId,'SpecialPriceRequestInsert');
        controller.submitApproval();
        controller.cancelProcess();
        controller.codeCoverage();
         controller.codeCoverage2();
        
        
        test.stopTest();
        
    }
    
        @isTest static void test_method_three() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        list<id> proId=new list<id>();
        Test.startTest();
        User us2=new User();
        us2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'System Administrator'].Id;
        us2.LastName='username1';
        us2.Email='username1@av.com';
        us2.Username='username1@av.com'+ System.currentTimeMillis();
        us2.CompanyName='Test';
        us2.TimeZoneSidKey='Asia/Kolkata';
        us2.Title='title';
        us2.Alias='use1';
        us2.EmailEncodingKey='UTF-8';
        us2.LanguageLocaleKey='en_US';
        us2.LocaleSidKey='en_IN';
        us2.IsActive=true;
        us2.Create_Attendance__c=true;
        us2.EmployeeNumber = 'Test1';
        insert us2;
        
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username122';
        User1.Email='username12@av.com';
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
        user1.Project_Approver__c=us2.id;
        insert User1;
        
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
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Party_Type__c ='Borer';
        acc.Accountant__c ='Yes';
            acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Accountant__c='Yes';
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
        Discount_Master__c disc=new Discount_Master__c();
        disc.Products__c='CPVC-PIPE';
        disc.Distributor__c=acc1.Id;
        disc.Std_APPL_Discount_Percent__c=56.56;
        insert disc;
        
        String sproBathroom = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c pro=new Probability_Master__c();
        pro.RecordTypeId=sproBathroom;
        pro.SWR_System_to_be_Deployed__c='Conventional';
        pro.Dimension_of_Stack__c='160mm';
        pro.Internal_Plumbing_Mix__c='CPVC';
        pro.Price__c=1300;
        pro.Property_Type__c ='Commercial';
        pro.Product_Category__c='AQUA-PIPE';
        insert pro;
        
        String sproKitchen = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c pro2=new Probability_Master__c();
        pro2.RecordTypeId=sproKitchen;
        pro2.SWR_System_to_be_Deployed__c='Conventional';
        pro2.Dimension_of_Stack__c='160mm';
        pro2.Internal_Plumbing_Mix__c='CPVC';
        pro2.Price__c=1300;
        pro2.Property_Type__c ='Commercial';
        pro2.Product_Category__c='AQUA-PIPE';
        insert pro2;
        
        String sproProjectArea = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Project Area'].Id;
        Probability_Master__c pro3=new Probability_Master__c();
        pro3.RecordTypeId=sproProjectArea;
        pro3.SWR_System_to_be_Deployed__c='Conventional';
        pro3.Dimension_of_Stack__c='160mm';
        pro3.Internal_Plumbing_Mix__c='CPVC';
        pro3.Price__c=1300;
        pro3.Property_Type__c ='Commercial';
        pro3.Product_Category__c='AQUA-PIPE';
        insert pro3;
        
        
        
        
        
        
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
        opp.No_of_Floors__c=21;
        opp.Number_of_kitchens__c=6;
        opp.Number_of_towers__c=1;
        opp.Material_of_Stack__c='SWR';
        opp.Internal_Plumbing_Mix__c='CPVC';
        opp.Dimension_of_the_stack__c='160';
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
        insert opp;
        
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
        
        New_Offer_Section__c newOff1=new New_Offer_Section__c();
        newOff1.Product_Name__c='Aqualife';
        newOff1.MRP_Value__c=56000;
        newOff1.APPL__c=15;
        newOff1.Extra_Discount__c=6;
        newOff1.Project__c=opp.Id;
        newOff1.Lost_to_brand__c='ACO';
        newOff1.Send_for_SPR__c=true;
        newOff1.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff1; 
        list<New_Offer_Section__c> nlist=new List<New_Offer_Section__c>();
        nlist.add(newOff1);
          nlist.add(newOff3);
        String oppProId = opp.Id;
        Map<id,opportunity> mapOppId=new  Map<id,opportunity>();
        mapOppId.put(oppProId,opp);
        Test.setCurrentPageReference(new PageReference('Page.SPR_NewOffer')); 
        System.currentPageReference().getParameters().put('id', oppProId);
        
        SPR_NewOfferController controller = new SPR_NewOfferController() ;
        controller.newOffSectUniqueList.addAll(nlist);
        controller.giveUniqueName();
        //controller.removeSelectedRow();
        NewOfferSectionDMLHandler.calcMatrixMap(mapOppId,'SpecialPriceRequestInsert');
        controller.submitApproval();
        controller.cancelProcess();
        
        
        
        test.stopTest();
        
    }
          @isTest static void test_method_four() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        list<id> proId=new list<id>();
        Test.startTest();
        User us2=new User();
        us2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'System Administrator'].Id;
        us2.LastName='username1';
        us2.Email='username1@av.com';
        us2.Username='username1@av.com'+ System.currentTimeMillis();
        us2.CompanyName='Test';
        us2.TimeZoneSidKey='Asia/Kolkata';
        us2.Title='title';
        us2.Alias='use1';
        us2.EmailEncodingKey='UTF-8';
        us2.LanguageLocaleKey='en_US';
        us2.LocaleSidKey='en_IN';
        us2.IsActive=true;
        us2.Create_Attendance__c=true;
        us2.EmployeeNumber = 'Test1';
        insert us2;
        
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username122';
        User1.Email='username12@av.com';
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
        user1.Project_Approver__c=us2.id;
        insert User1;
        
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
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Party_Type__c ='Borer';
        acc.Accountant__c ='Yes';
              acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Accountant__c='Yes';
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
        Discount_Master__c disc=new Discount_Master__c();
        disc.Products__c='CPVC-PIPE';
        disc.Distributor__c=acc1.Id;
        disc.Std_APPL_Discount_Percent__c=56.56;
        insert disc;
        
        String sproBathroom = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c pro=new Probability_Master__c();
        pro.RecordTypeId=sproBathroom;
        pro.SWR_System_to_be_Deployed__c='Conventional';
        pro.Dimension_of_Stack__c='160mm';
        pro.Internal_Plumbing_Mix__c='CPVC';
        pro.Price__c=1300;
        pro.Property_Type__c ='Commercial';
        pro.Product_Category__c='AQUA-PIPE';
        insert pro;
        
        String sproKitchen = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c pro2=new Probability_Master__c();
        pro2.RecordTypeId=sproKitchen;
        pro2.SWR_System_to_be_Deployed__c='Conventional';
        pro2.Dimension_of_Stack__c='160mm';
        pro2.Internal_Plumbing_Mix__c='CPVC';
        pro2.Price__c=1300;
        pro2.Property_Type__c ='Commercial';
        pro2.Product_Category__c='AQUA-PIPE';
        insert pro2;
        
        String sproProjectArea = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Project Area'].Id;
        Probability_Master__c pro3=new Probability_Master__c();
        pro3.RecordTypeId=sproProjectArea;
        pro3.SWR_System_to_be_Deployed__c='Conventional';
        pro3.Dimension_of_Stack__c='160mm';
        pro3.Internal_Plumbing_Mix__c='CPVC';
        pro3.Price__c=1300;
        pro3.Property_Type__c ='Commercial';
        pro3.Product_Category__c='AQUA-PIPE';
        insert pro3;
        
        
        
        
        
        
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
        insert opp;
        
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
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='Aqualife';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Send_for_SPR__c=false;
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3; 
        
        New_Offer_Section__c newOff1=new New_Offer_Section__c();
        newOff1.Product_Name__c='SWR';
        newOff1.MRP_Value__c=56000;
        newOff1.APPL__c=15;
        newOff1.Extra_Discount__c=6;
        newOff1.Project__c=opp.Id;
        newOff1.Lost_to_brand__c='ACO';
        newOff1.Send_for_SPR__c=false;
        newOff1.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff1; 
        list<New_Offer_Section__c> nlist=new List<New_Offer_Section__c>();
        nlist.add(newOff1);
          nlist.add(newOff3);
        String oppProId = opp.Id;
        Map<id,opportunity> mapOppId=new  Map<id,opportunity>();
        mapOppId.put(oppProId,opp);
        Test.setCurrentPageReference(new PageReference('Page.SPR_NewOffer')); 
        System.currentPageReference().getParameters().put('id', oppProId);
        
        SPR_NewOfferController controller = new SPR_NewOfferController() ;
        
       
        NewOfferSectionDMLHandler.calcMatrixMap(mapOppId,'SpecialPriceRequestInsert');
        controller.newOffSectUniqueList.addAll(nlist);
        controller.submitApproval();
        controller.cancelProcess();
        
        test.stopTest();
        
    }
    
          @isTest static void test_method_five() {
    
test.startTest();        
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
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Party_Type__c ='Borer';
        acc.Accountant__c ='Yes';
              acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Primary_Contact_Person_Name__c='test';
        acc1.Business_Line__c='Column';
        acc1.Classification__c='A';
        acc1.Purchase_Cycle__c='Weekly';
        acc1.Status__c='Cold Call';
        acc1.Type_of_Partner__c='Projects Partner';
        acc1.Accountant__c='Yes';
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
        Discount_Master__c disc=new Discount_Master__c();
        disc.Products__c='CPVC-PIPE';
        disc.Distributor__c=acc1.Id;
        disc.Std_APPL_Discount_Percent__c=56.56;
        insert disc;
        
        String sproBathroom = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c pro=new Probability_Master__c();
        pro.RecordTypeId=sproBathroom;
        pro.SWR_System_to_be_Deployed__c='Conventional';
        pro.Dimension_of_Stack__c='160mm';
        pro.Internal_Plumbing_Mix__c='CPVC';
        pro.Price__c=1300;
        pro.Property_Type__c ='Commercial';
        pro.Product_Category__c='AQUA-PIPE';
        insert pro;
        
        String sproKitchen = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c pro2=new Probability_Master__c();
        pro2.RecordTypeId=sproKitchen;
        pro2.SWR_System_to_be_Deployed__c='Conventional';
        pro2.Dimension_of_Stack__c='160mm';
        pro2.Internal_Plumbing_Mix__c='CPVC';
        pro2.Price__c=1300;
        pro2.Property_Type__c ='Commercial';
        pro2.Product_Category__c='AQUA-PIPE';
        insert pro2;
        
        String sproProjectArea = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Project Area'].Id;
        Probability_Master__c pro3=new Probability_Master__c();
        pro3.RecordTypeId=sproProjectArea;
        pro3.SWR_System_to_be_Deployed__c='Conventional';
        pro3.Dimension_of_Stack__c='160mm';
        pro3.Internal_Plumbing_Mix__c='CPVC';
        pro3.Price__c=1300;
        pro3.Property_Type__c ='Commercial';
        pro3.Product_Category__c='AQUA-PIPE';
        insert pro3;
       
        //1st project
        Opportunity opp = new Opportunity();
        //opp.OwnerId=User1.Id;
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
        insert opp;
        
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
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='Aqualife';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Send_for_SPR__c=false;
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3; 
        
        New_Offer_Section__c newOff1=new New_Offer_Section__c();
        newOff1.Product_Name__c='SWR';
        newOff1.MRP_Value__c=56000;
        newOff1.APPL__c=15;
        newOff1.Extra_Discount__c=6;
        newOff1.Project__c=opp.Id;
        newOff1.Lost_to_brand__c='ACO';
        newOff1.Send_for_SPR__c=false;
        newOff1.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff1; 
        list<New_Offer_Section__c> nlist=new List<New_Offer_Section__c>();
        nlist.add(newOff1);
          nlist.add(newOff3);
        String oppProId = opp.Id;
        Map<id,opportunity> mapOppId=new  Map<id,opportunity>();
        mapOppId.put(oppProId,opp);
        Test.setCurrentPageReference(new PageReference('Page.SPR_NewOffer')); 
        System.currentPageReference().getParameters().put('id', oppProId);
        
        SPR_NewOfferController controller = new SPR_NewOfferController() ;
        
       
        NewOfferSectionDMLHandler.calcMatrixMap(mapOppId,'SpecialPriceRequestInsert');
        controller.newOffSectUniqueList.addAll(nlist);
        controller.submitApproval();
        controller.cancelProcess();
              
              SPR_NewOfferController obj = new SPR_NewOfferController();
        		obj.submitApproval();
        test.stopTest();
        
    }
}