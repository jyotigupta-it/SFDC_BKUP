public With sharing class AddPromotionalMember {
@AuraEnabled
    public static list<string> addmember (String PromotionId) {
        system.debug('test2   '+'a0a3000000EpPOAAA3');
        list<string> stringlist=new list<string>();
          string Gtype;
        decimal difference;
        difference = [select Difference__c from Promotion__c where Id =: PromotionId].Difference__c;
        Gtype=[select type__c from Promotion__c where Id =: PromotionId].type__c;
        String stringdifference = String.valueOf(difference.format());
        stringlist.add(stringdifference);
        stringlist.add(Gtype);
        system.debug('test'+stringlist);
        return stringlist;
        
        
    }
    
    
}