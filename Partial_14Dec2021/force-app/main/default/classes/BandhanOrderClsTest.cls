@isTest
public class BandhanOrderClsTest {
    static testMethod void BandhanOrderClsMethod() {
        Account acc = new Account();
        acc.Name = 'Bandhan';
        acc.Status__c = 'Existing';
        acc.Discount__c = 10;
        acc.Contact_Number_Mobile__c = '9859000000';
        Insert acc;
        
        Bandhan_Orders__c bandhan = new Bandhan_Orders__c();
        bandhan.Cart_Status__c = 'Order Given';
     //   bandhan.Year_of_CreatedDate__c = '';
     //   bandhan.Month_of_CreatedDate__c = '';
        bandhan.Account__c = acc.Id;
        
        Insert bandhan;
        
        BandhanOrderCls.getBandhanOrdRec(acc.Id);
            
    }
}