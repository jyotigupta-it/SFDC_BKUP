public class ServiceAppointmentTriggerHandler {

    public static void afterUpdate(Map<Id,ServiceAppointment> mapOfNewServApps, Map<Id,ServiceAppointment> mapOfOldServApps){
        Map<Id,ServiceAppointment> mapOfCompletedSAs=new Map<Id,ServiceAppointment>();
        Map<Id,ServiceAppointment> mapOfDispatchedSAs=new Map<Id,ServiceAppointment>();
        Map<Id,ServiceAppointment> mapOfScheduledSAs=new Map<Id,ServiceAppointment>();
        for(ServiceAppointment sa: mapOfNewServApps.values()){
            if(sa.status != null && sa.status == 'Completed' && sa.status != mapOfOldServApps.get(sa.Id).status){
                mapOfCompletedSAs.put(sa.Id,sa);
            }
            if(sa.status != null && sa.status == 'Dispatched' && sa.status != mapOfOldServApps.get(sa.Id).status){
                mapOfDispatchedSAs.put(sa.Id,sa);
            }
            if(sa.status != null && sa.status == 'Scheduled' && sa.status != mapOfOldServApps.get(sa.Id).status){
                mapOfScheduledSAs.put(sa.Id,sa);
            }
            if(sa.OwnerId!=null && sa.OwnerId!=mapOfOldServApps.get(sa.Id).OwnerId){
                mapOfDispatchedSAs.put(sa.Id,sa);
            }
        }
        if(!mapOfCompletedSAs.isEmpty()){
            ServiceAppoitmentTriggerHelper.updateWorkOrderAndCaseStatus(mapOfCompletedSAs,'Completed by Plumber');
            SMSLogService.generateSMSContentForServiceAppointment(mapOfCompletedSAs,'Customer');
        }
        if(!mapOfScheduledSAs.values().isEmpty()){
            ServiceAppoitmentTriggerHelper.updateWorkOrderAndCaseStatus(mapOfScheduledSAs,'Technician Assigned');
        }
        if(!mapOfDispatchedSAs.isEmpty()){
            SMSLogService.generateSMSContentForServiceAppointment(mapOfDispatchedSAs,'Customer');
        }
        
        
    }
    
    public static void afterInsert(Map<Id,ServiceAppointment> mapOfNewServApps){
       Map<Id,ServiceAppointment> mapOfScheduledSAs=new Map<Id,ServiceAppointment>();
       Map<Id,ServiceAppointment> mapOfServiceAppointment=new Map<Id,ServiceAppointment>();
        for(ServiceAppointment sa: mapOfNewServApps.values()){
            if(sa.status != null && sa.status == 'Scheduled'){
                mapOfScheduledSAs.put(sa.Id,sa);
            }
            if(sa.ParentRecordId!=null){
                mapOfServiceAppointment.put(sa.ParentRecordId,sa);
            }
        }
        
        if(!mapOfScheduledSAs.values().isEmpty()){
            ServiceAppoitmentTriggerHelper.updateWorkOrderAndCaseStatus(mapOfScheduledSAs,'Techinician Assigned');
        }
      
        
            
        
        //if(!mapOfServiceAppointment.isEmpty()){
       //ServiceAppoitmentTriggerHelper.serviceAppoinment(mapOfServiceAppointment);
       // }
    }
    
}