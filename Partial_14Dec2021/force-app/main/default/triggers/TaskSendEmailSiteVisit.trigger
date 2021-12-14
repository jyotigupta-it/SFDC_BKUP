trigger TaskSendEmailSiteVisit on Site_Visit__c (before update) {
   if(Trigger.isUpdate && Trigger.isBefore){
      SiteVisitTaskHandler.createSiteVisitTasks(trigger.newMap,trigger.oldMap);     
    }      
           }