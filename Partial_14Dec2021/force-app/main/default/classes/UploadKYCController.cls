/* 
* Name      : UploadKYCController
* Purpose   : This class is used as controller for UploadKYC page and component.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public without sharing class UploadKYCController {
    @AuraEnabled
    public static KycWrap checkActiveSession(String messagingSessionID,String endUserId){
        System.debug(messagingSessionID);
        System.debug(endUserId);
        String phNumber = '';
        Integer expiryLimit = Integer.valueOf(System.Label.KYC_Upload_Link_Expiry_Time);
        List<Account> accList = new List<Account>();
    	List<MessagingSession> messagingSessionList = new List<MessagingSession>();
        messagingSessionList = [SELECT id,Status,MessagingEndUser.Name,KYC_Doc_Upload_Link_Generation_Time__c FROM MessagingSession WHERE Id =:messagingSessionID AND Status != 'Ended'];
        if(messagingSessionList.size() > 0){
            phNumber = messagingSessionList[0].MessagingEndUser.Name.right(10);
            System.debug(phNumber);
            accList = [SELECT Id,Name FROM Account WHERE Party_Type__c = 'Plumber' AND Contact_Number_Mobile__c =:phNumber];
            
            Datetime start = messagingSessionList[0].KYC_Doc_Upload_Link_Generation_Time__c;
            Datetime later = System.now();
            Decimal millisecs = Decimal.valueOf(later.getTime() - start.getTime());
            Decimal dDays = millisecs/1000/60/60/24;
            Integer iDays = Integer.valueOF(math.floor(dDays));
            Decimal remainderDays = dDays- iDays;
            
            Decimal dHours = remainderDays * 24;
            Integer iHours = Integer.valueOf(math.floor(dHours));
            Decimal remainderHours = dHours - iHours;
            
            Decimal dMinutes = remainderHours * 60;
            Integer iMinutes = Integer.valueOf(math.floor(dMinutes));
            
            Integer iSeconds = Integer.valueOf(math.floor((dMinutes - iMinutes) * 60));
            system.debug('Days: ' + iDays+' - '+'Hours: ' + iHours+' - '+'Minutes: ' + iMinutes+' - '+'Seconds: ' + iSeconds);
            
            if(iDays >0 || iHours >0 || iMinutes > expiryLimit)
                RETURN new KycWrap(false,'','',null,null);
            else
                RETURN new KycWrap(true,accList[0].Id,accList[0].Name,expiryLimit-iMinutes,iSeconds);
        }
        else
            RETURN new KycWrap(false,'','',null,null);
    }
    
    @AuraEnabled
    public static void updateFileUploadStatus(String messagingSessionID,String endUserId){
    	List<MessagingSession> messagingSessionList = new List<MessagingSession>();
        messagingSessionList = [SELECT id,Status,MessagingEndUser.Name,KYC_Doc_Upload_Time__c FROM MessagingSession WHERE Id =:messagingSessionID AND Status != 'Ended'];
        if(messagingSessionList.size() > 0){
            messagingSessionList[0].KYC_Doc_Upload_Time__c = System.now();
            UPDATE messagingSessionList;
        }
    }
    @AuraEnabled
    public static Id saveChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) {
        if(fileId == '')
            fileId = saveTheFile(parentId, fileName, base64Data, contentType);
        else
            appendToFile(fileId, base64Data);
        RETURN Id.valueOf(fileId);
    }
    
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment att = new Attachment();
        att.parentId = parentId;
        
        att.Body = EncodingUtil.base64Decode(base64Data);
        att.Name = fileName;
        att.ContentType = contentType;
        att.Description = 'KYC_Document_WhatsApp_BOT';
        INSERT att;
        RETURN att.Id;
    }
    
    private static void appendToFile(Id fileId, String base64Data) {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment att = [
            SELECT Id, Body
            FROM Attachment
            WHERE Id =: fileId
        ];
        String existingBody = EncodingUtil.base64Encode(att.Body);
        att.Body = EncodingUtil.base64Decode(existingBody + base64Data);
        UPDATE att;
    }
    public class KycWrap{
        @AuraEnabled
        public Boolean status;
        @AuraEnabled
        public String accId;
        @AuraEnabled
        public String userName;
        @AuraEnabled
        public Integer endMin;
        @AuraEnabled
        public Integer endSec;
        public KycWrap(Boolean status,String accId,String userName,Integer endMin,Integer endSec){
            this.status = status;
            this.accId = accId;
            this.userName = userName;
            this.endMin = endMin;
            this.endSec = endSec;
        }
    }
}