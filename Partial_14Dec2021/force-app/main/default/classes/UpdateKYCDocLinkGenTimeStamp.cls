/* 
* Name      : UpdateKYCDocLinkGenTimeStamp
* Purpose   : This class is used as an utility to Update KYC Doc Link Gen TimeStamp.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class UpdateKYCDocLinkGenTimeStamp {
    public class PlumberInput {
        @InvocableVariable(required=true)
        public String messagingSessionId;
        @InvocableVariable(required=true)
        public String plumberId;
    }
    @InvocableMethod(label='Update KYC Document')
    public static void getPlumberDetails(List<PlumberInput> plumberInputs){
        try{
            List<MessagingSession> messagingSession = new List<MessagingSession>();
            List<ContentDocumentLink> contDocLinkList = new List<ContentDocumentLink>();
            List<ContentDocumentLink> contDocLinkInsertList = new List<ContentDocumentLink>();
            List<ContentDocument> contDocList = new List<ContentDocument>();
            
            if(plumberInputs.size() > 0 && plumberInputs[0].messagingSessionId != null && plumberInputs[0].messagingSessionId != '')
                contDocLinkList = [SELECT Id, LinkedEntityId, ContentDocumentId, ShareType, Visibility FROM ContentDocumentLink WHERE LinkedEntityId =:plumberInputs[0].messagingSessionId];
            if(contDocLinkList.size() > 0){
                contDocList = [SELECT Id, Title, Description FROM ContentDocument WHERE Id =:contDocLinkList[0].ContentDocumentId AND Description = null ORDER BY CreatedDate DESC];
                if(contDocList.size() > 0){
                    contDocList[0].Description = 'KYC_Document_WhatsApp_BOT';
                    UPDATE contDocList; 
                }
                ContentDocumentLink conDocObj = new ContentDocumentLink(ContentDocumentId=contDocLinkList[0].ContentDocumentId,LinkedEntityId = plumberInputs[0].plumberId,SHARETYPE='V');
                contDocLinkInsertList.add(conDocObj);
                INSERT contDocLinkInsertList;
            }
        }
        catch(Exception e){
            System.debug(e.getStackTraceString());
        }
    }
}