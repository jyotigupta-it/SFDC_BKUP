trigger genericEmailTrigger on Unique_SPR__c (After update) {

    if(trigger.isAfter && trigger.isUpdate)
    {
       genericEmailTriggerHandler.checkConditionForGenricEmail(trigger.new); 
    }
    
}