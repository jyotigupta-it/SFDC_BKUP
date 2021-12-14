global class NpsCheckBatchScheduler implements Schedulable {
    global void execute(SchedulableContext sc)
    {
        NpsCheckBatch npsBatch = new NpsCheckBatch();
        Database.executeBatch(npsBatch);
    }
}