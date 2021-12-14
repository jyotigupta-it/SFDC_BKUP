/*
 * Author: vasanthi
 */
global class Quiz_Second_Email_Scheduler_class implements Schedulable{

    global void execute(SchedulableContext sc) {

       Quiz_Second_Email_Controller b1 = new Quiz_Second_Email_Controller();
       ID batchprocessid = Database.executeBatch(b1,200);           
    }
}