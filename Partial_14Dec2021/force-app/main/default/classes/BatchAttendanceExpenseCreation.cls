global class BatchAttendanceExpenseCreation implements Database.Batchable<SObject>,Database.Stateful{
    global Date startDate,EndDate;
    
    global Map<String,List<AP_Tour_Plan__c>> MapTour; 
    
    global BatchAttendanceExpenseCreation(){
        try{
            endDate=Date.newInstance(System.today().year(),System.today().month(),25);
            startDate=endDate.addMonths(-1);
            System.debug('Start Date :'+startDate);
            System.debug('End Date :'+endDate);
            MapTour=new Map<String,List<AP_Tour_Plan__c>>();
        }catch(Exception ex){
            System.debug(ex);
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());
        }
    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        try{
            String Query='select Id,Date__c,Ex_Station_Actual__c,Target__r.Target_User__c,Head_Quarter_Actual__c,Head_Quarter_Metro_Actual__c,Head_Quarter_State_Capital_Actual__c,Out_Station_Actual__c,Target__r.Target_User__r.EmployeeNumber from AP_Tour_Plan__c where Date__c>=:startDate AND Date__c<=:endDate';
            return Database.getQueryLocator(Query);
        }catch(Exception ex){
            System.debug(ex);
            System.debug(ex.getLineNumber());
            System.debug(ex.getMessage());
        }
        return null;
    }
    global void execute(Database.BatchableContext bc,List<AP_Tour_Plan__c> tourLst){
        try{
            System.debug(tourLst);
            for(AP_Tour_Plan__c temp:tourLst){
                if(MapTour.containsKey(temp.Target__r.Target_User__c)){
                    MapTour.get(temp.Target__r.Target_User__c).add(temp);
                }else{
                    MapTour.put(temp.Target__r.Target_User__c,new List<AP_Tour_Plan__c>{temp});
                }
            }
            
        }catch(Exception ex){
            System.debug(ex);
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());
   
        }
    }
    global void finish(Database.BatchableContext bc){
        System.debug(MapTour);
        List<String> dt1=(''+startDate).split(' ');
        List<String> dt2=(''+endDate).split(' ');
       // List<String> dt3=(''+startDate.addMonths(1)).split(' ');
       // List<String> fastforward=dt3[0].split('-');
        List<String> beforeMonth=dt1[0].split('-');
        List<String> presentMonth=dt2[0].split('-');
        
        
        List<Attendance_Expense__c> AE_lst=new LIst<Attendance_Expense__c>();
        for(String mapID:MapTour.keySet()){
            Attendance_Expense__c expense=new Attendance_Expense__c();
            expense.Date__c=System.today();
            expense.UserName__c=mapID;
             //expense.Employee_Number__c=MapTour.get(mapID)[0].Target__r.Target_User__r.EmployeeNumber;
             expense.External_Id__c=mapID+beforeMonth[1]+presentMonth[1]+endDate.year();          
            expense.Ex_Station__c=0;
            expense.HeadQuarter__c=0;
            expense.Headquarter_Metro__c=0;
            expense.Headquarter_State_Capital__c=0;
            expense.Outstation__c=0;
            for(AP_Tour_Plan__c z:MapTour.get(mapID)){
                if(z.Ex_Station_Actual__c>0){
                    expense.Ex_Station__c++;
                }
                if(z.Head_Quarter_Actual__c>0){
                    expense.HeadQuarter__c++;
                }
                if(z.Head_Quarter_Metro_Actual__c>0){
                    expense.Headquarter_Metro__c++;
                }
                if(z.Head_Quarter_State_Capital_Actual__c>0){
                    expense.Headquarter_State_Capital__c++;
                }
                if(z.Out_Station_Actual__c>0){
                    expense.Outstation__c++;
                }
            }
            AE_lst.add(expense);
        }
        if(AE_lst.size()>0){
            upsert AE_lst External_Id__c;
        }
        System.debug('Finish');
        
        try{
        /*PageReference page = new PageReference('/apex/ViewAttendanceReport');
        system.debug(page);
        page.setRedirect(true);*/
        
        AttendanceReport a = new AttendanceReport();
        system.debug(a);
        }
        catch(Exception ex){
            System.debug(ex);
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());
        }
    }
    
}