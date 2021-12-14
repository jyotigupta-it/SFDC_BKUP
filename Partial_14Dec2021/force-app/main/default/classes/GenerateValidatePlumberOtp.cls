public class GenerateValidatePlumberOtp {
    public class PlumberInput {
        @InvocableVariable(required=false)
        public String otp;
        @InvocableVariable(required=false)
        public String plumberPhone;
        @InvocableVariable(required=false)
        public String messagingSessionId;
        @InvocableVariable(required=false)
        public String generationFlag;
    }
    public class PlumberOutput {
        @InvocableVariable(required=true)
        public String otp;
        @InvocableVariable(required=true)
        public Boolean validOtpFlag;
        @InvocableVariable(required=true)
        public string RemainingCapacity;
        @InvocableVariable(required=true)
        public string rewardClaimed;
    }
    @InvocableMethod(label='Generate_Validate_OTP')
    public static List<PlumberOutput> generateValidateOtp(List<PlumberInput> plumberInputs){
        List<PlumberOutput> outputList = new List<PlumberOutput>();
        List<MessagingSession> messagingSessionList = new List<MessagingSession>();
        List<Redeem__c> redeemList = new List<Redeem__c>();
        List<Decimal> capList = new List<Decimal>();
        Decimal remCap = 0;
        PlumberOutput outputObj = new PlumberOutput();
        outputObj.otp = '';
        string claimedReward = '';
        outputObj.validOtpFlag = false;
        if(plumberInputs[0].generationFlag == 'True'){
            Integer otp =  Math.round((Math.random() * (900000) + 100000));
            string otpValue = String.valueOf(otp);
            outputObj.otp = otpValue;
            String phNumber = '';
            messagingSessionList = [SELECT Id, Name, OTP__c, MessagingEndUser.Name FROM MessagingSession WHERE Id=: plumberInputs[0].messagingSessionId];
            messagingSessionList[0].OTP__c = otpValue;
            UPDATE messagingSessionList;   
        }
        else{
            String userName = '%'+plumberInputs[0].plumberPhone;
            messagingSessionList = [SELECT Id,OTP__c FROM MessagingSession WHERE MessagingEndUser.Name LIKE :userName ORDER By CreatedDate DESC LIMIT 1];
            if(messagingSessionList[0].OTP__c == plumberInputs[0].otp){
                List<Account> accountList = [SELECT id,Remaining_Purchased_Capacity__c, name,Contact_Number_Mobile__c, (SELECT id,Request_Quantity_Capacity__c,Reward_Quantity__c, name from Redeems__r WHERE Active__c = True ORDER BY Request_Quantity_Capacity__c ASC) from Account WHERE Contact_Number_Mobile__c =:plumberInputs[0].plumberPhone];
                outputObj.validOtpFlag = true;
                if(accountList[0].Remaining_Purchased_Capacity__c != null)
                    remCap = Decimal.valueOf(accountList[0].Remaining_Purchased_Capacity__c.removeEnd('L'));
                for(Account acc : accountList){
                    for(Redeem__c redeem : acc.Redeems__r){
                        claimedReward+= redeem.Reward_Quantity__c+'gms;';
                        capList.add(redeem.Request_Quantity_Capacity__c);
                        remCap -= redeem.Request_Quantity_Capacity__c;
                        redeem.Status__c = 'Processed';
                        redeem.Active__c = False;
                        redeemList.add(redeem);
                    }
                }
                accountList[0].Remaining_Purchased_Capacity__c = remCap+'L';
                UPDATE accountList;
            }
            if(redeemList.size() > 0)
                UPDATE redeemList;
            outputObj.RemainingCapacity = remCap+'L';
        }
        outputObj.rewardClaimed = claimedReward;
        
        outputList.add(outputObj);
        RETURN outputList;
    }
}