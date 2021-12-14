@isTest
private class AccountSelectorTestClass {
public static testMethod void testAccount(){
    Set<Id> SetIds = new Set<Id>();
        Map<Id,Account> mapOfAccount=new  Map<Id,Account>();
      Map<Id,Case> mapOfCase=new  Map<Id,Case>();
         OperatingHours oh = new OperatingHours();
        oh.Name = 'TestOH';
        oh.TimeZone='America/Los_Angeles';
        insert oh;
        
      ServiceTerritory s1=new ServiceTerritory();
        s1.Name='Bangalore';
        s1.IsActive=true;
        s1.OperatingHoursId=oh.id;
        insert s1;
        
        Town_Master__c tm=new Town_Master__c();
        tm.Name='Bangalore';
        tm.State__c='Karnataka';
        tm.District__c='Bangalore';
        tm.Service_Territory__c=s1.id;
        insert tm;
        
        Account acc1=new Account();
        acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail-Customer').getRecordTypeId();
        acc1.Name='Customer';
        acc1.Contact_Number_Mobile__c='12345678901';
        acc1.Can_you_please_give_address_retail__c='asdfghj';
        acc1.City_lookup__c=s1.id;
        acc1.State__c='Karnataka';
        acc1.Country_fsl__c='India';
        acc1.PinCode__c='123456';
        acc1.Town_Code__c='5670';
        acc1.Town_Name__c=tm.id;
        acc1.Business_Line__c='Column';
        acc1.Products__c='CPVC';
        insert acc1;

     mapOfAccount.put(acc1.id,acc1);
        for(Account acc:mapOfAccount.values()){
            SetIds.add(acc.id);
        }
         
    AccountSelector.getAllAccountData(SetIds);
}}