@isTest
private class AccountGeocodeUpdateController_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    Account account_Obj = new Account(Name = 'Name179', Contact_Number_Mobile__c = '9999999999', BillingStreet = 'PratapNagar', BillingCity = 'Jaipur', BillingState = 'Raj', BillingPostalCode = '302022', BillingCountry = 'India',  Inactive_Mobile_No__c = false, System_Flag__c = false, Account_Status_Flag__c = false, Geolocation__Latitude__s = 0, Geolocation__Longitude__s = 0);
    Insert account_Obj; 
    test.stopTest();
  }
  static testMethod void test_updateAccountGeoDetails_UseCase1(){
    List<Account> account_Obj  =  [SELECT Id,Name,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,BillingAddress,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    PageReference pageRef = Page.CaptureAccountGeoLocation;
    pageRef.getParameters().put('id',account_Obj[0].ID);
    Test.setCurrentPage(pageRef);
    AccountGeocodeUpdateController obj01 = new AccountGeocodeUpdateController(new ApexPages.StandardController(account_Obj[0]));
    obj01.acct = account_Obj[0];
   // obj01.accountId = '01p90000006uk2w';
  // string seilizeVal = JOSN.serilize(account_Obj[0]);
    AccountGeocodeUpdateController.updateAccountGeoDetails(account_Obj[0].Id,'{"LATITUDE":12.9140683,"LONGITUDE":77.6322311,"STREET":"5th Main Road","CITY":"Bangalore Urban","STATE":"Karnataka","COUNTRY":"India","POSTAL_CODE":"560102"}');
  }
}