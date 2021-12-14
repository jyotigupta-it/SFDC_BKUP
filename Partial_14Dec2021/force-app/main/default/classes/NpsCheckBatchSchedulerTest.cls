@isTest
private class NpsCheckBatchSchedulerTest {
    @isTest static void npsBatch() {
        List<Account> accList = new List<Account>();
        Account acc = new Account();
        acc.Name ='akh';
        acc.Primary_Contact_Person_Name__c='Vivek Rungta ';
        acc.Classification__c='A';
        acc.Purchase_Cycle__c='Weekly';
        acc.Contact_Number_Mobile__c='9308622241';
        acc.Street_Address__c='Station road';
        acc.Display_of_our_product__c='Prominent';
        acc.Type_of_Dealer__c='Sanitary';
        acc.Media__c='Outshop';    
        acc.Market__c ='Existing';
        acc.Party_Type__c='Plumber';
        acc.Status__c = 'Existing'; 
        acc.Discount__c=50.50;
        acc.VAT_CST_Number__c='123456789789123';
        acc.Annual_Ashirvad_Turnover__c=50;
        acc.Year_Since_in_Business__c='2018';
        acc.Conversion_Probability__c = 'Medium';
        acc.NpsTagged__c = true;
        accList.add(acc);
        
        Insert accList;
        
        Test.StartTest(); 
        NpsCheckBatchScheduler npsCheckBatch = new NpsCheckBatchScheduler();
        String sch = '0 55 23 L * ?'; // schedule class to run at particular time.
        System.schedule('Make NpsTagged to false', sch, npsCheckBatch);
        Test.StopTest();   
    }
}