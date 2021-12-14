@isTest
private class Test_createPromotion_Ctrl_v2
{   
    //Account - Distributor
    //Account - 3
    //Promotion
    //Promotion Members
    static User testUser;
    private static Account testAccountDis1;
    private static Account testAccount1;
    private static Account testAccount2;
    private static Account accDistributor;

    static Account testAccount;
    static Opportunity testOpp;

    private static Promotion__c newPromotion;
    private static Promotion_Member__c proMember1;
    private static Promotion_Member__c proMember2;
    private static Promotion_Member__c proMember3;


    // initializing test data
    private static void init()
    {
        

    }

    private static testMethod void promotionUnitTest() {
        
        testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
        insert testUser;
        
       
        testAccountDis1 = Initial_Test_Data.createAccount('test Account1','Distributor');
        testAccountDis1.Contact_Number_Mobile__c ='7259582222'; 
        insert testAccountDis1;

        testAccount1 = Initial_Test_Data.createAccount('Test Account1', 'Dealer');
        testAccount1.Contact_Number_Mobile__c ='7259582222';
        testAccount1.Party_Type__c='Dealer';
        insert testAccount1;

        testAccount2 = Initial_Test_Data.createAccount('Test Account2', 'Key Accounts');
        testAccount2.Contact_Number_Mobile__c = '7259582222';
        insert testAccount2;

        //Start Test
        Test.startTest();
        //Call the VF Page
        pagereference pr=new pagereference('/apex/createPromotion_v2?promoDate=04/05/2015');
        Test.setCurrentPageReference(pr);
        //Creating Instance of the Controller
        createPromotion_Ctrl_v2 promotionInstance = new createPromotion_Ctrl_v2();

        newPromotion = Test_Intial_Data_Phase2.CreatePromotion('Architects Meet');
        insert newPromotion;
        
        
         promotionInstance.newpromotion.Date__c= date.today();
         promotionInstance.newpromotion.Type__c = 'Dealer';
         promotionInstance.newpromotion.Total_Expenses__c = 1000;
         promotionInstance.newpromotion.Total_no_of_attendees__c = 0;
         promotionInstance.newpromotion.State__c = 'Karnataka';
         promotionInstance.newpromotion.Location__c = 'BTM';
         promotionInstance.newpromotion.Distributor__c=testAccountDis1.id;
        promotionInstance.CreatePromotion();
        promotionInstance.addMember();
        
        

        
        createPromotion_Ctrl_v2.getCustomer('725');
        apexpages.currentpage().getparameters().put('rowIndex' , '1');
        apexpages.currentpage().getparameters().put('cusMobile','7259582222');
        promotionInstance.getAccoutRow();
        promotionInstance.CancelToPromo();
        
        proMember1 = Test_Intial_Data_Phase2.CreatePromotionMember(newPromotion.Id, testAccount1.Id);
        insert proMember1;
        System.debug(proMember1+'=proMember1');
        
        proMember2 = Test_Intial_Data_Phase2.CreatePromotionMember(newPromotion.Id, testAccount2.Id);
        insert proMember2;
        System.debug(proMember2+'=proMember2');
        promotionInstance.SavePromotionMembers();
        promotionInstance.CancelToPromo();
        promotionInstance.CanelPromotion();
       Test.stopTest();
        //End of Test Method

    }
    
}