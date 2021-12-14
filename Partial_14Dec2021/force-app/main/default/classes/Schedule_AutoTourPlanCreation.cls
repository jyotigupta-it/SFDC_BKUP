global class Schedule_AutoTourPlanCreation implements Schedulable{
    global void execute(SchedulableContext sc) {
        Database.executeBatch(new Batch_AutoTourPlanCreation(null,''),1);
    }
}