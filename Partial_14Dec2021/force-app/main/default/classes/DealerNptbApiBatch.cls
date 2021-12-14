/* *******************************************************************
Created by : Samarth Nadig
Description : To upsert NPTB data from sparsh
************************************************************************ */
global class DealerNptbApiBatch implements Database.Batchable<Sobject>, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
                
        String query = 'SELECT Id FROM User LIMIT 1';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Object> scope)  {
        
    }
    
    global void finish(Database.BatchableContext BC)  {
        
        DealerNptbApi2 dna = new DealerNptbApi2(); 
        dna.invoke();
        system.debug('Batch for Dealer Churn complete!');
    }
    
}