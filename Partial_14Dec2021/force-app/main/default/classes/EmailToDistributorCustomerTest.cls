@isTest
public class EmailToDistributorCustomerTest {
    
    
    @isTest static void test_method_one() {
        test.startTest(); 
        
        
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
        opp.GSTN__c='101010000000000';
        opp.Project_Location__c='hdwj';
        opp.Street_Address__c='hdja';
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
        
        
        Unique_SPR__c un=new Unique_SPR__c();
        un.Unique_Name__c='un_0001';
        un.Project__c=opp.Id;
        un.Approval_Status__c='Approved';
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
        
        
        
        Test.setCurrentPageReference(new PageReference('Page.EditOrderPage2')); 
        System.currentPageReference().getParameters().put('uniqueSprId', un.id);
        System.currentPageReference().getParameters().put('projectId', opp.id);
        EmailToDistributorandCustomerController ed=new EmailToDistributorandCustomerController();
        test.stopTest();
        
    }
    
}