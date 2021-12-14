global class MyBatchClassToUpdateOLI implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        string status='Approved';
        return Database.getQueryLocator('SELECT id,Special_Pricing_Request_Approval__c,( SELECT id,checked_if_approved__c  FROM OpportunityLineItems)FROM Opportunity where Special_Pricing_Request_Approval__c=:status');
    }

    global void execute(Database.BatchableContext bc, List<opportunity> opp){
        // process each batch of records
        List<opportunityLineItem> oliList=new List<opportunityLineItem>();
            for(Opportunity o:Opp){
            system.debug('opportunity'+o);
                for(OpportunityLineItem oli:o.OpportunityLineItems){
                    system.debug('OLi'+oli);
                    oli.checked_if_approved__c=true;
                    oliList.add(oli);
                    system.debug('after changing'+oli);
                }
            }
            update oliList;
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    

}