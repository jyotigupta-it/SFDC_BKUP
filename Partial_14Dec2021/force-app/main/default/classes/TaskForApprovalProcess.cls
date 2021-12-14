/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email: Pranitha_S@infosys.com
Description:  Handler class for trigBrandingRequestTrigger for task creation.
 ****************************************************************************************/
 public class TaskForApprovalProcess{

   public static Id masterTask=[Select id from RecordType where Name ='Branding Request'  and sobjecttype='Task'].id;   
   public static Id collateralRequest=[Select id from RecordType where Name ='Collateral Request' and sobjecttype='Case'].id;
   public static Id brandingRequest=[Select id from RecordType where Name ='Branding Request' and sobjecttype='Case'].id;
 /**
 * Name: taskForBranding
 * Params: None
 * Description: Method to create tasks for approvers
 */ 
    public void taskForBranding(){
    try{
       
        if(trigger.isbefore && trigger.isupdate){
            List<Task> taskToInsert = new List<Task>();
            List<Task> taskToUpdate = new List<Task>();
            List<Id> caseid = new List<id>();
            List<Case> caseReferenceNew = new List<case>();
            List<Case> caseReferenceOld = new List<case>();
             
            for(sobject caseRequest : trigger.new){
                Case newStatusCase = (Case) caseRequest;
                Case  oldStatusCase = (Case)Trigger.oldMap.get(newStatusCase.id);
                if(newStatusCase.RecordTypeId==brandingRequest){
                    if((newStatusCase.status != oldStatusCase.status)||
                            (newStatusCase.Is_In_Approval_Process__c != oldStatusCase.Is_In_Approval_Process__c)){
                            caseid.add(newStatusCase.id);
                            caseReferenceNew.add(newStatusCase);
                    }
                }
            }
            List<Task> openTask =[select status, id, whoid, whatid, ownerid, createddate from task t where status != :System.Label.Branding_Request_Completed and whatid in : caseid];
            if(openTask.size() != 0){
                for(Case taskCase : caseReferenceNew){

                    for(Task tasks : openTask){
                        if(tasks.whatid == taskCase.id){
                            Id TaskOwnerId = getPreviousApproverId(taskCase);
                            Id CurrentOwnerId = getCurrentApprover(taskCase);
                            if(CurrentOwnerId != TaskOwnerId){
                                tasks.status = System.Label.Branding_Request_Completed;
                                tasks.BD_Comments__c ='Completed the task on '+ system.today();
                                taskToUpdate.add(tasks);
                                if(taskCase.status != System.Label.Branding_Request_Completed){
                                    Task InsertTask = getStaticDetails();
                                    if(CurrentOwnerId != null){
                                        InsertTask.ownerId =CurrentOwnerId ;
                                        InsertTask.WhatId = taskCase.id;
                                        InsertTask.ActivityDate = Date.today()+getDueDate(taskCase);
                                        taskToInsert.add(InsertTask);
                                    }
                                }
                            }         
                        } 
                    }
                }

            }
            else{
                for(Case taskCase : caseReferenceNew){
                    Task InsertTask = getStaticDetails();
                    InsertTask.ownerId = taskCase.team_lead__c;
                    InsertTask.WhatId = taskCase.id;
                    InsertTask.ActivityDate = Date.today()+getDueDate(taskCase);
                    taskToInsert.add(InsertTask);
                }  

            }
            update taskToUpdate;
            insert taskToInsert; 
        }
      } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
    }
    
 /**
 * Name: getStaticDetails
 * Params: None
 * Description: Creates task for approvers
 */
    public Task getStaticDetails(){
       
        Task t = new Task();
        t.priority ='Normal';
        t.RecordTypeId = masterTask;
        t.description = 'Request is pending for your approval';
        t.status ='Not Started'; 
        t.subject ='Branding Request Approval';
        t.IsReminderSet = true;
        t.ReminderDateTime = System.now();
        return t;
    }
    
 /**
 * Name: getPreviousApproverId
 * Params: None
 * Description: method to get the previous approver of a case
 */
    public Id getPreviousApproverId(Case cas){
    Id returdId;
    try{
        /* Getting the previous approver for Branding */
        if(cas.Status == System.label.Branding_Request_New){
            returdId = null;}
        else if(cas.status == System.label.Branding_Request_Approved_by_TL){
            returdId = cas.team_lead__c;}
        else if(cas.status == System.Label.Branding_Request_Approved_by_Branding_Team || cas.status == System.Label.Branding_Request_Recce_Approved_by_Branding_team  || cas.status == System.label.Branding_Request_Completed_by_Branding_Team){
            returdId = cas.Branding_Team_Member__c;}
        else if(cas.status == System.Label.Branding_Request_Recce_Submitted_by_Vendor|| cas.status == System.label.Branding_Request_Completed_by_Vendor){
            returdId = cas.vendor__c;}
        else if(cas.status == System.Label.Branding_Request_Completed_By_BDM){
            returdId = cas.ownerId;}
        else if(cas.status == System.Label.Branding_Request_Approved_by_Branding_Manager){
            returdId = cas.Branding_Manager__c;}
        } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
        return returdId;
    }
    
 /**
 * Name: getCurrentApprover
 * Params: None
 * Description: method to get the current approver of a case
 */
    public Id getCurrentApprover(Case cas){
    Id returdId;
    try{
        if(cas.Status == System.Label.Branding_Request_New){
            returdId = cas.team_lead__c;}

        else if(cas.status == System.Label.Branding_Request_Approved_by_TL || cas.status == System.Label.Branding_Request_Recce_Submitted_by_Vendor
             || cas.status == System.label.Branding_Request_Completed_by_Vendor ){
            returdId = cas.Branding_Team_Member__c;}


        else if(cas.status == System.Label.Branding_Request_Approved_by_Branding_Team || cas.status == System.Label.Branding_Request_Approved_by_Branding_Manager ){
            returdId = cas.vendor__c;}


        else if( cas.status == System.label.Branding_Request_Completed_by_Branding_Team){
            returdId = cas.ownerId;}


        else if(cas.status == System.Label.Branding_Request_Recce_Approved_by_Branding_team ){
            returdId = cas.Branding_Manager__c;} 

        else if(cas.status == System.Label.Branding_Request_Completed_By_BDM ){
            returdId = cas.ownerId;}    //customer support 
        } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
        return returdId;
    
    }
    
 /**
 * Name: getDueDate
 * Params: None
 * Description: method to get the SLA for the approver of a case
 */
    public Integer getDueDate(Case cas){
        Integer days=0;
    try{    
        if(cas.Status == System.Label.Branding_Request_New || cas.status == System.Label.Branding_Request_Recce_Approved_by_Branding_team || cas.status == System.label.Branding_Request_Completed_by_Vendor
        || cas.status == System.label.Branding_Request_Completed_by_Branding_Team || cas.status == System.Label.Branding_Request_Completed_By_BDM  ){
            days=2;}

        else if(cas.status == System.Label.Branding_Request_Recce_Submitted_by_Vendor){
            if(cas.Metro_Non_Metro__c==System.Label.Branding_Request_Metro)
            days=2;
            else if(cas.Metro_Non_Metro__c==System.Label.Branding_Request_Non_Metro)
            days=3;}
            
        else if(cas.status == System.Label.Branding_Request_Approved_by_TL){
            days=1;}

        else if((cas.status == System.Label.Branding_Request_Approved_by_Branding_Team || cas.status == System.Label.Branding_Request_Approved_by_Branding_Manager) && cas.Metro_Non_Metro__c==System.Label.Branding_Request_Metro ){
            days=5;}
         
        else if(cas.status == System.Label.Branding_Request_Approved_by_Branding_Team && cas.Metro_Non_Metro__c==System.Label.Branding_Request_Non_Metro ){
            days=7;}
            
        else if(cas.status == System.Label.Branding_Request_Approved_by_Branding_Manager && cas.Metro_Non_Metro__c==System.Label.Branding_Request_Non_Metro ){
            days=8;}
        } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
        return days;

    }
    
    /**
 * Name: taskForInventory
 * Params: None
 * Description: Method to create tasks for approvers
 */ 
    public void taskForInventory(){
    try{
        
        if(trigger.isbefore && trigger.isupdate){
            List<Task> taskToInsert = new List<Task>();
            List<Task> taskToUpdate = new List<Task>();
            List<Id> caseid = new List<id>();
            List<Case> caseReferenceNew = new List<case>();
            List<Case> caseReferenceOld = new List<case>();
            for(sobject caseRequest : trigger.new){
                Case newStatusCase = (Case) caseRequest;
                Case  oldStatusCase = (Case)Trigger.oldMap.get(newStatusCase.id);
                if(newStatusCase.RecordTypeId==collateralRequest){
                    if((newStatusCase.status != oldStatusCase.status)||
                            (newStatusCase.Is_In_Approval_Process__c != oldStatusCase.Is_In_Approval_Process__c)){
                            caseid.add(newStatusCase.id);
                            caseReferenceNew.add(newStatusCase);
                    }
                }
            }
            List<Task> openTask =[select status, id, whoid, whatid, ownerid, createddate from task t where status != :System.Label.Collateral_Request_Completed and whatid in : caseid];
            if(openTask.size() != 0){
                for(Case taskCase : caseReferenceNew){

                    for(Task tasks : openTask){
                        if(tasks.whatid == taskCase.id){
                            Id TaskOwnerId = getPreviousApproverIdForInventory(taskCase);
                            Id CurrentOwnerId = getCurrentApproverForInventory(taskCase);
                            if(CurrentOwnerId != TaskOwnerId){
                                tasks.status = System.Label.Collateral_Request_Completed;
                                tasks.BD_Comments__c ='Completed the task on '+ system.today();
                                taskToUpdate.add(tasks);
                                if(taskCase.status != System.Label.Collateral_Request_Completed){
                                    Task InsertTask = getStaticDetails();
                                    InsertTask.subject ='Collateral Request Approval';
                                    if(CurrentOwnerId != null){
                                        InsertTask.ownerId =CurrentOwnerId ;
                                        InsertTask.WhatId = taskCase.id;
                                        InsertTask.ActivityDate = Date.today()+getDueDateForCollateral(taskCase);
                                        taskToInsert.add(InsertTask);
                                    }
                                }
                            }         
                        } 
                    }
                }

            }
            else{
                for(Case taskCase : caseReferenceNew){
                
                if(taskCase.team_lead__c != null){
                    Task InsertTask = getStaticDetails();
                    InsertTask.subject ='Collateral Request Approval';
                    InsertTask.ownerId = taskCase.team_lead__c;
                    InsertTask.WhatId =  taskCase.id;
                    InsertTask.ActivityDate = Date.today()+getDueDateForCollateral(taskCase);
                    taskToInsert.add(InsertTask);
                    }
                 else if(taskCase.depo__c != null){
                    Task InsertTask = getStaticDetails();
                    InsertTask.subject ='Collateral Request Approval';
                    InsertTask.ownerId = taskCase.depo__c;
                    InsertTask.WhatId =  taskCase.id;
                    InsertTask.ActivityDate = Date.today()+getDueDateForCollateral(taskCase);
                    taskToInsert.add(InsertTask);
                 }
                 else{
                 Task InsertTask = getStaticDetails();
                    InsertTask.subject ='Collateral Request Approval';
                    InsertTask.ownerId = taskCase.head_office__c;
                    InsertTask.WhatId =  taskCase.id;
                    InsertTask.ActivityDate = Date.today()+getDueDateForCollateral(taskCase);
                    taskToInsert.add(InsertTask);
                 
                 }
                }  

            }
            update taskToUpdate;
            insert taskToInsert; 
        }
      } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
    }
    
     /**
 * Name: getPreviousApproverIdForInventory
 * Params: None
 * Description: method to get the previous approver of a case
 */
    public Id getPreviousApproverIdForInventory(Case cas){
    Id returdId;
    try{
        /* Getting the previous approver for Collateral*/
        if(cas.Status == 'New' || cas.status == 'Auto Approved'){
            returdId = null;}
        else if(cas.status == 'Approved by Team Leader'){
            returdId = cas.team_lead__c;}
        else if(cas.status == 'Dispatched' || cas.status == 'Corrected Dispatch'){
        if(cas.depo__c != null){
            returdId = cas.depo__c;}
            else{
             returdId = cas.head_office__c;
            }
            }
        else if(cas.status == 'Completed' || cas.status == 'Correction of Dispatch Quantity' ){
            returdId = cas.ownerId;}
        } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
        return returdId;
    }
    
 /**
 * Name: getCurrentApproverForInventory
 * Params: None
 * Description: method to get the current approver of a case
 */
    public Id getCurrentApproverForInventory(Case cas){
    Id returdId;
    try{
        if(cas.Status == 'New'){
            returdId = cas.team_lead__c;}

        else if(cas.status == 'Approved by Team Leader' || cas.status == 'Correction of Dispatch Quantity'){
           if(cas.depo__c != null){
            returdId = cas.depo__c;}
            else{
             returdId = cas.head_office__c;
            }
            }
        else if(cas.status == 'Auto Approved'){
        returdId = cas.head_office__c;
        }
        else if(cas.status == 'Dispatched' || cas.status == 'Corrected Dispatch' ){
            returdId = cas.ownerId;}
        } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
        return returdId;
    
    }
    
    /**
 * Name: getDueDateForCollateral
 * Params: None
 * Description: method to get the SLA for the approver of a case
 */
    public Integer getDueDateForCollateral(Case cas){
        Integer days=0;
    try{    
        if(cas.Status == 'New'){
        if(cas.Collateral_Flows__c == 'Requestor'){
            days=3;}
        else if(cas.Collateral_Flows__c == 'Depot'){
        if(cas.Depot_Zone__c =='North' || cas.Depot_Zone__c =='East'){
        days=11;
        }
        if(cas.Depot_Zone__c =='West'){
                days=8;
        }
        if(cas.Depot_Zone__c =='South'){
                days=6;
        }
        } 
        
            
        }
        
        else if(cas.status == 'Auto Approved'){
            if(cas.Check_Gifts__c == true){
            days = 40;
            }
            else if(cas.collateral_check__c == true){
            days =6;
            } 
            else{
            days = 4;
            }       
        }
        
        else if(cas.status == 'Approved by Team Leader' || cas.status == 'Correction of Dispatch Quantity')
            days=4;
        
        else if(cas.status == 'Dispatched' || cas.status == 'Corrected Dispatch'){
            days=3;} 
            
            
        } catch(exception e){system.debug('Exception Occurred'+e.getMessage());} 
        
return days; 
    }
    
}