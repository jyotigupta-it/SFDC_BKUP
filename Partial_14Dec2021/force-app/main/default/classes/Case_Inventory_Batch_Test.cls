/*
 * Author: Renjay Surendran
 */
@isTest
private class Case_Inventory_Batch_Test
{
    static testmethod void StartTest(){
    
         Database.BatchableContext BC;
         List<Target__c> lt= new List<Target__c>();
         
         test.startTest();
                    
        // String batchID1=Case_Email_Scheduler_class.scheduleMe(); 
         
         String sched = '0 00 00 * * ?';  //Every Day at Midnight 

         Sync_Inventory_Scheduler_class SC1 = new Sync_Inventory_Scheduler_class(); 
         String batchID2=System.schedule('Sync_Inventory', sched, SC1);
         
         AutoRequestForMeet_Scheduler_class SC2 = new AutoRequestForMeet_Scheduler_class(); 
         String batchID3=System.schedule('AutoRequestForMeet', sched, SC2);
         
         Bi_Monthly_Batch_Scheduler SC3 = new Bi_Monthly_Batch_Scheduler(); 
         String batchID4=System.schedule('Bi_Monthly_Batch_Scheduler', sched, SC3);
         
         Scheduledbatchclasstodeleteattachements SC4 = new Scheduledbatchclasstodeleteattachements();
         String batchID5=System.schedule('Scheduledbatchclasstodeleteattachements', sched, SC4);
         
       Quiz_Second_Email_Scheduler_class SC5= new Quiz_Second_Email_Scheduler_class();
      String batchID6=System.schedule('Second Email', sched, SC5);
         
        Quiz_First_Email_Scheduler_class SC6= new Quiz_First_Email_Scheduler_class();
         String batchID7=System.schedule('First Email', sched, SC6);
         
        scheduledQuizChatter SC7= new scheduledQuizChatter();
        String batchID8=System.schedule('First Quiz', sched, SC7);
         
         AutoRequestForMeetController prog = new AutoRequestForMeetController();
         prog.execute(BC, lt); 
                                                    
                                                      
         
         //System.abortJob(batchID1);
         System.abortJob(batchID2);
         System.abortJob(batchID3);
         System.abortJob(batchID4);
         System.abortJob(batchID5);
       System.abortJob(batchID6);
         System.abortJob(batchID7);
       System.abortJob(batchID8);
       test.stopTest();    
    }
}