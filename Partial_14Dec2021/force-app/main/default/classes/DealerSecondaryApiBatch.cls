/* *******************************************************************
Created by : Samarth Nadig
Description : To upsert Secondary Sales data from sparsh
************************************************************************  */
global class DealerSecondaryApiBatch implements Database.Batchable<Sobject>, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM User LIMIT 1';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Object> scope)  {
        DealerSecondaryApi.invoke();
    }
    
    global void finish(Database.BatchableContext BC)  {   
        system.debug('Batch for Dealer Secondary Sales complete!');
    }
    
}