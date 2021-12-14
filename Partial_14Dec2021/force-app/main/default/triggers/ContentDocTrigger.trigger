/* ***************************************************************************************
Created By    : Srilakshmi, KVP Business Solutions
Description   : To calculate the number of attachments in promotion object for upload files button
******************************************************************************************** */
trigger ContentDocTrigger on ContentDocument (before delete) {   
    // List<ContentDocument> data = trigger.isdelete?trigger.new:trigger.old;    
   List<ContentDocument> data = trigger.old;  
    // List<ContentDocument> data2 = ;         
    ContentDocTriggerHandler.getFileCount(data);
    ContentDocTriggerHandler.getFileCountonAccount(data);
        
    /*set<Id> contentDocId = new set<Id>();
    set<id> promotionid = new set<id>();
    set<id> promoIdSet = new set<id>();
    if(trigger.IsDelete){
        for(ContentDocument con : Trigger.old){
            System.debug('---**'+Trigger.old);
            System.debug('---*'+con.Id);
            contentDocId.add(con.Id);  
        }
        system.debug('cd set----'+contentDocId);
        for(ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId IN : contentDocId]){
            promotionid.add(cdl.LinkedEntityId );                   
        }
        System.debug('id in set -promotionid ************'+promotionid);
         
        List<promotion__c> oldpromotionWithAtt = new List<promotion__c>(); 
        oldpromotionWithAtt =[select id,total_no_of_attachment__c from promotion__c where Id IN:promotionid ];
        
        for(promotion__c promo : oldpromotionWithAtt) {
            promoIdSet.add(promo.Id);
        }        
        system.debug('promoIdSet set id--------'+promoIdSet);
       
        AggregateResult[] totalCount= [SELECT count(Id) totalcnt, LinkedEntityId parId FROM ContentDocumentLink WHERE ContentDocumentId NOT IN : contentDocId and LinkedEntityId IN: promoIdSet GROUP BY LinkedEntityId];        
        System.debug('totalcount of files----------------------'+totalCount+'************');
        
        List<promotion__c> ls = new List<promotion__c>();
        
        try{  
         
            for(AggregateResult agRes : totalCount) {        
                                            
                Promotion__c pr=new Promotion__c();  
                pr.Id = (ID)agRes.get('parId');
                pr.Total_No_of_Attachment__c=Integer.valueOf(agRes.get('totalcnt'));
                system.debug('output...............'+pr.Total_No_of_Attachment__c);                                                
                    
                ls.add(pr);
                system.debug('ls list from adding pr'+ls);
                system.debug('ls size ---------------------'+ls.size());                    
            }                
            
            system.debug('final op============================'+ls);
            if(ls!=null && ls.size()>0){                
                update ls;
            } 
            
        }catch(exception ex1){
            System.debug('exception   ............'+ex1);
        } 
        
    }*/


}