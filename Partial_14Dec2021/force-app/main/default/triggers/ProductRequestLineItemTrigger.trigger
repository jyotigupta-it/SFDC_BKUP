trigger ProductRequestLineItemTrigger on ProductRequestLineItem (before insert,after update) {

    if(trigger.isAfter){
        if(trigger.isUpdate){
            ProductRequestLineItemTriggerhandler.afterUpdate(trigger.NewMap,trigger.OldMap);
        }
    }
}