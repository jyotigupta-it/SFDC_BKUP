trigger AssignedResourceTrigger on AssignedResource (before insert,after insert,after update) {
    
    if(trigger.isAfter){
        if(trigger.isInsert){
            AssignedResourceTriggerHandler.afterInsert(trigger.newMap);
        }
    }else{
        if(trigger.isInsert){
            AssignedResourceTriggerHandler.beforeInsert(trigger.new);
        }
    }
//new
    if(trigger.isUpdate){
        AssignedResourceTriggerHandler.afterupdate(trigger.newMap);
    }
}