global class scheduledBatchableAttendanceExpense implements Schedulable {

  global void execute(SchedulableContext sc) {
  BatchAttendanceExpenseCreation batchRun = new BatchAttendanceExpenseCreation(); // Attendance Batch Class
  database.executebatch(batchRun);
  }
  
}