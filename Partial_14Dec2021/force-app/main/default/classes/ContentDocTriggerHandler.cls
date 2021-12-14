/* ***************************************************************************************
Created By    : Srilakshmi, KVP Business Solutions
Description   : To calculate the number of attachments in promotion object for upload files button
******************************************************************************************** */
public class ContentDocTriggerHandler{   
    
    public static void getFileCount(List<ContentDocument> data){
        
        string contentDocId ='';//= new set<Id>();
        string promotionid = '';// new set<id>();
        set<id> promoIdSet = new set<id>();
        
            for(ContentDocument con : data){
                //System.debug('---**'+Trigger.old);
                //System.debug('---*'+con.Id);
                contentDocId = con.id;//.add(con.Id);  
            }
            system.debug('cd set----'+contentDocId);
            for(ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId =: contentDocId]){
                if(String.valueof(cdl.LinkedEntityId).StartsWith('a0a'))
                    promotionid = cdl.LinkedEntityId;//.add(cdl.LinkedEntityId );                   
            }
            System.debug('id in set -promotionid ************'+promotionid);
             
            /*List<promotion__c> oldpromotionWithAtt = new List<promotion__c>(); 
            oldpromotionWithAtt =[select id,total_no_of_attachment__c from promotion__c where Id IN:promotionid ];
            
            for(promotion__c promo : oldpromotionWithAtt) {
                promoIdSet.add(promo.Id);
            }        
            system.debug('promoIdSet set id--------'+promoIdSet);*/
           
            AggregateResult[] totalCount= [SELECT count(Id) totalcnt, LinkedEntityId parId FROM ContentDocumentLink WHERE ContentDocumentId !=: contentDocId and LinkedEntityId =: promotionid GROUP BY LinkedEntityId];        
            System.debug('totalcount of files----------------------'+totalCount+'************');
            
            List<promotion__c> ls = new List<promotion__c>();
            map<id, integer> promoAttCount = new map<id, integer>();
            try{  
             
                for(AggregateResult agRes : totalCount) {  
                    //if(String.valueof((ID)agRes.get('parId')).StartsWith('a0a')){      
                        if(Integer.valueOf(agRes.get('totalcnt')) >0){
                            promoAttCount.put((ID)agRes.get('parId'), Integer.valueOf(agRes.get('totalcnt'))); 
                        }
                        else{
                            promoAttCount.put((ID)agRes.get('parId'), 0);
                        }
                    //}
                    system.debug('---map---*'+promoAttCount);                         
                    
                    /*Promotion__c pr=new Promotion__c();  
                    pr.Id = (ID)agRes.get('parId');
                    pr.Total_No_of_Attachment__c=Integer.valueOf(agRes.get('totalcnt'));
                    system.debug('output...............'+pr.Total_No_of_Attachment__c);                                                
                        
                    ls.add(pr);
                    system.debug('ls list from adding pr'+ls);
                    system.debug('ls size ---------------------'+ls.size()); */
                                     
                }   
                for(Id proid : promoAttCount.keyset()){
                    Promotion__c pr = new Promotion__c();  
                    pr.Id = proid;
                    pr.Total_No_of_Attachment__c = promoAttCount.get(proid) ;
                    system.debug('output...............'+pr.Total_No_of_Attachment__c);                                                
                        
                    ls.add(pr);
                    system.debug('ls list from adding pr'+ls);
                    system.debug('ls size ---------------------'+ls.size()); 
                }             
                
                system.debug('final op CD============================'+ls);
                if(ls!=null && ls.size()>0){                
                    update ls;
                } 
                
            }catch(exception ex1){
                System.debug('exception CD ............'+ex1);
            } 
            
    }

 public static void getFileCountonAccount(List<ContentDocument> data){
        
        string contentDocId ='';//= new set<Id>();
        string promotionid = '';// new set<id>();
        set<id> promoIdSet = new set<id>();
        
            for(ContentDocument con : data){
                
                 contentDocId = con.id;//.add(con.Id);   
            }
            system.debug('cd set----'+contentDocId);
            for(ContentDocumentLink cdl : [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId =: contentDocId]){
                if(String.valueof(cdl.LinkedEntityId).StartsWith('001'))
                    promotionid = cdl.LinkedEntityId;//.add(cdl.LinkedEntityId );                  
            }
            System.debug('id in set -promotionid ************'+promotionid);
             
           
           
            AggregateResult[] totalCount= [SELECT count(Id) totalcnt, LinkedEntityId parId FROM ContentDocumentLink WHERE ContentDocumentId  !=: contentDocId and LinkedEntityId =: promotionid GROUP BY LinkedEntityId];        
            System.debug('totalcount of files----------------------'+totalCount+'************');
            
            List<Account> ls = new List<Account>();
            map<id, integer> promoAttCount = new map<id, integer>();
            try{  
             
                for(AggregateResult agRes : totalCount) {  
                       
                        if(Integer.valueOf(agRes.get('totalcnt')) >0){
                            promoAttCount.put((ID)agRes.get('parId'), Integer.valueOf(agRes.get('totalcnt'))); 
                        }
                        else{
                            promoAttCount.put((ID)agRes.get('parId'), 0);
                        }
                    //}
                    system.debug('---map---*'+promoAttCount);                         
                   
                                     
                }   
                for(Id proid : promoAttCount.keyset()){
                    Account pr = new Account();  
                    pr.Id = proid;
                    pr.Count_Attachment__c = promoAttCount.get(proid) ;
                    system.debug('output...............'+pr.Count_Attachment__c);                                                
                        
                    ls.add(pr);
                    system.debug('ls list from adding pr'+ls);
                    system.debug('ls size ---------------------'+ls.size()); 
                }             
                
                system.debug('final op CD============================'+ls);
                if(ls!=null && ls.size()>0){                
                    update ls;
                } 
                
            }catch(exception ex1){
                System.debug('exception CD ............'+ex1);
            } 
            
    }
        
    }