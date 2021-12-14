public with sharing class AssignDealerInBeatController {
    
    @AuraEnabled
    public static Object fetchBeats(String accId1){
        Account account ;
        if(accId1 != null){
            account = [Select Id,Beat_Area__c from Account where Id =:accId1 LIMIT 1];
        }
        if(account.Beat_Area__c == true){
            return 'beatAssigned' ;
        }else{
            Map<String,Integer> mapOfCountRetailers = new Map<String,Integer>();
            BeatsWrapper be;
            List<BeatsWrapper> beatList = new List<BeatsWrapper>();
            for(Beat_Master_Account__c ac:[Select Beat_Master__c from Beat_Master_Account__c where Beat_Master__c!= null And Beat_Master__r.OwnerId =:userInfo.getUserId()]){
                if(mapOfCountRetailers.containsKey(ac.Beat_Master__c)){
                    mapOfCountRetailers.put(ac.Beat_Master__c,mapOfCountRetailers.get(ac.Beat_Master__c)+1);
                    
                }else{
                    mapOfCountRetailers.put(ac.Beat_Master__c,1);
                }
            }
            
            for(Beat_Master__c beat : [Select Id,Name from Beat_Master__c where OwnerId =:userInfo.getUserId()]){
                be= new BeatsWrapper();
                be.beatName=beat.Name;
                be.beatId=beat.Id;
                if(mapOfCountRetailers.containsKey(beat.Id)){
                    be.noOfDealers=mapOfCountRetailers.get(beat.Id);
                    
                }
                beatList.add(be);
            }
            return beatList; 
        }
        
    }
    @AuraEnabled
    public static String addingInBeat(String accId, String beatId){
        
        if(accId != null && accId != '' && accId != beatId && beatId != ''){
            Beat_Master_Account__c beatM = new Beat_Master_Account__c(Beat_Master__c=beatId,Account__c=accId);
            insert beatM;
            Account acc =new Account(Id=accId,Beat_Area__c =true);
            update acc;
        }
        return [Select Name from Beat_Master__c where Id =: beatId LIMIT 1][0].Name;
        
    }
    
    public class BeatsWrapper{
        @AuraEnabled public String beatName;
        @AuraEnabled public String beatId;
        @AuraEnabled public Integer noOfDealers;
    }
}