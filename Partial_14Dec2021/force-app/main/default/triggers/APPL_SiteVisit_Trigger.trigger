/*  
    Author: Satyanarayana
    Description : SMART KRA Controller : Generate SMART KRA Report for particular Month based on the User.
    Date : 06/07/2015    */
trigger APPL_SiteVisit_Trigger on AP_Site_Visit__c (before insert,after insert) {
    
    public APPL_SiteVisitTriggerHandler handler = APPL_SiteVisitTriggerHandler.getInstance();
    
    // Populate Vertical & Promotion Type; while Insert on Site Visit.
    if((trigger.isInsert || trigger.isUpdate) && (trigger.isBefore)) {
        
        handler.beforeInsert(trigger.new);
    }
    
    if((trigger.isInsert || trigger.isUpdate) && (trigger.isAfter)) {
        
        handler.afterInsert(trigger.new);
    }
}