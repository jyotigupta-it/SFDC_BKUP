/* *******************************************************************
Created by : Srilakshmi
Description : To upsert churn data from sparsh
************************************************************************ */
global class DealerChurnAPIBatch implements Database.Batchable<Sobject>, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
                
        String query = 'SELECT Id FROM User LIMIT 1';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Object> scope)  {
         
        DealerChurnAPI.invoke();
    }
    
    global void finish(Database.BatchableContext BC)  {
        
        system.debug('Batch for Dealer Churn complete!');
    }
    
}