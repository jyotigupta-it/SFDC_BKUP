trigger Update_Rollup_ApplTarget2 on Target__c (before update, after update, after insert) {
    
     public static Update_Rollup_ApplTarget_Handler handler = Update_Rollup_ApplTarget_Handler.getInstance();
    
     if(trigger.isUpdate) {
        
        if(trigger.isBefore && Update_Rollup_ApplTarget_Helper.isTarget) {
            handler.populateactualVisitType(trigger.new);
        } 

  }
}