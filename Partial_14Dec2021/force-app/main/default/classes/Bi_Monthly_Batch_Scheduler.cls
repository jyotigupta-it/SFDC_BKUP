/*
 * Author: Renjay Surendran
 */
global class Bi_Monthly_Batch_Scheduler implements Schedulable{

    global void execute(SchedulableContext sc) {
      Date currentDate = Date.today();
      Integer a=currentDate.month()/2;
      Integer b=a*2;  
      if(currentDate.month()==b)
       {  
        Bi_Monthly_Batch b1 = new Bi_Monthly_Batch();
        ID batchprocessid = Database.executeBatch(b1,5);           
       } 
    }
}