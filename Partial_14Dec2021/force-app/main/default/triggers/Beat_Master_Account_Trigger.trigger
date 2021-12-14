trigger Beat_Master_Account_Trigger on Beat_Master_Account__c (before insert,after update,before delete) {
    if(Trigger.isInsert && Trigger.isBefore){
        BeatMasterAccountTriggerHandler.validateBeatsOnInsert(Trigger.new);
    }
    if(Trigger.isUpdate&& Trigger.isAfter){
        BeatMasterAccountTriggerHandler.validateBeatsOnInsert(Trigger.new);
    }
    if(Trigger.isDelete && Trigger.isBefore){
        BeatMasterAccountTriggerHandler.updateAccountsOnDelete(Trigger.old);
    }
}