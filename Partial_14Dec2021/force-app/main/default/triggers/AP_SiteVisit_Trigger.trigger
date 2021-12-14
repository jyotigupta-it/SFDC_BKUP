trigger AP_SiteVisit_Trigger on AP_Site_Visit__c (before insert,before update,after insert, after update) {
    
    // Populate Vertical & Promotion Type; while Insert on Site Visit.
    if((trigger.isInsert || trigger.isUpdate) && (trigger.isBefore)) {
        for(AP_Site_Visit__c siteVisit : Trigger.New) {
            siteVisit.Vertical__c = siteVisit.Target_Vertical__c;
            siteVisit.Promotion_Type__c = siteVisit.Promotion_Party_Type__c;
        }
    }
    
    if((trigger.isInsert || trigger.isUpdate) && (trigger.isAfter)) {
        
        string visit_RecordTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        map<Id, Account> updateAccountList = new map<Id, Account>();
        
        for(AP_Site_Visit__c siteVisit : Trigger.new) {
            if(siteVisit.Party_Name__c!= null && siteVisit.RecordTypeId == visit_RecordTypeId) {
              Account acc = new Account(id=sitevisit.Party_Name__c, Latest_Visit_Date__c = sitevisit.Date__c);
                updateAccountList.put(sitevisit.Party_Name__c, acc);
            }
        }
        
        if(updateAccountList.size() > 0) {
        //list<Account> accountList = new list<account>();
        //accountList.addAll(updateAccountList);
            database.update(updateAccountList.values(), false);
    }
    }
}