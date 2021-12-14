trigger ServiceAppointmentTrigger on ServiceAppointment (before insert,after insert,after update) {

    if(trigger.isAfter){
        if(trigger.isUpdate){
            ServiceAppointmentTriggerHandler.afterUpdate(trigger.newMap, trigger.oldMap);
        }
        if(trigger.isInsert){
            ServiceAppointmentTriggerHandler.afterInsert(trigger.newMap);
        }
    }
        
    
}