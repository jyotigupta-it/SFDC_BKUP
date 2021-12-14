public class InvoiceTriggerHandler {
    public static void beforeUpdate(Map<id,Invoice__c> newmap,Map<id,Invoice__c> oldmap){
        Map<id,Invoice__c> invMspUnderpro=new Map<id,Invoice__c>();
        for(Invoice__c inv:newMap.values()){
            if(inv.Status__c=='Raised' && oldMap.get(inv.id).Status__c!='Raised'){
             invMspUnderpro.put(inv.id,inv);   
            }
        }
        if(!invMspUnderpro.isEmpty()){
            System.debug('validation');
            InvoiceTriggerHelper.validateattachment(invMspUnderpro);
        }
    }
     public static void afterUpdate(Map<id,Invoice__c> newmap,Map<id,Invoice__c> oldmap){
        Map<id,Invoice__c> invMspUnderpro=new Map<id,Invoice__c>();
        for(Invoice__c inv:newMap.values()){
            if(inv.Status__c=='Raised' && oldMap.get(inv.id).Status__c!='Raised'){
             invMspUnderpro.put(inv.id,inv);   
            }
        }
        if(!invMspUnderpro.isEmpty()){
            System.debug('send email');
             InvoiceTriggerHelper.sendEmailToPaymnetteam(invMspUnderpro);
        }
    }
}