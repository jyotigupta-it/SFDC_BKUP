public class AccountTriggerHelper {
    public static void CityMapping(Map<Id,Account> mapOfAccount){
     set<Id> setIds=new set<Id>();
        System.debug('asdfgh');
     for(Account acc:mapOfAccount.values()){
         If(acc.Town_Name__c!=null){
            setIds.add( acc.Town_Name__c);
          System.debug('setIds'+setIds);
         }}
        Map<Id,Town_Master__c> mapOfTerritory=new Map<Id,Town_Master__c>([Select id,Service_Territory__c from Town_Master__c where id=:setIds]);
       if(!mapOfTerritory.isEmpty()){
        System.debug('mapOfTerritory'+mapOfTerritory);
        for(Account acc:mapOfAccount.values()){
            System.debug('entering here');
            acc.City_lookup__c=mapOfTerritory.get(acc.Town_Name__c).Service_Territory__c;
            System.debug('hjhkj'+acc.City_lookup__c);
                    
            }
        }}
    }