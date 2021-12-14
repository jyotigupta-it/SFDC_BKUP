public class ReturnOrderLineItemTriggerHelper {

   /* public static void updateInventoryInLocations(Map<Id,ReturnOrderLineItem> mapOfReturnOrdersLineItems){
        Set<Id> setOfProductItemIds = new Set<Id>();
        List<ProductItem> listOfProductItemsToUpdate = new  List<ProductItem>();
        for(ReturnOrderLineItem roli : mapOfReturnOrdersLineItems.values()){
            setOfProductItemIds.add(roli.ProductItemId);
        }
        Map<Id,ProductItem> mapOfProductItems = new Map<Id,ProductItem>([Select Id, QuantityOnHand  from ProductItem where Id in: setOfProductItemIds]);
        for(ReturnOrderLineItem roli : mapOfReturnOrdersLineItems.values()){
            ProductItem pi = mapOfProductItems.get(roli.productItemId);
            pi.QuantityOnHand = pi.QuantityOnHand - roli.QuantityReturned;
            listOfProductItemsToUpdate.add(pi);
        }
        if(!listOfProductItemsToUpdate.isEmpty())
           update listOfProductItemsToUpdate;
    }*/
    
    Public static void updateReturnedOrderQuantityReturned(List<ReturnOrderLineItem> listOfReturnOrdersLineItems){
        Set<Id> setOfProductItemIds = new Set<Id>();
        List<ProductItem> listOfProductItemsToUpdate = new  List<ProductItem>();
        for(ReturnOrderLineItem roli : listOfReturnOrdersLineItems){
            setOfProductItemIds.add(roli.ProductItemId);
        }
        Map<id,List<ProductConsumed>> mapOfProductConsumed=new Map<id,List<ProductConsumed>>();
        Map<id,Decimal> mapofConsumed=new Map<id,Decimal>();
        List<ProductConsumed> listOfConsumed= new List<ProductConsumed>([select id,Consumed__c,QuantityConsumed,ProductItemId from ProductConsumed where ProductItemId in:setOfProductItemIds AND Consumed__c=false ]);
       System.debug('mapOfProductConsumed'+mapOfProductConsumed);
        if(!listOfConsumed.isEmpty()){
        for(ProductConsumed pc:listOfConsumed){
            if(!mapofConsumed.containsKey(pc.ProductItemId)){
                mapofConsumed.put(pc.ProductItemId,pc.QuantityConsumed);
                mapOfProductConsumed.put(pc.ProductItemId,new List<ProductConsumed>{pc});
            }
            else
            {
                Decimal quantity=mapofConsumed.get(pc.ProductItemId);
                quantity=quantity+pc.QuantityConsumed;
                mapofConsumed.put(pc.ProductItemId,quantity);
                mapOfProductConsumed.get(pc.ProductItemId).add(pc);
            }
        }}
        for(ReturnOrderLineItem reo:listOfReturnOrdersLineItems){
            if(!mapofConsumed.isEmpty()){
           System.debug('quantity'+mapofConsumed.get(reo.ProductItemId));
            reo.QuantityReturned= mapofConsumed.get(reo.ProductItemId);
            }}
        updateProductConsumedToFalse(listOfConsumed);
    }
    Public static void updateProductConsumedToFalse(List<ProductConsumed> listOfConsumed){
        List<ProductConsumed> listOfProductConsumed=new List<ProductConsumed>();
        List<ProductConsumed> listOfProducts=new List<ProductConsumed>();
        
        for(ProductConsumed pro : listOfConsumed){
            pro.Consumed__c=true;
            listOfProductConsumed.add(pro);
        }
        if(!listOfProductConsumed.isEmpty()){
           update listOfProductConsumed;
        }
    }
}