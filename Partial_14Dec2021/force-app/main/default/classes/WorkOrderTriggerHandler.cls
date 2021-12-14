public class WorkOrderTriggerHandler {
    public static void afterUpdate(Map<Id,WorkOrder> mapOfNewWorkOrders, Map<Id,WorkOrder> mapOfOldWorkOrders){
        Map<Id,WorkOrder> mapOfWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfNewStatusWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfClosedWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfInProgressWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfViolatedWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfViolatedWorkOrders2 = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfTechnicianAssigned = new Map<Id,WorkOrder>();
        for(WorkOrder wo : mapOfNewWorkOrders.values()){
            if(wo.status != null && (wo.status == WorkOrderConstants.WORK_ORDER_STATUS_IN_PROGRESS || wo.status == WorkOrderConstants.WORK_ORDER_STATUS_CLOSED) && wo.status != mapOfOldWorkOrders.get(wo.Id).status){
                mapOfWorkOrders.put(wo.Id, wo);
            }
            if(wo.status != null && (wo.status == 'Acceptance Pending')  && wo.status != mapOfOldWorkOrders.get(wo.Id).status){
                mapOfNewStatusWorkOrders.put(wo.Id, wo);
            }
            if(wo.stop_Milestone__c != null && (wo.stop_Milestone__c == 'Case Violation')  && wo.stop_Milestone__c != mapOfOldWorkOrders.get(wo.Id).stop_Milestone__c){
                mapOfViolatedWorkOrders.put(wo.Id, wo);
            }
            if(wo.stop_Milestone__c != null && (wo.stop_Milestone__c == 'Cart Violation')  && wo.stop_Milestone__c != mapOfOldWorkOrders.get(wo.Id).stop_Milestone__c){
                mapOfViolatedWorkOrders2.put(wo.Id, wo);
            }
            if(wo.status != null && (wo.status == 'Technician Assigned')  && wo.status != mapOfOldWorkOrders.get(wo.Id).status){
                mapOfTechnicianAssigned.put(wo.Id, wo);
            }
            /*if(wo.status != null && wo.status != mapOfOldWorkOrders.get(wo.Id).status && wo.status == 'Closed' && wo.Closed_Reason__c == 'Customer Not Avaliable'){
                mapOfClosedWorkOrders.put(wo.Id, wo);
            }
            if(wo.status != null && wo.status != mapOfOldWorkOrders.get(wo.Id).status && wo.status == 'Closed' && wo.Closed_Reason__c == 'Problem Resolved'){
                mapOfClosedWorkOrders.put(wo.Id, wo);
            }*/
            if(wo.status != null && wo.status != mapOfOldWorkOrders.get(wo.Id).status && wo.status == 'Accepted' && mapOfOldWorkOrders.get(wo.Id).status == 'Acceptance Pending'){
                mapOfInProgressWorkOrders.put(wo.Id, wo);
                System.debug('MSG Called');
            }
            
        }
        //if(!mapOfTechnicianAssigned.values().isEmpty())
        //WorkOrderTriggerHelper.updateCaseStatus(mapOfTechnicianAssigned, 'Plumber Assigned');
        if(!mapOfViolatedWorkOrders.values().isEmpty())
        WorkOrderTriggerHelper.updateCaseDetails(mapOfViolatedWorkOrders);
        if(!mapOfViolatedWorkOrders2.values().isEmpty())
        WorkOrderTriggerHelper.updateCaseDetails2(mapOfViolatedWorkOrders2);
        if(!mapOfWorkOrders.values().isEmpty())
        WorkOrderTriggerHelper.updateWorkOrderMileStone(mapOfWorkOrders);
        if(!mapOfNewStatusWorkOrders.isEmpty())
        SMSLogService.generateSMSContentForWorkOrders(mapOfNewStatusWorkOrders,'Contractor');
        /*if(!mapOfClosedWorkOrders.isEmpty()){
        SMSLogService.generateSMSContentForWorkOrders(mapOfClosedWorkOrders);
        }*/
        if(!mapOfInProgressWorkOrders.isEmpty()){
        System.debug('MSG Called2');
        SMSLogService.generateSMSContentForWorkOrders(mapOfInProgressWorkOrders,'Customer');
            System.debug('MSG Called');
        }
     
    }
    public static void beforeUpdate(Map<Id,WorkOrder> mapOfNewWorkOrders, Map<Id,WorkOrder> mapOfOldWorkOrders){
        Map<Id,WorkOrder> mapOfHoldWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfResumeWorkOrders = new Map<Id,WorkOrder>();
        Map<Id,WorkOrder> mapOfClosedWorkOrders=new Map<Id,WorkOrder>();
        for(WorkOrder wo : mapOfNewWorkOrders.values()){
            if(wo.status != null && wo.status == WorkOrderConstants.WORK_ORDER_STATUS_ON_HOLD && wo.status != mapOfOldWorkOrders.get(wo.Id).status){
                mapOfHoldWorkOrders.put(wo.Id, wo);
            }
            if(wo.status != null  && mapOfOldWorkOrders.get(wo.Id).status == WorkOrderConstants.WORK_ORDER_STATUS_ON_HOLD && wo.status != mapOfOldWorkOrders.get(wo.Id).status){
                mapOfResumeWorkOrders.put(wo.Id, wo);
            }
            if(wo.Status=='Closed' && wo.Status!=mapOfOldWorkOrders.get(wo.Id).Status && wo.Status!=null){
              mapOfClosedWorkOrders.put(wo.Id,wo)  ;
            }
            if(wo.Stop_milestone__c=='Case Violation'){
                System.debug('***************trigger is firing*****************');
            }
        }
        if(!mapOfHoldWorkOrders.isEmpty())
        WorkOrderTriggerHelper.pauseWorkOrderMilestones(mapOfHoldWorkOrders,true);
        if(!mapOfResumeWorkOrders.isEmpty())
        WorkOrderTriggerHelper.pauseWorkOrderMilestones(mapOfResumeWorkOrders,false);
        if(!mapOfClosedWorkOrders.isEmpty())
        WorkOrderTriggerHelper.validationForWorkOrderClosed(mapOfClosedWorkOrders);
    }
    public static void afterInsert(Map<Id,WorkOrder> mapOfWorkOrders){
        Map<Id,WorkOrder> mapOfNewWorkOrders = new Map<Id,WorkOrder>();
         Map<Id,WorkOrder> mapOfService = new Map<Id,WorkOrder>();
        
        for(WorkOrder wo : mapOfWorkOrders.values()){
            if(wo.status != null && (wo.status == 'Acceptance Pending' || wo.status == 'Accepted')){
                mapOfNewWorkOrders.put(wo.Id, wo);
            }
             if(wo.OwnerId!=null){
                mapOfService.put(wo.Id,wo);
            }
            
        }
        if(!mapOfNewWorkOrders.isEmpty())
        SMSLogService.generateSMSContentForWorkOrders(mapOfNewWorkOrders, 'Contractor');
       
       
    }
    
         
    
    
        
}