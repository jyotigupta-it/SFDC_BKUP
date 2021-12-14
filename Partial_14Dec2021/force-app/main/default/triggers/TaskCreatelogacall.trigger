trigger TaskCreatelogacall on Feedback__c(after insert)
 {  
   for (Feedback__c opEvent : Trigger.new) {
        Task tsk= new Task(
            OwnerId = opEvent.CreatedById,
            WhatId = opEvent.Account__c,
             ActivityDate= opEvent.Date__c,
            
            
            Subject = 'Feedback Status' +'-'+ ''+opEvent.Status__c
            

        );
        insert tsk ;             
    }
}