/*
**Please run this batch always with frequency as 1.
*/
global class Batch_AutoTourPlanCreation implements Database.Batchable <SObject>,Database.Stateful {
    public Boolean beatFreqChangeFlag;
    public Set<Id> whereCondition = new Set<Id>();
    public String batchMonthStr = '';
    public Map<Date,AP_Tour_Plan__c> dateTourPlanMap = new Map<Date,AP_Tour_Plan__c>();
    //Constructor to get dynamic query parameters
    public Batch_AutoTourPlanCreation(Set<Id> targetIdSet,String monthStr){
        whereCondition = targetIdSet;
        batchMonthStr = monthStr;
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        DateTime dt = Datetime.now().AddMonths(1);
        String nextMonth = dt.format('MMMM');
        String year = String.valueOf(dt.Year());
        beatFreqChangeFlag = false;
        String query = '';
        if(whereCondition == null)
            query = 'SELECT Id,Name,Start_Date__c,End_Date__c,OwnerId,Approval_Status__c FROM Target__c WHERE Approval_Status__c IN (\'Not Submitted\',\'Pending\') AND Month__c = \''+nextMonth+' - '+year+'\'';
        else
            query = 'SELECT Id,Name,Start_Date__c,End_Date__c,OwnerId,Approval_Status__c FROM Target__c WHERE ID IN:whereCondition';
        if(batchMonthStr != '')
            query += ' AND State__c=\''+batchMonthStr+'\'';
        System.debug(query);
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<Target__c> targetList) {
        if(targetList[0].Approval_Status__c != null && (targetList[0].Approval_Status__c == 'Pending' || targetList[0].Approval_Status__c == 'Not Submitted')){
            List<AP_Tour_Plan__c> tourPlanList = new List<AP_Tour_Plan__c>(); 
            List<Beat_Master__c> beatMasterLst = new List<Beat_Master__c>();
            dateTourPlanMap = new Map<Date,AP_Tour_Plan__c>();
            Map<String,Integer> dayMap = new Map<String,Integer>();
            Map<Integer,Integer> dayWeekMap = new Map<Integer,Integer>();
            List<String> beatFreqList;
            Integer dayinMonth = Date.daysInMonth(targetList[0].Start_Date__c.year(),targetList[0].Start_Date__c.month());
            beatMasterLst = [SELECT Id,Beat_Frequency__c FROM Beat_Master__c WHERE Beat_Frequency__c != null AND OwnerId = :targetList[0].OwnerId];
            for(Integer i = 1; i <= 7; i++){
                Date tempDate = Date.newInstance(targetList[0].Start_Date__c.year(),targetList[0].Start_Date__c.month(),i);
                Datetime tempDateTime = (DateTime)tempDate;
                dayMap.put(tempDateTime.format('EEEE'),i);
                dayWeekMap.put(i,getWeekOfMonth(tempDate));
            }
            for(Beat_Master__c beatMasterObj : beatMasterLst){
                beatFreqList = new List<String>();
                beatFreqList.addAll(beatMasterObj.Beat_Frequency__c.split(';'));
                for(String beatFreqObj : beatFreqList){
                    tourPlanList.add(getTourPlan(targetList[0],beatMasterObj,beatFreqObj,dayMap));
                }
            }
            //planning for 5th week
            for(Integer dayNumber: dayWeekMap.keySet()){
                if(dayWeekMap.get(dayNumber) == 1 && dayNumber + 28 <= dayinMonth){
                    if(dateTourPlanMap.get(Date.newInstance(targetList[0].Start_Date__c.year(),targetList[0].Start_Date__c.month(),dayNumber+14)) != null){
                        AP_Tour_Plan__c tourPlanObj = dateTourPlanMap.get(Date.newInstance(targetList[0].Start_Date__c.year(),targetList[0].Start_Date__c.month(),dayNumber+14)).clone();
                        tourPlanObj.Date__c = tourPlanObj.Date__c.addDays(14);
                        Datetime tempDateTime = (DateTime)tourPlanObj.Date__c;
                        tourPlanObj.Beat_Frequency__c = tempDateTime.format('EEEE') +' Week5';
                        tourPlanList.add(tourPlanObj);
                    }
                }
            }
            if(tourPlanList.size() > 0){
                INSERT tourPlanList;
                if(!beatFreqChangeFlag){
                    if(targetList[0].Approval_Status__c != 'Pending'){
                        targetList[0].Approval_Status__c = 'Pending';
                        UPDATE targetList[0];   
                    }
                    approvalSubmission(targetList[0].Id);
                }
            }
        }
    }
    global void finish(Database.BatchableContext bc){}
    //Prepare tor plan object for insertion
    public AP_Tour_Plan__c getTourPlan(Target__c targetObj,Beat_Master__c beatMasterObj,String beatFreqObj,Map<String,Integer> dayMap){
        AP_Tour_Plan__c tourPlanObj =  new AP_Tour_Plan__c();                                 
        tourPlanObj.Target__c = targetObj.Id;
        tourPlanObj.OwnerId = targetObj.OwnerId;
        tourPlanObj.Beat__c = beatMasterObj.Id;
        tourPlanObj.Beat_Frequency__c = beatFreqObj;
        tourPlanObj.Date__c = getBeatDate(beatFreqObj,targetObj.Start_Date__c,dayMap);
        dateTourPlanMap.put(tourPlanObj.Date__c,tourPlanObj);
        RETURN tourPlanObj;
    }
    public Date getBeatDate(String beatFreqObj,Date startDate,Map<String,Integer> dayMap){
        String freqDay = beatFreqObj.split(' ')[0];
        Date beatDate_1 = Date.newInstance(startDate.year(),startDate.month(),dayMap.get(freqDay));
        Date beatDate_2 = beatDate_1.addDays(7*(Integer.valueOf(beatFreqObj.substring(beatFreqObj.length()-1))-1));
        RETURN beatDate_2;
    }
    //SUbmission for approval
    public void approvalSubmission(Id targetId) {
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setComments('Please approve my Tour Plan.');
        req1.setObjectId(targetId);
        try {
            Approval.ProcessResult result = Approval.process(req1);
        }catch(Exception e) {
            system.debug(e.getMessage());
        }
    }
    //get week count from date
    public Integer getWeekOfMonth( Date todaysDate){
        Date currentDate = todaysDate;
        Integer weekCount = 0;
        Integer startWeekResidue = 0;
        Integer endWeekResidue = 0;
        Date dt = currentDate.toStartOfMonth().addDays(-1);
        Date dtFirstWeekend = dt.toStartOfWeek().addDays(6);
        startWeekResidue = dt.daysBetween(dtFirstWeekend);
        Date dtLastWeekend = currentDate.toStartOfWeek().addDays(-1);
        endWeekResidue = dtLastWeekend.daysBetween(currentDate);
        weekCount = (currentDate.day() - (startWeekResidue + endWeekResidue))/7;
        weekCount += (startWeekResidue > 0 ? 1:0)+(endWeekResidue > 0 ? 1:0);
        RETURN weekCount;
    }
}