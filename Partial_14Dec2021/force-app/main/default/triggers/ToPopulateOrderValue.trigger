Trigger ToPopulateOrderValue on Task(After insert,After Update){
Trigger_ToPopulateOrderValueFromTask.PopulateOrderValue(Trigger.new);
}