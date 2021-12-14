/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :26-Jan-2015
Modified Date   :
Version         :1.0
Description     :Test class for Product_Page_v2_Controller 

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_ProductPagev2Controller {

    static User testUser;
    static Product2 testProduct;
    static Pricebook2 testPricebook;
    static PricebookEntry testPriceEntry;
    static PricebookEntry testPriceEntry2;
    static Account testAccount;
    static Opportunity testOpp;
    static Opportunity testOpp2;
    static OpportunityLineItem testOppLIYes; //Product Specified = 'Yes'
    static OpportunityLineItem testOppLINo; //Product Specified = 'No'
    static Influencer__c testInflu;
    static Project_Tracker__c testPT;

    static Order testOrder;
    static OrderItem testOrderItem;
    static Supply__c testSupply;
    static SupplyLineItem__c testSupplyItem;


    static void init(string MobNum) {

        testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
        insert testUser;

        testProduct = Initial_Test_Data.createProduct('Test product');
        insert testProduct;

        testPricebook = Initial_Test_Data.createPriceBook('Project');
        insert testPricebook;

        Id stdpb = Test.getStandardPricebookId();

        testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
        insert testPriceEntry;

        testPriceEntry2 = Initial_Test_Data.createPriceBookEntry(testPricebook.Id, testProduct.Id);
        insert testPriceEntry2;
 
        testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
        testAccount.Contact_Number_Mobile__c = mobNum;
        insert testAccount;

        testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
        testOpp.pricebook2Id = stdpb;
        insert testOpp;
        
        testOpp2 = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
        testOpp2.pricebook2Id = testPricebook.Id;
        insert testOpp2;
        

       /*testOppLIYes = Initial_Test_Data.createOppLineItemYes(testOpp.Id,'APPL Probability',testPriceEntry.Id);
       testOppLIYes.Probability_Quantity__c = null;
       testOppLIYes.Probability_Check__c = true;
       
        insert testOppLIYes;*/

        testOppLINo = Initial_Test_Data.createOppLineItemNo(testOpp2.Id,'APPL Probability',testPriceEntry2.Id);
        testOppLINo.Probability_Quantity__c = null;
        testOppLINo.Probability_Check__c = true;
       
        insert testOppLINo;

        testOrder = Initial_Test_Data.createOrder(testAccount.Id, testOpp2.Id, testPricebook.Id);
        insert testOrder;

        testOrderItem = Initial_Test_Data.createOrderItem(testProduct.Id, testOrder.Id, testAccount.Id, testPriceEntry2.Id);
        testOrderItem.Order_Value__c = 500;
        testOrderItem.ServiceDate = date.today();
        testOrderItem.ORC_Markup__c = 'hbkjdj';
        testOrderItem.ORC_Status__c = 'Paid';
        testOrderItem.Order_Status__c = 'Part Received';
        testOrderItem.UnitPrice = 20;
       
        insert testOrderItem;

        testSupply = Initial_Test_Data.createSupply(testOrder.Id, testOpp.Id);
        insert testSupply;

        testSupplyItem = Initial_Test_Data.createSupplyItem(testSupply.Id, testOrderItem.Id, testProduct.Id, testAccount.Id);
        insert testSupplyItem;

    

    }
    
    /* APPL Probability*/
    @isTest static void test_method_one() {
        
       init('9761542376');
        testProduct.Name = 'CPVC';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp2.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                oppController.probabilityListTemp[0].Product_Specified__c = 'Yes';
                oppController.saveProbability();
            Test.stopTest();
            
        }
    }
    
    @isTest static void test_method_two() {
        
        init('9761542386');
        testProduct.Name = 'UPVC';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                oppController.probabilityListTemp[0].Product_Specified__c = 'No';
                oppController.saveProbability();
                testProduct.Name = 'Concealed Cisterns';
                oppController.addProductsInProbability();
        update testproduct;
        
            Test.stopTest();
            
        }
    }
    
     @isTest static void test_method_three() {
        
        init('9761542396');
        testProduct.Name = 'SWR';
        update testproduct;
        testOppLINo.Offer_Quantity__c = 5;
        testOppLINo.Offer_MRP__c = 10;
        testOppLINo.Tentative_Date__c = 'Date.today()';
        testOppLINo.Discount_Offered__c = 10;
        testOppLINo.Price_List_Date__c = date.today();
        testOppLINo.Price_Valid_Date__c = date.today();
        testOppLINo.Competitor_name_Offer__c = '10';
        testOppLINo.Offer_Probability__c = '10';
        testOppLINo.Reason__c = 'test';
        testOppLINo.Probability_Quantity__c = 25;
        testOppLINo.Probability_MRP__c = 23;
        testOppLINo.Product_Specified__c = 'yes';
        testOppLINo.Probability__c = 'Unit';
        testOppLINo.Description = 'sdfs';
        testOppLINo.Offer_Check__c = true;
        
        testOppLINo.Order_Loss__c='test';
        update testOppLINo;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp2.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                
                oppController.saveProbability();
                oppController.generateOffer();
               // oppController.offerList[1].Offer_Check__c = false;
                oppController.saveOffer();
                oppController.generateOrder();   
                oppController.generateOrderLoss();             
                oppController.OrderItemList[0].createOrder = true;
                //oppController.parentOrderRecord.add(testorder);
                oppController.saveOrder();
                oppController.generateSupply();
                 oppController.SupplyItemList[0].createSupply=true;
                oppController.saveSupply();
                oppController.orderLossList[0].createOrderLoss = true;
                //OrderLossWrapperClass.createOrderLoss=true;
                oppController.saveOrderLoss();
                oppController.parentOrderRecord=new List<Order>();
               // oppController.saveOrder();
                //oppController.saveSupply();
                oppController.deleteRow();
                
                 ApexPages.currentPage().getParameters().put('Id',null);
                 oppController.saveOrder();
                
                Test.stopTest();
        }
     }
     
     @isTest static void test_method_four() {
        
        init('9761542166');
        testProduct.Name = 'Silent SWR';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                oppController.saveProbability();
                Test.stopTest();
        }
     }
     
     @isTest static void test_method_five() {
        
        init('9761542266');
      testProduct.Name = 'WC Pan Connector';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                Test.stopTest();
        }
     }
     
     @isTest static void test_method_six() {
        
        init('9761542466');
        testProduct.Name = 'Concealed Cisterns';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                Test.stopTest();
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
        }
     }
     
     @isTest static void test_method_seven() {
        
       init('9761542566');
        
        testProduct.Name = 'Waste & Traps';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                oppController.probabilityList= new List<OpportunityLineItem>();
                oppController.orderList= new List<OpportunityLineItem>();
                oppController.supplyList= new List<OpportunityLineItem>();
                oppController.renderAddSupply=true;         
                Test.stopTest();
        }
     }
     
     @isTest static void test_method_eight() {
        
        init('9761542766');
        testProduct.Name = 'Concealed Valves';
        update testproduct;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/Product_Page_v2');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                ApexPages.currentPage().getParameters().put('applType','probType');
                ApexPages.currentPage().getParameters().put('pIndex','0');
                Product_Page_v2_Controller oppController = new Product_Page_v2_Controller(sc);
                Test.stopTest();
        }
     }
     
     /*@isTest static void test_method_nine() {
        
        init();
       Product2 testProduct = Initial_Test_Data.createProduct('Concealed Cisters');
        insert testProduct;
        PricebookEntry testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
        insert testPriceEntry;
       OpportunityLineItem testOppLI = Initial_Test_Data.createOppLineItemYes(testOpp.Id,'APPL Probability',testPriceEntry.Id);
       testOppLI.Probability_Quantity__c = null;
       testOppLI.Probability_Check__c = true;
        insert testOppLI;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
        }
     }
     @isTest static void test_method_ten() {
        
        init();
       Product2 testProduct = Initial_Test_Data.createProduct('Concealed Cisters');
        insert testProduct;
        PricebookEntry testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
        insert testPriceEntry;
       OpportunityLineItem testOppLI = Initial_Test_Data.createOppLineItemYes(testOpp.Id,'APPL Probability',testPriceEntry.Id);
       testOppLI.Probability_Quantity__c = null;
       testOppLI.Probability_Check__c = true;
        insert testOppLI;
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
        }
     }*/
    
}