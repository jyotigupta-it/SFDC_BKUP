public class InvoiceTriggerHelper {
    public static void validateattachment(Map<id,Invoice__c> invMap){
        System.debug('invMap'+invMap);
        List<ContentDocumentLink> attlist=new List<ContentDocumentLink>();
        Map<id,ContentDocumentLink> attmapToParent=new Map<id,ContentDocumentLink>();
        attlist=[Select id,ContentDocumentId,LinkedEntityId  from ContentDocumentLink where LinkedEntityId=:invMap.keySet()];
        if(!attlist.isEmpty()){
            for(ContentDocumentLink att:attlist){
                attmapToParent.put(att.LinkedEntityId,att);
            }
        }
        System.debug(attmapToParent);
        for(Invoice__c inv:invMap.values()){
            if(!attmapToParent.containsKey(inv.id)){
                inv.addError('Please Attach invoice attachment');
            } 
        }
    }
    public static void sendEmailToPaymnetteam(Map<id,Invoice__c> invMap){
        Map<id,ContentDocumentLink> attmap=new Map<id,ContentDocumentLink>();
        Map<id,id> attmapToParent=new Map<id,id>();
        Set<id> cdset=new set<id>();
        list<ContentVersion> cvlist=new list<ContentVersion>();
        Map<id,ContentVersion> cdmapTocv=new Map<id,ContentVersion>();
        List<Messaging.SingleEmailMessage> masterListMails = new List<Messaging.SingleEmailMessage>();
        attmap=new Map<id,ContentDocumentLink>([Select id,LinkedEntityId,ContentDocumentId from ContentDocumentLink where LinkedEntityId=:invMap.keySet()]);
        if(!attmap.isEmpty()){
            for(ContentDocumentLink att:attmap.values()){
                attmapToParent.put(att.LinkedEntityId,att.ContentDocumentId);
                cdset.add(att.ContentDocumentId);
            }
        }
        cvlist=[SELECT Id, Title, FileType, VersionData, isLatest, ContentDocumentId FROM ContentVersion WHERE isLatest = true AND ContentDocumentId IN :cdset];
        if(!cvlist.isEmpty()){
            for(ContentVersion cv:cvlist){
                cdmapTocv.put(cv.ContentDocumentId,cv);
            }
        }
        EmailTemplate emailTemplate = [Select Id,Name,Subject,Description,HtmlValue,DeveloperName,Body From EmailTemplate Where Name = 'Invoice Email Template'];
        
        for(Invoice__c inv:invMap.values()){
            Invoice__c inv1 = [Select Id, Account__r.Name,Name,Invoice_Date__c ,Invoice_Amount__c,OwnerId from Invoice__c where Id =: inv.Id];
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); 
            email.setTargetObjectId(inv1.OwnerId); 
            email.setSenderDisplayName(inv1.Account__r.Name);
            // Set list of peoples who should recieve an email
            List<String> sendTo = new List<String>();
            sendTo.add(Label.Payment_team_Email_Id);
            email.setToAddresses(sendTo);
            String subject = emailTemplate.Subject;
            subject = subject.replace('{!Invoice__c.Account__r.Name}', inv1.Account__r.Name);
            subject = subject.replace('{!Invoice__c.Invoice_Date__c}', String.valueOf(inv1.Invoice_Date__c));
            System.debug('subject: '+subject);
            email.setSubject(subject); 
            String htmlBody = emailTemplate.HtmlValue;
            htmlBody = htmlBody.replace('{!Invoice__c.Name}', inv1.Account__r.Name);
            htmlBody = htmlBody.replace('{!Invoice__c.Invoice_Date__c}', String.valueOf(inv1.Invoice_Date__c));
            htmlBody = htmlBody.replace('{!Invoice__c.Account__r.Name}', inv1.Account__r.Name);
            htmlBody = htmlBody.replace('{!Invoice__c.Invoice_Amount__c}', String.valueOf(inv1.Invoice_Amount__c));
            email.setHtmlBody(htmlBody);
            email.setSaveAsActivity(false);
            email.setWhatId(inv1.Id);
            
            //Attach attachment
            List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setFileName(cdmapTocv.get(attmapToParent.get(inv.id)).Title);
            efa.setBody(cdmapTocv.get(attmapToParent.get(inv.id)).VersionData);
            attachments.add(efa);
            email.setFileAttachments(attachments);
            // Add your email address into the master list
            masterListMails.add(email);
        }
        if(!masterListMails.isEmpty()){
            // Sends mass emails
            System.debug('masterListMails******'+masterListMails);
            Messaging.sendEmail(masterListMails);
        }
    }
    
}