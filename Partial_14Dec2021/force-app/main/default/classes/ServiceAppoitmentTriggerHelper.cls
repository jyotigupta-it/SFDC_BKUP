public class ServiceAppoitmentTriggerHelper {

    public static void updateWorkOrderAndCaseStatus(Map<Id,ServiceAppointment> mapOfServiceAppointments,String status){
        List<WorkOrder> listOfWorkOrders = new List<WorkOrder>(); 
        for(ServiceAppointment sa : mapOfServiceAppointments.values()){
            WorkOrder wo = new WorkOrder();
            wo.Id = sa.parentRecordId;
            wo.Status = status;
            listOfWorkOrders.add(wo);
        }
        update listOfWorkOrders;
        
    }
    /*public static void populateValuesInServiceAppointment(List<ServiceAppointment> listOfServiceAppoimtments){
        Set<Id> setOfSAIds = new Set<Id>();
        for(ServiceAppointment sa : listOfServiceAppoimtments){
            setOfSAIds.add(sa.Id);
        }
        Map<Id,ServiceAppointment> mapOfServiceAppointments = new Map<Id,ServiceAppointment>([Select Id,Account.ShippingStreet,Account.Shippingcity,Account.ShippingPostalCode,Account.Shippingstate,Account.ShippingCountry from ServiceAppointment where Id in:setOfSAIds]);
        for(Servi)
    }*/
    /* public static void serviceAppoinment(Map<Id,ServiceAppointment> mapOfServiceAppointment){
        
      // List<ServiceAppointment> listOfService=[select id,ParentRecordId,Work_Order__c,Work_Order_Owner__c from ServiceAppointment where Id=:mapOfServiceAppointment.keySet()];
       // system.debug('ggggg'+listOfService);
       
      List<ServiceAppointment> listOfServiceToUpdate=new List<ServiceAppointment>();
        for(ServiceAppointment sa:mapOfServiceAppointment.values()){
             ServiceAppointment sa1=new ServiceAppointment();
            sa1.id=sa.id;
           sa1.Work_Order__c=mapOfServiceAppointment.get(sa.ParentRecordId).Id;
           sa1.Work_Order_Owner__c=mapOfServiceAppointment.get(sa.ParentRecordId).OwnerId;
           listOfServiceToUpdate.add(sa1);
          
            System.debug('rrrrrrrrrr'+listOfServiceToUpdate);
        }
          if(!listOfServiceToUpdate.isEmpty())
        insert listOfServiceToUpdate;
       
    }*/
}