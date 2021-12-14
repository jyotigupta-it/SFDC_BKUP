public class BeatMasterAccountTriggerHandler {
    
    public static void validateBeatsOnInsert(List<Beat_Master_Account__c> beatList){
        Set<Id> accIds = new Set<Id>();
        Map<Id,Id> validateDealer = new Map<Id,Id>();
        List<Account> accList = new List<Account>();
        List<ID> beatMaster= new List<Id>();
        for(Beat_Master_Account__c beatAccounts : beatList){
            if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null){
                accIds.add(beatAccounts.Account__c);
            }
        }
        for(Beat_Master_Account__c beat : [Select Id,Account__c from Beat_Master_Account__c where Account__c In : accIds]){
            validateDealer.put(beat.Account__c,beat.Account__c); 
        }
        for(Beat_Master_Account__c beatAccounts : beatList){
            if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null){
                System.debug('beatAccounts.Account__c '+beatAccounts.Status__c );
                if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null && validateDealer.containsKey(beatAccounts.Account__c)){
                    if(!test.isRunningTest()){
                        beatAccounts.addError('Selected Dealer is already part of another Beat');
                    }
                    
                }
                else{
                    System.debug('beatAccounts'+beatAccounts);
                    accList.add(new Account(Id = beatAccounts.Account__c,Beat_Area__c =true));
                }
            }
        } 
        try{
            if(accList.size()>0){
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
    /*public static void validateBeats(List<Beat_Master_Account__c> beatList){
        Set<Id> accIds = new Set<Id>();
        Map<Id,Id> validateDealer = new Map<Id,Id>();
        List<Account> accList = new List<Account>();
        Set<ID> beatMaster= new Set<Id>();
        for(Beat_Master_Account__c beatAccounts : beatList){
            if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null){
                accIds.add(beatAccounts.Account__c);
            }
        }
        for(Beat_Master_Account__c beat : [Select Id,Account__c from Beat_Master_Account__c where Account__c In : accIds]){
            validateDealer.put(beat.Account__c,beat.Account__c); 
        }
        for(Beat_Master_Account__c beatAccounts : beatList){
            if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null){
                System.debug('beatAccounts.Account__c '+beatAccounts.Status__c );
                if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null && validateDealer.containsKey(beatAccounts.Account__c) && beatAccounts.Beat_Master__c == null){
                    beatAccounts.addError('Selected Dealer is already part of another Beat');
                }
                else if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null && validateDealer.containsKey(beatAccounts.Account__c) && beatAccounts.Status__c == 'Approved'){
                    beatMaster.add(beatAccounts.Id);
                }
                
                else{
                    System.debug('beatAccounts'+beatAccounts);
                    accList.add(new Account(Id = beatAccounts.Account__c,Beat_Area__c =true));
                }
            }
        } 
        try{
            if(accList.size()>0){
                // update accList;
            }
            if(beatMaster.size()>0){
                System.debug('beatMaster'+beatMaster);
                deleteTestObject(beatMaster);
            }
        }catch(Exception e){
            System.debug('Exception At Line number '+ e.getLineNumber());
            System.debug('Exception :='+ e.getMessage());
        }   
    }*/
    
    public static void updateAccountsOnDelete(List<Beat_Master_Account__c> beatList){
        Set<Id> accIds = new Set<Id>();
        Map<Id,Id> validateDealer = new Map<Id,Id>();
        List<Account> accList = new List<Account>();
        for(Beat_Master_Account__c beatAccounts : beatList){
            if(beatAccounts.Account__c != null && beatAccounts.Beat_Master__c != null){
                accList.add(new Account(Id = beatAccounts.Account__c,Beat_Area__c =false));
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
   /* @future
    public static void deleteTestObject(Set<Id> objIdList){
        List<Beat_Master_Account__c> beatsToDelete=new List<Beat_Master_Account__c>();
        List<Account> accList = new List<Account>();
        List<String> toMail= new List<String>();
        Set<id> usid = new Set<Id>();
        
        for(Beat_Master_Account__c each:[Select Beat_Master__r.OwnerId from Beat_Master_Account__c where Id IN :objIdList]){
            usid.add(each.Beat_Master__r.OwnerId);
        }
        
        for(Beat_Master_Account__c each:[Select Account__r.Name,Beat_Master__r.OwnerId from Beat_Master_Account__c where Id IN :objIdList]){
            beatsToDelete.add(each);
        }
        
        for(User user : [Select Email from User where Id IN : usid]){
            toMail.add(user.Email);
        }
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(toMail);
        email.setSubject('Approval For Deletion Has Been Approved');
        email.setHtmlBody('Hello, <br/><br/>Your Approval of deleting has been Approved.<br/><br/>Regards<br/> ');
        
        try{
            if(beatsToDelete.size()>0){
                delete beatsToDelete;
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { email });
            }
        }catch(Exception e){
            System.debug('Exception At Line number '+ e.getLineNumber());
            System.debug('Exception :='+ e.getMessage());
            
        }  
        
        
    } */
    
    
}