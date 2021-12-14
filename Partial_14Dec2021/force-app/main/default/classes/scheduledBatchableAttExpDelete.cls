global class scheduledBatchableAttExpDelete implements Schedulable {

  global void execute(SchedulableContext sc) {
  BatchAttendanceAndExpenseDelete batchRun = new BatchAttendanceAndExpenseDelete(); 
  database.executebatch(batchRun);
  }
  
}