trigger ServiceChargeTrigger on Service_Charge__c (before insert,after insert) {
if(trigger.isbefore){
        if(trigger.isInsert){
            System.debug('Service Trigger after insert');
           ServiceChargeHandler.onAfterInsert(trigger.new);
            
        }}
}