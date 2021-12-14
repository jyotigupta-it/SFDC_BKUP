/* 
* Name      : ValidatePlumberPhone
* Purpose   : This class is used as an utility to validate phone number entered by DP while Redemption.
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class ValidatePlumberPhone {
    public class PlumberInput {
        @InvocableVariable
        public String phoneNumber; 
        @InvocableVariable
        public string Redeem; 
    }
    public class PlumberOutput { 
        @InvocableVariable
        public String statusMessage;
        @InvocableVariable
        public Boolean plumberPhoneFlag;
        @InvocableVariable
        public String plumberId;
        @InvocableVariable
        public String Capacity;
    }
    @InvocableMethod(label='Validate Phone Number')
    public static List<PlumberOutput> validatePhoneNumber(List<PlumberInput> plumberInputs){
        List<PlumberOutput> plumberOutputList = new List<PlumberOutput>();
        List<Claim__c> claimList = new List<Claim__c>();
        List<Account> accountsList = new List<Account>();
        
        PlumberOutput pOutput = new PlumberOutput();
        pOutput.statusMessage = '';
        pOutput.plumberId = '';
        pOutput.Capacity = '';
        if(plumberInputs.size() > 0){
            String plPhoneNumber = plumberInputs[0].phoneNumber;
            if(plPhoneNumber == null || plPhoneNumber == ''){
                pOutput.statusMessage = 'Not a Valid Phone Number, Please Enter Phone Number Again!';  
                pOutput.plumberPhoneFlag = false;
            }
            else{
                plPhoneNumber = plPhoneNumber.trim();
                if(plPhoneNumber.startsWith('+91')){
                    plPhoneNumber = plPhoneNumber.removeStart('+91');
                }
                accountsList = [SELECT id, name, Contact_Number_Mobile__c,Remaining_Purchased_Capacity__c,(SELECT id,Request_Quantity_Capacity__c,Reward_Quantity__c, name from Redeems__r WHERE Active__c = True AND Status__c = 'Created') from Account WHERE Contact_Number_Mobile__c=:plPhoneNumber];
                if(accountsList.size() <= 0){
                    pOutput.statusMessage = 'No Plumber Found, Please Enter the Phone Number Again!';  
                }else{
                    if(plPhoneNumber.length() != 10){
                        pOutput.statusMessage = plPhoneNumber+' is Not a Valid Phone Number, Please Enter Phone Number Again!';  
                        pOutput.plumberPhoneFlag = false;
                    }
                    else{
                        String cap = '0L';
                        if(accountsList[0].Remaining_Purchased_Capacity__c != null)
                            cap = accountsList[0].Remaining_Purchased_Capacity__c;
                        pOutput.statusMessage = 'Total Remaining Capacity to be Claimed is: '+cap;
                        pOutput.plumberId = accountsList[0].Id;
                        pOutput.plumberPhoneFlag = true;
                        pOutput.Capacity = cap;
                        cap = cap.removeEnd('L');
                        Decimal  capacity =  decimal.valueOf(cap);
                        if(capacity < 2000){
                            pOutput.statusMessage = 'You Dont have Enough Capacity To claim.';
                        }else{
                            Decimal remainingCapacity = 0;
                            if(plumberInputs[0].Redeem == 'True'){
                                List<Redeem__c> redeemUpdateList = new List<Redeem__c>();
                                List<Plumber_Scheme_Relation__c> plumberSchemeList = [SELECT id, name, Plumber__r.name from Plumber_Scheme_Relation__c WHERE Plumber__c =:accountsList[0].id];
                                List<Reward_Master__c> RewardMasterList = [SELECT id, Quantity_Capacity__c, Reward_Quantity__c, Reward_Unit_of_Measuremnt__c, Unit_of_Measurement__c from Reward_Master__c WHERE active__c=true  ORDER BY Quantity_Capacity__c DESC];
                                for(Redeem__c redeemObj : accountsList[0].Redeems__r){
                                    redeemObj.Active__c = False;
                                    redeemUpdateList.add(redeemObj);
                                }
                                if(redeemUpdateList.size() > 0)
                                    UPDATE redeemUpdateList;
                                if(plumberSchemeList.size() > 0){
                                    Integer count = 0;
                                    Integer count_RewardMasterList = RewardMasterList.size();
                                    boolean check = true;
                                    List<Redeem__c> redeemList = new List<Redeem__c>();
                                    if(count_RewardMasterList>0){
                                        WHILE(check == true){
                                            for(Reward_Master__c reward : RewardMasterList){
                                                if(capacity >= reward.Quantity_Capacity__c){
                                                    Redeem__c redeem = new Redeem__c();
                                                    redeem.Account__c = accountsList[0].id;
                                                    redeem.Status__c = 'Created';
                                                    redeem.Request_Unit_of_Measurement__c = 'L';
                                                    redeem.Active__c = True;
                                                    redeem.Reward_Quantity__c = string.valueOf(reward.Reward_Quantity__c) ;
                                                    capacity = capacity-reward.Quantity_Capacity__c;
                                                    redeem.Request_Quantity_Capacity__c = reward.Quantity_Capacity__c;
                                                    redeemList.add(redeem);
                                                    break; 
                                                }else{
                                                    count++;
                                                }
                                                if(count==count_RewardMasterList){
                                                    check=false;
                                                }
                                            }
                                        }
                                        If(redeemList.size() >0){
                                            UPSERT redeemList;
                                        }else if(count==count_RewardMasterList){
                                            pOutput.statusMessage = 'You dont have enough purchased Capacity to claim!';                             
                                        }
                                    }else{
                                        pOutput.statusMessage = 'No reward found, Please contact to admin.'; 
                                    }
                                }else{
                                    pOutput.statusMessage = 'No Schemes Found, Please contact to admin.'; 
                                } 
                            }
                        }
                    }
                }
            }
        }
        plumberOutputList.add(pOutput);
        RETURN plumberOutputList;
    }
}