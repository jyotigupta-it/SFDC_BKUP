/************

Deactivated by Extentor  on 20/04/2015

Reason: This is no more a requirement

************/

trigger TaskSendEmailpromotion on Promotion__c (before update) {
    
   /* Set<Id> ownerIds = new Set<Id>();
    Set<Id> Managerid=new Set<Id>();
  List<User> lstU2 = [select id,email,TL__c,ManagersId__c from User];
    try
    {
  List<Promotion__c> t2=[select id,Verification_Status1__c,Verified__c from Promotion__c where Verification_Status1__c=:'Complaint' LIMIt 1];
    for(User u1:lstU2)
    {
    for(Promotion__c pr:Trigger.New)
    {
        ownerIds.add(pr.ownerId);
       Managerid.add(u1.ManagersId__c);
   }
   
   } 
    Map<Id, User> userMap = new Map<Id,User>([select Name, Email,ManagersId__c from User where Id in :ownerIds]);
   
    for(Promotion__c tsk : Trigger.New)
    {
    if(tsk.Verification_Status1__c=='Complaint' && tsk.Verified__c==true)
    {
        
       
           Promotion__c eq=[select id from Promotion__c where id=:tsk.id];
           system.debug('Enquiry'+eq);
           
           Task Tk = new Task();
           Tk.OwnerId = userMap.get(tsk.ownerId).ManagersId__c;
         // Tk.WhoId = tsk.owner.ManagersId__c;
           Tk.WhatId=eq.id;
           Tk.ActivityDate=system.today();
        
           Tk.Priority='Normal';
           Tk.Subject='Promotion Complaint';
           insert Tk;
           
           
           }
           }
          }Catch(Exception e)
          {}      */                          
           }