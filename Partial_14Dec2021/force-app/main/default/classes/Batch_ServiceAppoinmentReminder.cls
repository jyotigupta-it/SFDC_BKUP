global class Batch_ServiceAppoinmentReminder implements Database.AllowsCallouts,Database.Batchable<sObject>,schedulable {
    public dateTime todayDate;
    public dateTime yesterdayDate;
    Public String Status;
    global void execute(SchedulableContext sc) {
        Batch_ServiceAppoinmentReminder b = new Batch_ServiceAppoinmentReminder();
        database.executebatch(b,1);
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
       todayDate = System.Today();
        Status='Scheduled';
        system.debug('xxxxxxxxxx');
        List<ServiceAppointment> listOfService=[SELECT ID,SchedStartTime,Service_Appointment_Notificetion__c,Status From ServiceAppointment Where SchedStartTime=Today AND Status=:Status];
       System.debug('listofsrvicennnn'+listOfService);
        return Database.getQueryLocator(
            'SELECT ID,SchedStartTime,Service_Appointment_Notificetion__c,Status From ServiceAppointment Where SchedStartTime=Today AND Status=:Status' 
        );
    }
    global void execute(Database.BatchableContext bc, List<ServiceAppointment> serviceAppoinmentList){
        system.debug('hhhhhh');
        Map<Id,ServiceAppointment> mapOfServiceAppointments = new Map<Id,ServiceAppointment>();
        for(ServiceAppointment serviceApp:serviceAppoinmentList){
           mapOfServiceAppointments.put(serviceApp.id, serviceApp);
        }
        SMSLogService.generateSMSContentForServiceAppointmentBatch(mapOfServiceAppointments,'Day Batch');
    }    
    global void finish(Database.BatchableContext bc){
    }    
}