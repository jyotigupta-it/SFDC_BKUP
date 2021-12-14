trigger ReturnOrderTrigger on ReturnOrder (before insert,after insert,after update,before update) {
    if(trigger.isAfter){
        if(trigger.isUpdate){
            ReturnOrderTriggerHandler.onAfterUpdate(trigger.oldMap,trigger.newMap);
        }
    }
}