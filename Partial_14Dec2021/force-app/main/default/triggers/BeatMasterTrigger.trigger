trigger BeatMasterTrigger on Beat_Master__c (before delete, before insert,before update,after update) {
    if(Trigger.isDelete && Trigger.isBefore){
        BeatrMasterTriggerHandler.updateAccountsOnDelete(Trigger.old);
    }
    if((Trigger.isInsert && Trigger.isBefore || Trigger.isUpdate && Trigger.isBefore) && !BeatrMasterTriggerHandler.triggerFlag){
        //Beat plan frequency duplicate check.
        BeatrMasterTriggerHandler.beatFrequencyDupCheck(trigger.new,trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        //Tour plan updataion on beat frequency approval.
        BeatrMasterTriggerHandler.beatFreqTourPlanUpdate(trigger.new,trigger.oldMap);
    }
}