/*  
    Author: Satyanarayana
    Description : SMART KRA Controller : Generate SMART KRA Report for particular Month based on the User.
    Date : 06/07/2015    */

public  class APPL_SiteVisitTriggerHandler {
    
    public static APPL_SiteVisitTriggerHandler instance;
    map<Id, list<date>> mapofAPSiteVisit_UnChecked   =  new map<Id, list<date>>();
    map<Id, list<date>> mapofAPSiteVisit_Checked     =  new map<Id, list<date>>();
    map<Id, set<date>> mapofAPSiteVisit_Checked1     =  new map<Id, set<date>>();
    
    
    /*-- SINGLETON PATTERN --*/
    public static APPL_SiteVisitTriggerHandler getInstance() {
        
        if(instance == null) {
            instance = new APPL_SiteVisitTriggerHandler();
        }
        return instance;
    }
    
    //Before Insert; Populate Vertical & Promotion Type fields  & Make Single Visit Under Target as checked for the field "Retailing_Day__c.
    public void beforeInsert(list<AP_Site_Visit__c> newSiteVisit) {
    	
        string visit_RecordTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        set<id> visitIdSet = new set<id>();
        
        for(AP_Site_Visit__c SiteVisit : newSiteVisit) {
            
            SiteVisit.Vertical__c         =    SiteVisit.Target_Vertical__c;
            SiteVisit.Promotion_Type__c   =    SiteVisit.Promotion_Party_Type__c;
            SiteVisit.No_Of_Activities__c =    SiteVisit.No_Of_Activities_Dup__c;
            boolean flag  = true;
            
            if(mapofAPSiteVisit_UnChecked.containsKey(siteVisit.Target__c)) {
                for(Date d : mapofAPSiteVisit_UnChecked.get(siteVisit.Target__c)) {

                    if(d == siteVisit.Date__c && siteVisit.Date__c != null) {
                        flag = false;
                        break;
                    } 
                }
            }
            
            //Getting Checked Retailing days records for historical data of Site Visits. 
            if(siteVisit.Retailing_Day__c) {
            	if(mapofAPSiteVisit_Checked1.containsKey(siteVisit.Target__c)) {
                    mapofAPSiteVisit_Checked1.get(siteVisit.Target__c).add(siteVisit.Date__c);
                } else {
                    mapofAPSiteVisit_Checked1.put(siteVisit.Target__c, new set<date>());
                    mapofAPSiteVisit_Checked1.get(siteVisit.Target__c).add(siteVisit.Date__c);
                }
            }
            
             //Getting Un-Checked Retailing days records of Site Visits. 
            if(siteVisit.RecordTypeId == visit_RecordTypeId && !siteVisit.Retailing_Day__c && siteVisit.Date__c != null && flag) {
                visitIdSet.add(SiteVisit.Id);
                system.debug(visitIdSet);
                system.debug(visitIdSet.size());
                if(mapofAPSiteVisit_UnChecked.containsKey(siteVisit.Target__c)) {
                    mapofAPSiteVisit_UnChecked.get(siteVisit.Target__c).add(siteVisit.Date__c);
                } else {
                    mapofAPSiteVisit_UnChecked.put(siteVisit.Target__c, new list<date>());
                    mapofAPSiteVisit_UnChecked.get(siteVisit.Target__c).add(siteVisit.Date__c);
                }
            }
        }
        
       /* if(mapofAPSiteVisit_Checked1.size() > 0) {
        for(Id tId : mapofAPSiteVisit_Checked1.keySet()) {
        	set<Date> dateSet = new set<date>();
        	dateSet = mapofAPSiteVisit_Checked1.get(tId);
        	
        	if(mapofAPSiteVisit_UnChecked.containsKey(tId)) {
        		integer i = 0;
        	
        	for(Date d1 : mapofAPSiteVisit_UnChecked.get(tId)) {
        		if(dateSet.contains(d1)) {
        			//mapofAPSiteVisit_UnChecked.get(tId).remove(i);
        		}i++;
        	}
        	}
        }
        }*/
        
        //Getting Dates for Unchecked Site Visits.
        if(mapofAPSiteVisit_UnChecked.size() > 0) {
            set<Date> selectedDates = new set<Date>();
            for(list<Date> d : mapofAPSiteVisit_UnChecked.values()) {
                selectedDates.addAll(d);
            }
            
            //Populating the checked Dates by Querying from the DB.
            for(Target__c target : [select id, (select id, Date__c, Retailing_Day__c, Target__c from AP_Site_Visits__r where recordTypeId =: visit_RecordTypeId and Retailing_Day__c = true and Date__c IN: selectedDates and id NOT IN: visitIdSet order by id limit 1) from Target__c where id IN: mapofAPSiteVisit_UnChecked.keySet()]) {
                for(AP_Site_Visit__c siteVisit : target.AP_Site_Visits__r) {
                    system.debug(siteVisit+'siteVisit');
                    if(siteVisit.Retailing_Day__c) {
                        if(mapofAPSiteVisit_Checked.containsKey(siteVisit.Target__c)) {
                            mapofAPSiteVisit_Checked.get(siteVisit.Target__c).add(siteVisit.Date__c);
                        } else {
                            mapofAPSiteVisit_Checked.put(siteVisit.Target__c, new list<date>());
                            mapofAPSiteVisit_Checked.get(siteVisit.Target__c).add(siteVisit.Date__c);
                        }
                    }
                }
            }
        }
        
        //Removing the particular Date of Site Visit w.r.t. Target from the Unchecked Map, if that Date is found in Checked Map.
        if(mapofAPSiteVisit_Checked.size() > 0) {
            for(Id targetCheckedId : mapofAPSiteVisit_Checked.keySet()) {
                for(Date visitCheckedDate : mapofAPSiteVisit_Checked.get(targetCheckedId)) {
                    if(mapofAPSiteVisit_UnChecked.containsKey(targetCheckedId)) {
                        integer i = 0;
                        for(Date visitUnCheckedDate : mapofAPSiteVisit_UnChecked.get(targetCheckedId)) {
                            if(visitCheckedDate == visitUnCheckedDate) {
                                mapofAPSiteVisit_UnChecked.get(targetCheckedId).remove(i);
                            }i++;
                        }
                    }
                }
            }
        }
        
        //Final Map of Unchecked SiteVisits records for unique dates to tick the Retailing days field. 
        if(mapofAPSiteVisit_UnChecked.size() > 0) {
            for(AP_Site_Visit__c siteVisit : newSiteVisit) {
                if(mapofAPSiteVisit_UnChecked.containsKey(siteVisit.Target__c)) {
                    integer j = 0;
                    for(Date d : mapofAPSiteVisit_UnChecked.get(siteVisit.Target__c)) {
                        if(d == siteVisit.Date__c) {
                            siteVisit.Retailing_Day__c = true;
                            mapofAPSiteVisit_UnChecked.get(siteVisit.Target__c).remove(j);
                        }j++;
                    }
                }
            }
        }
    }
    
    
    //After Insert; Populating the Latest Visit Date to the Individual Contact(Account); using it in reports to track the Max. No. of Site Visits done. 
    public void afterInsert(list<AP_Site_Visit__c> newSiteVisit) {
        
        string visit_RecordTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        map<Id, Account> updateAccountList = new map<Id, Account>();
        
        for(AP_Site_Visit__c siteVisit : newSiteVisit) {
            
            if(siteVisit.Party_Name__c!= null && siteVisit.RecordTypeId == visit_RecordTypeId) {
                
                Account acc = new Account(id=sitevisit.Party_Name__c, Latest_Visit_Date__c = sitevisit.Date__c);
                updateAccountList.put(sitevisit.Party_Name__c, acc);
            }  
        }
        
        //Updating The Accounts.
        if(updateAccountList.size() > 0) {
            
            database.update(updateAccountList.values(), false);
        }  
    }   
}