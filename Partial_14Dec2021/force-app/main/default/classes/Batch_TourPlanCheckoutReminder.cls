/*To be scheduled in evening for checkot reminder for tour plans*/
global class Batch_TourPlanCheckoutReminder implements Database.Batchable <SObject>,Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id,Target__c,OwnerId,Beat__r.Name,Beat_Frequency__c,Date__c,Name,Target__r.Name,Login_Time__c,Logout_Time__c FROM AP_Tour_Plan__c WHERE Date__c = TODAY AND Logout_Time__c = null';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<AP_Tour_Plan__c> tourPlanList){
        list<Messaging.SingleEmailMessage> mailList= new list<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
        List<String> toAddressses = new List<String>();
        Set<Id> ownerIdSet = new Set<Id>();
        List<User> ownerList = new List<User>();
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
                mail.setSubject('Tour Plan daily logout status.');
                mail.setHtmlBody('<html><body>Dear,<br><br>Request you to please logout for the tour plan details provided below:<br><br>'+
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
            }
            catch(Exception e){
                System.debug(e.getStackTraceString());
            }
        }
    }
    global void finish(Database.BatchableContext bc){}
}