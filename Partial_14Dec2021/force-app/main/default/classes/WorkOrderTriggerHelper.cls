public class WorkOrderTriggerHelper {

    public static void updateWorkOrderMileStone(Map<Id,WorkOrder> mapOfWorkOrders){
        List<EntityMilestone> listOfEntityMileStones = [Select Id, ParentEntityId,completionDate  
                                                        from EntityMilestone 
                                                        where ParentEntityId  in: mapOfWorkOrders.keySet() 
                                                        and isCompleted = false];
        for(EntityMilestone em : listOfEntityMileStones){
            em.completionDate = System.now();
        }
        if(!listOfEntityMileStones.isEmpty())
        update listOfEntityMileStones;
    }
    public static void pauseWorkOrderMilestones(Map<Id,WorkOrder> mapOfWorkOrders, boolean status){
        for(WorkOrder wo: mapOfWorkOrders.values()){
            wo.isStopped = status;
        }
    }
   
    public static void validationForWorkOrderClosed(Map<Id,WorkOrder> mapOfWorkOrder){
          List<ServiceAppointment> listOfService=[select id,ParentRecordId,Status from ServiceAppointment where ParentRecordId=:mapOfWorkOrder.keySet()];
        Map<Id,List<ServiceAppointment>> mapOfServiceWithWorkOrder=new Map<Id,List<ServiceAppointment>>();
        for(ServiceAppointment sa:listOfService){
         if(mapOfServiceWithWorkOrder.containsKey(sa.ParentRecordId))
                    mapOfServiceWithWorkOrder.get(sa.ParentRecordId).add(sa);
                else
                    mapOfServiceWithWorkOrder.put(sa.ParentRecordId, new List<ServiceAppointment>{sa});
        
        }
        for(WorkOrder wo:mapOfWorkOrder.values()){
            List<ServiceAppointment> listOfServiceWorkOrder = mapOfServiceWithWorkOrder.get(wo.id);
            System.debug('listOfServiceWorkOrder'+listOfServiceWorkOrder);
            if(listOfServiceWorkOrder!=null && !listOfServiceWorkOrder.isEmpty())
            for(ServiceAppointment sa:listOfServiceWorkOrder){
                if(sa.Status!='Canceled' && sa.Status!='Completed' && sa.Status!='Cannot Complete'){
                  wo.addError('Workorder cannot be closed because service appointment is not closed');
                }
            }
        }
    }
    public static void updateCaseDetails(Map<Id,WorkOrder> mapOfWorkOrder){
        Set<Id> setOfCaseIds = new Set<Id>();
        List<case> listOfCases = new List<case>();
        for(WorkOrder wo:mapOfWorkOrder.values()){
            Case c = new Case();
            c.Id = wo.CaseId;
            c.Case_Milestone_status__c = 'Remind Contractor to accept work order';
            listOfCases.add(c);
        }
        if(!listOfCases.isEmpty()){
            update listOfCases;
        }
        
    }
    public static void updateCaseDetails2(Map<Id,WorkOrder> mapOfWorkOrder){
        Set<Id> setOfCaseIds = new Set<Id>();
        List<case> listOfCases = new List<case>();
        for(WorkOrder wo:mapOfWorkOrder.values()){
            Case c = new Case();
            c.Id = wo.CaseId;
            c.Case_Milestone_status__c = 'Remind Contractor to call customer';
            listOfCases.add(c);
        }
        if(!listOfCases.isEmpty()){
            update listOfCases;
        }
        
    }
    /*public static void updateCaseStatus(Map<Id,WorkOrder> mapOfWorkOrder,String status){
        Set<Id> setOfCaseIds = new Set<Id>();
        List<case> listOfCases = new List<case>();
        for(WorkOrder wo:mapOfWorkOrder.values()){
            Case c = new Case();
            c.Id = wo.CaseId;
            c.status = status;
            listOfCases.add(c);
        }
        if(!listOfCases.isEmpty()){
            update listOfCases;
        }
        
    }*/
    
}