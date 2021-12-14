/*
 * Author: vasanthi
 */
global class Quiz_First_Email_Scheduler_class implements Schedulable{

    global void execute(SchedulableContext sc) {

       Quiz_first_Email_Controller b1 = new Quiz_first_Email_Controller();
       ID batchprocessid = Database.executeBatch(b1,200);           
    }
}