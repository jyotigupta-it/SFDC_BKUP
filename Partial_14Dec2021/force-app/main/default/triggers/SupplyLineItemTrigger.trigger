trigger SupplyLineItemTrigger on SupplyLineItem__c (after insert, after update) {
    if(Trigger.isInsert || Trigger.isUpdate){
        SupplyLineItemTriggerHandler instance = SupplyLineItemTriggerHandler.getInstance();
        instance.onAfterInsert(Trigger.New,Trigger.Old,Trigger.Newmap,Trigger.oldMap);  
    }
}