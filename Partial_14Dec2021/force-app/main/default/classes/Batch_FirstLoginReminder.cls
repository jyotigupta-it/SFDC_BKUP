global class Batch_FirstLoginReminder implements Database.Batchable <SObject>,Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id,Target__c,OwnerId,Beat__r.Name,Beat_Frequency__c,Date__c,Name,Target__r.Name,Login_Time__c,Logout_Time__c FROM AP_Tour_Plan__c WHERE Date__c = TODAY AND Login_Time__c = null';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<AP_Tour_Plan__c> tourPlanList){
        String header = 'Target Number, Tour Plan Name, Date, Beat Master Name, Beat Frequency\n';
        list<Messaging.SingleEmailMessage> mailList= new list<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        List<String> toAddressses = new List<String>();
        Set<String> recipientsIds = new Set<String>();
        String targetId = '';
        List<User> ownerList = new List<User>();
        CustomNotificationType notificationType = [SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName='Login_Notification_First'];
        Set<Id> ownerIdSet = new Set<Id>();
        Map<Id,String> ownerManagerMap = new Map<Id,String>();
        for(AP_Tour_Plan__c tourPlanObj : tourPlanList){
        	ownerIdSet.add(tourPlanObj.OwnerId);
        }
        ownerList = [SELECT Id,Manager.Email FROM User WHERE Id IN: ownerIdSet];
        for(User ownerUserObj : ownerList){
            ownerManagerMap.put(ownerUserObj.Id,ownerUserObj.Manager.Email);
        }
        for(AP_Tour_Plan__c tourPlanObj : tourPlanList){
            try{
                toAddressses.add(tourPlanObj.OwnerId);
                if(ownerManagerMap.get(tourPlanObj.OwnerId) != null)
                    toAddressses.add(ownerManagerMap.get(tourPlanObj.OwnerId));
                recipientsIds.add(tourPlanObj.OwnerId);
                mail.setSubject('Tour Plan daily login status.');
                mail.setHtmlBody('<html><body>Dear,<br><br>Request you to please login and proceed for visit activities.<br>Details are as below:<br>'+
                                 +'Target: '+tourPlanObj.Target__r.Name+'<br>'+
                                 +'Tor Plan Name: '+tourPlanObj.Name+'<br>'+
                                 +'Date: '+tourPlanObj.Date__c+'<br>'+
                                 +'Beat Master Name: '+tourPlanObj.Beat__r.Name+'<br>'+
                                 +'Beat Frequency: '+tourPlanObj.Beat_Frequency__c+'<br><br>'+
                                 +'Regards,<br>SFDC Support<br></html></body>');
                mail.setToAddresses(toAddressses);
                mail.setSenderDisplayName('SFDC Support');
                mailList.add(mail);
                
                if(!mailList.isEmpty()){
                    Messaging.SendEmail(mailList);
                }
                //Push notification
                targetId = tourPlanObj.Target__c;
                Messaging.CustomNotification notification = new Messaging.CustomNotification();
                notification.setTitle('Login Request Notification');
                notification.setBody('Request you to please login and proceed for visit activities for today!');
                notification.setNotificationTypeId(notificationType.Id);
                notification.setTargetId(targetId);
                notification.send(recipientsIds);
            }
            catch(Exception e){
                System.debug(e.getStackTraceString());
            }
        }
    }
    global void finish(Database.BatchableContext bc){}
}