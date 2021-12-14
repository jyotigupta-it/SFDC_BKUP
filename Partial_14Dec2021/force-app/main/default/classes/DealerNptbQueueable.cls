public class DealerNptbQueueable implements Queueable {
    public List<NPTB__c> dataWrapChunks;
    public DealerNptbQueueable(List<NPTB__c> dataWrapChunks) {  
        this.dataWrapChunks = dataWrapChunks;
    } 
    public void execute(QueueableContext context) {
        Database.UpsertResult[] accUpsertRes = Database.Upsert(dataWrapChunks,false);
    }
}