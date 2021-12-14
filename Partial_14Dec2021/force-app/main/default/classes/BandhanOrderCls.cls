/*******************************************************************************
 * Developer : Srilakshmi K.U
 * Description : Apex controller for button Bandhan Orders on account layout
********************************************************************************/
public class BandhanOrderCls {
	@AuraEnabled   
    public static Map<String, Object> getBandhanOrdRec(id recordId){
        Map<String, Object> res = new Map<String, Object>();
        list<Bandhan_Orders__c> bord = new list<Bandhan_Orders__c>();
        try{
            List<Account> accts = [Select Id,Name,Parent.Status__c From Account where Id = :recordId];
            bord = [Select id,Cart_Status__c,Year_of_CreatedDate__c,Month_of_CreatedDate__c From Bandhan_Orders__c Where Account__c=:recordId];
            res.put('ACCOUNT', accts);
            res.put('ORDERS', bord);
            return res;
        }catch (Exception ex){
            throw new AuraHandledException('Apex error: '+ ex.getMessage());
        } 
    }    
	  
}