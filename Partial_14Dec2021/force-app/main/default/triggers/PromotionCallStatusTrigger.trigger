trigger PromotionCallStatusTrigger on Promotion_Member__c (after insert,after update,before insert,before update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        ToDeactivateAccountOnInvalicPhNo.InactivatingAccountMethod(trigger.new);
    }
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        ToDeactivateAccountOnInvalicPhNo.ValueAssigningMethod(trigger.new);
    }
}