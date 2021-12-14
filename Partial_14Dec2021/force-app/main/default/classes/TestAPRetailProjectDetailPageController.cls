@isTest
public class TestAPRetailProjectDetailPageController {
    public static testMethod void method1(){ 
        
        Account objAcct  = Test_Utilclass.ObjAcct();
        objAcct.Contact_Number_Mobile__c     = '9603612607'; 
        insert objAcct;
        
        Opportunity oppObj = Test_Utilclass.oppObj();
        oppObj.Probability_New__c = '20%';
        insert oppObj;
        
        Pricebook2 objPriceBook = Test_Utilclass.objPricebook();
        insert objPriceBook;
        
        Product2 objProd = Test_Utilclass.objProd();
        insert objProd;
        
        Order objOrder = Test_Utilclass.objOrder();
        objOrder.AccountId = objAcct.id;
        objOrder.EffectiveDate       =  date.today();
        objOrder.Status  = 'Draft';
        objOrder.Opportunityid = oppObj.id;
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
        
        OpportunityLineItem oppLineItem = Test_Utilclass.objOpportunityLineitem();
        oppLineItem.OpportunityId       = oppObj.id;
        oppLineItem.PricebookEntryId    = objPricebookEntry.id;
        insert oppLineItem;
        
        OpportunityLineItem oppLineItem1 = Test_Utilclass.objOpportunityLineitem1();
        oppLineItem1.OpportunityId       = oppObj.id;
        oppLineItem1.PricebookEntryId    = objPricebookEntry.id;
        insert oppLineItem1;
        
        OpportunityLineItem oppLineItem2 = Test_Utilclass.objOpportunityLineitem2();
        oppLineItem2.OpportunityId       = oppObj.id;
        oppLineItem2.PricebookEntryId    = objPricebookEntry.id;
        insert oppLineItem2;
        
        OrderItem objOrderItem           =  Test_Utilclass.objOrderItem();
        objOrderItem.OrderId             =  objOrder.id;
        objOrderItem.PricebookEntryId    =  objPricebookEntry.id;
        objOrderItem.UnitPrice           =  1567;
        insert objOrderItem;
        
        Supply__c objSupply              = Test_Utilclass.objSupply();
        objSupply.Order__c               = objOrder.id;
        objSupply.Project__c             = oppObj.id;
        insert objSupply;
        
        SupplyLineItem__c objSupplyLineItem   = Test_Utilclass.objSupplyLineItem();
        objSupplyLineItem.Distributor_Name__c = objAcct.id;
        objSupplyLineItem.OrderLineItem__c    = objOrderItem.id;
        objSupplyLineItem.SupplyDetails__c    = objSupply.id;
        insert objSupplyLineItem;
        
        ApexPages.currentPage().getParameters().put('Id',oppObj.id);
        AP_RetailProjectDetailPage_Controller objApRetail = new AP_RetailProjectDetailPage_Controller(new ApexPages.StandardController(oppObj));
        objApRetail.editInfluencer();
        objApRetail.editProjectTrack();
        objApRetail.offerProd();
        objApRetail.probProd();
        objApRetail.orderLoss();
        objApRetail.orderProd();
        objApRetail.supplyProd();
        objApRetail.removeRowType = 'appl_prob';
        objApRetail.removeRow();
        objApRetail.saveProb();
        objApRetail.saveOffer();
        objApRetail.saveOrderLoss();
        objApRetail.saveOrder();
        objApRetail.saveSupply();  
        //AP_RetailProjectDetailPage_Controller.productWrapper objProdwrap = new AP_RetailProjectDetailPage_Controller.productWrapper(true,false,false);
        //AP_RetailProjectDetailPage_Controller.orderProductWrapper objOrderProd = new AP_RetailProjectDetailPage_Controller.orderProductWrapper();           
        objApRetail.getprobabilityList();
        objApRetail.getofferList();
        objApRetail.getorderList();
        objApRetail.getsupplyList();
        objApRetail.getInfluencerList();
        objApRetail.getorderLossList();
        objApRetail.getProjectTrackerList();
    }
}