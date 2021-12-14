global class Scheduledbatchclasstodeleteattachements implements Schedulable {
   global void execute(SchedulableContext SC) {
      batchclasstodeleteattachements newbatch = new  batchclasstodeleteattachements();
        Database.executeBatch(newbatch ,100);
    }
}