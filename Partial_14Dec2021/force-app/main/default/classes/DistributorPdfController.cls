public class DistributorPdfController {
    private final Account a;
    
    public Set<string> sTsoName{get;set;}
    public Set<string> sTsoPhoeNum{get;set;}
    public Account distributor{get;set;}
    public string DistributorId{get;set;}
    public List<Account> dealerList{get;set;}
    public List<Order> tsoOrderList{get;set;}
    public Map<Id,list<Dealer_Order_line_item__c>> tsoOrderLineItemMap {get;set;}
    
    public DistributorPdfController( ApexPages.StandardController controller )
    {
        DistributorId = Apexpages.currentPage().getParameters().get('id'); 
        if(DistributorId!=null){
            distributor = [SELECT Id, Name, MasterRecordId, Type, RecordTypeId, ParentId, Phone, CreatedDate, Category__c, Contact_Number_Mobile__c, City__c, State__c,
                           Status__c FROM Account where id =:DistributorId ];
        }
        
        system.debug('controller '+ controller);
        dealerList = new List<Account>();
        tsoOrderList = new List<Order >();
        tsoOrderLineItemMap = new Map<Id,list<Dealer_Order_line_item__c>>();
        // Id tsoOrderRecTypeId = Schema.SObjectType.Catalog_Order__c.getRecordTypeInfosByName().get('Secondary Sales Order').getRecordTypeId();
        dealerList = fetchDealers(DistributorId);
        tsoOrderList = fetchOrder(dealerList );
        tsoOrderLineItemMap = fetchOrderLineItem( tsoOrderList);
        sTsoName = new Set<string>();
        sTsoPhoeNum = new Set<string>();
        for(Order order:tsoOrderList)
        {
            sTsoName.add( order.Account.Name);
            sTsoPhoeNum.add( order.Account.Contact_Number_Mobile__c);
        }
    }
    
    public List<Account> fetchDealers(Id DistributorId){
        system.debug('DistributorId***'+DistributorId);
        List<Account> accList = new List<Account>();
        if(DistributorId!=Null){
            accList = [SELECT Id, Name, MasterRecordId, Type, RecordTypeId, ParentId, Phone, CreatedDate, Category__c, Contact_Number_Mobile__c, City__c, State__c, Status__c FROM Account where ParentId =:DistributorId ];
        }
        
        system.debug('accList**'+accList);
        system.debug('acclist size**'+accList.size());
        return accList;
    }
    public List<Order> fetchOrder(List<Account> accList)
    {
        Set<Id> dealerIds = new Set<ID>();
        for(Account acc:accList){
            dealerIds.add(acc.id);
        }
        system.debug('dealerIds++'+dealerIds);
        Id distributorRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        Id portalOrderId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('Portal').getRecordTypeId();
       // Id orderId= Schema.SObjectType.Order.RecordTypeInfosByName.get('Portal').RecordTypeId;
        //Id retailerRecTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        Time morningTime = Time.newInstance(6, 0, 0, 0);
        Time eveningTime = Time.newInstance(18, 0, 0, 0);
        Time midNightTime = Time.newInstance(0, 0, 0, 0);
        
        DateTime d = System.now();
        Time currentTime = d.time();
        List<order> orderList=new List<order >();
        
        orderList=	[SELECT Id, OwnerId, ContractId, AccountId,Account.Name,Account.Contact_Number_Mobile__c, OriginalOrderId, Status, EndDate, Type, Name, OrderNumber, ActivatedDate, TotalAmount, CreatedDate, CreatedById, Actual_Created_date__c, Actual_Lastmodified_date__c FROM Order where AccountId =: dealerIds AND CreatedDate = TODAY AND RecordTypeId = :portalOrderId  ORDER BY AccountId];
        system.debug('order->'+orderList);
        return orderList;
    }
    
    public Map<Id,list<Dealer_Order_line_item__c>> fetchOrderLineItem( List<Order> orderList)
    {
        Map<Id,list<Dealer_Order_line_item__c>> orderLineItemMap = new Map<Id,list<Dealer_Order_line_item__c>>();
        
        List<Order> ordList = [SELECT Id, OwnerId, ContractId, AccountId,Account.Name,Account.Contact_Number_Mobile__c,(SELECT Id, CreatedDate, Name, CreatedById, Order__c, Quantity__c, Product__c,Product__r.Name,Product__r.ProductCode,Product__r.Family FROM Order_Line_Items__r), Actual_Created_date__c, Actual_Lastmodified_date__c FROM Order Where CreatedDate = Today AND id IN :orderList ];
        for(order ord : ordList){
            orderLineItemMap.put(ord.Id,ord.Order_Line_Items__r);
        }
       /* 
		 if( orderList.size() > 0)
        {
            Set<Id> sOrderId = new Set<Id>();
            for(Order ord : orderList )
            {
                sOrderId.add(ord.Id);
            }
            system.debug('sOrderId+++'+sOrderId);
            List<Dealer_Order_line_item__c> itemList;
            for(Dealer_Order_line_item__c orderLine : [SELECT Id, CreatedDate, Name, CreatedById, Order__c, Quantity__c, Product__c,Product__r.Name,Product__r.ProductCode,Product__r.Family FROM Dealer_Order_line_item__c where CreatedDate = TODAY])
            {
                system.debug('orderLine=='+orderLine);
                if(orderLineItemMap.containsKey(orderLine.Order__c))
                {
                    itemList = new List<Dealer_Order_line_item__c>();
                   itemList= orderLineItemMap.get( orderLine.Order__c );
                    itemList.add(orderLine);
                     orderLineItemMap.put( orderLine.Order__c,itemList);
                }
                else{
                    orderLineItemMap.put( orderLine.Order__c, new List<Dealer_Order_line_item__c>{orderLine});
                }
            }
        }


*/
        return orderLineItemMap;
    }
    
}