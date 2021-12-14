global class Quiz_Second_Email_Controller implements Database.Batchable<sObject>{
 
    List<String> qu=new List<String> {'Agriculture Junior' , 'Agriculture Senior', 'Plumbing Junior', 'Plumbing Senior'};
    global String query ='select ID, email, firstname, lastname ,Quiz_Catagory__c  from user where Quiz_Catagory__c IN:qu';
    
    global  database.QueryLocator start(Database.BatchableContext BC)
    {
        // Initiate the Batch context
       return Database.getQueryLocator(query);
       //return null;      
    }
    global void execute(Database.BatchableContext BC, List<sObject> scope)
    {
       execbatch((list<user>) scope);
    }
    
    public void execbatch(list<user> userList)
    { 
     autoRequestBatchHelper autoRequest = new autoRequestBatchHelper();
                
     String thisMonth = autoRequest.getCurrentMonth();
      List<Messaging.SingleEmailMessage> allMails = new List<Messaging.SingleEmailMessage>();
        List<Quiz_Attendee__c> atendees = [select Quiz_Attendee__c from Quiz_Attendee__c where Quiz_Month__c =: thisMonth and Quiz_status__c = 'Completed'];
        Set<User> userSet = new Set<user>();
       for(User users : userList){
        boolean flag = false;
        
         for(Quiz_Attendee__c att : atendees){
        if(att.Quiz_Attendee__c == users.id){
        flag = true;
        break;
        }
        
        }
        if(!flag){
        userSet.add(users);
        }
        
        }
        
        
        for(User val : userSet)
        { 
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             Messaging.reserveSingleEmailCapacity(1);
             mail.setToAddresses(new String[] { val.Email });
             mail.setReplyTo(val.Email);
             mail.setSubject('Reminder to finish the Monthly Quiz by 6:00 PM today');
             mail.setPlainTextBody('Hi,\r\n\r\nThe Quiz window is open now and will close at 6:00 PM today. Please take the quiz before 6 PM today, else you will not be able to take the Quiz for this month.\r\n\r\n\r\n[Note:Kindly do not reply to this email.The emails to this account are not monitored]');                  
              allMails.add(mail);
             
             system.debug('####'+val.id);
             
        }
          Messaging.sendEmail(allMails );

    }       
    global void finish(Database.BatchableContext BC)
    {
       
    }     
    
}