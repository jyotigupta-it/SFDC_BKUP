/* 
	Helper class of TrigggerAccount
	Helper adds Account id into IEP_Influncer__c custom object after insert & update on Account
	Author: Mohit
*/
public class TriggerAccountHelper {
public static void insertAccountIntoIEPInfluncer(List<Account> accNew){
        List<iep_influencer__c> iepList = [select Id, Account__c from iep_influencer__c];
        Map<Id, iep_influencer__c> mapIep = new Map<Id, iep_influencer__c>();
        for(iep_influencer__c i : iepList){
            mapIep.put(i.Account__c,i);
        }
        for(Account ac : accNew){
            if(ac.is_active__c){
                if(!mapIep.containsKey(ac.Id)){
                    iep_influencer__c iep = new iep_influencer__c(Account__c=ac.Id, Current_point__c=0.00);
                    insert iep;
                }
            }
        }
    }
}