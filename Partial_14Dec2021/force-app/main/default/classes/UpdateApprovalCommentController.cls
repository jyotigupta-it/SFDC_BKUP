/******************************************************************************************************
* Created By: Subhajit Ghosh
* Created Date: 17.9.2019
* Company: KVP Business Solutuons Pvt. Ltd.
* Description: This trigger captures the latest approval comments and stores in the Unique SPR level.
  This is used to get approval history and comments on the basis on line items.It also captures the name of the user who 
  approved or rejected the record.
* Test:      UpdateApprovalCommentControllerTest

**************************************************************************************************/


public class UpdateApprovalCommentController {
    public static void updateApprovalComment(List<Unique_SPR__c> unsprId){
        Set<Id> unsprIdSet=new Set<Id>();
        List<Id>  osprIds = New List <Id>();
        List<Unique_SPR__c> sprToUpdate=new List<Unique_SPR__c>();
        try{
            
            for(Unique_SPR__c spr:unsprId){
                //if(opp.Special_Pricing_Request_Approval__c !='Pending'){
                unsprIdSet.add(spr.Id);
                // }
            }
            system.debug('unsprIdSet--'+unsprIdSet);
           
                
                List<ProcessInstance> instances = [select Id, TargetObjectId from ProcessInstance where TargetObjectId in :unsprIdSet order by createddate DESC];//get the latest process instance only
                Map<Id,Id> OpportunityProcessMap = new Map<Id,Id>();
                system.debug('instances----'+instances);
                for(ProcessInstance pi:instances){
                    if(!OpportunityProcessMap.containskey(pi.TargetObjectId)){
                        OpportunityProcessMap.put (pi.TargetObjectId,pi.Id); 
                        osprIds.add (pi.Id); 
                    }
                    
                 }
                
                List<ProcessInstanceStep> instancesSteps = [select Comments,ProcessInstanceId,StepStatus,Actor.Name from ProcessInstanceStep where ProcessInstanceId in :osprIds AND (StepStatus = 'Approved' OR StepStatus ='Rejected') ORDER BY CreatedDate DESC];
               	System.debug('instancesSteps'+instancesSteps);
            	Map<Id,String> OppProcessStepMap = new Map<Id,String>();
                Map<Id,String> OppProcessStepMapActorName = new Map<Id,String>();
                
                for(ProcessInstanceStep pis:instancesSteps){
                    if(!OppProcessStepMap.containsKey(pis.ProcessInstanceId)){
                        OppProcessStepMap.put (pis.ProcessInstanceId, pis.Comments);
                        OppProcessStepMapActorName.put(pis.ProcessInstanceId, pis.Actor.Name);
                    }
                    
                    // system.debug('key--'+OppProcessStepMap);
                     system.debug(' OppProcessStepMap.put (pis.ProcessInstanceId, pis.Comments)---'+ OppProcessStepMap.put (pis.ProcessInstanceId, pis.Comments));
                }
                
                for(Unique_SPR__c o:unsprId){
                    //system.debug('OppProcessStepMap.get(OpportunityProcessMap.get(o.Id)---'+OppProcessStepMap.get(OpportunityProcessMap.get(o.Id)));
                    o.Approver_Comments__c=OppProcessStepMap.get(OpportunityProcessMap.get(o.Id));
                    o.Record_App_Rej_By__c=OppProcessStepMapActorName.get(OpportunityProcessMap.get(o.Id));
                    
                } 
                
                
            }
            
       
        catch(Exception e){
            system.debug('expcetion has occued while getting latest comment--'+e);
        }
    }
    
}