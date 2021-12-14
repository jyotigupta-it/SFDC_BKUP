/********************************************XXX**********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 14-Oct-2017
Description     : Batch test class for Birthday & Anniversary sms wishes

**********************************************XXX*********************************************************/
@isTest(SeeAllData=false)
global class ScheduledBatchableBirthdayTest {
    
        public static testmethod void testMethod1(){
        List<Account> lstAccount = new List<Account>();
        for(Integer i=0 ;i <1;i++){
            Account acc = new Account();
            acc.Name ='Name'+i;
            acc.Primary_Contact_Person_Name__c='contact name'+i;
            acc.Contact_Number_Mobile__c='9900044387'; 
            acc.Birth_Date__c=System.today();
            acc.Anniversary_Date__c=System.today();
            lstAccount.add(acc);
        }
        insert lstAccount;
        Test.startTest();
        Batch_Birthday_Anniversary_SMS_alert batchScheduleRun = new Batch_Birthday_Anniversary_SMS_alert();
        database.executeBatch(batchScheduleRun,5);
        Test.stopTest();             
    }
    
     public static testmethod void testMethod2(){
        List<Account> lstAccount = new List<Account>();
        for(Integer i=0 ;i <1;i++){
            Account acc = new Account();
            acc.Name ='Name'+i;
            acc.Contact_Number_Mobile__c='9900044387';
            acc.Anniversary_Date__c=System.today();   
            lstAccount.add(acc);
        }
        insert lstAccount;
       Test.startTest();
        Batch_Birthday_Anniversary_SMS_alert batchScheduleRun = new Batch_Birthday_Anniversary_SMS_alert();
        database.executeBatch(batchScheduleRun,5);
        Test.stopTest();             
    }
    
      public static testmethod void testMethod3(){
        List<Account> lstAccount = new List<Account>();
        for(Integer i=0 ;i <1;i++){
            Account acc = new Account();
            acc.Name ='Name'+i;
            acc.Contact_Number_Mobile__c='9900044387'; 
            acc.Birth_Date__c=System.today();
            lstAccount.add(acc);
        }
        insert lstAccount;
        Test.startTest();
        Datetime dt = Datetime.now().addMinutes(1);
        String Schedule_time = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
        System.schedule('schedulebatchbirthdayclasstest1', schedule_time, new ScheduledBatchableBirthdayAnniversarySMS());
        Test.stopTest(); 
            
    }
}