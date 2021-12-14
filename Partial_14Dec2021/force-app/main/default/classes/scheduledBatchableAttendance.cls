global class scheduledBatchableAttendance implements Schedulable {

  global void execute(SchedulableContext sc) {
  BatchCreateAttendanceRecords batchRun = new BatchCreateAttendanceRecords(); // Attendance Batch Class
  database.executebatch(batchRun);
  }
  
}