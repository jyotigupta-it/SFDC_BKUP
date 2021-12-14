/********************************************XXX**********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 25-Oct-2017
Description     : Scheduled Batch class for birthday/anniversary msgs and made batch size to 1

**********************************************XXX*********************************************************/
global class ScheduledBatchableBirthdayAnniversarySMS implements schedulable {
    global void execute(SchedulableContext sc)  {
        Batch_Birthday_Anniversary_SMS_alert batchScheduleRun = new Batch_Birthday_Anniversary_SMS_alert();
        database.executeBatch(batchScheduleRun,1);
    }
}