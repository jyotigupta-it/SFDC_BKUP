public class BeatrMasterTriggerHandler {
    public static Boolean triggerFlag = false;
    public static void updateAccountsOnDelete(List<Beat_Master__c> beatList){
        Set<Id> accIds = new Set<Id>();
        Set<Id> beatMasterIds = new Set<Id>();
        List<Account> accList = new List<Account>();
        
        for(Beat_Master__c beatMaster : beatList){
            if(beatMaster.Id != null){
                beatMasterIds.add(beatMaster.Id);
            }
        }
        system.debug('ttttt==>'+[Select Id,Account__c from Beat_Master_Account__c]);
        for(Beat_Master_Account__c beatAccounts : [Select Id,Account__c from Beat_Master_Account__c where Beat_Master__c In : beatMasterIds And Account__c != null]){
            if(beatAccounts.Account__c != null ){
                accIds.add(beatAccounts.Account__c);
            }
        }
        for(Id Ids : accIds){
            if(Ids != null){
                accList.add(new Account(Id = Ids,Beat_Area__c =false));
            }
        }
        try{
            if(accList.size()>0){
                update accList;
                Database.SaveResult[] saveResultList = Database.update(accList, false);
                // Iterate through saveResultList based on isSuccess capture the failed records
                for (Database.SaveResult sr : saveResultList) {
                    if (!sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Account fields that affected this error: ' + err.getFields());
                        }
                    }
                }
            }
        }catch(Exception e){
            System.debug('Exception At Line number '+ e.getLineNumber());
            System.debug('Exception :='+ e.getMessage());
            
        }  
    }
    
    //Beat plan frequency duplicate check.
    public static void beatFrequencyDupCheck(List<Beat_Master__c> newBeatList, Map<Id,Beat_Master__c> oldBeatMap){
        Set<String> beatFreqSet = new Set<String>();
        Set<String> beatFreqExistingSet = new Set<String>();
        List<Beat_Master__c> beatMasterList = new List<Beat_Master__c>();
        String beatOwnerId = '';
        for(Beat_Master__c beatMaster: newBeatList){
            if(beatMaster.Beat_Frequency__c != null){
                beatFreqSet.addAll(beatMaster.Beat_Frequency__c.split(';'));
                beatOwnerId = beatMaster.OwnerId;
            }
        }
        System.debug(beatOwnerId);
        System.debug(newBeatList[0].Id);
        if(beatFreqSet.size() > 0 && beatOwnerId != ''){
            beatMasterList = [SELECT Id,Beat_Frequency__c FROM Beat_Master__c WHERE OwnerId =:beatOwnerId AND Beat_Frequency__c != null AND Id != :newBeatList[0].Id];
        }
        if(beatMasterList.size() > 0){
            for(Beat_Master__c beatMasterObj : beatMasterList){
                beatFreqExistingSet.addAll(beatMasterObj.Beat_Frequency__c.split(';'));
            }
            for(String beatFreqObj : beatFreqSet){
                if(beatFreqExistingSet.contains(beatFreqObj)){
                    newBeatList[0].addError('Beat frequency: "'+beatFreqObj+'" is already selected for another Beat master');
                    break;
                }
            }
        }
        triggerFlag = true;
    }
    
    //Tour plan updataion on beat frequency approval.
    public static void beatFreqTourPlanUpdate(List<Beat_Master__c> newBeatList, Map<Id,Beat_Master__c> oldBeatMap){
        Boolean beatApprovalFlag = false;
        //Check if beat frequency is changed and approved
        for(Beat_Master__c beatMaster: newBeatList){
            if(beatMaster.Beat_frequency_approval_status__c != oldBeatMap.get(beatMaster.Id).Beat_frequency_approval_status__c && beatMaster.Beat_frequency_approval_status__c == 'Approved'){
                beatApprovalFlag = true;
            }
        }
        if(beatApprovalFlag){
            Map<Id,Target__c> targetMap = new map<Id,Target__c>();
            //Get pending targets
            targetMap = new Map<Id,Target__c>([SELECT Id,Name,Start_Date__c,End_Date__c,OwnerId,Approval_Status__c FROM Target__c WHERE Approval_Status__c IN ('Pending') AND OwnerId =:newBeatList[0].OwnerId]);
            if(targetMap.size() > 0){
                //Delete pending tour plans and visits
                try{
                    DELETE [SELECT Id FROM AP_Tour_Plan__c WHERE Target__c IN :targetMap.keySet()];
                }
                catch(Exception e){
                    System.debug(e.getStackTraceString());
                }
                //call batch to create tour plan and vists according to approved beat frequency
                Batch_AutoTourPlanCreation batchObj = new Batch_AutoTourPlanCreation(targetMap.keySet(),'');
                Database.executeBatch(batchObj,1);
            }
        }
        triggerFlag = true;
    }
}