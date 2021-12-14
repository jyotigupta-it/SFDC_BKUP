public class AssignedResourceTriggerHelper {

    public static void assignServiceAppointmentToResource(Map<Id,AssignedResource> mapOfAssignedResource){
        Map<Id,AssignedResource> mapOfAssignedResources = new Map<Id,AssignedResource>([Select Id,serviceResource.RelatedRecordId  from AssignedResource where Id in :mapOfAssignedResource.keySet()]);
        List<ServiceAppointment> listOfServiceAppointmentsToUpdate = new List<ServiceAppointment>();
        for(AssignedResource ar: mapOfAssignedResource.values()){
            ServiceAppointment sa = new ServiceAppointment();
            sa.Id = ar.ServiceAppointmentId;
            sa.OwnerId = mapOfAssignedResources.get(ar.Id).serviceResource.RelatedRecordId;
            listOfServiceAppointmentsToUpdate.add(sa);
        }
        update listOfServiceAppointmentsToUpdate;
    }

    
    }