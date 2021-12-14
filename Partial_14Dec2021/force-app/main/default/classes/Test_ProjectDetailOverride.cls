/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :24-Jan-2015
Modified Date   :
Version         :1.0
Description     :Test class for ProjectDetailPageOverride page

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_ProjectDetailOverride {
    
    static User testUser;
    static Product2 testProduct;
    static PricebookEntry testPriceEntry;
    static Account testAccount;
    static Opportunity testOpp;
    static OpportunityLineItem testOppLI;
    static Influencer__c testInflu;
    static Project_Tracker__c testPT;


    static void init(string mobNum) {

        testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
        insert testUser;

        testProduct = Initial_Test_Data.createProduct('Test Product');
        insert testProduct;

        Id stdpb = Test.getStandardPricebookId();
        testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
        insert testPriceEntry;
 
        testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
        testAccount.Contact_Number_Mobile__c = mobNum;
        insert testAccount;

        testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
        testopp.Probability_New__c ='20%';
        insert testOpp;
        

        testOppLI = Initial_Test_Data.createOppLineItem(testOpp.Id,'APPL Probability',testPriceEntry.Id);
        testOppLI.Quantity = 1;
        testOppLI.Probability_Check__c = true;
        insert testOppLI;

        testInflu = Initial_Test_Data.createInfluencer(testOpp.Id);
        insert testInflu;

        testPT = Initial_Test_Data.createPTracker(testOpp.Id);
        insert testPT;

    }
    static TestMethod void test_method_one() {
        
        init('9762142316');
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/ProjectDetailPageOverride');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                //ApexPages.currentPage().getParameters().put('retURL',null);
                
                ProjDetailOverride_Controller oppController = new ProjDetailOverride_Controller(sc);
                oppController.getInfluencerList();
                oppController.editInfluencer();
                oppController.getProjectTrackerList();
                oppController.editProjectTrack();
                oppController.getApplProList();
                oppController.getOfferListPro();
                oppController.getOrderListPro();
                oppController.getSupplyListPro();
                oppController.getOrderLossProducts();
                oppController.addlDiscReq();
            	oppController.SPRPDFPreviewRedirect();
            	oppController.SPRPDFPreviewRedirect2();

            Test.stopTest();
            
        }
    }
    
    static TestMethod void test_method_two() {
        init('9762242316');
        system.runAs(testUser) {

            Test.startTest();
                OpportunityLineItem testOppLI2 = Initial_Test_Data.createOppLineItem(testOpp.Id,'APPL Offer',testPriceEntry.Id);
                testOppLI2.Quantity = 1;
                insert testOppLI2;
                OpportunityLineItem testOppLI3 = Initial_Test_Data.createOppLineItem(testOpp.Id,'APPL Order',testPriceEntry.Id);
                testOppLI3.Quantity = 1;
                insert testOppLI3;
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/ProjectDetailPageOverride');
                Test.setCurrentPage(pageRef);
                ApexPages.currentPage().getParameters().put('Id',testOpp.Id);
                //ApexPages.currentPage().getParameters().put('retURL',null);
                
                ProjDetailOverride_Controller oppController = new ProjDetailOverride_Controller(sc);
                ProjDetailOverride_Controller.OrderItemWrapperClass abc= new ProjDetailOverride_Controller.OrderItemWrapperClass();
                oppController.getInfluencerList();
                oppController.editInfluencer();
                oppController.getProjectTrackerList();
                oppController.editProjectTrack();
                oppController.getApplProList();
                oppController.getOfferListPro();
                oppController.getOrderListPro();
                oppController.addlDiscReq();
                oppController.SPRPDFPreviewRedirect();
            	oppController.SPRPDFPreviewRedirect2();
            
                Account objAcct  = Test_Utilclass.ObjAcct();
                objAcct.Contact_Number_Mobile__c     = '9603612607'; 
                insert objAcct;
                
                Pricebook2 objPriceBook = Test_Utilclass.objPricebook();
                insert objPriceBook;
                
                Product2 objProd = Test_Utilclass.objProd();
                insert objProd;
        
                Order objOrder = Test_Utilclass.objOrder();
                objOrder.AccountId = objAcct.id;
                objOrder.EffectiveDate       =  date.today();
                objOrder.Status  = 'Draft';
                objOrder.Opportunityid = testOpp.Id;
                objOrder.Pricebook2Id  = objPriceBook.id;
                insert objOrder;
                
                PricebookEntry objPricebookEntry0 = Test_Utilclass.objPricebookEntry();
                objPricebookEntry0.Product2Id     = objProd.id;
                objPricebookEntry0.Pricebook2Id   = test.getStandardPricebookId();
                insert objPricebookEntry0;
                
                PricebookEntry objPricebookEntry = Test_Utilclass.objPricebookEntry();
                objPricebookEntry.Product2Id          =  objProd.id;
                objPricebookEntry.Pricebook2Id        =  objPriceBook.id;
                insert objPricebookEntry;
                
                OrderItem objOrderItem           =  Test_Utilclass.objOrderItem();
                objOrderItem.OrderId             =  objOrder.id;
                objOrderItem.PricebookEntryId    =  objPricebookEntry.id;
                objOrderItem.UnitPrice           =  1567;
                insert objOrderItem;
        
                oppController.getOrderListPro();
            Test.stopTest();
            
        }
    }
    
}