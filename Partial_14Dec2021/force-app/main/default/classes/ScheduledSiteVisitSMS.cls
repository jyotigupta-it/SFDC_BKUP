/********************************************XXX**********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 22-Nov-2017
Description     : Scheduled Batch class for SiteVisit  

**********************************************XXX*********************************************************/
global class ScheduledSiteVisitSMS implements schedulable {
    global void execute(SchedulableContext sc)  {
        Batch_SMS_on_Sitevisit batchScheduleRun = new Batch_SMS_on_Sitevisit();
        database.executeBatch(batchScheduleRun,1);
    }
}