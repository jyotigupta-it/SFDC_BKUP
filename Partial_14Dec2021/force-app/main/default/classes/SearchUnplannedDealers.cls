public with sharing class SearchUnplannedDealers {
    
    public List<Account> fetchAccounts(String cond, String nameCond, Set<Id> dealerRemoval){
        List<Account> ret= new List<Account>([SELECT Id,Name,Custom_Distributor_LookUp__c,District__c, State__c, Status__c,City__c ,
                                              Party_type__c,Column_club_ID__c, Plumbing_club_ID__c,Contact_Number_Mobile__c  FROM Account WHERE (Id NOT IN : dealerRemoval And  Party_type__c = 'Dealer') 
                                              and (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR 
                                                   Contact_Number_Mobile__c LIKE :cond )  limit 200]);
        return ret;
    }
    
    
}