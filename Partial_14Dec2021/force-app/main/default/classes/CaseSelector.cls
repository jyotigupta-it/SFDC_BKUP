public class CaseSelector {

    public Map<Id,Case> getCaseDetailsFromSet(Set<Id> setOfCaseIds){
        Map<Id,Case> mapOfCases = new Map<Id,Case>([Select Id, Problem__c,closure_code__c, AccountId,Contractor__c,Account.State__c,Account.City_fsl__c, Account.Town_Name__r.Name,Service_Territory__c,Account.Can_you_please_give_address_retail__c,Account.city_Lookup__r.Name,Account.PinCode__c,Problem__r.Work_Type__c,Account.Country_fsl__c,Account.City_lookup__c from Case where Id in: setOfCaseIds]);
        return mapOfCases;
    }
}