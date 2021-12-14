/***************************************************
 * Name:SudhaMurthy
 * Description: Batch class to send email to user if less than 40 viists a week
 * Trigger:AdoptedPlumberAndDealer 
 * Test class:Test_RollupInfluencerVisitsColumn
 * created date :12/08/2019***********************/
 global class NoOfProjectVisitRollUp_Batch implements Database.Batchable<sObject>{
 
 list<AP_Site_Visit__c> visitlist1= [select id,name,AP_Tour_Plan__r.ownerId,Target__R.No_of_Visits_Actual_Project__c,Target__R.id,Target__R.ownerId from AP_Site_Visit__c  where Action_Date__c=THIS_WEEK];
  string visitlist= 'select id,name,Target__R.No_of_Visits_Actual_Project__c,AP_Tour_Plan__r.ownerId,Target__R.id,Target__R.ownerId from AP_Site_Visit__c where createddate=THIS_WEEK';
  
 
  //start method
  global  database.QueryLocator start(Database.BatchableContext BC)
    {
     
     return Database.getQueryLocator(visitlist);
    } 
     global void execute(Database.BatchableContext BC, List<AP_Site_Visit__c> scope)
    {
     Map<id, list<AP_Site_Visit__c>> visitmap= new Map<id, list<AP_Site_Visit__c>>();
         system.debug('list..'+scope);
         system.debug('list..'+scope.size());
      for(AP_Site_Visit__c visit : scope){
       system.debug('visit '+visit.AP_Tour_Plan__r.ownerId);
          system.debug('visit *** '+visit.Target__R.No_of_Visits_Actual_Project__c);
      if(visit.Target__R.No_of_Visits_Actual_Project__c<40 ){ 
          system.debug('visit 22*** '+visit.Target__R.No_of_Visits_Actual_Project__c);
           if(!visitmap.isEmpty() && visitmap.containsKey(visit.AP_Tour_Plan__r.ownerId) && visitmap.get(visit.AP_Tour_Plan__r.ownerId) != null) {
              
                 visitmap.get(visit.AP_Tour_Plan__r.ownerId).add(visit);
                //  visitmap.put(visit.AP_Tour_Plan__r.ownerId, visitmap.get(visit.AP_Tour_Plan__r.ownerId).add(visit));
                  system.debug('visitmap1'+visitmap);
               
                   system.debug('test owner'+visitmap.get(visit.AP_Tour_Plan__r.ownerId));
               } else {
                   visitmap.put(visit.AP_Tour_Plan__r.ownerId, new List<AP_Site_Visit__c>{visit});
                system.debug('test..'+visitmap.size());
               }
            }
       }
        list<user> userlist=[select id,name,email from user where id IN:visitmap.keyset()];
       List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
       system.debug('map...'+visitmap.keyset());
             system.debug('userlist which has less visit'+userlist);
                
          if(!userlist.IsEmpty() && userlist.size()>0){     
               for(User val : userlist){
            
                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                 Messaging.reserveSingleEmailCapacity(1);
                 mail.setToAddresses(new String[] { val.Email });
                 mail.setReplyTo(val.Email);
                 mail.setSubject('Warning:Less visits this week');
                 mail.setPlainTextBody('Hi ,\r\n\r\nTotal no of visits in this week is less than 40.Please ensure to make atleast 8 visits per day.Otherwise this may affect your attendance..\r\n\r\n\r\n[Note:Kindly do not reply to this email.The emails to this account are not monitored]');                  
                  allMails.add(mail);
                 
                 system.debug('####'+val.id);
                 
            }
         } 
          Messaging.sendEmail(allMails );  
       
    }
    global void finish(Database.BatchableContext BC)
    {
       
    } 
 }