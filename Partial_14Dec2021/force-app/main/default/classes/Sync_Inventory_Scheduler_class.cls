/*
 * Author: Renjay Surendran
 */
global class Sync_Inventory_Scheduler_class implements Schedulable{

    global void execute(SchedulableContext sc) {

        Sync_Inventory_Controller b1 = new Sync_Inventory_Controller();
        ID batchprocessid = Database.executeBatch(b1,50);           
    }
}