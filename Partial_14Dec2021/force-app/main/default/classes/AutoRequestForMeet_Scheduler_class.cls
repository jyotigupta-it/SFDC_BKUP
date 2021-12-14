/*
 * Author: vasanthi K N
 */
global class AutoRequestForMeet_Scheduler_class implements Schedulable{

    global void execute(SchedulableContext sc) {

        AutoRequestForMeetController b1 = new AutoRequestForMeetController();
        ID batchprocessid = Database.executeBatch(b1,10);           
    }
}