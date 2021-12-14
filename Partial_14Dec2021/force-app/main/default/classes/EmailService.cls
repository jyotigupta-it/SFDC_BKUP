public class EmailService {
    public string subject;
    public List<String> toAddresses;
    public List<String> CCAddresses;
    public String body;
    public string displayName; 
    public boolean isAttachment;
    public Map<String,String> attachFiles;
    public boolean isHtml;
    public List<Messaging.EmailFileAttachment> attachments; 
    public Messaging.SingleEmailMessage email;
    
    public EmailService(){
        attachments = new List<Messaging.EmailFileAttachment>();
        email =new Messaging.SingleEmailMessage();
        this.isAttachment=false;  
        this.isHtml=false;
    }
    public EmailService(Messaging.SingleEmailMessage mailMessage){
        attachments = new List<Messaging.EmailFileAttachment>();
        email =mailMessage;
        this.isAttachment=false;  
    }
    public void sendMail(){
        if(isAttachment){
            for(String name : attachFiles.keySet()){                
                Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
                blob csvBlob = Blob.valueOf(attachFiles.get(name));
                string csvname=name+'.csv';
                csvAttc.setContentType('text/csv');
                csvAttc.setFileName(csvname);
                csvAttc.setBody(csvBlob);
                attachments.add(csvAttc);
            } 
        }
        email.setSubject(subject);
        email.setToAddresses(toAddresses);
        email.setSenderDisplayName(displayName);
        if(isHtml){
            email.setHtmlBody(body);
        }
        else{
            email.setPlainTextBody(body);
        }
        if(isAttachment){
            email.setFileAttachments(attachments);  
        }
        Messaging.SendEmailResult [] emailSentResults = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email}); 
        system.debug('Email sent');
    }
}