global class NpsCheckBatch implements Database.Batchable<Sobject> {
    // Start method
    global Database.QueryLocator start(Database.BatchableContext BaCon) {
        return Database.getQueryLocator([SELECT Id, Name, NpsTagged__c From Account WHERE NpsTagged__c = true]);
    }
    
    global void execute(Database.BatchableContext BaCon, List<Account> accList) {   
        try {
            System.debug('accList occured: ' + accList);
            for(Account acc : accList) {
                acc.NpsTagged__c = false;
            }
            System.debug('accList after change: ' + accList);
            Update accList;
        }
        catch(DmlException ex) {
            System.debug('Exception occured: ' + ex);
        }
        
    }
    
    global void finish(Database.BatchableContext BaCon) {
        
    }
    
}