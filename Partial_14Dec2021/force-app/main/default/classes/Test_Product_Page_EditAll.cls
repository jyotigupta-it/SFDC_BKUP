/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :02-Mar-2015
Modified Date   :
Version         :1.0
Description     :Test class for Product_Page_EditAll_Controller

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_Product_Page_EditAll {
    
    static User testUser;
    static Product2 testProduct;
    static Pricebook2 testPricebook;
    static PricebookEntry testPriceEntry;
    static PricebookEntry testPriceEntry2;
    static Account testAccount;
    static Opportunity testOpp;
    static OpportunityLineItem testOppLI;

    static Order testOrder;
    static OrderItem testOrderItem;
    static Supply__c testSupply;
    static SupplyLineItem__c testSupplyItem;


    static void init(string mobNum) {

            testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
            insert testUser;

            testProduct = Initial_Test_Data.createProduct('Test Product');
            insert testProduct;

            Id stdpb = Test.getStandardPricebookId();
            testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
            insert testPriceEntry;
            
            testPricebook = Initial_Test_Data.createPriceBook('Project');
            insert testPricebook;

            testPriceEntry2 = Initial_Test_Data.createPriceBookEntry(testPricebook.Id, testProduct.Id);
            insert testPriceEntry2;

            testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
            testAccount.Contact_Number_Mobile__c = mobNum;
            insert testAccount;

            testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
            insert testOpp;

            testOppLI = Initial_Test_Data.createOppLineItem(testOpp.Id,'APPL Probability',testPriceEntry2.Id);
            testOppLI.Quantity = 1;
            testOppLI.Probability_Check__c = true;
            testOppLI.Offer_Check__c = false;
            testOppLI.Order_Check__c = true;
            testOppLI.Supply_Check__c = true;
            testOppLI.Probability_Quantity__c = 5;
            insert testOppLI;

            testOrder = Initial_Test_Data.createOrder(testAccount.Id, testOpp.Id, testPricebook.Id);
            insert testOrder;

            testOrderItem = Initial_Test_Data.createOrderItem(testProduct.Id, testOrder.Id, testAccount.Id, testPriceEntry2.Id);
            insert testOrderItem;

            testSupply = Initial_Test_Data.createSupply(testOrder.Id, testOpp.Id);
            insert testSupply;

            testSupplyItem = Initial_Test_Data.createSupplyItem(testSupply.Id, testOrderItem.Id, testProduct.Id, testAccount.Id);
            insert testSupplyItem;
    }


    @isTest static void test_method_one() {
        
        init('9761542316');
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                Apexpages.currentPage().getParameters().put('delId',testOppLI.Id);
               
                Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
                //oppController.getoppList();
                oppController.savePage();
                //oppController.buttonAction();
                oppController.deleteRow();
              

            Test.stopTest();
            
        }
    
    }
    
    @isTest static void test_method_two() {
        init('9761542326');
        system.runAs(testUser) {

            Test.startTest();
                
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','offerType');
                Apexpages.currentPage().getParameters().put('emptyDataId',testOppLI.Id);
                
                Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
                //oppController.getOfferListPro();
                //oppController.oppOfferList[0].Offer_Check__c = false;
                oppController.savePage();
                oppController.deleteData();

            Test.stopTest();
            
        }
    }

    @isTest static void test_method_three() {
        init('9761542336');
        system.runAs(testUser) {

            Test.startTest();
                
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','orderType');
                Apexpages.currentPage().getParameters().put('emptyDataId',testOppLI.Id);
                
                Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
                oppController.getOrderListPro();
                oppController.savePage();
                oppController.deleteData();

            Test.stopTest();
            
        }
    }

    @isTest static void test_method_four() {
        init('9761542346');
        system.runAs(testUser) {

            Test.startTest();
                
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','supplyType');
                Apexpages.currentPage().getParameters().put('emptyDataId',testOppLI.Id);
                
                Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
                oppController.getSupplyListPro();
                oppController.savePage();
                oppController.deleteData();

            Test.stopTest();
            
        }
    }
    
    
    @isTest static void test_method_five() {
    init('9761542356');
    system.runAs(testUser) {

      Test.startTest();
        testOppLI.Offer_Check__c = true;
        update testOppLI;
        ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
        PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
              Test.setCurrentPage(pageRef);
              ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
            
               ApexPages.currentPage().getParameters().put('applType','offerType');
              Apexpages.currentPage().getParameters().put('emptyDataId',testOppLI.Id);
              
              Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
              //oppController.getOfferListPro();
              oppController.oppOfferList[0].Offer_Check__c = false;
              oppController.savePage();
                oppController.oppOfferList[0].Offer_Check__c = true;
              oppController.savePage();
                 ApexPages.currentPage().getParameters().put('applType','retailOfferType');
                 oppController.savePage();
                 
                           ApexPages.currentPage().getParameters().put('applType','orderLost');
                            oppController.savePage();

      Test.stopTest();
      
    }
  }

  @isTest static void test_method_six() {
    init('9761542366');
    system.runAs(testUser) {

      Test.startTest();
        testOppLI.Offer_Check__c = true;
        update testOppLI;
        ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
        PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
              Test.setCurrentPage(pageRef);
              ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
              ApexPages.currentPage().getParameters().put('applType','orderLost');
              Apexpages.currentPage().getParameters().put('emptyDataId',testOppLI.Id);
              
              Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
              //oppController.getOfferListPro();
              oppController.oppOrderList= new list<OpportunityLineItem>();
              oppController.oppSupplyList= new list<OpportunityLineItem>();
              oppController.saveOrder=true;
              oppController.saveSupply=true;
              oppController.delID='asd';
              oppController.getOrderLossList();              
              oppController.savePage();

      Test.stopTest();
      
    }
  }
     @isTest static void test_method_seven() {
    init('9761542356');
    system.runAs(testUser) {

      Test.startTest();
        testOppLI.Offer_Check__c = true;
        update testOppLI;
        ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
        PageReference pageRef = new PageReference('/apex/Product_Page_EditAll');
              Test.setCurrentPage(pageRef);
              ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
            
               ApexPages.currentPage().getParameters().put('applType','retailOfferType');
              Apexpages.currentPage().getParameters().put('emptyDataId',testOppLI.Id);
              
              Product_Page_EditAll_Controller oppController = new Product_Page_EditAll_Controller(sc);
              //oppController.getOfferListPro();
              oppController.oppOfferList[0].Offer_Check__c = false;
              oppController.savePage();
              oppController.oppOfferList[0].Offer_Check__c = true;  
                oppController.savePage();

      Test.stopTest();
      
    }
  }
 
  
}