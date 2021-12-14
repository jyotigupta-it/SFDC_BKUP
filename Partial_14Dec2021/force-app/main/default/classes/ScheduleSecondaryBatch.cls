global class ScheduleSecondaryBatch implements schedulable
{
    global void execute(SchedulableContext sc)
    {
        DealerSecondaryApiBatch dsab = new DealerSecondaryApiBatch();
        database.executebatch(dsab);
    }
}