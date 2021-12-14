global class Batch_PreviousDayReminderForService implements Database.AllowsCallouts,Database.Batchable<sObject>,schedulable {
    public dateTime yesterdayDate;
    Public String Status;
    global void execute(SchedulableContext sc) {
        Batch_PreviousDayReminderForService b = new Batch_PreviousDayReminderForService();
        database.executebatch(b,1);
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        yesterdayDate=System.Today()+1;
        Status='Scheduled';
        List<ServiceAppointment> listOfServiceAppoinments=[SELECT ID,SchedStartTime,Service_Appointment_Notificetion__c,Status From ServiceAppointment Where SchedStartTime=TOMORROW AND Status=:Status ];
        System.debug('ggggg'+listOfServiceAppoinments);
       return Database.getQueryLocator(
            'SELECT ID,SchedStartTime,Service_Appointment_Notificetion__c,Status From ServiceAppointment Where SchedStartTime=TOMORROW AND Status=:Status '
        );
    }
    global void execute(Database.BatchableContext bc, List<ServiceAppointment> serviceAppoinmentList){
        system.debug('hhhhhh');
        Map<Id,ServiceAppointment> mapOfServiceAppointments = new Map<Id,ServiceAppointment>();
        for(ServiceAppointment serviceApp:serviceAppoinmentList){
           mapOfServiceAppointments.put(serviceApp.id, serviceApp);
        }
        SMSLogService.generateSMSContentForServiceAppointmentBatch(mapOfServiceAppointments,'Before Day Batch');
    }    
    global void finish(Database.BatchableContext bc){
    }    
}