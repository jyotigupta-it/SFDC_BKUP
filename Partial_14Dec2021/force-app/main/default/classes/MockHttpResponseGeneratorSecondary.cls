@isTest
global class MockHttpResponseGeneratorSecondary implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        System.assertEquals('http://180.179.7.179/integration/read/jsonSecondrySales', req.getEndpoint()); 
        System.assertEquals('GET', req.getMethod());
        
        
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"id":"1006998","Dealer_Code":"URCHNL808617","Dealer_Name":"SANITARY SHOPPEE","Sales_Value":"3588","Invoice_Date":"2019-07-11 00:00:00"}]');
        res.setStatusCode(200);
        
        
        List<Account> accList = new List<Account>();
        accList = [select id from Account LIMIT 1];
        system.debug('accList is ' + accList);
        
        List<User_Taluk_Master_Junction__c> talukList = new List<User_Taluk_Master_Junction__c>();
        talukList = [select id from User_Taluk_Master_Junction__c LIMIT 1];
        
        DealerSecondaryApi.AccountWrapper accWrap = new DealerSecondaryApi.AccountWrapper();
        accWrap.Dealer_Code = 'URCHNL808617';
        accWrap.Invoice_Date = '22/07/2019';
        accWrap.Sales_Value = '8215';
        accWrap.Trans_No = '01042018URCHNL426995';
        
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
        dist.Sparsh_Code__c = 'URCHNL796329';
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
        
        Secondary_Sales_Order__c ss = new Secondary_Sales_Order__c();
        ss.Amount__c = 123456;
        ss.Account__c = acc.Id;
        ss.Date__c = Date.parse(accWrap.Invoice_Date);
        ss.MergedField__c = accWrap.Trans_No;
        insert ss;
        
        
        
        
        return res;
    }
}