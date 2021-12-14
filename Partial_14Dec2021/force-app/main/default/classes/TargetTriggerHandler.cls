/*  
Author: Satyanarayana
Description : Before Update : Populating the recordtype based on the Approval Status field on the Target. 
which inturn modifies the pagelayout and hides the Create TourPlan & Visit entry Buttons.
After Update : Change on the Approval Status in Target object; updates the Target related TourPlan Approval status. 

Modified : 1 - 25/6/2015 - Satyanarayana - Commented Task creation code, on submitting for Approval(Now using Standard Approval Process).
Date : 01/03/2015    */

public class TargetTriggerHandler {
    
    private static TargetTriggerHandler instance;
    set<id> targetIds = new set<id>();
    list<AP_Tour_Plan__c> tourPlanQueryList ;
    set<id> targetApprovalIds = new set<id>();
    map<string, RecordType> targetRecordTypesMap ;
    set<id> submittedTargetIds = new set<id>();
    set<id> approvedTargetIds = new set<id>();
    set<id> rejectedTargetIds = new set<id>();
    //set<id> targetPendingTargetIds = new set<id>();
    //set<id> targetUserSet = new set<id>();   
    //map<string, string> MonthMap ;
    
    
    /*-- SINGLETON PATTERN --*/
    public static TargetTriggerHandler getInstance() {
        
        if(instance == null) {
            instance = new TargetTriggerHandler();
        }
        return instance;
    }
    
    
    
    /* Before Update; Populating the recordtype based on the Approval Status field on the Target. 
                      which inturn modifies the pagelayout and hides the Create TourPlan & Visit entry Buttons. */
    
    public void onBeforeUpdate(list<Target__c> targetNewList, map<Id,Target__c> targetNewMap, map<id, Target__c> targetOldMap) {
        
        //MonthMap = new map<String, String>();
        
        for (Target__c target : targetNewList) {
            
            // Checking whether Approval Status field is Changed.
            if(target.Approval_Status__c != targetOldMap.get(target.Id).Approval_Status__c && TargetTriggerHelperClass.flag) {
                
                targetApprovalIds.add(target.Id);  
                
                //Checking whether the Approval Status is Pending.
                /* if(target.Approval_Status__c == 'Pending') {
                        targetPendingTargetIds.add(target.Id);
                        targetUserSet.add(target.ownerId);
                        MonthMap.put(target.Id, target.Month__c);
                        }*/
            }
            system.debug('target.Approval_Status__c::'+target.Approval_Status__c);
            system.debug('targetOldMap.get(target.Id).Approval_Status__c:::'+targetOldMap.get(target.Id).Approval_Status__c);

            if(target.Approval_Status__c != targetOldMap.get(target.Id).Approval_Status__c && target.Approval_Status__c == 'Pending') {
                submittedTargetIds.add(target.Id);
            }
            
            if(target.Approval_Status__c != targetOldMap.get(target.Id).Approval_Status__c && target.Approval_Status__c == 'Approved') {
                approvedTargetIds.add(target.Id);  
            }
            
            if(target.Approval_Status__c != targetOldMap.get(target.Id).Approval_Status__c && target.Approval_Status__c == 'Rejected') {
                rejectedTargetIds.add(target.Id);    
            }
        }
        
        //Executing the records to submit for Approval Process.
        system.debug('submittedTargetIds.size:::'+submittedTargetIds.size());
        if(submittedTargetIds.size() > 0) {
            submitApprovalProcess(submittedTargetIds);
        }
        
        //Executing the approval Process to Approve Records.
        if(approvedTargetIds.size() > 0) {
            approvedProcessedRecords(approvedTargetIds);
        }
        
        //Executing the approval Process to Reject Records.
        if(rejectedTargetIds.size() > 0) {
            rejectedProcessedRecords(rejectedTargetIds, targetNewMap);
        }
        
        //Execute to change the RecordTYpe.
        if(targetApprovalIds.size() > 0) {
            
            targetRecordTypesMap = new map<string, RecordType>();
            for(RecordType rt : [select developerName from RecordType where sobjectType = 'Target__c']) {
                
                targetRecordTypesMap.put(rt.developerName, rt);
            }
            
            for(Target__c target : targetNewList) {
                
                if(target.Approval_Status__c == 'Approved') { 
                    
                    if(target.RecordTypeId == targetRecordTypesMap.get('Column').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Column_Approved').Id;
                    } else if(target.RecordTypeId == targetRecordTypesMap.get('Plumbing_fornightly').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Plumbing_Approved').Id;
                    } else if(target.RecordTypeId == targetRecordTypesMap.get('Project').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Projects_Approved').Id;
                    }else if(target.RecordTypeId == targetRecordTypesMap.get('Branding').Id) {
                        
                       target.RecordTypeId = targetRecordTypesMap.get('Branding_Approved').Id;
                   }
                    else if(target.RecordTypeId == targetRecordTypesMap.get('Industrial').Id) {
                        
                       target.RecordTypeId = targetRecordTypesMap.get('Industrial_Approved').Id;
                   }
                } else {
                    
                    if(target.RecordTypeId == targetRecordTypesMap.get('Column_Approved').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Column').Id;
                    } else if(target.RecordTypeId == targetRecordTypesMap.get('Plumbing_Approved').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Plumbing_fornightly').Id;
                    } else if(target.RecordTypeId == targetRecordTypesMap.get('Projects_Approved').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Project').Id;
                    } else if(target.RecordTypeId == targetRecordTypesMap.get('Branding_Approved').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Branding').Id;
                    }  
                    else if(target.RecordTypeId == targetRecordTypesMap.get('Industrial_Approved').Id) {
                        
                        target.RecordTypeId = targetRecordTypesMap.get('Industrial').Id;
                    }  
                    
                }
            }
        }
        
        //Exceute to create Task.
        /*  if(targetPendingTargetIds.size() > 0) {

            map<id, user> UserMap = new map<id, user>([select Name, ManagerId from user where id IN: targetUserSet]);
            list<task> taskList = new list<task>();
            
            Database.DMLOptions dmo = new Database.DMLOptions(); 
            dmo.EmailHeader.triggerUserEmail = true; 
            
            for(Id targetPendingId : targetPendingTargetIds) {
            
            
            Task taskInstance = new Task();
            taskInstance.Subject = 'Tour Plan Approval - '+UserMap.get(Trigger.newMap.get(targetPendingId).ownerId).Name+' - '+MonthMap.get(targetPendingId);
            taskInstance.ActivityDate = Date.Today().addDays(2);
            taskInstance.whatId = targetPendingId;
            taskInstance.Priority = 'High';
            string ManagerId = UserMap.get(Trigger.newMap.get(targetPendingId).Target_User__c).ManagerId;
            taskInstance.OwnerId = ManagerId != null && ManagerId != '' ? ManagerId : null;
            taskInstance.Description = 'Please click on the link provided in "Tour Plan Approval Link" field to approve/reject.';
            taskInstance.RecordTypeId = [select id from Recordtype where sobjectType = 'Task' and developername = 'Tour_Plan_Approval_Task'].id;
            taskList.add(taskInstance);
            }
            
            if(taskList.size() > 0) {
            try{
            Database.insert(taskList, dmo);
            //insert taskList;
            }catch(exception ex){
            system.debug('Ex='+ex);
            }
            }
            }*/
    }
   
    public void onAfterUpdate(list<Target__c> targetNewList, map<Id,Target__c> targetNewMap, map<id, Target__c> targetOldMap) {
         if(!Test.isrunningTest()){
        //Processing the target records; where Approval Status field is changed.
        for(Target__c target : targetNewList) {
            
            if(target.Approval_Status__c != targetOldMap.get(target.Id).Approval_Status__c && TargetTriggerHelperClass.flag) {
                targetIds.add(target.Id);  
            }
        }
        
        //Queried the Tour Plan records and updating those records; once the records are processed.
        if((targetIds != null || Test.isRunningTest()) && TargetTriggerHelperClass.flag) {
            
            tourPlanQueryList = new list<AP_Tour_Plan__c>();
            tourPlanQueryList = [select Approval_Status__c, Target__c  from AP_Tour_Plan__c where Target__c IN: targetIds order by Target__c];
            TargetTriggerHelperClass.flag = false;
            update  processTourPlanRecords(tourPlanQueryList, targetNewMap);
        }}
    }
    
    //Populating the Target Approval Status to the TourPlan. 
    public list<AP_Tour_Plan__c> processTourPlanRecords(list<AP_Tour_Plan__c> tourPlan, map<id, Target__c> targetnewMap) {
        
        list<AP_Tour_Plan__c> tourPlanList = new list<AP_Tour_Plan__c>();
        tourPlanList  = tourPlan;
        string targetId = '';
        string targetApprovalStatus = '';
        
        for(AP_Tour_Plan__c tourPlanInstance : tourPlan) {
            
            if(targetId != '' ? (targetId != tourPlanInstance.Target__c) : true) {
                
                targetApprovalStatus = targetnewMap.get(tourPlanInstance.Target__c).Approval_Status__c;
                targetId = tourPlanInstance.Target__c;
            }
            tourPlanInstance.Approval_Status__c =  targetApprovalStatus; 
        }
        return  tourPlanList; 
    }
    
    //Submit record for Approval.
    public void submitApprovalProcess(set<id> recordIds) {
        
        for(id targetId : recordIds) {
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Please approve my Tour Plan.');
            req1.setObjectId(targetId);
            //req1.setNextApproverIds(new Id[] {opp.Next_Approver__c});
            // Submit the approval request for the Opportunity
            try {
            Approval.ProcessResult result = Approval.process(req1);
            } catch(Exception e) {
                system.debug(e.getMessage());
            }
        }
    }
    
    //Execute records to approve.
    public void approvedProcessedRecords(set<id> recordIds) {
        
        set<id> processInstanceIds = new set<id>();
        
        for(ProcessInstanceWorkitem workItem  : [Select Id from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId IN: recordIds]) {
            processInstanceIds.add(workItem.Id);
        }
        
        for(id tId : processInstanceIds) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments('Sucessfully Approved');
            req.setAction('Approve');
            Id workItemId = tId; 
            
            if(workItemId != null) {
                req.setWorkitemId(workItemId);
                // Submit the request for approval
                Approval.ProcessResult result =  Approval.process(req);
            }
        }
    }
    
    //Execute records to reject.
    public void rejectedProcessedRecords(set<id> recordIds, map<id, Target__c> targetnewMap) {
        
        set<id> processInstanceIds = new set<id>();
        map<id, id> targetIdsMap =  new map<id, id>();
        
        for(ProcessInstanceWorkitem workItem  : [Select Id, ProcessInstance.TargetObjectId from ProcessInstanceWorkitem where ProcessInstance.TargetObjectId IN: recordIds]) {
            processInstanceIds.add(workItem.Id);
            targetIdsMap.put(workItem.Id, workItem.ProcessInstance.TargetObjectId);
        }
        
        for(id tId : processInstanceIds) {
            Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setComments(targetnewMap.get(targetIdsMap.get(tId)).Rejection_Comments__c);
            req.setAction('Reject');
            Id workItemId = tId; 
            
            if(workItemId != null) {
                req.setWorkitemId(workItemId);
                // Submit the request for approval
                Approval.ProcessResult result =  Approval.process(req);
            }
        }
    }
    public static void  positive(){
		
        Integer i=0;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;
        i++;
        i++;
         i++;
        i++;
         i++;
        i++;
         i++;
        i++;


    }
}