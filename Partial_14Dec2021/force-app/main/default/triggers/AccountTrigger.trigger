/*  
Author: Satyanarayana
Description : 
Events : Before Insert, Before Update : Populate Dealer, Distributor, Direct Dealer Activated Date, once the Status is changed from Prospect to Existing.
After Insert, After Update : Populate Dealer, Distributor, Direct Dealer Activated Actaul count, once the Status is changed from Prospect to Existing.
Date : 13/07/2015    */
trigger AccountTrigger on Account (before insert, before update, after insert, after update,after delete) {
    
   
   
    public AccountTriggerHandler instance = AccountTriggerHandler.getInstance();
    
    
    if((Trigger.isInsert || Trigger.isUpdate) && trigger.isBefore) {
        
       instance.beforeInsert(Trigger.new, Trigger.oldMap); 
       
        
        if(trigger.IsInsert && trigger.IsBefore)
        {
           
			plumberAutoGenAreaHandler.populateArea(Trigger.new);            
            instance.beforeInsertAccount(Trigger.new);
        }

        
    }
    
    
    
    if((Trigger.isInsert || Trigger.isUpdate) && trigger.isAfter) {
        
       instance.afterInsert(Trigger.new, Trigger.oldMap); 
        
        
    }
 
}