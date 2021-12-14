public class CaseProductsTriggerHelper {

    public static void createWorkOrderLineItems(Map<Id,Case_Products__c> mapOfCaseProducts){
        Map<Id,Case_Products__c> mapOfCaseProductsQuery = new Map<Id,Case_Products__c>([Select Id,Problem__r.Work_Type__c,Product__c,Problem__c,Quantity__c from Case_Products__c where Id in: mapOfCaseProducts.keySet()]);
        Map<Id,Case_Products__c> mapOfCaseIdToCaseProduct = new Map<Id,Case_Products__c>();
        List<WorkOrderLineItem> lisOfWorkOrderLineItemsToInsert= new List<WorkOrderLineItem>();
        Set<Id> setOfCaseIds = new Set<Id>();
        for(Case_Products__c cp : mapOfCaseProducts.values()){
            mapOfCaseIdToCaseProduct.put(cp.Case__c, cp);
            setOfCaseIds.add(cp.Case__c);
        }
        List<WorkOrder> listOfWorkOrders = [Select Id,caseId from WorkOrder where CaseId in :setOfCaseIds];
        for(WorkOrder wo: listOfWorkOrders){
            WorkOrderLineItem woli = new WorkOrderLineItem();
            woli.Product_Family__c = mapOfCaseIdToCaseProduct.get(wo.caseId).Product_Family__c;
            woli.Problem__c = mapOfCaseIdToCaseProduct.get(wo.caseId).Problem__c;
            woli.Quantity__c = mapOfCaseIdToCaseProduct.get(wo.caseId).Quantity__c;
            woli.WorkOrderId = wo.Id;
            woli.WorkTypeId = mapOfCaseIdToCaseProduct.get(wo.caseId).Problem__r.Work_Type__c;
            lisOfWorkOrderLineItemsToInsert.add(woli);
            }
        if(!lisOfWorkOrderLineItemsToInsert.isEmpty()){
            insert lisOfWorkOrderLineItemsToInsert;
        }
        
    }
    public static void changeStatusOfWorkOrder(Map<Id,Case_Products__c> mapOfCaseProducts){
        Set<Id> setOfCaseIds = new Set<Id>();
        for(Case_Products__c cp : mapOfCaseProducts.values()){
            setOfCaseIds.add(cp.Case__c);
        }
        List<WorkOrder> listOfWorkOrders=[Select Id from WorkOrder where CaseId in: setOfCaseIds and status = 'New'];
        for(WorkOrder wo: listOfWorkOrders){
            wo.status = 'Acceptance Pending';
        }
        if(!listOfWorkOrders.isEmpty()){
            update listOfWorkOrders;
        }
    }
    public static void caseProductDuplicateValidation(List<Case_Products__c> listOfCaseProducts){
        Map<Id,List<Case_Products__c>> mapOfCaseIdToCaseProduct = new Map<Id,List<Case_Products__c>>();
        Set<Id> setOfCaseIds = new Set<Id>();
        if(!listOfCaseProducts.isEmpty()){
        for(Case_Products__c cp : listOfCaseProducts){
            setOfCaseIds.add(cp.Case__c);
        }}
        List<Case_Products__c> listOfCaseProduct=new List<Case_Products__c >([select id,Product_Family__c,Problem__c,Case__c from Case_Products__c
                                                                              where Case__c in: setOfCaseIds]);
        system.debug('listOfCaseProduct'+listOfCaseProduct);
        system.debug('listOfCaseProduct'+listOfCaseProduct.size());
        if(listOfCaseProduct.size()>=1){
        for(Case_Products__c cp:listOfCaseProduct) {
            System.debug('inside for loop');
           if(mapOfCaseIdToCaseProduct.containsKey(cp.Case__c))
                mapOfCaseIdToCaseProduct.get(cp.Case__c).add(cp);
            else
                mapOfCaseIdToCaseProduct.put(cp.Case__c, new List<Case_Products__c>{cp});
        }
        system.debug('mapOfCaseIdToCaseProduct'+mapOfCaseIdToCaseProduct.values());
        
        for(Case_Products__c casep:listOfCaseProducts){
            System.debug('inside for loop');
            List<Case_Products__c> lcp=mapOfCaseIdToCaseProduct.get(casep.Case__c);
            System.debug('lcp'+lcp.size());
            for(Case_Products__c c:lcp){
                System.debug('inside for loop');

                if( c.Product_Family__c==casep.Product_Family__c && c.Problem__c==casep.Problem__c){
                    casep.addError('Case Product already exist ');
                }
            }
        }
        } }
}