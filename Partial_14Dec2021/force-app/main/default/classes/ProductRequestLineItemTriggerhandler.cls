public class ProductRequestLineItemTriggerhandler {

    public static void afterUpdate(Map<Id,ProductRequestLineItem> mapofNewProductReqs, Map<Id,ProductRequestLineItem> mapofOldProductReqs){
        Map<Id,ProductRequestLineItem> mapOfAllRecievedPRLs = new Map<Id,ProductRequestLineItem>();
        for(ProductRequestLineItem eachPRL : mapofNewProductReqs.values()){
            if(eachPRL.status != null && eachPRL.Quantity_Received__c != 0 && eachPRL.Quantity_Received__c != mapofOldProductReqs.get(eachPRL.Id).Quantity_Received__c){
                mapOfAllRecievedPRLs.put(eachPRL.id, eachPRL);
            }
        }
        if(!mapOfAllRecievedPRLs.isEmpty()){
            ProductRequestLineItemTriggerHelper.createOrUpdateProductItems(mapOfAllRecievedPRLs, mapofOldProductReqs);
        }
    }
}