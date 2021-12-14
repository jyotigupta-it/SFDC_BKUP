public class GeoLocationInAccount{
    public static void toPopulateGeoinsert(List<AP_Site_Visit__c> siteVisitList){
        Map<ID,Account> apMap = new Map<ID,Account>();
        Set<Id> accSet = new Set<Id>();
          List<Account> accList = new List<Account>();
        set<Account> accountSet = new Set<Account>();
        for(AP_Site_Visit__c ap : siteVisitList){
            
            accSet.add(ap.Party_Name__c);
        }
        apMap = new Map<ID,Account>([SELECT ID,Geolocation__Latitude__s,Geolocation__Longitude__s,(SELECT ID,Geo_Location__Latitude__s,Geo_Location__Longitude__s FROM AP_Visits__r) FROM Account WHERE Id IN: accSet]);
        for(AP_Site_Visit__c apsv: siteVisitList){
            if((apsv.Geo_Location__Latitude__s != NULL || apsv.Geo_Location__Latitude__s != 0)  && (apsv.Geo_Location__Longitude__s != NULL || apsv.Geo_Location__Longitude__s != 0) && apsv.Party_Name__c != NULL){
                Account accnt = apMap.get(apsv.Party_Name__c);
                if((accnt.Geolocation__Latitude__s == NULL || accnt.Geolocation__Latitude__s == 0) && (accnt.Geolocation__Longitude__s == NULL || accnt.Geolocation__Longitude__s == 0)){           
                    accnt.Geolocation__Latitude__s = apsv.Geo_Location__Latitude__s;
                    accnt.Geolocation__Longitude__s = apsv.Geo_Location__Longitude__s;
                    accountSet.add(accnt);
                }
            }
        }
 if(!accountSet.isEmpty()){
     accList.addAll(accountSet);
            update accList;
        }
    }
    
    
    
    
    
    public static void toPopulateGeoInAccount(List<AP_Site_Visit__c> siteVisitList,map<id,AP_Site_Visit__c> oldmap){
        Map<ID,Account> apMap = new Map<ID,Account>();
        Set<Id> accSet = new Set<Id>();
        set<Account> accList = new set<Account>();
        for(AP_Site_Visit__c ap : siteVisitList){
            if((ap.Actual_Created_Date__c!=oldmap.get(ap.id).Actual_Created_Date__c) ||  (ap.Actual_LastModified_Date__c!=oldmap.get(ap.id).Actual_LastModified_Date__c)){
                
            }else{
                accSet.add(ap.Party_Name__c);
            }
            
        }
        
        if(!accSet.isempty()){
                //apMap = new Map<ID,Account>([SELECT ID,Geolocation__Latitude__s,Geolocation__Longitude__s,(SELECT ID,Geo_Location__Latitude__s,Geo_Location__Longitude__s FROM AP_Visits__r) FROM Account WHERE Id IN: accSet]);
            for(Account acc:[SELECT ID,Geolocation__Latitude__s,Geolocation__Longitude__s,(SELECT ID,Geo_Location__Latitude__s,Geo_Location__Longitude__s FROM AP_Visits__r) FROM Account WHERE Id IN: accSet ]){
  				apMap.put(acc.Id,acc);              
            } 
            } 
            for(AP_Site_Visit__c ap2 : siteVisitList){
                if((ap2.Geo_Location__Latitude__s != NULL || ap2.Geo_Location__Latitude__s != 0)  && (ap2.Geo_Location__Longitude__s != NULL || ap2.Geo_Location__Longitude__s != 0) && ap2.Party_Name__c != NULL){
                    Account accnt = apMap.get(ap2.Party_Name__c);
                    if(accnt!=null){
                        if((accnt.Geolocation__Latitude__s == NULL || accnt.Geolocation__Latitude__s == 0) && (accnt.Geolocation__Longitude__s == NULL || accnt.Geolocation__Longitude__s == 0)){           
                            accnt.Geolocation__Latitude__s = ap2.Geo_Location__Latitude__s;
                            accnt.Geolocation__Longitude__s = ap2.Geo_Location__Longitude__s;
                            accList.add(accnt);
                        }
                    }
                }
            }
             
            
            
           list<account>  acclistupdate = new list<account>();
        acclistupdate.addAll(accList);
        if(!acclistupdate.isEmpty()){
            update acclistupdate;
        }
        }
    //accSet.add(ap.Party_Name__c);
    
    
    
}//end of toPopulateGeoInAccount