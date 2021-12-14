global class NoOfProjectVisitRollUp_scheduler implements Schedulable{

    /*8***public static String CRON_EXPR = '0 0 10 1/1 * ? *';  //Every Day at Midnight 
       
    
     global static String scheduleIt() {
    NoOfProjectVisitRollUp_scheduler job = new NoOfProjectVisitRollUp_scheduler();
    return System.schedule('ProjectVisitWarningmail', CRON_EXPR, job);
  }***/
  
    global void execute(SchedulableContext sc) {
        
        NoOfProjectVisitRollUp_Batch BatchJob = new NoOfProjectVisitRollUp_Batch();
         ID batchprocessid =Database.executeBatch(BatchJob,200);         
    }
 }