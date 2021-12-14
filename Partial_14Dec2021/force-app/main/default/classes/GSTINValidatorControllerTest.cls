@IsTest
public class GSTINValidatorControllerTest {

    private static testmethod void validateGSTIN(){
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorGSTIN());
        
        Account objParentAccount = TestDataFactory.createParentAccount();
        insert objParentAccount;
        
        Id dealerRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Dealer').getRecordTypeId();
        Account objAccount = TestDataFactory.createDealerAccount(objParentAccount.Id, dealerRecordTypeId);
        insert objAccount;
        
        test.startTest();
        system.assertEquals('Success', 
                            GSTINValidatorController.validateGSTIN(objAccount.Id));
        test.stopTest();
    }
}