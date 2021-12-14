public class AssignedResourceTriggerHandler {

    public static void afterInsert(Map<Id,AssignedResource> mapOfAssignedResource){
        SMSLogService.generateSMSContentForAssignedResource(mapOfAssignedResource);
        AssignedResourceTriggerHelper.assignServiceAppointmentToResource(mapOfAssignedResource);
    }
    public static void beforeInsert(List<AssignedResource> listOfAssignedResource){
        
    }
    //new
    public static void afterupdate(Map<Id,AssignedResource> mapOfAssignedResource){
           SMSLogService.generateSMSContentForAssignedResource(mapOfAssignedResource);
           AssignedResourceTriggerHelper.assignServiceAppointmentToResource(mapOfAssignedResource);
    }
}