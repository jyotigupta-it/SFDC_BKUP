public class SiteVisitTaskHandler{
    
    Public static void createSiteVisitTasks(Map<Id,Site_Visit__c> mapTriggerNew,Map<Id,Site_Visit__c> mapTriggerOld){
        Map<id,Id> mapUserIdVsMgrId = new Map<id,Id>(); 
        List<Task> lstTask = new List<Task>();
           
        for(user u :[Select id,email,ManagersId__c from User where isActive = true and ManagersId__c <> null]){ 
            mapUserIdVsMgrId.put(u.id, u.ManagersId__c);    
        }
          
        for(Site_Visit__c p: mapTriggerNew.Values()){
            if(p.Verified__c = true && ((p.Verification_Type__c == 'Complaint' && p.Verification_Type__c <> mapTriggerOld.get(p.Id).Verification_Type__c)
                                          || (p.Verification_Type__c == 'Suggestion' && p.Verification_Type__c <> mapTriggerOld.get(p.Id).Verification_Type__c)
                                          ||  (p.Verification_Type__c == 'Suggestion;Complaint' && p.Verification_Type__c <> mapTriggerOld.get(p.Id).Verification_Type__c))){
                if(mapUserIdVsMgrId.containsKey(p.CreatedById)){
                    
                    for(integer i=0; i<=1; i++){
                        Task t = new task();
                        if(i == 0){
                            t.ownerid = p.CreatedById;
                        }
                        if(i == 1){
                            t.ownerid = mapUserIdVsMgrId.get(p.CreatedById);
                        }
                        t.Call_Center_Comments__c = p.Call_Center_Remarks__c;
                        t.WhatId = p.id;
                        t.Suggestion__c = p.Suggestion__c;
                        t.Complaint__c = p.Complaints__c;
                        t.ActivityDate = system.today();
                        t.Priority = 'Normal';
                        if(p.Verification_Type__c == 'Suggestion'){
                           t.Subject = 'SiteVisit Suggestion'; 
                        }
                        else{
                            t.Subject = 'SiteVisit Complaint';
                        }
                        
                        lstTask.add(t);
                   }
                }
            } 
        }

        if(!lstTask.isEMpty()){
            insert lstTask;
        }   
    }
}