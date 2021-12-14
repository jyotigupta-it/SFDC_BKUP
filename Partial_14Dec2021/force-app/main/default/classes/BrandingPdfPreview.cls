public class BrandingPdfPreview {
@AuraEnabled
   public static decimal promotionrec (Id accountId) {
       decimal percent;
        List<Promotion__c> promoList;
        promoList = [select Percent_of_attendees__c from Promotion__c where Id =: accountId];
     percent=promolist[0].Percent_of_attendees__c;
       system.debug('tets   '+percent);
       return percent;
    }
}