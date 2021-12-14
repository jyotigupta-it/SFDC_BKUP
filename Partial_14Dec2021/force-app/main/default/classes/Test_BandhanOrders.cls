@isTest
public class Test_BandhanOrders{
    private static Account testAccount1;
    public static testMethod void one(){
        testAccount1 = Initial_Test_Data.createAccount('Testount1', 'Dealer');
        testAccount1.Contact_Number_Mobile__c ='7253452222';
        testAccount1.Party_Type__c='Dealer';
        testAccount1.District__c='Bangalore';
        testAccount1.State__c='Karnataka';
        testAccount1.Business_Line__c='Plumbing';
        insert testAccount1;

        Bandhan_Orders__c bandhanOBJ1 = new Bandhan_Orders__c();
       // bandhanOBJ1.account__c=testAccount1.id;
       // insert bandhanOBJ1;

        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(bandhanOBJ1);
        Bandhan_Order_Controller BndhnOBJ=new Bandhan_Order_Controller(sc);
        PageReference pageRef = Page.Bandhan_Orders;
        pageRef.getParameters().put('pid', String.valueOf(testAccount1.Id));
        Test.setCurrentPage(pageRef);
        BndhnOBJ.accountId=ApexPages.currentPage().getParameters().get('pid');
        bandhanOBJ1.account__c=BndhnOBJ.accountId;
        BndhnOBJ.callPersonName='Call Executive1';
        BndhnOBJ.getbandhanOBJ();
    
        BndhnOBJ.save();
        //insert bandhanOBJ1;
        //insert obj;
        
        test.stopTest();
 }
    public static testMethod void two(){
        testAccount1 = Initial_Test_Data.createAccount('Testount1', 'Dealer');
        testAccount1.Contact_Number_Mobile__c ='7253452222';
        testAccount1.Party_Type__c='Dealer';
        testAccount1.District__c='Bangalore';
        testAccount1.State__c='Karnataka';
        testAccount1.Business_Line__c='Plumbing';
        insert testAccount1;

        Bandhan_Orders__c bandhanOBJ1 = new Bandhan_Orders__c();
       // bandhanOBJ1.account__c=testAccount1.id;
       // insert bandhanOBJ1;

     

        test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(bandhanOBJ1);
        Bandhan_Order_Controller BndhnOBJ=new Bandhan_Order_Controller(sc);
        PageReference pageRef = Page.Bandhan_Orders;
        pageRef.getParameters().put('pid', String.valueOf(testAccount1.Id));
        Test.setCurrentPage(pageRef);
        BndhnOBJ.AccountId=ApexPages.currentPage().getParameters().get('pid');
        bandhanOBJ1.account__c=BndhnOBJ.AccountId;
        BndhnOBJ.callPersonName='';
        BndhnOBJ.getbandhanOBJ();
    
       
        BndhnOBJ.saveAndNew();
              
        test.stopTest();
 }

}