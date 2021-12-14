trigger MessagingSessionTrigger on MessagingSession (after insert,before update,after update) {
    if(trigger.isAfter){
        if(trigger.isInsert){
            System.debug('Messaging Trigger after insert');
            MessagingSessionTriggerHandler.onAfterInsert(trigger.newMap);   
        }
    }
}