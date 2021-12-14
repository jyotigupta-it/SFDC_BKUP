@isTest
private class EditAllNewOfferTest {
    @isTest static void test_method_one() {
        
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
        acc.Party_Type__c='Builder';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
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
        opp.GSTN__c = '101010000000000';
        opp.Street_Address__c='whitefield';
        opp.Project_Location__c='bangalore';
        insert opp;
        proId.add(opp.id);
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
        newOff6.Validity_for_the_Price__c=date.today() - 2;
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
        
        New_Offer_Section__c newOff7=new New_Offer_Section__c();
        newOff7.Product_Name__c='CPVC';
        newOff7.MRP_Value__c=56000;
        newOff7.APPL__c=15;
        newOff7.Id=newOff3.Id;
        newOff7.Extra_Discount__c=6;
        update newOff7;
        
        
       //2nd Project
       Opportunity opp1 = new Opportunity();
        opp1.Name='TestClass';
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
        opp1.Dimension_of_the_stack__c='160';
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
        opp1.GSTN__c='101010000000000';
        opp1.Street_Address__c='whitefield';
        opp1.Project_Location__c='bangalore';
        insert opp1; 
          proId.add(opp1.id);
        
        Influencer__c inf3 = new Influencer__c();
        inf3.Influencer_Type__c=infCustom.Type__c;
        inf3.Account__c=acc.Id;
        inf3.Source__c='In House';
        inf3.Update_of_Last_Visit__c='trtr';
        inf3.Opportunity__c = opp1.Id;
        insert inf3;
        
        Influencer__c inf4 = new Influencer__c();
        inf4.Influencer_Type__c=infCustom2.Type__c;
        inf4.Account__c=acc.Id;
        inf4.Source__c='In House';
        inf4.Update_of_Last_Visit__c='trtr';
        inf4.Opportunity__c = opp1.Id;
        insert inf4;
        
       
        New_Offer_Section__c nof1=new New_Offer_Section__c();
        nof1.Product_Name__c='Concealed Diverters';
        nof1.MRP_Value__c=56000;
        nof1.APPL__c=15;
        nof1.Extra_Discount__c=6;
        nof1.Project__c=opp1.Id;
        insert nof1;
        
        New_Offer_Section__c nof2=new New_Offer_Section__c();
        nof2.Product_Name__c='Concealed Valves';
        nof2.MRP_Value__c=56000;
        nof2.APPL__c=15;
        nof2.Extra_Discount__c=6;
        nof2.Project__c=opp1.Id;
       // nof2.Product_Status__c='Loss';
       // nof2.Lost_to_brand__c='ACO';
        
        insert nof2;
        
        New_Offer_Section__c nof3=new New_Offer_Section__c();
        nof3.Product_Name__c='Concealed Valves';
        nof3.MRP_Value__c=56000;
        nof3.APPL__c=15;
        nof3.Validity_for_the_Price__c=date.today() - 2;
        nof3.Extra_Discount__c=6;
        nof3.Project__c=opp1.Id;
        nof3.Product_Status__c='Win';
        insert nof3;
        
        
         //3nd Project
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
        opp2.GSTN__c='101010000000000';
        opp2.Street_Address__c='whitefield';
        opp2.Project_Location__c='bangalore'; 
        insert opp2; 
          proId.add(opp2.id);
        
        Influencer__c inf5 = new Influencer__c();
        inf5.Influencer_Type__c=infCustom.Type__c;
        inf5.Account__c=acc.Id;
        inf5.Source__c='In House';
        inf5.Update_of_Last_Visit__c='trtr';
        inf5.Opportunity__c = opp2.Id;
        insert inf5;
        
        Influencer__c inf6 = new Influencer__c();
        inf6.Influencer_Type__c=infCustom2.Type__c;
        inf6.Account__c=acc.Id;
        inf6.Source__c='In House';
        inf6.Update_of_Last_Visit__c='trtr';
        inf6.Opportunity__c = opp2.Id;
        insert inf6;
        
       
        New_Offer_Section__c nof4=new New_Offer_Section__c();
        nof4.Product_Name__c='Concealed Diverters';
        nof4.MRP_Value__c=56000;
        nof4.APPL__c=15;
        nof4.Extra_Discount__c=6;
        nof4.Project__c=opp2.Id;
        nof4.Product_Status__c='Loss';
        nof4.Lost_to_brand__c='ACO';
        insert nof4;
        
        
         //4th Project
       Opportunity opp3 = new Opportunity();
        opp3.Name='TestClass';
        opp3.StageName = 'Designing';
        opp3.CloseDate =date.TODAY()+10;
        opp3.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp3.Project_Type__c='Commercial';
        opp3.Mixed_Type__c='Malls';
        opp3.No_of_Bathrooms__c = 12;
        opp3.No_of_Floors__c=5;
        opp3.Number_of_kitchens__c=6;
        opp3.Number_of_towers__c=1;
        opp3.Material_of_Stack__c='SWR';
        opp3.Internal_Plumbing_Mix__c='CPVC';
        opp3.Dimension_of_the_stack__c='160';
        opp3.Project_Area__c=2563;
        opp3.Standard_ORC__c=4;
        opp3.SWR_system_to_be_deployed__c='Conventional';
        opp3.Project_By__c=acc.Id;
        opp3.Distributor__c=acc1.Id;
        opp3.Special_Pricing_Request_Approval__c='Submitted';
        opp3.Taluk__c=ap.Id;
        opp3.Freight__c='FOR';
        opp3.Delivery__c='2 weeks';
        opp3.Price_Basis__c='FOR Site';
        opp3.Delivery_Lots__c='9 Lots';
        opp3.Taxes__c='Included';
        opp3.Offer_Valid_Till__c='60 Days';
        opp3.Payment_Term__c='45 days after delivery';
        opp3.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        opp3.Order_Placement__c='Contractor';
        opp3.GSTN__c='101010000000000';
        opp3.Street_Address__c='whitefield';
        opp3.Project_Location__c='bangalore';
        insert opp3; 
          proId.add(opp3.id);
        
        Influencer__c inf8 = new Influencer__c();
        inf8.Influencer_Type__c=infCustom.Type__c;
        inf8.Account__c=acc.Id;
        inf8.Source__c='In House';
        inf8.Update_of_Last_Visit__c='trtr';
        inf8.Opportunity__c = opp3.Id;
        insert inf8;
        
        Influencer__c inf7 = new Influencer__c();
        inf7.Influencer_Type__c=infCustom2.Type__c;
        inf7.Account__c=acc.Id;
        inf7.Source__c='In House';
        inf7.Update_of_Last_Visit__c='trtr';
        inf7.Opportunity__c = opp3.Id;
        insert inf7;
        
       
        New_Offer_Section__c nof6=new New_Offer_Section__c();
        nof6.Product_Name__c='Concealed Diverters';
        nof6.MRP_Value__c=56000;
        nof6.APPL__c=15;
        nof6.Extra_Discount__c=6;
        nof6.Project__c=opp3.Id;
        nof6.Product_Status__c='Loss';
        nof6.Lost_to_brand__c='ACO';
        nof6.Reason_of_lost_sales__c='Others';
        insert nof6;
        
        //5th project
         Opportunity opp4 = new Opportunity();
        opp4.Name='TestClass';
        opp4.StageName = 'Designing';
        opp4.CloseDate =date.TODAY()+10;
        opp4.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp4.Project_Type__c='Commercial';
        opp4.Mixed_Type__c='Malls';
        opp4.No_of_Bathrooms__c = 12;
        opp4.No_of_Floors__c=5;
        opp4.Number_of_kitchens__c=6;
        opp4.Number_of_towers__c=1;
        opp4.Material_of_Stack__c='SWR';
        opp4.Internal_Plumbing_Mix__c='CPVC';
        opp4.Dimension_of_the_stack__c='160';
        opp4.Project_Area__c=2563;
        opp4.Standard_ORC__c=4;
        opp4.SWR_system_to_be_deployed__c='Conventional';
        opp4.Project_By__c=acc.Id;
        opp4.Distributor__c=acc1.Id;
        opp4.Special_Pricing_Request_Approval__c='Submitted';
        opp4.Taluk__c=ap.Id;
        opp4.GSTN__c='101010000000000';
        opp4.Street_Address__c='whitefield';
        opp4.Project_Location__c='bangalore'; 
        insert opp4; 
          proId.add(opp4.id);
        
        //5th project
         Opportunity opp5 = new Opportunity();
        opp5.Name='TestClass';
        opp5.StageName = 'Designing';
        opp5.CloseDate =date.TODAY()+10;
        opp5.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp5.Project_Type__c='Commercial';
        opp5.Mixed_Type__c='Malls';
        opp5.No_of_Bathrooms__c = 12;
        opp5.No_of_Floors__c=5;
        opp5.Number_of_kitchens__c=6;
        opp5.Number_of_towers__c=1;
        opp5.Material_of_Stack__c='SWR';
        opp5.Internal_Plumbing_Mix__c='CPVC';
        opp5.Dimension_of_the_stack__c='160';
        opp5.Project_Area__c=2563;
        opp5.Standard_ORC__c=4;
        opp5.SWR_system_to_be_deployed__c='Conventional';
        opp5.Project_By__c=acc.Id;
        opp5.Distributor__c=acc1.Id;
        opp5.Special_Pricing_Request_Approval__c='Submitted';
        opp5.Taluk__c=ap.Id;
         opp5.Freight__c='FOR';
        opp5.Delivery__c='2 weeks';
        opp5.Price_Basis__c='FOR Site';
        opp5.Delivery_Lots__c='9 Lots';
        opp5.Taxes__c='Included';
        opp5.Offer_Valid_Till__c='60 Days';
        opp5.Payment_Term__c='45 days after delivery';
        opp5.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        opp5.Order_Placement__c='Contractor';
        opp5.GSTN__c='101010000000000';
        opp5.Street_Address__c='whitefield';
        opp5.Project_Location__c='bangalore'; 
        insert opp5; 
          proId.add(opp5.id);
        
        New_Offer_Section__c nof8=new New_Offer_Section__c();
        nof8.Product_Name__c='Concealed Diverters';
        nof8.MRP_Value__c=56000;
        nof8.APPL__c=15;
        nof8.Extra_Discount__c=6;
        nof8.Project__c=opp5.Id;
        nof8.Product_Status__c='Win';
        nof8.Lost_to_brand__c='ACO';
        nof8.Reason_of_lost_sales__c='Others';
        insert nof8;
       
        for(Id idval:proId){
            String oppProId = idval;
        
        Test.setCurrentPageReference(new PageReference('Page.EditAllNewOfferSection')); 
        System.currentPageReference().getParameters().put('id', oppProId);
       // Test.startTest();
        EditAllNewOfferSection_Controller controller = new EditAllNewOfferSection_Controller() ;
        controller.cancelEdit();
        controller.saveUpdatedOffers();
        // EditAllNewOfferSection_Controller.fakeMethod();
        //Test.stopTest();
        }
        
        
    }
    
}