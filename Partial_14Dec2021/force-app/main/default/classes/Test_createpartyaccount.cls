@isTest
public class Test_createpartyaccount {
    
    public static Account account;

    public static void init(string partytype) {
       createPartyAccount_Ctrl partyaccount =  new createPartyAccount_Ctrl();
        partyaccount.quickAccount.Name='Upendar';
        partyaccount.quickAccount.Party_Type__c=partytype;
        partyaccount.quickAccount.Firm_Name__c='TestFirm';
        partyaccount.quickAccount.Contact_Number_Mobile__c='1234567898';
        partyaccount.quickAccount.Visit_Type__c='Ex-Station';
        partyaccount.quickAccount.State__c='Andhra Pradesh';
        partyaccount.quickAccount.District__c='Hyderabad';
        partyaccount.quickAccount.City__c='Hyderabad';
        partyaccount.createAccount();
        partyaccount.CanelAccount();
    }   
    public static testmethod void testone() {
       
        test.starttest();
         init('Dealer');
        test.stoptest();
    }
     public static testmethod void testwo() {
       
        test.starttest();
         init('Direct Dealer');
        test.stoptest();
    }
    public static testmethod void testhree() {
       
        test.starttest();
         init('Distributor');
        test.stoptest();
    }
     public static testmethod void testfour() {
       
        test.starttest();
         init('TestPartytype');
        test.stoptest();
    }
}