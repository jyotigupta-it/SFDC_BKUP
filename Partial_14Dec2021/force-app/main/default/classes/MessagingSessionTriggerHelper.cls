public class MessagingSessionTriggerHelper {
   
    public static void assignAccountToMessagingSession(Map<Id,MessagingSession> mapOfMessages){
        
        Set<Id> setOfMessagingUserId=new Set<Id>();  
        List<MessagingEndUser> listOfMessagingUser=new List<MessagingEndUser>();
        List<MessagingSession> listOfMessagingsession=[Select id,Messaging_User_Account__c,MessagingEndUserId from MessagingSession where Id=:mapOfMessages.keyset()];
        List<MessagingSession> listOfMessagingsessionToUpdate=new List<MessagingSession>();
        List<Account> listOfAccount=new List<Account>();
        List<Account> listOfAccountToUpdate=new List<Account>();
        Map<String,Id> listOfContactNumberWithMessagingUserId=new Map<String,Id>();
        Map<Id,MessagingSession> mapOfMessagingUserIdWithMessagingSession=new Map<Id,MessagingSession>();
        Map<Id,Account> mapOfMessagingUserIdWithItsAccount=new Map<Id,Account>();
        for(MessagingSession ms:mapOfMessages.values()) {
            setOfMessagingUserId.add(ms.MessagingEndUserId);
        }
        listOfMessagingUser=[select id,Name from MessagingEndUser where id in :setOfMessagingUserId];
        if(!listOfMessagingUser.isEmpty()){
            for(MessagingEndUser ms:listOfMessagingUser){
                
                String ContactNumber=ms.Name.right(10);
                system.debug('ContactNumber'+ContactNumber);
                listOfContactNumberWithMessagingUserId.put(ContactNumber,ms.Id);
            }
        }
        if(!listOfContactNumberWithMessagingUserId.isEmpty()){
            listOfAccount=[Select id,name,Contact_Number_Mobile__c from Account where Contact_Number_Mobile__c=:listOfContactNumberWithMessagingUserId.keyset()];
        }
        if(!listOfAccount.isEmpty()){
            for(Account acc:listOfAccount){
                Id messagingUserId;
                if(listOfContactNumberWithMessagingUserId.containskey(acc.Contact_Number_Mobile__c))
                    messagingUserId=listOfContactNumberWithMessagingUserId.get(acc.Contact_Number_Mobile__c);
                mapOfMessagingUserIdWithItsAccount.put(messagingUserId,acc);
            }
        }
        if(!mapOfMessagingUserIdWithItsAccount.isEmpty()){
            for(MessagingSession ms:listOfMessagingsession){
                Account acc=mapOfMessagingUserIdWithItsAccount.get(ms.MessagingEndUserId);
                acc.Messaging_Session__c=ms.id;
                ms.Messaging_User_Account__c=acc.Id;
                listOfAccountToUpdate.add(acc);
                listOfMessagingsessionToUpdate.add(ms); 
            }
        }
        
        if(!listOfMessagingsessionToUpdate.isEmpty()){
            update listOfMessagingsessionToUpdate;
        }
         if(!listOfAccountToUpdate.isEmpty()){
            update listOfAccountToUpdate;
        }
    }
}