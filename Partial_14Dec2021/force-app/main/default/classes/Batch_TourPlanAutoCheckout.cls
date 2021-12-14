/*To be scheduled in evening for auto checkot the tour plans*/
global class Batch_TourPlanAutoCheckout implements Database.Batchable <SObject>,Database.Stateful{
    global Database.QueryLocator start(Database.BatchableContext bc) {
    	String query = 'SELECT Id,Login_Time__c,Logout_Time__c FROM AP_Tour_Plan__c WHERE Date__c = TODAY AND Logout_Time__c = null';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext bc,List<AP_Tour_Plan__c> tourPlanList) {
        for(AP_Tour_Plan__c tourPlanObj : tourPlanList){
            tourPlanObj.Logout_Time__c = System.now();
        }
        UPDATE tourPlanList;
    }
    global void finish(Database.BatchableContext bc){}
}