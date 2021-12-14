@isTest
private class TransactionEscalationTest{
    @testSetup
    static void setup(){
        Id DlrRcdType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        Account accObj = new Account(Name='testName',Primary_Contact_Person_Name__c='testContactPerson',
                                     Status__c='Existing',Classification__c='Adopted',Purchase_Cycle__c='Weekly',
                                     Contact_Number_Mobile__c='9999999999',Type_of_Dealer__c='Sanitary',
                                     Display_of_our_product__c='Prominent',Media__c='In Shop',Sub_Media__c='Sunboard',Discount__c=40,recordtypeid=DlrRcdType);
        
        Transaction__c tranFields=new Transaction__c();
        tranFields.Status__c = 'INITIATED';
        INSERT tranFields;
        
        sales_accrual__c salesAccObj = new sales_accrual__c();
        salesAccObj.Bill_amount__c = 12121;
        salesAccObj.Account__c = accObj.Id;
        salesAccObj.Dealer__c = accObj.Id;
        salesAccObj.scheme_point__c = 1212;
        salesAccObj.Transaction__c = tranFields.Id;
        INSERT salesAccObj;
        
        Test.StartTest();
        tranFields.Status__c = 'PENDING';
        UPDATE tranFields;
    }
    @isTest
    static void toSendEmailTest(){
        Test.startTest();
        List<Transaction__History> histryList = new List<Transaction__History>();
        histryList = [SELECT Id,CreatedDate, ParentId, Field, OldValue, NewValue FROM Transaction__History WHERE Field = 'Status__c'];
        System.debug(histryList.size());
        Schedule_TransactionEscalationBatch sct= new Schedule_TransactionEscalationBatch();      
        String sct1 = '0 0 23 * * ?';
        System.schedule('Test',sct1,sct);
        Test.stopTest();
    }
    
}