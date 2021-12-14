public class CaseProductsTriggerHandler {

    public static void afterInsert(Map<Id,Case_Products__c> mapOfCaseProducts){
        CaseProductsTriggerHelper.createWorkOrderLineItems(mapOfCaseProducts);
        CaseProductsTriggerHelper.changeStatusOfWorkOrder(mapOfCaseProducts);
        
    }
    public static void beforeInsert(List<Case_Products__c> listCaseProducts){
        if(!listCaseProducts.isEmpty()){
        CaseProductsTriggerHelper.caseProductDuplicateValidation(listCaseProducts);
        }}
     //public static void beforeUpdate(List<Case_Products__c> listCaseProducts){
       // CaseProductsTriggerHelper.caseProductDuplicateValidation(listCaseProducts);
    //}
    
     
}