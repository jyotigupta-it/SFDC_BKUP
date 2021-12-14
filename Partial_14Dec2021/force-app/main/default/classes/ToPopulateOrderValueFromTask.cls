global class ToPopulateOrderValueFromTask  implements Database.Batchable<sObject> {
      
    string tempName = 'Normal';
      string tempName2 = 'Enquiry__c';
    String query='Select OwnerId,Order_value__c,ActivityDate,What.type,RecordType.Name From Task where Recordtype.Name=:tempName AND Order_value__c!=null AND What.type=:tempName2 limit 40000';
    global Database.QueryLocator start(Database.BatchableContext BC) {
    
         
         
    return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC,List<Task> tasklist) {
        map<Id,Task> m=new map<Id,Task>();
                set<String> Ownernme=new set<String>();
    
   // List<Task> tasklist =[Select Owner.name,Order_value__c,ActivityDate,What.type,RecordType.Name From Task where RecordType.Name='Normal' AND Order_value__c!=null AND What.type='Enquiry__c' limit 4000];
    for(Task tsk:tasklist){
    Ownernme.add(tsk.OwnerId);
    m.put(tsk.OwnerId,tsk);
    }
         System.debug('Set'+Ownernme);
    Integer month1,month2;
    List<Target__c> targetList=[Select OwnerId,End_Date__c,Order_value_from_task__c From Target__c where OwnerId IN:Ownernme limit 4000];
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
    
    global void finish(Database.BatchableContext BC) {
    }
    
    }