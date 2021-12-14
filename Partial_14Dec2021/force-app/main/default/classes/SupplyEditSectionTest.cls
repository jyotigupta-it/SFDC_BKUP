@isTest
public class SupplyEditSectionTest {
    @isTest static void test_method_one() {
        
        
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
        
        
        Unique_SPR__c un=new Unique_SPR__c();
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
        
        New_Order__c orderObj=new New_Order__c();
        orderObj.Order_Number__c=1;
        orderObj.Project__c=opp.Id;
        orderObj.Account__c=acc1.Id;// it should be project by--check with clientt
        insert orderObj;
        
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
        
        PageReference pageRef = Page.SupplyEditSectionVF;
        pageRef.getParameters().put('id',opp.id);
        pageRef.getParameters().put('applType','supplyType');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        SupplyEditSectionController s=new SupplyEditSectionController(sc);
        s.getSupplyListPro();
        s.savePage();
        s.deleteData();
      
        
        
        
    }
}