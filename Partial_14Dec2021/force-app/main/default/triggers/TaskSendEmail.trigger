trigger TaskSendEmail on Task (before update) {
    
    Set<Id> ownerIds = new Set<Id>();
    Set<Id> Managerid=new Set<Id>();
  List<User> lstU2 = [select id,email,TL__c,ManagersId__c from User];
  List<Task> t2=[select id,Verification_Status__c,WhatId from Task where Verification_Status__c=:'Task Not Completed' LIMIt 1];
    for(User u1:lstU2)
    {
    for(Task tsk: Trigger.New)
    {
        ownerIds.add(tsk.ownerId);
       Managerid.add(u1.ManagersId__c);
   }
   
   } 
    Map<Id, User> userMap = new Map<Id,User>([select Name, Email,ManagersId__c from User where Id in :ownerIds]);
   
    for(Task tsk : Trigger.New)
    {
    if(tsk.Verification_Status__c=='Task Not Completed')
    {
        User theUser = userMap.get(tsk.ownerId);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {theUser.Email};
        mail.setToAddresses(toAddresses);    
        mail.setSubject('A assigned Task is not completed ' );    
        
        String template = 'Hello {0}, \nYour task has not been completed. Here are the details - \n\n';
        template+= 'Subject - {1}\n';
        template+= 'Due Date - {2}\n';
        template+= 'Priority -{3} \n';
        template+= 'Comments -{4} \n';
        String duedate = '';
        if (tsk.ActivityDate==null)
            duedate = '';
        else
            duedate = tsk.ActivityDate.format();
        List<String> args = new List<String>();
        args.add(theUser.Name);
        args.add(tsk.Subject);
        args.add(duedate);
       args.add(tsk.Priority);
        args.add(tsk.Description);
       
        
        String formattedHtml = String.format(template, args);
       
        mail.setPlainTextBody(formattedHtml);
        Messaging.SendEmail(new Messaging.SingleEmailMessage[] {mail});
       
           Enquiry__c eq=[select id from Enquiry__c where id=:tsk.WhatId];
           system.debug('Enquiry'+eq);
           
           Task Tk = new Task();
           Tk.OwnerId = userMap.get(tsk.ownerId).ManagersId__c;
          
           Tk.WhatId=eq.id;
           Tk.ActivityDate=system.today();
           Tk.Verification_Status__c='Task Not Completed';
           Tk.Priority='Normal';
           Tk.Subject='Escalation';
           insert Tk;
           
           
           }
           }
           }