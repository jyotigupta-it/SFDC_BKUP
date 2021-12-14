public class ReturnOrderLineItemTriggerHandler {

    public static void afterInsert(List<ReturnOrderLineItem> listOfReturnOrdersLineItems){
        //for(ReturnOrderLineItem roli : mapOfReturnOrdersLineItems.values()){
            
        //}
        //ReturnOrderLineItemTriggerHelper.updateInventoryInLocations(mapOfReturnOrdersLineItems);
        ReturnOrderLineItemTriggerHelper.updateReturnedOrderQuantityReturned(listOfReturnOrdersLineItems);
    }
}