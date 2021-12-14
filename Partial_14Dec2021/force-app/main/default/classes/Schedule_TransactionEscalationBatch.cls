global class Schedule_TransactionEscalationBatch implements Schedulable{
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new TransactionEscalationBatch(),1);
    }
}