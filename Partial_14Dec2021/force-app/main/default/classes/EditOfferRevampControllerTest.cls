@isTest
public class EditOfferRevampControllerTest {
    
    @isTest static void test_method_one() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        
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
        
        
        //1st project
        Opportunity opp = new Opportunity();
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
        
        
        New_Offer_Section__c newOff=new New_Offer_Section__c();
        newOff.Product_Name__c='Concealed Diverters';
        newOff.MRP_Value__c=56000;
        newOff.APPL__c=15;
        newOff.Extra_Discount__c=6;
        newOff.Project__c=opp.Id;
        insert newOff;
        
        New_Offer_Section__c newOff2=new New_Offer_Section__c();
        newOff2.Product_Name__c='Concealed Valves';
        newOff2.MRP_Value__c=56000;
        newOff2.APPL__c=15;
        newOff2.Extra_Discount__c=6;
        newOff2.Project__c=opp.Id;
        insert newOff2;
        
        New_Offer_Section__c newOff6=new New_Offer_Section__c();
        newOff6.Product_Name__c='Concealed Valves';
        newOff6.MRP_Value__c=56000;
        newOff6.APPL__c=15;
        newOff6.Validity_for_the_Price__c=date.today() + 5;
        newOff6.Extra_Discount__c=6;
        newOff6.Project__c=opp.Id;
        newOff6.Product_Status__c='Win';
        insert newOff6;
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='CPVC';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Product_Status__c='Loss';
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3;
        
        
        Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Pending';
        insert un;
        
        New_Special_Pricing_Request__c newspr=new New_Special_Pricing_Request__c();
        newspr.Product_name__c='Concealed Valves';
        newspr.MRP_Value__c=56000;
        newspr.APPL__c=15;
        newspr.Unique_SPR__c=un.Id;
        newspr.Project__c=opp.id;
        insert newspr;
        
        New_Special_Pricing_Request__c newspr1=new New_Special_Pricing_Request__c();
        newspr1.Product_name__c='Aqualife';
        newspr1.MRP_Value__c=56000;
        newspr1.APPL__c=15;
        newspr1.Unique_SPR__c=un.Id;
        newspr1.Project__c=opp.id;
        newspr1.Product_Status__c='Loss';
        insert newspr1;
        
        New_Order__c orderObj=new New_Order__c();
        orderObj.Order_Number__c=1;
        orderObj.Project__c=opp.Id;
        orderObj.Account__c= opp.Distributor__c;// it should be project by--check with clientt
        insert orderObj;
        
        Order_Line_Item__c oli=new Order_Line_Item__c();
        oli.Product_name__c='Concealed Valves';
        oli.New_Order__c=orderObj.id;
        oli.Project__c=opp.Id;
        insert oli;
        
         Test.startTest();
        
        PageReference pageRef = Page.EditOfferRevampSection; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(un.Id));
        pageRef.getParameters().put('projectId', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        EditOfferRevampController testAccPlan = new EditOfferRevampController();
        testAccPlan.saveUpdatedOffers();
        testAccPlan.cancelEdit();
        
        Test.stopTest();
        
    }
    @isTest static void test_method_two() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        
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
        
        
        //1st project
        Opportunity opp = new Opportunity();
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
        
        
        New_Offer_Section__c newOff=new New_Offer_Section__c();
        newOff.Product_Name__c='Concealed Diverters';
        newOff.MRP_Value__c=56000;
        newOff.APPL__c=15;
        newOff.Extra_Discount__c=6;
        newOff.Project__c=opp.Id;
        insert newOff;
        
        New_Offer_Section__c newOff2=new New_Offer_Section__c();
        newOff2.Product_Name__c='Concealed Valves';
        newOff2.MRP_Value__c=56000;
        newOff2.APPL__c=15;
        newOff2.Extra_Discount__c=6;
        newOff2.Project__c=opp.Id;
        insert newOff2;
        
        New_Offer_Section__c newOff6=new New_Offer_Section__c();
        newOff6.Product_Name__c='Concealed Valves';
        newOff6.MRP_Value__c=56000;
        newOff6.APPL__c=15;
        newOff6.Validity_for_the_Price__c=date.today() + 5;
        newOff6.Extra_Discount__c=6;
        newOff6.Project__c=opp.Id;
        newOff6.Product_Status__c='Win';
        insert newOff6;
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='CPVC';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Product_Status__c='Loss';
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3;
        
        
        Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Pending';
        insert un;
        
        New_Special_Pricing_Request__c newspr=new New_Special_Pricing_Request__c();
        newspr.Product_name__c='Concealed Valves';
        newspr.MRP_Value__c=56000;
        newspr.APPL__c=15;
        newspr.Unique_SPR__c=un.Id;
        newspr.Project__c=opp.id;
        insert newspr;
        
        New_Special_Pricing_Request__c newspr1=new New_Special_Pricing_Request__c();
        newspr1.Product_name__c='Aqualife';
        newspr1.MRP_Value__c=56000;
        newspr1.APPL__c=15;
        newspr1.Unique_SPR__c=un.Id;
        newspr1.Project__c=opp.id;
        /* newspr1.Product_Status__c='Loss';
newspr1.Loss_to_brand__c='Astral';*/
        insert newspr1;
        
        List<New_Special_Pricing_Request__c> sprList=new List<New_Special_Pricing_Request__c>();
        New_Special_Pricing_Request__c newspr2=new New_Special_Pricing_Request__c();
        newspr2.id=newspr.id;
        newspr2.Product_Status__c='Loss';
        newspr2.Loss_to_brand__c='Astral';
        update newspr2;
        sprList.add(newspr2);
        
        New_Order__c orderObj=new New_Order__c();
        orderObj.Order_Number__c=1;
        orderObj.Project__c=opp.Id;
        orderObj.Account__c= opp.Distributor__c;// it should be project by--check with clientt
        insert orderObj;
        
        Order_Line_Item__c oli=new Order_Line_Item__c();
        oli.Product_name__c='Concealed Valves';
        oli.New_Order__c=orderObj.id;
        oli.Project__c=opp.Id;
        insert oli;
        
         Test.startTest();
        
        PageReference pageRef = Page.EditOfferRevampSection; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(un.Id));
        pageRef.getParameters().put('projectId', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        EditOfferRevampController testAccPlan = new EditOfferRevampController();
        testAccPlan.newsprUpdateList=sprList;
        testAccPlan.saveUpdatedOffers();
        testAccPlan.cancelEdit();
        
        Test.stopTest();
        
    }
    
    @isTest static void test_method_three() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        
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
        
        
        //1st project
        Opportunity opp = new Opportunity();
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
        
        
        New_Offer_Section__c newOff=new New_Offer_Section__c();
        newOff.Product_Name__c='Concealed Diverters';
        newOff.MRP_Value__c=56000;
        newOff.APPL__c=15;
        newOff.Extra_Discount__c=6;
        newOff.Project__c=opp.Id;
        insert newOff;
        
        New_Offer_Section__c newOff2=new New_Offer_Section__c();
        newOff2.Product_Name__c='Concealed Valves';
        newOff2.MRP_Value__c=56000;
        newOff2.APPL__c=15;
        newOff2.Extra_Discount__c=6;
        newOff2.Project__c=opp.Id;
        insert newOff2;
        
        New_Offer_Section__c newOff6=new New_Offer_Section__c();
        newOff6.Product_Name__c='Concealed Valves';
        newOff6.MRP_Value__c=56000;
        newOff6.APPL__c=15;
        newOff6.Validity_for_the_Price__c=date.today() + 5;
        newOff6.Extra_Discount__c=6;
        newOff6.Project__c=opp.Id;
        newOff6.Product_Status__c='Win';
        insert newOff6;
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='CPVC';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Product_Status__c='Loss';
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3;
        
        
        Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Pending';
        insert un;
        
        New_Special_Pricing_Request__c newspr=new New_Special_Pricing_Request__c();
        newspr.Product_name__c='Concealed Valves';
        newspr.MRP_Value__c=56000;
        newspr.APPL__c=15;
        newspr.Unique_SPR__c=un.Id;
        newspr.Project__c=opp.id;
        insert newspr;
        
        New_Special_Pricing_Request__c newspr1=new New_Special_Pricing_Request__c();
        newspr1.Product_name__c='Aqualife';
        newspr1.MRP_Value__c=56000;
        newspr1.APPL__c=15;
        newspr1.Unique_SPR__c=un.Id;
        newspr1.Project__c=opp.id;
        /* newspr1.Product_Status__c='Loss';
newspr1.Loss_to_brand__c='Astral';*/
        insert newspr1;
        
        List<New_Special_Pricing_Request__c> sprList=new List<New_Special_Pricing_Request__c>();
        New_Special_Pricing_Request__c newspr2=new New_Special_Pricing_Request__c();
        newspr2.id=newspr.id;
        newspr2.Product_Status__c='Loss';
        newspr2.Loss_to_brand__c='Astral';
        newspr2.Reason_of_lost_sales__c='Others';
        
        update newspr2;
        sprList.add(newspr2);
        
        New_Order__c orderObj=new New_Order__c();
        orderObj.Order_Number__c=1;
        orderObj.Project__c=opp.Id;
        orderObj.Account__c= opp.Distributor__c;// it should be project by--check with clientt
        insert orderObj;
        
        Order_Line_Item__c oli=new Order_Line_Item__c();
        oli.Product_name__c='Concealed Valves';
        oli.New_Order__c=orderObj.id;
        oli.Project__c=opp.Id;
        insert oli;
        
         Test.startTest();
        
        PageReference pageRef = Page.EditOfferRevampSection; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(un.Id));
        pageRef.getParameters().put('projectId', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        EditOfferRevampController testAccPlan = new EditOfferRevampController();
        testAccPlan.newsprUpdateList=sprList;
        testAccPlan.saveUpdatedOffers();
        testAccPlan.cancelEdit();
        
        Test.stopTest();
        
    }
    @isTest static void test_method_four() {
        
        ApexPages.Message[] messages = ApexPages.getMessages();
        list<id> proId=new list<id>();
       
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
        
        
        //1st project
        Opportunity opp = new Opportunity();
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
        
        
        New_Offer_Section__c newOff=new New_Offer_Section__c();
        newOff.Product_Name__c='Concealed Diverters';
        newOff.MRP_Value__c=56000;
        newOff.APPL__c=15;
        newOff.Extra_Discount__c=6;
        newOff.Project__c=opp.Id;
        insert newOff;
        
        New_Offer_Section__c newOff2=new New_Offer_Section__c();
        newOff2.Product_Name__c='Concealed Valves';
        newOff2.MRP_Value__c=56000;
        newOff2.APPL__c=15;
        newOff2.Extra_Discount__c=6;
        newOff2.Project__c=opp.Id;
        insert newOff2;
        
        New_Offer_Section__c newOff6=new New_Offer_Section__c();
        newOff6.Product_Name__c='Concealed Valves';
        newOff6.MRP_Value__c=56000;
        newOff6.APPL__c=15;
        newOff6.Validity_for_the_Price__c=date.today() + 5;
        newOff6.Extra_Discount__c=6;
        newOff6.Project__c=opp.Id;
        newOff6.Product_Status__c='Win';
        insert newOff6;
        
        
        
        New_Offer_Section__c newOff3=new New_Offer_Section__c();
        newOff3.Product_Name__c='CPVC';
        newOff3.MRP_Value__c=56000;
        newOff3.APPL__c=15;
        newOff3.Extra_Discount__c=6;
        newOff3.Project__c=opp.Id;
        newOff3.Product_Status__c='Loss';
        newOff3.Lost_to_brand__c='ACO';
        newOff3.Reason_of_lost_sales__c='Product unavailable';        
        insert newOff3;
        
        
        Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Pending';
        insert un;
        
        New_Special_Pricing_Request__c newspr=new New_Special_Pricing_Request__c();
        newspr.Product_name__c='Concealed Valves';
        newspr.MRP_Value__c=56000;
        newspr.APPL__c=15;
        newspr.Unique_SPR__c=un.Id;
        newspr.Project__c=opp.id;
        insert newspr;
        
        New_Special_Pricing_Request__c newspr1=new New_Special_Pricing_Request__c();
        newspr1.Product_name__c='Aqualife';
        newspr1.MRP_Value__c=56000;
        newspr1.APPL__c=15;
        newspr1.Unique_SPR__c=un.Id;
        newspr1.Project__c=opp.id;
        insert newspr1;
        
        
        List<New_Special_Pricing_Request__c> sprList=new List<New_Special_Pricing_Request__c>();
        New_Special_Pricing_Request__c newspr2=new New_Special_Pricing_Request__c();
        newspr2.id=newspr.id;
        newspr2.Product_Status__c='Win';
        newspr2.Loss_to_brand__c='Astral';
        update newspr2;
        sprList.add(newspr2);
        
        New_Order__c orderObj=new New_Order__c();
        orderObj.Order_Number__c=1;
        orderObj.Project__c=opp.Id;
        orderObj.Account__c= opp.Distributor__c;// it should be project by--check with clientt
        insert orderObj;
        
        Order_Line_Item__c oli=new Order_Line_Item__c();
        oli.Product_name__c='Concealed Valves';
        oli.New_Order__c=orderObj.id;
        oli.Project__c=opp.Id;
        insert oli;
        
        
         Test.startTest();
        PageReference pageRef = Page.EditOfferRevampSection; // Add your VF page Name here
        pageRef.getParameters().put('id', String.valueOf(un.Id));
        pageRef.getParameters().put('projectId', String.valueOf(opp.Id));
        Test.setCurrentPage(pageRef);
        
        EditOfferRevampController testAccPlan = new EditOfferRevampController();
        testAccPlan.newsprUpdateList=sprList;
        testAccPlan.saveUpdatedOffers();
        testAccPlan.cancelEdit();
        
        Test.stopTest();
        
    }
    
    
}