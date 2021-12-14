global class ScheduleChurnBatch implements schedulable
{
    global void execute(SchedulableContext sc)
    {
    DealerChurnAPIBatch dcab = new DealerChurnAPIBatch();
      database.executebatch(dcab);
    }
}