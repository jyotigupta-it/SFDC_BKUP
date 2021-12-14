@isTest
class Test_forLookupPopup{
    
    static  testmethod void init(){
        Account newAccount = new Account();
        
        newAccount.Name='isaac';
        newAccount.BillingState='Gujarat';
        newAccount.BillingStreet= 'Abc Street';
        newAccount.BillingCity = 'Abc City';
        newAccount.BillingCountry = 'India';
        newAccount.Party_Type__c='Distributor';
        newAccount.Status__c='Existing';
        
        
        //insert newAccount;
        System.debug('%%%%%%%%%%%%%%%%%'+newAccount);
        
        
        test.StartTest();
        
        LookupController obj=new LookupController ();
        System.assertEquals(null, obj.runQuery());
        test.StopTest();
    }
}