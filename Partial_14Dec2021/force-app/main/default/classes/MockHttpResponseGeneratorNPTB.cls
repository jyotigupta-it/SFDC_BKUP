@isTest
global class MockHttpResponseGeneratorNPTB implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        System.assertEquals('http://180.179.7.179/integration/read/jsonNTBP', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"id":"6613","Dealer_Code":"URCHNL806534","Dealer_Name":"MANIVAR ASSOCIATES","Products":[{"Name":"CPVC___2225111-3 FABT ( BRASS ) 80MM CPVC FITTINGS"},{"Name":"CPVC___2224621-3 X 2 REDUCER COUPLER( SCH 80 ) (8.0 X 5.0)MM CPVC FITTINGS"},{"Name":"CPVC___2228102 - 80 MM (3) Sch 80 Coupler - FG PLUS CPVC Fittings"},{"Name":"CPVC___2228214 - 150 MM OD (6) ELBOW - FG PLUS CPVC Fittings"},{"Name":"CPVC___2129214 - 150 MM OD (6) SCH 40 (5 Mtr) FG PLUS CPVC Pipes"},{"Name":"CPVC___2228497 -1 Flange (Open) SDR 11 - FG PLUS CPVC Fittings"},{"Name":"CPVC___2228103 - 100 MM (4) Sch 80 Coupler - FG PLUS CPVC Fittings"},{"Name":"CPVC___2224620-3 X 2 REDUCER COUPLER ( SCH 40 ) (8.0 X 5.0)MM CPVC FITTINGS"},{"Name":"CPVC___2227203-4 SHORT BEND ( SCH 40 ) (10 CM) CPVC FITTINGS"},{"Name":"CPVC___2227202-80MM (3) SHORT BEND ( SCH - 40 ) CPVC FITTING"}],"added_on":"2019-07-15 09:56:09"}]');
        res.setStatusCode(200);
        
        List<Account> accList = new List<Account>();
        accList = [select id from Account LIMIT 1];
        system.debug('accList is ' + accList);
        
        List<User_Taluk_Master_Junction__c> talukList = new List<User_Taluk_Master_Junction__c>();
        talukList = [select id from User_Taluk_Master_Junction__c LIMIT 1];
        
        DealerNptbApi2.Products produ = new DealerNptbApi2.Products();
        produ.Name = 'CPVC___2225111-3 FABT ( BRASS ) 80MM CPVC FITTINGS';
        
        DealerNptbApi2.AccountWrapper accWrap = new DealerNptbApi2.AccountWrapper();
        accWrap.Dealer_Code = 'URCHNL806534';//'URCHNL808617';
        accWrap.prod = produ;
        
        List<RecordType> rtList = new List<RecordType>();
        rtList = [select name from RecordType where Name ='Distributor'];
        system.debug('rt Name ' + rtList);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c();
        utmj.name = 'test utmj';
        insert utmj;
        
        Account dist = new Account();
        dist.RecordTypeId = rtList[0].Id;
        dist.Name = 'SANITARY SHOPPEE dist';
        dist.Primary_Contact_Person_Name__c = 'Ashirvad Pipes';
        dist.Classification__c = 'B';
        dist.Purchase_Cycle__c = 'Fortnightly';
        dist.Sparsh_Code__c = 'URCHNL806534';//'URCHNL796329';
        dist.Contact_Number_Mobile__c = '9557087543';
        dist.Type_of_Dealer__c = 'Sanitary';
        dist.Display_of_our_product__c = 'Prominent';
        dist.Media__c = 'Outshop';
        dist.APPL_Taluk__c = utmj.id;
        dist.Status__c = 'Existing';
        dist.Conversion_Probability__c = 'Medium';
        dist.Discount__c = 7;
        dist.VAT_CST_Number__c = '29AXDPT6526E1Z7';
        dist.Annual_Ashirvad_Turnover__c = 123456789;
        dist.Year_Since_in_Business__c = '2015';
        dist.Accountant__c = 'Yes';
        dist.Accounting_software_installed__c = 'Yes';
        dist.Avg_Credit_days_offered_in_market__c = 15;
        dist.Dedicated_office_space__c = 'Yes';
        dist.Distribution_as_a_part_of_total_business__c = 25;
        dist.Ramco_ID__c = '2';
        dist.SAP_id_DP__c = 'sap1234';
        dist.Size_of_Dedicated_godown_for_Ashirvad__c = 2;
        dist.Total_working_capital_investment__c = 125;
        dist.Borrowed_capital__c = 34343;
        dist.Expected_AA_contribution_in_total_busi__c = 25;
        dist.Name_of_software__c = 'Sample';
        dist.Total_Annual_Turnover__c = 45;
        insert dist;
        
        Account acc = new Account();
        acc.ParentId = dist.id;
        acc.Name = 'SANITARY SHOPPEE';
        acc.Primary_Contact_Person_Name__c = 'Ashirvad Pipes';
        acc.Classification__c = 'B';
        acc.Purchase_Cycle__c = 'Fortnightly';
        acc.Sparsh_Code__c = 'URCHNL808617';
        acc.Contact_Number_Mobile__c = '9557087543';
        acc.Type_of_Dealer__c = 'Sanitary';
        acc.Display_of_our_product__c = 'Prominent';
        acc.Media__c = 'Outshop';
        acc.APPL_Taluk__c = utmj.id;
        acc.Status__c = 'Existing';
        acc.Conversion_Probability__c = 'Medium';
        acc.Discount__c = 7;
        acc.VAT_CST_Number__c = '29AXDPT6526E1Z7';
        acc.Annual_Ashirvad_Turnover__c = 123456789;
        acc.Year_Since_in_Business__c = '2015';
        insert acc;
        
        NPTB__c nptb = new NPTB__c();
        nptb.Account__c = acc.Id;
        nptb.Product__c = 'CONCEALED VALVES___2221105-1" X 1/2" 3 IN MIXER AD';
        insert nptb;
        
        return res;
    }
}