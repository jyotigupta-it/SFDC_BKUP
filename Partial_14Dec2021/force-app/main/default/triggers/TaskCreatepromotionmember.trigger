trigger TaskCreatepromotionmember on Promotion_Member__c (before update) {    
  if(Trigger.isUpdate && Trigger.isBefore){
      PramotionmemberTaskHandler.createPramotionTasks(trigger.newMap,trigger.oldMap);     
    }                                       
}