/*
 *  Trigger adds Account id into IEP_Influncer__c custom object after insert & update on Account
    Author: Mohit
*/
trigger TriggerAccount on Account (after insert,after update) {
     if(Trigger.isAfter){
        if(Trigger.isInsert){
            TriggerAccountHelper.insertAccountIntoIEPInfluncer(Trigger.New);
        }
        if(Trigger.isUpdate){
            TriggerAccountHelper.insertAccountIntoIEPInfluncer(Trigger.New);
            
        }
    }
}