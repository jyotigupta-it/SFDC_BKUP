public class ProductRequestLineItemTriggerHelper {

    public static void createOrUpdateProductItems(Map<Id,ProductRequestLineItem> mapofProductReqs, Map<Id,ProductRequestLineItem> OldmapofProductReqs){
        Set<Id> setOfLocations = new Set<Id>();
        Map<Id,ProductItem> mapOfProductIdToProductItems = new Map<Id,ProductItem>();
        List<ProductRequestLineItem> listOfPRLIToUpdate = new List<ProductRequestLineItem>();
        Map<Id,List<ProductItem>> mapOfLocationIdToProductItems = new Map<Id,List<ProductItem>>();
        for(ProductRequestLineItem prli : mapofProductReqs.values()){
            setOfLocations.add(prli.DestinationLocationId);
        }
        List<ProductItem> listOfProductItems = [Select id, Product2Id, QuantityOnHand , LocationId  from ProductItem where LocationId  in : setOfLocations];
        for(ProductItem pi : listOfProductItems){
            if(mapOfLocationIdToProductItems.containsKey(pi.LocationId))
               mapOfLocationIdToProductItems.get(pi.LocationId).add(pi);
            else
                mapOfLocationIdToProductItems.put(pi.LocationId, new List<ProductItem>{pi});
        }
        List<ProductItem> listOfProductItemsToUpsert = new List<ProductItem>();
        for(ProductRequestLineItem prli : mapofProductReqs.values()){
            boolean productFound = false;
            List<ProductItem> listOfProductItemsToLoaction = mapOfLocationIdToProductItems.get(prli.DestinationLocationId);
            for(ProductItem pi : listOfProductItemsToLoaction){
                if(pi.Product2Id == prli.Product2Id){
                    productFound = true;
                    pi.QuantityOnHand = (pi.QuantityOnHand - OldmapofProductReqs.get(prli.Id).Quantity_Received__c) + prli.Quantity_Received__c;
                    listOfProductItemsToUpsert.add(pi);
                }
            }
            if(productFound == false){
               ProductItem prItm = new  ProductItem();
               prItm.Product2Id = prli.Product2Id;
               prItm.LocationId = prli.DestinationLocationId;
               prItm.QuantityOnHand = prli.Quantity_Received__c;
               listOfProductItemsToUpsert.add(prItm);
            }
            ProductRequestLineItem prlis = new ProductRequestLineItem();
            prlis.Id = prli.Id;
            if(prli.QuantityRequested > prli.Quantity_Received__c){
                prlis.status = 'Partially Reveived';
                listOfPRLIToUpdate.add(prlis);
            }else if(prli.QuantityRequested == prli.Quantity_Received__c){
                prlis.status = 'Received';
                listOfPRLIToUpdate.add(prlis);
            }
        }
        if(!listOfPRLIToUpdate.isEmpty()){
            update listOfPRLIToUpdate;
        }
        if(!listOfProductItemsToUpsert.isEmpty()){
            upsert listOfProductItemsToUpsert;
        }
    }
}