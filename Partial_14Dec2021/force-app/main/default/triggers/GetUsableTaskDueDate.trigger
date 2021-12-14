trigger GetUsableTaskDueDate on Task (before insert, before update)
  { 
  Task[] checkTasks = Trigger.new; 
  for(Task t : checkTasks)
  { 
  t.Task_DPD1__c = t.ActivityDate;}
  
   }