global class BatchCreateAttendanceRecords implements Database.Batchable<SObject>, Database.Stateful {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        //first, you gather all the records you want to create a new record with
      
            Map<Id,User> mapUser=new Map<Id,User>([select id,Create_Attendance__c  from user where Create_Attendance__c=true AND isActive=true]);
            List<Id> zz=new List<Id>();
            for(Id z:mapUser.KeySet()){
                zz.add(z);
            }
       
           // set<Id> usrSet=new set<Id>();
           // String usrSet='select id,name,Create_Attendance__c from User where Create_Attendance__c=true AND isActive=true';
           //system.debug(usrSet);
            Date startDate=Date.newInstance(System.today().Year(),System.today().month(),23);
            Date endDate=startDate.addMonths(1);
            System.debug('startDate =='+startDate);
            System.debug('endDate =='+endDate);
          //  List<AP_Tour_Plan__c> tourPlanLst = [SELECT Id, Name, Date__c, Target__c,Target__r.Target_User__c,Target__r.Target_User__r.Name, Target__r.Target_User__r.EmployeeNumber, Non_Holiday_Non_Leave_Other_Activities__c, Non_Holiday_Non_Leave_Visit_Activities__c, Number_of_Leave_Holiday__c FROM AP_Tour_Plan__c where (Date__c =Today OR Date__c = Yesterday)];
            String tourPlanLst = 'SELECT Id, Name, Date__c, Target__c,Target__r.Target_User__c,Target__r.Target_User__r.Name, Target__r.Target_User__r.EmployeeNumber, Non_Holiday_Non_Leave_Other_Activities__c, Non_Holiday_Non_Leave_Visit_Activities__c, Number_of_Leave_Holiday__c FROM AP_Tour_Plan__c where (Date__c =LAST_N_DAYS:90 and Date__c<=Today) and Target__r.Target_User__r.Id in:zz';
            
        //below checks to see if the batch is being called from a test class. If the record count
        //returned by the query above is over 200, the test will fail
       /*if(Test.isRunningTest())
            query += ' limit 200'; */ 
        return Database.getQueryLocator(tourPlanLst);
    }
    
   
    
    
    global void execute(Database.BatchableContext bc, List<AP_Tour_Plan__c> tourPlanLst){
        //now we want to loop through the records from the query above and create the new records
        //and store them in a list
         Map<String,AP_Tour_Plan__c> presentMapTour=new Map<String,AP_Tour_Plan__c>();
         Map<String,AP_Tour_Plan__c> absentMapTour=new Map<String,AP_Tour_Plan__c>();
         String inTime=Label.In_Time;
         String outTime=Label.Out_Time;

         for(AP_Tour_Plan__c tour:tourPlanLst){
                 List<String> tourdate=(''+tour.Date__c).split(' ');
                 List<String> dateSplit=tourdate[0].split('-');
                 if((tour.Non_Holiday_Non_Leave_Other_Activities__c>0||tour.Non_Holiday_Non_Leave_Visit_Activities__c>0)){
                     presentMapTour.put(''+tour.Target__r.Target_User__c+dateSplit[0]+dateSplit[1]+dateSplit[2],tour);
                 }
                 if((tour.Number_of_Leave_Holiday__c>0 && tour.Non_Holiday_Non_Leave_Other_Activities__c==0 && tour.Non_Holiday_Non_Leave_Visit_Activities__c==0)||(tour.Non_Holiday_Non_Leave_Other_Activities__c==0 && tour.Non_Holiday_Non_Leave_Visit_Activities__c==0 && tour.Number_of_Leave_Holiday__c==0 )){
                     absentMapTour.put(''+tour.Target__r.Target_User__c+dateSplit[0]+dateSplit[1]+dateSplit[2],tour);
                 }
            }
            System.debug(presentMapTour);
            System.debug(absentMapTour);
            
            Map<String,Attendance__c> presentAttendance= new Map<String,Attendance__c>();
            Map<String,Attendance__c> absentAttendance= new Map<String,Attendance__c>();
            List<Attendance__c> attendanceLst = [Select id,name,Employee_Id__c,Employee_Name__c,Status__c,Tour_Plan__c,TourPlanDate__c,Employee__c from Attendance__c where  (TourPlanDate__c = LAST_N_DAYS:90 and Tourplandate__c <= Today)];
            for(Attendance__c att:attendanceLst){
                List<String> tourdate=(''+att.TourPlanDate__c).split(' ');
                List<String> dateSplit=tourdate[0].split('-');
                if(att.Status__c=='Present'){
                    presentAttendance.put(att.Employee__c+dateSplit[0]+dateSplit[1]+dateSplit[2],att);
                }else{
                    absentAttendance.put(att.Employee__c+dateSplit[0]+dateSplit[1]+dateSplit[2],att);
                }
            }
            System.debug(presentAttendance);
            System.debug(absentAttendance);
            
            
            List<Attendance__C> UpsertData=new List<Attendance__C>();
            
            for(String presTour:presentMapTour.keySet()){
                if(absentAttendance.containsKey(presTour)){
                    Attendance__C temp=absentAttendance.get(presTour);
                    temp.Status__c='Present';
                    temp.In_Time__c = inTime;
                    temp.Out_Time__c = outTime;
                    UpsertData.add(temp);
                    absentAttendance.remove(presTour);
                }else if(presentAttendance.containsKey(presTour)){
                
                    System.debug('Already Present');
                }else{
                    AP_Tour_Plan__c tempTour=presentMapTour.get(presTour);
                    Attendance__C temp=new Attendance__C ();
                    temp.Employee__c= tempTour.Target__r.Target_User__c;
                    temp.Status__c = 'Present';
                    temp.In_Time__c = inTime;
                    temp.Out_Time__c = outTime;
                    temp.TourPlanDate__c= tempTour.Date__c;
                    temp.Tour_Plan__c= tempTour.Name;                  
                    UpsertData.add(temp);
                }
            }
            
           
            
            for(String absTour:absentMapTour.keySet()){
                if(presentAttendance.containsKey(absTour)){
                    Attendance__C temp=presentAttendance.get(absTour);
                    System.debug(temp);
                    temp.Status__c='Absent';
                    temp.In_Time__c = '';
                    temp.Out_Time__c = '';
                    UpsertData.add(temp);
                    presentAttendance.remove(absTour);
                }else if(absentAttendance.containsKey(absTour)){
                
                    System.debug('Already Absent');
                }else{
                    AP_Tour_Plan__c tempTour=absentMapTour.get(absTour);
                    Attendance__C temp=new Attendance__C ();
                    temp.Employee__c= tempTour.Target__r.Target_User__c;
                    temp.Status__c = 'Absent';
                    temp.In_Time__c ='';
                    temp.Out_Time__c = '';
                    temp.TourPlanDate__c= tempTour.Date__c;
                    temp.Tour_Plan__c= tempTour.Name;
                 
                    UpsertData.add(temp);
                }
            }        
        
        //this checks to see if there are any records to insert. If there are, then it will create them
       
        if(!UpsertData.isEmpty())
            database.upsert(UpsertData,false); 
        //newrecords is the list of records you put in during the for loop. The "false" is saying,
        //if one records fails to insert, still insert the rest (All or Nothing)
    }
    
    global void finish(Database.BatchableContext bc) {}
}