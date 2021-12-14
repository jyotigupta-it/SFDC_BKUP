/* 
* Name      : FetchPlumberDetails
* Purpose   : This class is used as an utility to fetch Plumber Details.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class FetchPlumberDetails{
    public class PlumberInput {
        @InvocableVariable(required=true)
        public String endUserId;
    }
    public class PlumberOutput {
        @InvocableVariable(required=true)
        public String plumberName;
        @InvocableVariable(required=true)
        public String plumberId;
        @InvocableVariable(required=true)
        public String dpRpTGMId;
        @InvocableVariable(required=true)
        public Boolean clubMember;
        @InvocableVariable(required=true)
        public Boolean kycUploaded;
        @InvocableVariable(required=true)
        public Boolean partyMatchFlag;
        @InvocableVariable(required=true)
        public Boolean dpRpTgmFlag;
        
    }
    @InvocableMethod(label='Get Plumber Details')
    public static List<PlumberOutput> getPlumberDetails(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Account> accList = new List<Account>();
        List<User> userList = new List<User>();
        account accUpdateObj = null;
        List<MessagingEndUser> messagingUserList = new List<MessagingEndUser>();
        PlumberOutput pOutput = new PlumberOutput();
        pOutput.plumberId = '';
        pOutput.dpRpTGMId = '';
        pOutput.clubMember = false;
        pOutput.partyMatchFlag = false;
        String phNumber = '';
        pOutput.dpRpTgmFlag = false;
        
        if(plumberInputs.size() > 0){
            messagingUserList = [SELECT Id,Name FROM MessagingEndUser WHERE Id =:plumberInputs[0].endUserId];
            phNumber = messagingUserList[0].Name.right(10);
        }
        else
            pOutput.plumberName = 'Plumber Not Found';
        if(phNumber != null && phNumber != ''){
            accList = [SELECT Id,Name,recordType.DeveloperName,Party_Type__c,Plumber_Club_Member_Category__c,(SELECT Id FROM Attachments WHERE Description = 'KYC_Document_WhatsApp_BOT'),(SELECT Id,ContentDocument.Description FROM ContentDocumentLinks WHERE ContentDocument.Description = 'KYC_Document_WhatsApp_BOT') FROM Account WHERE Contact_Number_Mobile__c =:phNumber];
            if(accList.size() > 0){
                List<String> prtyTypeList = new List<String>{'Plumber','Mechanic','Plumber Cum Mechanic','Plumbing Contractor','Plumber club member'};
                    for(Account accObj : accList){
                        if(accObj.recordType.DeveloperName == 'Plumber_Club_Enrolment'){
                            pOutput.kycUploaded = false;
                            pOutput.plumberName = accObj.Name;
                            pOutput.plumberId = accObj.Id;
                            pOutput.clubMember = true;
                            if(accObj.Attachments.size() > 0 || accObj.ContentDocumentLinks.size() > 0)
                                pOutput.kycUploaded = true;
                            break;
                        }
                        else if(accObj.recordType.DeveloperName == 'Individual_Contacts' && prtyTypeList.contains(accObj.Party_Type__c)){
                            pOutput.kycUploaded = false;
                            accUpdateObj = new Account();
                            pOutput.plumberName = accObj.Name;
                            pOutput.plumberId = accObj.Id;
                            if(accObj.Attachments.size() > 0 || accObj.ContentDocumentLinks.size() > 0)
                                pOutput.kycUploaded = true;
                            accUpdateObj = accObj;
                            accUpdateObj.Plumber_Club_Member_Category__c = 'Purple';
                        }
                        else if(accObj.recordType.DeveloperName == 'Dealer' || accObj.recordType.DeveloperName == 'Distributor' ){
                            pOutput.kycUploaded = false;
                            pOutput.plumberName = accObj.Name;
                            pOutput.dpRpTGMId = accObj.Id;
                            pOutput.dpRpTgmFlag = true;
                        }
                    }
                if(pOutput.plumberId == ''){
                    pOutput.partyMatchFlag = true;
                    userList = [SELECT Id, name, IsActive, Phone, ProfileId, profile.name from User WHERE Phone =: phNumber AND  profile.name = 'BD' LIMIT 1]; 
                    if(userList.size() > 0){
                        pOutput.kycUploaded = false;
                        pOutput.plumberName = userList[0].Name;
                        pOutput.dpRpTGMId = userList[0].Id;
                        pOutput.dpRpTgmFlag = true;
                    }
                }
            }
            else{
                pOutput.partyMatchFlag = true;
                pOutput.plumberName = 'Plumber Not Found';
            }
            
        }
        else{
            pOutput.partyMatchFlag = true;
            pOutput.plumberName = 'Plumber Not Found';
        }
        plumberOutputList.add(pOutput);
        if(accUpdateObj != null && pOutput.clubMember == false)
            UPDATE accUpdateObj;
        RETURN plumberOutputList;
    }
}