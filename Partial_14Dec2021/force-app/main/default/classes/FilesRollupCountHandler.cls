/* ***************************************************************************************
Created By    : Srilakshmi, KVP Business Solutions
Description   : To calculate the number of attachments in promotion object for upload files button
******************************************************************************************** */
public class FilesRollupCountHandler{
    
    public static void getFileCount(List<ContentDocumentLink> data){
        set<id> promotionid = new set<id>();
        set<id> promoIdSet = new set<id>();
        System.debug('data*****Files******'+data+'************');
        
        if(data!=null){  
            //get related promotion ids in a set from attached document
            for(ContentDocumentLink cdl : data)
            {
                if(String.valueof(cdl.LinkedEntityId).StartsWith('a0a'))
                    promotionid.add(cdl.LinkedEntityId );                   
            }
        }
        System.debug('id in set promotionid Files ************'+promotionid);
        
        List<promotion__c> oldpromotionWithAtt = new List<promotion__c>(); 
        oldpromotionWithAtt =[select id,total_no_of_attachment__c from promotion__c where Id IN:promotionid ];
        for(promotion__c promo : oldpromotionWithAtt) {
            promoIdSet.add(promo.Id);
        }        
        system.debug('promoIdSet set id Files--------'+promoIdSet);      
        
        AggregateResult[] totalCount;
        if(promoIdSet != null && promoIdSet.size() > 0) {
            totalCount = [SELECT count(Id) totalcnt, LinkedEntityId parId FROM ContentDocumentLink WHERE LinkedEntityId IN :promoIdSet GROUP BY LinkedEntityId];        
            System.debug('totalcount of files-------Files---------------'+totalCount+'************');
            
            List<promotion__c> ls = new List<promotion__c>();
            
            //get rollup of attachment count from aggregate qry and update on promotion
            try{  
                
                for(AggregateResult agRes : totalCount) {        
                    
                    Promotion__c pr=new Promotion__c();  
                    pr.Id = (ID)agRes.get('parId');
                    pr.Total_No_of_Attachment__c=Integer.valueOf(agRes.get('totalcnt'));
                    system.debug('output..........Files.....'+pr.Total_No_of_Attachment__c);                                                
                    
                    ls.add(pr);
                    system.debug('ls list fromFiles adding pr'+ls);
                    system.debug('ls size ------Files---------------'+ls.size());                    
                }                
                
                system.debug('final list=======Files====================='+ls);
                if(ls!=null && ls.size()>0){                
                    update ls;
                } 
                
            }catch(exception ex1){
                System.debug('exception   ............'+ex1);
            }
        }
    }
    public static void getFileCountonAccount(List<ContentDocumentLink> data){
        
         
        set<id> accountid = new set<id>();
        set<id> accIdSet = new set<id>();
        System.debug('data*****Files******'+data+'************');
        
        if(data!=null){  
            //get related promotion ids in a set from attached document
            for(ContentDocumentLink cdl : data)
            {
                if(String.valueof(cdl.LinkedEntityId).StartsWith('001'))
                    accountid.add(cdl.LinkedEntityId );                   
            }
        }
        System.debug('id in set accountid Files ************'+accountid);
        
        List<Account> oldaccountWithAtt = new List<Account>(); 
        oldaccountWithAtt =[select id,Count_Attachment__c from Account where Id IN:accountid ];
        for(Account acc : oldaccountWithAtt) {
            accIdSet.add(acc.Id);
        }        
        system.debug('accIdSet set id Files--------'+accIdSet);      
        
        AggregateResult[] totalCount;
        if(accIdSet != null && accIdSet.size() > 0) {
            totalCount = [SELECT count(Id) totalcnt, LinkedEntityId parId FROM ContentDocumentLink WHERE LinkedEntityId IN :accIdSet GROUP BY LinkedEntityId];        
            System.debug('totalcount of files-------Files---------------'+totalCount+'************');
            
            List<Account> ls = new List<Account>();
            
            //get rollup of attachment count from aggregate qry and update on promotion
            try{  
                
                for(AggregateResult agRes : totalCount) {        
                    
                    Account ac=new Account();  
                    ac.Id = (ID)agRes.get('parId');
                    ac.Count_Attachment__c  =Integer.valueOf(agRes.get('totalcnt'));
                    system.debug('output..........Files.....'+ac.Count_Attachment__c    );                                                
                    
                    ls.add(ac);
                    system.debug('ls list fromFiles adding ac'+ls);
                    system.debug('ls size ------Files---------------'+ls.size());                    
                }                
                
                system.debug('final list=======Files====================='+ls);
                if(ls!=null && ls.size()>0){                
                    update ls;
                } 
                
            }catch(exception ex1){
                System.debug('exception   ............'+ex1);
            }
        }
    }
    
}