global class DealerNptbChunkBatch implements Database.Batchable<Sobject> {
	
    global final List<NPTB__c> dataWrapChunks; 

    global DealerNptbChunkBatch(List<NPTB__c> dataChunks){
        
        dataWrapChunks = dataChunks;
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
                
        String query = 'SELECT Id FROM User LIMIT 1';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Object> scope)  {
        
        Database.UpsertResult[] accUpsertRes = Database.Upsert(dataWrapChunks,false);     
        system.debug('dataWrapChunks:'+dataWrapChunks.size());
    }
    
    global void finish(Database.BatchableContext BC)  {
        
        system.debug('Batch for Dealer Churn complete!');
    }
}