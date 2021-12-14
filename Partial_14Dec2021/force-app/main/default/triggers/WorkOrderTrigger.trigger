trigger WorkOrderTrigger on WorkOrder (after insert, before insert, after update, before update) {
    

    if(trigger.isAfter){
        if(trigger.isUpdate){
            WorkOrderTriggerHandler.afterUpdate(trigger.newMap, trigger.oldMap);
        }
        if(trigger.isinsert){
            WorkOrderTriggerHandler.afterInsert(trigger.newMap);
        }
    }else{
        if(trigger.isUpdate){
            WorkOrderTriggerHandler.beforeUpdate(trigger.newMap, trigger.oldMap);
        }
    }
   
    
    
    
}