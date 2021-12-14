public class ReturnOrderTriggerHandler {
     public static void onAfterUpdate(Map<id,ReturnOrder> mapOfOldReturn,Map<id,ReturnOrder> mapOfNewReturn){
         Map<id,ReturnOrder> mapOfReturn=new Map<id,ReturnOrder>();
           Map<id,ReturnOrder> mapOfReturnOrder=new Map<id,ReturnOrder>();

         for(ReturnOrder eachReturn : mapOfNewReturn.values()){
             if(eachReturn.Status!=mapOfOldReturn.get(eachReturn.id).Status && eachReturn.Status=='Submitted' && mapOfOldReturn.get(eachReturn.id).Status=='Draft'){
                 mapOfReturn.put(eachReturn.id,eachReturn);
             }
             if(eachReturn.Status!=mapOfOldReturn.get(eachReturn.id).Status && eachReturn.Status=='Submitted'){
                 mapOfReturnOrder.put(eachReturn.id,eachReturn);
             }
         }
        if(!mapOfReturn.isEmpty()){
            ReturnOrderTriggerHelper.updateInventoryInLocations(mapOfReturn);
    }
         if(!mapOfReturnOrder.isEmpty()){
            ReturnOrderTriggerHelper.returnOrderEmail(mapOfReturn);
    }
         
     }
}