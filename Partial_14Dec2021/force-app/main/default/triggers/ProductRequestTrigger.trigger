trigger ProductRequestTrigger on ProductRequest (before insert,after insert,before update,after update) {
    if(trigger.isAfter){
        
        if(trigger.isinsert){
            ProductRequestHandler.afterInsert(trigger.newMap);
        }
        if(trigger.isUpdate){
           ProductRequestHandler.afterUpdate(trigger.newMap,trigger.oldMap); 
        }
            
    }
     
 
}