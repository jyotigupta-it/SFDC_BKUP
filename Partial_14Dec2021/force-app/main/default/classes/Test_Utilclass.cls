@isTest
public class Test_Utilclass {

    public static Account ObjAcct(){
        Account objAcct = new Account();
        objAcct.Name = 'Test Account';
        return objAcct;
    }
    public static Opportunity oppObj(){
        Opportunity objOpp = new Opportunity();
        objOpp.Name = 'TestOpprtunity';
        objOpp.CloseDate = date.today();
        objOpp.StageName = 'ClosedWon';
        return objOpp;
    }
    
    public static Product2 objProd(){
        Product2 objProd = new Product2();
        objProd.Name = 'Test Product';
        objProd.IsActive = true;
        return objProd;
    }
    
    
    public static pricebook2 objPricebook(){
        pricebook2 objPricebook = new pricebook2();
        objPricebook.Name = 'Project';
        objPricebook.IsActive = true;
        return objPricebook;
    }
    
    public static PricebookEntry objPricebookEntry(){
        PricebookEntry objPricebookentry = new PricebookEntry();
        objPricebookentry.isActive = true;
        objPricebookentry.UnitPrice = 12345;
        return objPricebookentry;
    }
    
    public static Order objOrder(){
        Order objOrder = new Order();
        objOrder.Name = 'TestOrder';
        return objOrder;
    }
    
    public static OpportunityLineItem  objOpportunityLineitem(){
        OpportunityLineItem objOpplineItem = new OpportunityLineItem();
        objOpplineItem.Quantity = 1;
        objOpplineItem.unitprice  = 2345;
        objOpplineItem.Order_Loss_Check__c = true;
        return objOpplineItem;
    }
    
    public static OpportunityLineItem  objOpportunityLineitem1(){
        OpportunityLineItem objOpplineItem = new OpportunityLineItem();
        objOpplineItem.Quantity = 1;
        objOpplineItem.unitprice  = 2345;
        objOpplineItem.Offer_Check__c = true;
        return objOpplineItem;
    }
    
    public static OpportunityLineItem  objOpportunityLineitem2(){
        OpportunityLineItem objOpplineItem = new OpportunityLineItem();
        objOpplineItem.Quantity = 1;
        objOpplineItem.unitprice  = 2345;
        objOpplineItem.Probability_Check__c = true;
        return objOpplineItem;
    }
    
    public static OrderItem objOrderItem(){
        OrderItem objOrderItem = new OrderItem();
        objOrderItem.Quantity = 2;
        return objOrderItem;       
    }
    
    public static Supply__c objSupply(){
        Supply__c objSupply = new Supply__c();
        return objSupply;
    }
    
    public static SupplyLineItem__c objSupplyLineItem(){
        SupplyLineItem__c objSupplyLineItem = new SupplyLineItem__c();
        objSupplyLineItem.Quantity__c = 1;
        objSupplyLineItem.Unit__c = 'Boxes';
        objSupplyLineItem.Order_Value__c = 50;
        objSupplyLineItem.Invoice_Date__c = date.today();
        objSupplyLineItem.Payment_Terms__c = '100% advance with PO';
        objSupplyLineItem.Supply_Status__c = 'Fully Received';
        return objSupplyLineItem;
    }
    
   public static Target__c objTarget(){
      Target__c objTarget = new Target__c();
      objTarget.Start_Date__c = date.today();
      objTarget.End_Date__c = date.today().adddays(1);
      return objTarget;
   }
   
   public static AP_Tour_Plan__c objTourPlan() {
   	  AP_Tour_Plan__c objTourPlan = new AP_Tour_Plan__c();
   	  return objTourPlan;
   }
   
   public static AP_Expenses__c objExpensive() {
   	  AP_Expenses__c objExpensive = new AP_Expenses__c();
   	  objExpensive.Expens_Visit_Type__c = 'Headquarter';
   	  return objExpensive;
   }

}