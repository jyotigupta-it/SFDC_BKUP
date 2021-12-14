global class TransactionEscalationBatch implements Database.Batchable<sobject> {
    global Database.Querylocator start(Database.BatchableContext Bc){
        String query = 'SELECT Id,CreatedDate, ParentId, Field, OldValue, NewValue FROM Transaction__History WHERE Field = \'Status__c\'';
        RETURN Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc, List<Transaction__History> transHistryList){
        Integer dayDiff;
        for(Transaction__History transHistObj : transHistryList){
            if(transHistObj.NewValue == 'PENDING'){
                dayDiff = 0;
                DateTime histCrDate = transHistObj.CreatedDate;
                dayDiff = System.today().daysBetween(Date.newInstance(histCrDate.year(),histCrDate.month(),histCrDate.day()));
                System.debug(dayDiff);
                if(dayDiff == 0){
                    TransactionEscalation.toSendEmail(transHistObj.ParentId);
                }
            }
        }
    }
    global void finish(Database.BatchableContext bc){}
}