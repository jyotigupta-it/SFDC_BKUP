trigger CaseTrigger on Case (before insert, after insert,before update,after update) {

    if(trigger.isAfter){
        if(trigger.isInsert){
            System.debug('Case Trigger after insert');
            CaseTriggerHandler.onAfterInsert(trigger.newMap);
            
        }
         else if(trigger.isUpdate){
            System.debug('Case Trigger after update');
           
            CaseTriggerHandler.onAfterUpdate(trigger.oldMap,trigger.newMap);
        }
    }

 if(trigger.isBefore){
        if(trigger.isInsert){
            System.debug('Case Trigger before insert');
            CaseTriggerHandler.onBeforeInsert(trigger.new);
            
        }
      else if(trigger.isUpdate){
            System.debug('Case Trigger after update');
           
            CaseTriggerHandler.onBeforeUpdate(trigger.oldMap,trigger.newMap);
        }
     
   
    
     
    }
}