trigger AssetTrigger on Asset (before insert,before update,after insert,after update) {

    if(trigger.isBefore){
        if(trigger.isInsert){
            System.debug('Asset Trigger before insert');
            AssetTriggerHandler.onBeforeInsert(trigger.new);  
        }
    }
    if(trigger.isAfter){
        if(trigger.isInsert){
            System.debug('Asset Trigger after insert');
            AssetTriggerHandler.onAfterInsert(trigger.newMap);  
        }
    }
}