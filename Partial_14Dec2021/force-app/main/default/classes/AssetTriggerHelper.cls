public class AssetTriggerHelper {
    
 public static void changeStatusToVerifiedWhenWarrantyMasterIsAssigned(List<Asset> listOfAsset){
     Set<string> setOfSerialNumber=new Set<String>();
     Set<Id> setOfAccountId=new Set<Id>();
     List<Asset> listOfAssetwithSerial=new List<Asset>();
     Map<String,Id> mapOfSerialWithAccount=new Map<String,Id>() ;
     List<Warranty_Master__c> listOfWarranty=new List<Warranty_Master__c>();
     Map<String,Warranty_Master__c> mapOfSerialWithWarranty=new Map<String,Warranty_Master__c>();
     for(Asset ass:listOfAsset){
         setOfSerialNumber.add(ass.SerialNumber);
         setOfAccountId.add(ass.AccountId);
     }
     if(!setOfSerialNumber.isEmpty()){
         listOfWarranty=[select id,Serial_Number__c from Warranty_Master__c where Serial_Number__c=:setOfSerialNumber];}
     listOfAssetwithSerial=[select id,AccountId,SerialNumber from Asset where SerialNumber=:setOfSerialNumber And AccountId NOT IN:setOfAccountId ];
     for(Warranty_Master__c wm:listOfWarranty){
         mapOfSerialWithWarranty.put(wm.Serial_Number__c,wm);
     }
     for(asset ass:listOfAsset){
         Warranty_Master__c wm=mapOfSerialWithWarranty.get(ass.SerialNumber);
         if(wm!=null){
             ass.Verification__c='Verified';
             ass.Warranty_Master__c=wm.id;
         }
     }
     for(Asset ass:listOfAssetwithSerial){
         mapOfSerialWithAccount.put(ass.SerialNumber,ass.AccountId);
     }
     for(asset ass:listOfAsset){
         Warranty_Master__c wm;
         if(mapOfSerialWithWarranty.Containskey(ass.SerialNumber)){
             wm=mapOfSerialWithWarranty.get(ass.SerialNumber);
         }
          
         if(mapOfSerialWithAccount.Containskey(ass.SerialNumber)){
             ass.Verification__c='Already Present';
             }
          ass.Warranty_Master__c=wm.id;
         }
 }
    Public static void assignContactNumberFromMessagingSession(List<Asset> listOfAsset){
        Set<id> setOfMessagingId=new Set<id>();
        Set<id> setOfMessagingUseId=new Set<Id>();
        Map<id,id> mapOfIds=new Map<Id,Id>();
        List<MessagingEndUser> listOfMessagingUser=new List<MessagingEndUser>();
        List<MessagingSession> listOfMessagingSession=new List<MessagingSession>();
         Map<Id,String> mapOfMessagingUserIdWithContactNumber=new Map<Id,String>();
          Map<Id,Id> mapOfMessagingAccount=new Map<Id,Id>();
        for(Asset ass:listOfAsset){
            if(ass.Messaging_Session__c!=null){
                setOfMessagingId.add(ass.Messaging_Session__c);
               
                
            }
        }
        listOfMessagingSession=[select id,Messaging_User_Account__c,MessagingEndUserId from MessagingSession where id=:setOfMessagingId ];
        if(!listOfMessagingSession.isEmpty()){
            for(MessagingSession ms:listOfMessagingSession){
                if(ms.MessagingEndUserId!=null){
                   mapOfIds.put(ms.id,ms.MessagingEndUserId);
                    System.debug('mapOfIds'+mapOfIds);
                }
                if(ms.Messaging_User_Account__c!=null){
                   mapOfMessagingAccount.put(ms.id,ms.Messaging_User_Account__c);
                    System.debug('mapOfIds'+mapOfMessagingAccount);
                }
            }
        }
        if(!mapOfIds.isEmpty()){
        listOfMessagingUser=[select id,Name from MessagingEndUser where id in :mapOfIds.values()];
        }
         if(!listOfMessagingUser.isEmpty()){
            for(MessagingEndUser ms:listOfMessagingUser){
                String ContactNumber=ms.Name.right(10);
                System.debug('ContactNumber'+ContactNumber);
                mapOfMessagingUserIdWithContactNumber.put(ms.Id,ContactNumber);
            }
        }
        
        For(Asset ass:listOfAsset){
            Id UserId;
            Id accId;
            if(mapOfIds.Containskey(ass.Messaging_Session__c))
            UserId=mapOfIds.get(ass.Messaging_Session__c);
            if(mapOfMessagingAccount.Containskey(ass.Messaging_Session__c))
            accId=mapOfMessagingAccount.get(ass.Messaging_Session__c);
            String contactNumber;
            if(mapOfMessagingUserIdWithContactNumber.Containskey(UserId))
            contactNumber=mapOfMessagingUserIdWithContactNumber.get(UserId);
            System.debug('contactNumber'+contactNumber);
            ass.Contact_Number__c=contactNumber;
            ass.AccountId=accId;
            
        }
    }
 }