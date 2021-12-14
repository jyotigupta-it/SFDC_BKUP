@isTest
private class NewOfferDMLTriggerTest {
    
    @isTest static void test_method_two() {
        
        Test.startTest();   
        //  String papa='Mini-Vent';
        Set<Id> orcChangedSet=new Set<Id>();
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
        acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        acc.Party_Type__c = 'Project Owner/Developer';
        insert acc;
        
        String strRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Distributor'].Id;
        Account acc1 = new Account();
        acc1.Name='testAcc';
        acc1.Contact_Number_Mobile__c = '9765433318';
        acc1.recordTypeId = strRecordTypeId1;
        acc1.Firm_Name__c = 'et';
        acc1.Products__c='Air Admittance Valve';
        acc1.Business_Line__c='column';
        acc1.Year_Since_in_Business__c='2015';
        
        insert acc1;
        
        AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='Belgaum';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        Discount_Master__c disc=new Discount_Master__c();
        disc.Products__c='CPVC-PIPE';
        disc.Distributor__c=acc1.Id;
        disc.Std_APPL_Discount_Percent__c=56.56;
        insert disc;
        
        
        String proBRecordTypeId = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c prob=new Probability_Master__c();
        prob.RecordTypeId=proBRecordTypeId;
        prob.Dimension_of_Stack__c='110mm';
        prob.Internal_Plumbing_Mix__c='CPVC';
        // prob.Material__c='Silent and SWR';
        prob.SWR_System_to_be_Deployed__c='Conventional';
        prob.Price__c=2000;
        prob.Product_Category__c='AQUA-PIPE';
        prob.Property_Type__c='Commercial';
        prob.Number_of_Floors_Max__c=18;
        prob.Number_of_Floors_Min__c=0;
        insert prob;
        
        String proKRecordTypeId = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c prob2=new Probability_Master__c();
        prob2.RecordTypeId=proKRecordTypeId;
        prob2.Product_Category__c='AQUA-PIPE';
        
        prob2.Price__c=2000;
        prob2.Dimension_of_Stack__c='110mm';
        prob2.Internal_Plumbing_Mix__c='CPVC';
        // prob2.Material__c='SWR';
        prob2.SWR_System_to_be_Deployed__c='Conventional';
        prob2.Property_Type__c='Commercial';
        prob2.Number_of_Floors_Max__c=18;
        prob2.Number_of_Floors_Min__c=0;
        insert prob2;
        
        String waterTankRecTypeId = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Watertank'].Id;
        Probability_Master__c probWT =new Probability_Master__c();
        probWT.RecordTypeId=waterTankRecTypeId;
        probWT.Product_Category__c='AQUA-PIPE';
        
        probWT.Price__c=2000;
        probWT.Dimension_of_Stack__c='110mm';
        probWT.Internal_Plumbing_Mix__c='CPVC';
        // prob2.Material__c='SWR';
        probWT.SWR_System_to_be_Deployed__c='Conventional';
        probWT.Property_Type__c='Commercial';
        probWT.Number_of_Floors_Max__c=18;
        probWT.Number_of_Floors_Min__c=0;
        probWT.Product_Category__c='AQUA-PIPE';
        insert probWT;
        
        String GIRecTypeId = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Grease Interceptors'].Id;
        Probability_Master__c probGI =new Probability_Master__c();
        probGI.RecordTypeId=GIRecTypeId;
        probGI.Product_Category__c='AQUA-PIPE';
        
        probGI.Price__c=2000;
        probGI.Dimension_of_Stack__c='110mm';
        probGI.Internal_Plumbing_Mix__c='CPVC';
        // prob2.Material__c='SWR';
        probGI.SWR_System_to_be_Deployed__c='Conventional';
        probGI.Property_Type__c='Commercial';
        probGI.Number_of_Floors_Max__c=18;
        probGI.Number_of_Floors_Min__c=0;
        probGI.Product_Category__c='AQUA-PIPE';
        insert probGI;
        
        String proKRecordTypeId1 = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c prob22=new Probability_Master__c();
        prob22.RecordTypeId=proKRecordTypeId1;
        prob22.Product_Category__c='AQUA-PIPE';
        
        prob22.Price__c=2000;
        prob22.Dimension_of_Stack__c='110mm';
        prob22.Internal_Plumbing_Mix__c='CPVC';
        // prob2.Material__c='SWR';
        prob22.SWR_System_to_be_Deployed__c='Conventional';
        prob22.Property_Type__c='Commercial';
        prob22.Number_of_Floors_Max__c=33;
        prob22.Number_of_Floors_Min__c=19;
        insert prob22;
        
        String proKRecordTypeId33 = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'PAPA and AAV'].Id;
        Probability_Master__c prob223=new Probability_Master__c();
        prob223.RecordTypeId=proKRecordTypeId33;
        prob223.Product_Category__c='AQUA-PIPE';
        prob223.Price__c=2000;
        insert prob223; 
        
        String proPARecordTypeId = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Project Area'].Id;
        Probability_Master__c prob3=new Probability_Master__c();
        prob3.RecordTypeId=proPARecordTypeId;
        prob3.Product_Category__c='AQUA-PIPE';
        
        prob3.Price__c=2000;
        prob3.Dimension_of_Stack__c='110mm';
        prob3.Internal_Plumbing_Mix__c='CPVC';
        prob3.Material__c='SWR';
        prob3.SWR_System_to_be_Deployed__c='Conventional';
        prob3.Property_Type__c='Commercial';
        prob3.Number_of_Floors_Max__c=18;
        prob3.Number_of_Floors_Min__c=0;
        insert prob3;
        
        
        String sproKitchen = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Kitchen'].Id;
        Probability_Master__c pro2=new Probability_Master__c();
        pro2.RecordTypeId=sproKitchen;
        pro2.SWR_System_to_be_Deployed__c='Conventional';
        pro2.Dimension_of_Stack__c='110mm';
        pro2.Internal_Plumbing_Mix__c='CPVC';
        pro2.Price__c=1300;
        pro2.Property_Type__c ='Commercial';
        pro2.Product_Category__c='AQUA-PIPE';
        insert pro2;
        String sproBathroom = [Select Id From RecordType Where SobjectType = 'Probability_Master__c' and Name = 'Bathroom'].Id;
        Probability_Master__c pro=new Probability_Master__c();
        pro.RecordTypeId=sproBathroom;
        pro.SWR_System_to_be_Deployed__c='Conventional';
        pro.Dimension_of_Stack__c='110mm';
        pro.Internal_Plumbing_Mix__c='CPVC';
        pro.Price__c=1300;
        pro.Property_Type__c ='Commercial';
        pro.Product_Category__c='AQUA-PIPE';
        insert pro;
        
        Opportunity op1 = new Opportunity();
        op1.Name='TestClass1';
        op1.StageName = 'Designing';
        op1.CloseDate =date.TODAY()+12;
        op1.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        op1.OwnerId=user1.id;
        op1.BlazeMaster__c='Yes';
        op1.HDPE__c='Yes';
        op1.Length_of_Pipeline_Meters__c=10;
        op1.Average_Flat_Area_in_sq_metres__c=5;
        op1.No_of_flats_per_floor__c=2;
        op1.Project_Type__c='Commercial';
        op1.Mixed_Type__c='Malls';
        op1.No_of_Bathrooms__c = 12;
        op1.No_of_Floors__c=5;
        op1.Number_of_kitchens__c=6;
        op1.Number_of_towers__c=1;
        op1.Material_of_Stack__c='SWR';
        op1.Internal_Plumbing_Mix__c='CPVC';
        op1.Dimension_of_the_stack__c='110';
        op1.Project_Area__c =2563;
        op1.SWR_system_to_be_deployed__c='Single Stack with P.A.P.A & A.A.V';
        op1.Project_By__c=acc.Id;
        op1.Standard_ORC__c=4;
        op1.Special_Pricing_Request_Approval__c='Submitted';
        op1.Taluk__c=ap.Id;
        op1.Freight__c='FOR';
        op1.Delivery__c='2 weeks';
        op1.Price_Basis__c='FOR Site';
        op1.Delivery_Lots__c='9 Lots';
        op1.Taxes__c='Included';
        op1.Offer_Valid_Till__c='60 Days';
        op1.Payment_Term__c='45 days after delivery';
        op1.Delivery_Conditions_Gurantee__c='As per APPL general condition';
        op1.Order_Placement__c='Contractor';
        op1.Distributor__c=acc1.Id;
        op1.No_of_Maxi_Filtra_Catridge__c=1;
        op1.No_of_Aluminum_cap_for_Maxi_Vent_Filtra__c=1;
        op1.No_of_P_A_P_A__c=1;
        op1.No_of_Mini_Vent__c=1;
        op1.No_of_Maxi_Vent__c=1;
        op1.No_of_Maxi_Filtra__c=1;
        op1.Grease_Interceptors__c = 'Yes';
        op1.Water_Tank__c = 'Yes';
        op1.Quantit_y__c = 2;
        op1.Quantity__c = 2;
        //op1.GSTN__c = '29ATQPC1989F1Z8';
        insert op1;
        
        /*  Opportunity opp1 = new Opportunity();
opp1.Name='TestClass1';
opp1.StageName = 'Designing';
opp1.CloseDate =date.TODAY()+12;
opp1.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
opp1.OwnerId=user1.id;
opp1.Project_Type__c='Commercial';
opp1.Mixed_Type__c='Malls';
opp1.No_of_Bathrooms__c = 12;
opp1.No_of_Floors__c=5;
opp1.Number_of_kitchens__c=6;
opp1.Number_of_towers__c=1;
opp1.Material_of_Stack__c='SWR';
opp1.Internal_Plumbing_Mix__c='CPVC';
opp1.Dimension_of_the_stack__c='110';
opp1.Project_Area__c =2563;
opp1.SWR_system_to_be_deployed__c='Single Stack with P.A.P.A & A.A.V';
opp1.Project_By__c=acc.Id;
opp1.Standard_ORC__c=4;
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
opp1.Distributor__c=acc1.Id;
insert opp1;

orcChangedSet.add(opp1.ID);
Opportunity opp11 = new Opportunity();
opp11.Name='TestClass11';
opp11.StageName = 'Designing';
opp11.CloseDate =date.TODAY()+12;
opp11.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
opp11.OwnerId=user1.id;
opp11.Project_Type__c='Commercial';
opp11.Mixed_Type__c='Malls';
opp11.No_of_Bathrooms__c = 12;
opp11.No_of_Floors__c=22;
opp11.Number_of_kitchens__c=6;
opp11.Number_of_towers__c=1;
opp11.Material_of_Stack__c='SWR';
opp11.Internal_Plumbing_Mix__c='CPVC';
opp11.Dimension_of_the_stack__c='160';
opp11.Project_Area__c =2563;
opp11.SWR_system_to_be_deployed__c='Single Stack with P.A.P.A & A.A.V';
opp11.Project_By__c=acc.Id;
opp11.Standard_ORC__c=4;
opp11.Special_Pricing_Request_Approval__c='Submitted';
opp11.Taluk__c=ap.Id;
opp11.Freight__c='FOR';
opp11.Delivery__c='2 weeks';
opp11.Price_Basis__c='FOR Site';
opp11.Delivery_Lots__c='9 Lots';
opp11.Taxes__c='Included';
opp11.Offer_Valid_Till__c='60 Days';
opp11.Payment_Term__c='45 days after delivery';
opp11.Delivery_Conditions_Gurantee__c='As per APPL general condition';
opp11.Order_Placement__c='Contractor';
opp11.Distributor__c=acc1.Id;
insert opp11;*/
        
        Opportunity opp = new Opportunity();
        opp.Name='TestClass';
        opp.StageName = 'Designing';
        opp.CloseDate =date.TODAY()+10;
        opp.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
        opp.OwnerId=user1.id;
        opp.Project_Type__c='Commercial';
        opp.Mixed_Type__c='Malls';
        opp.No_of_Bathrooms__c = 12;
        opp.No_of_Floors__c=19;
        opp.Number_of_kitchens__c=6;
        opp.Number_of_towers__c=1;
        opp.Material_of_Stack__c='SWR';
        opp.Internal_Plumbing_Mix__c='CPVC';
        opp.Dimension_of_the_stack__c='110';
        opp.Project_Area__c =2563;
        opp.SWR_system_to_be_deployed__c='Conventional';
        opp.Project_By__c=acc.Id;
        opp.Standard_ORC__c=4;
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
        opp.Distributor__c=acc1.Id;
        opp.BlazeMaster__c='No';
        //opp.GSTN__c='29ATQPC1989F1Z8';
        insert opp;
        
        /* Opportunity opp2 = new Opportunity();
opp2.Name='TestClass';
opp2.StageName = 'Designing';
opp2.CloseDate =date.TODAY()+10;
opp2.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
opp2.OwnerId=user1.id;
opp2.Project_Type__c='Residential';
opp2.Mixed_Type__c='Appartments';
opp2.No_of_Bathrooms__c = 12;
opp2.No_of_Floors__c=5;
opp2.Number_of_kitchens__c=6;
opp2.Number_of_towers__c=1;
opp2.Material_of_Stack__c='SWR';
opp2.Internal_Plumbing_Mix__c='Aqualife';
opp2.Dimension_of_the_stack__c='110';
opp2.Project_Area__c =2000;
opp2.SWR_system_to_be_deployed__c='Single Stack with P.A.P.A & A.A.V';
opp2.Project_By__c=acc.Id;
opp2.Standard_ORC__c=4;
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
opp2.Distributor__c=acc1.Id;
insert opp2;

Opportunity opp22 = new Opportunity();
opp22.Name='TestClass';
opp22.StageName = 'Designing';
opp22.CloseDate =date.TODAY()+10;
opp22.Approximate_Project_Value__c='Rs.0 – Rs.5Lakhs';
opp22.OwnerId=user1.id;
opp22.Project_Type__c='Residential';
opp22.Mixed_Type__c='Appartments';
opp22.No_of_Bathrooms__c = 12;
opp22.No_of_Floors__c=22;
opp22.Number_of_kitchens__c=6;
opp22.Number_of_towers__c=1;
opp22.Material_of_Stack__c='SWR';
opp22.Internal_Plumbing_Mix__c='Aqualife';
opp22.Dimension_of_the_stack__c='160';
opp22.Project_Area__c =2000;
opp22.SWR_system_to_be_deployed__c='Single Stack with P.A.P.A & A.A.V';
opp22.Project_By__c=acc.Id;
opp22.Standard_ORC__c=4;
opp22.Special_Pricing_Request_Approval__c='Submitted';
opp22.Taluk__c=ap.Id;
opp22.Freight__c='FOR';
opp22.Delivery__c='2 weeks';
opp22.Price_Basis__c='FOR Site';
opp22.Delivery_Lots__c='9 Lots';
opp22.Taxes__c='Included';
opp22.Offer_Valid_Till__c='60 Days';
opp22.Payment_Term__c='45 days after delivery';
opp22.Delivery_Conditions_Gurantee__c='As per APPL general condition';
opp22.Order_Placement__c='Contractor';
opp22.Distributor__c=acc1.Id;
insert opp22;*/
        
        orcChangedSet.add(opp.Id);
        Map<id,Opportunity> mapOpp=new Map<id,Opportunity>();
        mapOpp.put(opp.Id, opp);
        List<Opportunity> opplist=new List<Opportunity>();
        opplist.add(opp);
        
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
        
        opportunity op10=new opportunity();
        op10.id=opp.id;
        op10.Number_of_kitchens__c=126;
        update op10;
        Map<id,opportunity> newmap=new map<id,opportunity>(); 
        newmap.put(opp.id,op10);
        //   NewOfferSectionDMLHandler.updateCalcMatrixData(mapOpp,newmap);
        finalApproverUpdateFromOwner.finalapproverisnert(opplist);
        
        Test.stopTest();
        
    }
}