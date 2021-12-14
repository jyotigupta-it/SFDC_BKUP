trigger ReturnOrderLineItemTrigger on ReturnOrderLineItem (before insert,after insert,after update) {

    if(trigger.isBefore){
        if(trigger.isInsert){
            ReturnOrderLineItemTriggerHandler.afterInsert(trigger.new);
        }
    }
}