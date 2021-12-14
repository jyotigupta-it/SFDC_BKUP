public with sharing class BeatSelectionController {
    
    @AuraEnabled
    public static List<BeatsWrapper> fetchBeats(){
        
        Map<String,Integer> mapOfCountRetailers = new Map<String,Integer>();
        BeatsWrapper be;
        List<BeatsWrapper> beatList = new List<BeatsWrapper>();
        for(Beat_Master_Account__c ac:[Select Beat_Master__c from Beat_Master_Account__c where Beat_Master__c!= null]){
            if(mapOfCountRetailers.containsKey(ac.Beat_Master__c)){
                mapOfCountRetailers.put(ac.Beat_Master__c,mapOfCountRetailers.get(ac.Beat_Master__c)+1);
                
            }else{
                mapOfCountRetailers.put(ac.Beat_Master__c,1);
            }
        }
        
        for(Beat_Master__c beat : [Select Id,Name from Beat_Master__c]){
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
    
    @AuraEnabled
    public static Object addDealerInBeat(String selectedBeat1,List<String> selectedDealersToSave1){
        System.debug('selectedBeat'+selectedBeat1);
        System.debug('selectedDealersToSave'+selectedDealersToSave1);
        Set<String> accId = new Set<String>();
        accId.addAll(selectedDealersToSave1);
        //Beat_Master__c beatMaster = new Beat_Master__c(Id=selectedBeat1);
        List<Beat_Master_Account__c> beatAccounts = new List<Beat_Master_Account__c>();
        List<Account> accList = new list<Account>();
        Beat_Master_Account__c be;
       
        for(Account accIds :[Select Id,Name from Account where Id In : accId]){
            accList.add(accIds);
            be = new Beat_Master_Account__c();
            be.Account__c=accIds.Id;
            be.Beat_Master__c=selectedBeat1;
            //be.Name = accIds.Name;
            beatAccounts.add(be);
            
        }
        try{
            // DML statement
            update accList;
            insert beatAccounts;
            return 'Success';
        }catch(Exception e){
            Database.SaveResult[] srList = Database.update(accList, false);
            String errorString='';
            Integer i=0;
            Map<String,String> errorValues= new Map<String,String>();
            // Iterate through each returned result
            for (Database.SaveResult sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                }
                else {
                    // Operation failed, so get all errors                
                    for(Database.Error err : sr.getErrors()) {
                        System.debug('The following error has occurred.');                    
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Account fields that affected this error: ' + err.getFields());
                        if(errorValues.containsKey(accList.get(i).Id) && errorValues.containsKey(accList.get(i).Id) != null){
                            errorValues.put(accList.get(i).Id,errorValues.get(accList.get(i).Id)+','+accList.get(i).Name+'='+err.getMessage());
                        }else{
                            errorValues.put(accList.get(i).Id,accList.get(i).Name+'='+err.getMessage());
                        }
                        
                    }
                }
                i++;
            }
            Integer rowNo=1;
            for(String errors : errorValues.values()){
                if(rowNo==1){
                    errorString+=String.valueOf(rowNo)+'--> [ '+ errors +' ] ';
                }else{
                    errorString+=' , '+String.valueOf(rowNo)+'--> [ '+ errors +' ] ';
                }
                rowNo++;
            }
            return errorString;
        }
        // update accList;
        
    }
    
    
    public class BeatsWrapper{
        @AuraEnabled public String beatName;
        @AuraEnabled public String beatId;
        @AuraEnabled public Integer noOfDealers;
        
        
    }
}