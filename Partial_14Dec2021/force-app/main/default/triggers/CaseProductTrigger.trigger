trigger CaseProductTrigger on Case_Products__c (before insert,after insert,before update) {

    if(trigger.isAfter && trigger.isInsert){
        CaseProductsTriggerHandler.afterInsert(trigger.newMap);
    }
     if(trigger.isBefore){
         if(trigger.isInsert){
             CaseProductsTriggerHandler.beforeInsert(trigger.new);
         }
          if(trigger.isUpdate){
            // CaseProductsTriggerHandler.beforeUpdate(trigger.new);
         }
     }
}