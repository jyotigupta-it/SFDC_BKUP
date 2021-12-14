@isTest
global class MockHttpResponseGeneratorChurn implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        List<RecordType> rtList = new List<RecordType>();
        rtList = [select name from RecordType where Name ='Distributor'];
        system.debug('rt Name ' + rtList);
        
        
        
        HttpResponse res = new HttpResponse();
        String myLabel = System.Label.ChurnUrl;
        
        System.assertEquals(myLabel, req.getEndpoint()); 
        System.assertEquals('GET', req.getMethod());
        
        
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"distributor_id":"1","Dealer_Code":"URCHNL796328","Dealer_Name":"Kajaria Sanitaryware Pvt.Ltd","Predicted_Class":"Churned","added_on":"2019-07-18 11:08:56"}]');
        res.setStatusCode(200);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c();
        utmj.name = 'test utmj';
        
        DealerChurnAPI.AccountWrapper accWrap = new DealerChurnAPI.AccountWrapper();
        accWrap.Dealer_Code = 'URCHNL796329';
        accWrap.Predicted_Class = 'Others';
        
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
        acc.Sparsh_Code__c = 'URCHNL796328';
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
        
        acc.Status__c = 'Existed';
        update acc;
        
        return res;
    }
}