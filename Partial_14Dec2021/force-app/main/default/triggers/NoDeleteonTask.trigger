trigger NoDeleteonTask on Task (before delete){  
    preventdelteTask.prvdeltask(Trigger.old);
}