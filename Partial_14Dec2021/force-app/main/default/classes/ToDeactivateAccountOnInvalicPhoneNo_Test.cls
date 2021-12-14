@isTest
public class ToDeactivateAccountOnInvalicPhoneNo_Test{
    public static testmethod void PromoMemberMethod(){
         Account newAccount = new Account(
                                Name  = 'Test Name',
                                BillingState = 'Gujarat',
                                BillingStreet = 'Abc Street',
                                BillingCity = 'Abc City',
                                BillingCountry = 'India',
                                AccountNumber = '12345',
                                Contact_Number_Mobile__c = '9876543210'
                                );
        insert newAccount;
        Promotion__c pm = new Promotion__c();
        insert pm;
        Promotion_Member__c pmem1 = new Promotion_Member__c(Account__c = newAccount.ID, Promotions2__c = pm.ID, Call_Status__c = 'RNR');
        insert pmem1;
        Promotion_Member__c pmem2 = new Promotion_Member__c(ID = pmem1.ID, Call_Status__c = 'Wrong/Invalid Number');
        update pmem2;   
    }//end of PromoMemberMethod
}//end of class