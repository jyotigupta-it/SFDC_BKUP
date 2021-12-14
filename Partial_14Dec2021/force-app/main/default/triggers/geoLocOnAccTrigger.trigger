trigger geoLocOnAccTrigger on AP_Site_Visit__c (after insert, after update) {
   
    if(trigger.isAfter && trigger.isInsert ){
        GeoLocationInAccount.toPopulateGeoinsert(trigger.new);
    }
     if(trigger.isAfter &&  trigger.isUpdate){
        GeoLocationInAccount.toPopulateGeoInAccount(trigger.new,trigger.oldmap);
    }
}