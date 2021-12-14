global class ScheduleNptbBatch implements schedulable
{
    global void execute(SchedulableContext sc)
    {
        DealerNptbApiBatch dnab = new DealerNptbApiBatch();
        database.executebatch(dnab);
    }
}