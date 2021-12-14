trigger InvoiceTrigger on Invoice__c (before update,after Update) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            InvoiceTriggerHandler.beforeUpdate(Trigger.newmap,Trigger.oldmap);
        }
    }
     if(Trigger.isAfter){
        if(Trigger.isUpdate){
            InvoiceTriggerHandler.afterUpdate(Trigger.newmap,Trigger.oldmap);
        }
    }
}