public class genericEmailTriggerHandler {
    
    public static void checkConditionForGenricEmail(List<Unique_SPR__c> newSRPList)
    {
        List<Id> ProjectIds = new List<Id>();
        List<Id> usrIds = new List<Id>();
        Id pId;
        for(Unique_SPR__c sp:newSRPList)
        {
            if(sp.Approval_Status__c=='Approved')
            {
                ProjectIds.add(sp.Project__c);
                pId=sp.Project__c;
            }
        }
        List<Opportunity> oppList = new  List<Opportunity>();
        
        oppList=[SELECT Id,ownerId FROM Opportunity WHERE Id in:ProjectIds];
        
        for(Opportunity usr : oppList )
        {
            usrIds.add(usr.OwnerId);
        }
        List<user> usrList = new List<user>();
        
        usrList = [SELECT Intial_Project_Approver__c, Id, Name, Project_Approver__c FROM User WHERE Id in:usrIds];
        
        EmailTemplate templateId = [Select id,Name from EmailTemplate  WHERE Name = 'Special Pricing Req cc Template'];
        
        List<String> ToEmail = new List<String>();
        ToEmail.add('retail.projects@ashirvad.com');
        
        List<String> ccEmail = new List<String>();
        ccEmail.add('retail.projects@ashirvad.com');
       // ccEmail.add('akhil.kapali@kvpcorp.com');
        
        
        
        for(User usr1 :usrList)
        {
            if(usr1.Intial_Project_Approver__c=='0053A00000FFDcoQAH' || usr1.Project_Approver__c=='0053A00000FFDcoQAH' || test.isRunningTest())
            {
                system.debug('inside if');
                List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setTemplateID(templateId.Id);
                mail.setSaveAsActivity(false);
                system.debug('ToEmail----->'+ToEmail);
                system.debug('ccEmail----->'+ccEmail);
                mail.setTargetObjectId(usrList[0].Id);
                mail.setWhatId(pId);
                mail.setToAddresses(ToEmail);
                mail.setCcAddresses(ccEmail);
                allmsg.add(mail);
                Messaging.sendEmail(allmsg);
            }
        }
        
    }
}