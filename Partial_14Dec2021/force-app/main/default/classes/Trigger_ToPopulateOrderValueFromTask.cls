/*****************************************************************************************************************

Author: Balagopal G
Description: Trigger on Task to Populate the ordervalue field (add up all the order value from task)which comes under same owner in Target object field .
Created date:10-10-2016.
 *****************************************************************************************************************/


global class Trigger_ToPopulateOrderValueFromTask   {
    global static void PopulateOrderValue(List<Task>LstTask) {
     string tempName = 'Normal';
      string tempName2 = 'Enquiry__c';
        map<Id,Task> m=new map<Id,Task>();
                set<String> Ownernme=new set<String>();
     System.debug('LstTask'+LstTask);
RecordType recrd=[select id,RecordType.Name from recordtype where RecordType.Name=:tempName limit 1];
List<Task> tskrecord = new List<Task>();
tskrecord = [Select whatId,what.type From Task where what.type=:tempName2 limit 1];
    string str;
    if(!tskrecord.isEmpty())
    str=tskrecord[0].whatId;
        System.debug('str'+str);
        for(Task tsk1:LstTask){
         string str1= tsk1.whatId;
             System.debug('str1'+str1);
            if(recrd!=null && !LstTask.isEmpty() && str!=null && str1!=null )  {
    if(tsk1.RecordtypeId==recrd.id && str1.substring(0,4)==str.substring(0,4) && tsk1.Order_value__c!=null){
     Ownernme.add(tsk1.OwnerId);
    m.put(tsk1.OwnerId,tsk1);
    }
            }}
   // List<Task> tasklist =[Select Owner.name,Order_value__c,ActivityDate,What.type,RecordType.Name From Task where RecordType.Name=‘Normal’ AND Order_value__c!=null AND What.type=‘Enquiry__c’ limit 4000];
         System.debug('Set'+Ownernme);
    Integer month1,month2;
    List<Target__c> targetList= new List<Target__c>();
    targetList = [Select OwnerId,End_Date__c,Order_value_from_task__c From Target__c where OwnerId IN:Ownernme limit 4000];
    List<Target__c> newTargetUpdated =new List<Target__c>();
    for(Target__c targetlist2:targetList){
        try{
        if(m.containsKey(targetlist2.OwnerId)){
   if(m.get(targetlist2.OwnerId).ActivityDate!=null  && targetlist2.End_Date__c!=null){
           month1=targetlist2.End_Date__c.month();
        month2=m.get(targetlist2.OwnerId).ActivityDate.month();
        if(m.get(targetlist2.OwnerId)!=null  && m.get(targetlist2.OwnerId).Order_value__c!=null && month1==month2 ){
       targetlist2.Order_value_from_task__c=targetlist2.Order_value_from_task__c+m.get(targetlist2.OwnerId).Order_value__c;
    }
        }
    newTargetUpdated .add(targetlist2);
       }
        }
        catch(Exception e)
        {
            System.debug('The error is'+e.getMessage()+'At line number'+e.getLineNumber());
        }
        System.debug(' targetlist2'+targetlist2);
        }
    update newTargetUpdated ;
    system.debug(newTargetUpdated);
    }
    
}