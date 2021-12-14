/********************************************XXX**********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 14-Oct-2017
Description     : Batch class to fetch Birthday & Anniversary Accounts & send to SMS Application

**********************************************XXX*********************************************************/
global class Batch_Birthday_Anniversary_SMS_alert implements Database.Batchable<SObject>,Database.allowsCallouts,Database.Stateful {
    
    global Database.QueryLocator start(Database.BatchableContext bc){        
        String AccountList = 'select id,name,Is_Anniversary_Today__c,IS_Birth_Day_Today__c,Contact_Number_Mobile__c,Is_Dealer_or_distributor__c,Primary_Contact_Person_Name__c from account where Is_Anniversary_today__c=true or Is_Birth_day_today__c=true';
        return Database.getQueryLocator(AccountList);
    }
    
    global void execute(Database.BatchableContext bc, List<account> AccountList){
        String AnniversaryMsg=label.AnniversaryMsg;
        String BirthdayMsg=label.BirthdayMsg;
        try{
            
            for(account acList:AccountList){
                
            if(acList.Is_Anniversary_Today__c==true){
                System.debug('AnniversaryAccounts'+acList);
                String name='';
                if(acList.Is_Dealer_or_distributor__c==true){
                 name=acList.Primary_Contact_Person_Name__c;   
                }
                
                else{
                  name=acList.name; 
                }
                String AnvrsyMSg='Dear Mr. and Mrs.'+name+' '+AnniversaryMsg;
                system.debug(AnvrsyMsg);
                String msgEncoded1= EncodingUtil.urlEncode(AnvrsyMsg, 'UTF-8');
                SendSMS.sendMsg(acList.Contact_Number_Mobile__c,msgEncoded1);
            }
                
            else if(acList.Is_Birth_Day_Today__c==true){
                System.debug('BirthdayAccounts'+acList);
                String name='';
                 if(acList.Is_Dealer_or_distributor__c==true){
                 name=acList.Primary_Contact_Person_Name__c;   
                }
                
                else{
                  name=acList.name; 
                }
                String BrthdyMSg='Dear Mr.'+name+' '+BirthdayMsg;
                String msgEncoded2= EncodingUtil.urlEncode(BrthdyMsg, 'UTF-8');
                SendSMS.sendMsg(acList.Contact_Number_Mobile__c,msgEncoded2);
            }          
        }
        }
        
        catch(Exception Ex){
             System.debug('The Error is '+Ex.getMessage()+'at Annniversary Line Number'+Ex.getLineNumber());
        }
      
    }
    global void finish(Database.BatchableContext bc) {
        
    }
}