@isTest
public class Test_dpAppointmentApplicationForm {
    
   public static Account testAccount;
    public  static Account test1Account;
    public static DP_Detail__c testdpdetail;
   public  static Bank_Details__c testbank;
   public  static Contact testcon;
    public static Sales_Projection__c testsp;
    public static Partner_Detail__c pdeatil;
    public static Business_Activity_History__c Bactivity;
    @istest
     static void prepareTestData()
     {
         Account newaccount = new Account();
         Account testAccount = new Account(
             RecordTypeId= Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').recordTypeId,
         ParentId = 'Testing',
             Name = 'Dealer',
             Primary_Contact_Person_Name__c='Primary',
             Status__c='Cold Call',
             Business_Line__c='All Product',
             Classification__c='A',
             Party_Type__c='Dealer',
             Purchase_Cycle__c='Weekly',
             Contact_Number_Mobile__c='1234567890',
             APPL_Taluk__c='Taluk Junction',
             Display_of_our_product__c='Prominent',
             Media__c='N',
             Type_of_Dealer__c='HARDWEAR',
             Salutation__c='Mr.'
         );
         Test.startTest(); 
         insert testAccount;
         Account test1Account =  [select Id,Name,Primary_Contact_Person_Name__c,Status__c,Business_Line__c,Classification__c,Party_Type__c,
                    Purchase_Cycle__c,Contact_Number_Mobile__c,APPL_Taluk__c,Display_of_our_product__c ,Media__c,Type_of_Dealer__c
                    from Account Limit 1];
        
         Bank_Details__c testbank1 = new Bank_Details__c(Distributor__c=testAccount.id,
                                                        Name_of_your_Bank__c='HSB', Bank_Account_Number__c='34563456' );
         Insert  testbank1;
         Partner_Detail__c prdeatil = new Partner_Detail__c(
             RecordTypeId= Schema.SObjectType.Partner_Detail__c.getRecordTypeInfosByName().get('Distribution_Partner').recordTypeId, 
             Name_of_the_Project_Handled__c='one',
            Value__c=10000 ,Distributor__c= testAccount.id                                              
         );
         insert prdeatil;
         Sales_Projection__c onesp = new Sales_Projection__c(
          Distributer__c =testAccount.id,
          RecordTypeId= Schema.SObjectType.Sales_Projection__c.getRecordTypeInfosByName().get('Sales_Projection').recordTypeId,
          Product_Type__c= 'Agriculture'
         );
         Insert onesp;
         DP_Detail__c onedpdetail = new DP_Detail__c(
         Distributor__c =testAccount.id,
         RecordTypeId= Schema.SObjectType.DP_Detail__c.getRecordTypeInfosByName().get('Turnover_Details').recordTypeId,
             Year_1__c= 2000, Year_2__c=3909
         );
         insert onedpdetail;
          Business_Activity_History__c Bsactivity = new  Business_Activity_History__c(
          Name='New Brand',
              Type__c='RETAIL',
              Projected_Sales_In_Lacs__c = 5
          );
         insert Bsactivity;
          Test.stopTest();
     }
     @isTest
    public static void UpdateAccount()
    {
        prepareTestData();
      testAccount.ParentId = 'Testingone';
            testAccount.Name = 'Contract';
             testAccount.Primary_Contact_Person_Name__c='Secondary';
        update testAccount;
    
    }
    
    
    

}