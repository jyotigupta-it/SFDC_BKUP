/******************************************
 * Created By  : Ajeet Singh Shekhawat
 * Created On  : 03 Sep 2018
 * Modified By : 
 * Modified On : 03 Sep 2018
 * Description : fetch Difference__c from particular record id of Promotion__c object.
				
******************************************/ 
public class NewPromotionApex {
	@AuraEnabled
    public static Decimal fetchPromotionRecord (Id accountId) {
        try {
            Decimal difference;
            List<Promotion__c> promoList;
            promoList = [select Difference__c from Promotion__c where Id =: accountId];
            difference = promoList[0].Difference__c;
            System.debug('difference ' + difference);
            return difference;
        } catch (Exception ex){
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
         } 
        
    }
}