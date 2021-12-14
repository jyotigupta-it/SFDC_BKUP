global class BatchAttendanceAndExpenseDelete implements Database.Batchable<SObject>,Database.Stateful{   
    global List<String> Month;
    global String userdat;
    global Integer year,year1;
    global map<Id,User> mapuser;
    global List<String> userdataDelete;
    
    
    
     global Database.QueryLocator start(Database.BatchableContext bc) {
        //first, you gather all the records you want to create a new record with
    Month=new List<String>{'01','02','03','04','05','06','07','08','09','10','11','12'};
        Date dt = System.Today();
            year=dt.addMonths(-3).year();
        
        String monthVar='';
        
        
        if(Month[dt.addmonths(-3).month()-1]=='01'){
            monthVar='12';
            year=dt.addMonths(-3).year()-1;
        }else{
            monthVar=Month[dt.addmonths(-3).month()-2];
        }
        System.debug(monthVar);
        
        userdat=monthVar+Month[dt.addmonths(-3).month()-1]+year;
        system.debug(userdat);
        
        
        
        mapUser=new Map<Id,User>([select id,Create_Attendance__c  from user where Create_Attendance__c=true AND isActive=true]);
        userdataDelete=new List<String>();
        for(Id z:mapuser.keySet()){
            userdataDelete.add(''+z+userdat);
        }
        System.debug(userdataDelete);
date frm=date.newInstance(dt.year(),dt.addMonths(-3).month()-1,25);
        date to=frm.addmonths(1);
        System.debug('Frm===>'+frm);
        System.debug('To====>'+to);

        String attendanceRecords='select id from Attendance__c where TourPlanDate__c>=:frm  and TourPlanDate__c<=:to';
       
        //below checks to see if the batch is being called from a test class. If the record count
        //returned by the query above is over 200, the test will fail
/*        if(Test.isRunningTest())
            query += ' limit 200';  */
            
        return Database.getQueryLocator(attendanceRecords);
    }
    
  
      global void execute(Database.BatchableContext BC, List<Attendance__c>attendanceRecords){
      
     
          List<Attendance_Expense__c> attExpenseRecords=[select id from Attendance_Expense__c where External_Id__c in:userdataDelete];
      
          
          if(!attendanceRecords.isEmpty())
            database.delete(attendanceRecords,false); 
          if(!attExpenseRecords.isEmpty())
            database.delete(attExpenseRecords,false); 
       }
       
         global void finish(Database.BatchableContext bc) {
             System.debug('Finish');   
         
         }
        
}