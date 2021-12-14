public class AssetTriggerHandler {
    
    public static void onBeforeInsert(List<Asset> listOfAsset){
        AssetTriggerHelper.changeStatusToVerifiedWhenWarrantyMasterIsAssigned(listOfAsset);   
        for(Asset ass:listOfAsset){
            if(ass.Messaging_Session__c!=null){
               AssetTriggerHelper.assignContactNumberFromMessagingSession(listOfAsset);
            }
        }
    }
     public static void onAfterInsert(Map<id,Asset> mapOfAsset){
         Map<id,Asset> mapOfAssetWithStatusPresent=new Map<id,Asset>();
         Map<id,Asset> mapOfAssetWithStatusCreated=new Map<id,Asset>();
         for(Asset ass:mapOfAsset.values()){
             if(ass.Verification__c=='Already Present' && ass.Verification__c!=null){
                 mapOfAssetWithStatusPresent.put(ass.id,ass);
             }
             if(ass.Verification__c=='Verified' && ass.Verification__c!=null){
                 mapOfAssetWithStatusCreated.put(ass.id,ass);
             }
         }
         if(!mapOfAssetWithStatusPresent.isEmpty()){
           SMSLogService.generateSMSContentForWarranty(mapOfAssetWithStatusPresent);
         }
         if(!mapOfAssetWithStatusCreated.isEmpty()){
           SMSLogService.generateSMSContentForWarranty(mapOfAssetWithStatusCreated);
         }
     }
    
}