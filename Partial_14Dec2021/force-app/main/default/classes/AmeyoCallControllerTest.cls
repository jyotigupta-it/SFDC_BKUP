@IsTest
private class AmeyoCallControllerTest {
    @IsTest static void callCustomerTest() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorAmeyo());
        
        Account objParentAccount = TestDataFactory.createParentAccount();
        insert objParentAccount;
        
        Id dealerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Dealer').getRecordTypeId();
        Account objAccount = TestDataFactory.createDealerAccount(objParentAccount.Id, dealerRecordTypeId);
        insert objAccount;
        
        Target__c objTarget = TestDataFactory.createTarget();
        Insert objTarget;
        
        Promotion__c objPromotion = TestDataFactory.createPromotion();
        Insert objPromotion;
        
        AP_Tour_Plan__c objAPTourPlan = TestDataFactory.createAPTourPlan(objAccount.Id, objTarget.Id);
        Insert objAPTourPlan;
        
        AP_Site_Visit__c objAPSiteVisit = TestDataFactory.createAPSiteVisit(objAPTourPlan.Id, objTarget.Id);
        Insert objAPSiteVisit; 
        
        test.startTest();
        system.assertEquals('{"example":"test"}', 
                            AmeyoCallController.callCustomer(objAPSiteVisit.Id ,'1234567896','testTaskId'));
        test.stopTest();
    }
    
}