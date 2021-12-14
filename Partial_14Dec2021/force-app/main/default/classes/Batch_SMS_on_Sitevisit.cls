/********************************************XXX**********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 22-Nov-2017
Description     : Batch class to fetch all site visit records

**********************************************XXX*********************************************************/
global class Batch_SMS_on_Sitevisit implements Database.Batchable<Sobject>,Database.allowsCallouts,Database.stateful {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        String var='';
        String visitList='select id,Party_mobile_number__c from AP_Site_Visit__c where Party_mobile_number__c!=:var and createdDate=Yesterday';
        return Database.getQueryLocator(visitList);
    }
    
    global void execute(Database.BatchableContext bc, List<AP_Site_Visit__c> VList){
        String visitmsg=label.Site_Visit_SMS;
        system.debug(visitMsg);
        String msgEncoded= EncodingUtil.urlEncode(visitmsg, 'UTF-8');
        try{
            for(Ap_Site_Visit__c VisitsList:Vlist){
                SendSMS.sendMsg(VisitsList.Party_mobile_number__c,msgEncoded);
            }
        }
        catch(exception Ex){
              System.debug('The Error is '+Ex.getMessage()+'at Line Number'+Ex.getLineNumber());
        }
        
        
    }
    
    global void finish(Database.BatchableContext bc){
        
    }

}