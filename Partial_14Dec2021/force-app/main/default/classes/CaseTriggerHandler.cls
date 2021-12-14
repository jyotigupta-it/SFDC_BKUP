public class CaseTriggerHandler {
    
    public static void onAfterInsert(Map<Id,Case> mapOfCases){
        Map<Id,Case> mapOfProductComplaintCases = new Map<Id,Case>();
        Map<Id,Case> mapOfProductComplaintCasesToCreateProducts = new Map<Id,Case>();
        List<WorkOrder> ListOfWorkOrder = new List<WorkOrder>();
        Map<Id,Case> mapOfProductComplaint = new Map<Id,Case>();
        ListOfWorkOrder =[select id,CaseId,Status from WorkOrder where CaseId in:mapOfCases.keyset()];
        Map<Id,WorkOrder> mapOfWorkOrderWithCaseId = new Map<Id,WorkOrder>();
        for(WorkOrder wo : ListOfWorkOrder){
            mapOfWorkOrderWithCaseId.put(wo.CaseId,wo);
            
        }
        
        
        for(Case eachCase : mapOfCases.values() ){
            if(eachCase.RecordTypeId == CaseConstants.PRODUCT_COMPLAINT_RT_ID && eachCase.Create_WorkOrder__c == true){
                mapOfProductComplaintCases.put(eachcase.Id ,eachCase);
            }
            if(eachCase.RecordTypeId == CaseConstants.PRODUCT_COMPLAINT_RT_ID){
                mapOfProductComplaintCasesToCreateProducts.put(eachcase.Id ,eachCase);
                mapOfProductComplaint.put(eachcase.Id ,eachCase);
            }
            if(eachCase.RecordTypeId == CaseConstants.PRODUCT_COMPLAINT_RT_ID && (eachCase.Status=='Work Order Acceptance Pending')){
                //mapOfProductComplaint.put(eachcase.Id ,eachCase);
            }
            
            
            
        }
        
        if(!mapOfProductComplaint.isEmpty()){
            System.debug('Case Trigger after update handler');
            SMSLogService.generateSMSContentForCase(mapOfProductComplaint);
        }
        if(!mapOfProductComplaintCases.isEmpty()){
            System.debug('Case Trigger after insert handler');
            CaseTriggerHelper.createWorkOrderForCase(mapOfProductComplaintCases);
        }
        if(!mapOfProductComplaintCasesToCreateProducts.isEmpty()){
            System.debug('Case Trigger after insert handler');
            CaseTriggerHelper.createCaseProducts(mapOfProductComplaintCasesToCreateProducts);
        }
        if(!mapOfCases.isEmpty()){
       // CaseTriggerHelper.CityMapping(mapOfCases);
        }
    }
    public static void onBeforeInsert(List<Case> listOfCases){
        Map<Id,Case> mapOfTerritoryContractor = new Map<Id,Case>();
        List<id> listOfServiceTerritory=new List<id>();
        System.debug('entering into case for loop'+listOfCases);
        List<Entitlement> listOfEntitlementProcess = [Select Id from Entitlement where Name = :'Case Process'];
        for(Case eachCase : listOfCases){
            
            //if(eachCase.Service_Territory__c !=null ){
            mapOfTerritoryContractor.put(eachcase.Id ,eachCase);
            listOfServiceTerritory.add(eachcase.Service_Territory__c);
            // }
            eachCase.closure_code__c = String.valueOf(Math.round((Math.random() * (900000) + 100000)));
            if(!listOfEntitlementProcess.isEmpty())
            eachCase.EntitlementId = listOfEntitlementProcess[0].Id;
            
        }
        if(!mapOfTerritoryContractor.isEmpty() && !listOfServiceTerritory.isEmpty()){
            System.debug('Case Trigger before insert handler');
            // CaseTriggerHelper.validationAndAssignmentForTerritoryContractor(mapOfTerritoryContractor,listOfServiceTerritory);
        }
        if(!listOfCases.isEmpty()){
            System.debug('asdfgh');
            CaseTriggerHelper.CityMapping(listOfCases);
        }
       // CaseTriggerHelper.ServiceExtenalIdMapping(mapOfTerritoryContractor);
    }
    public static void onBeforeUpdate(Map<id,Case> MapOfOldCases,Map<id,Case> MapOfNewCases){
        Map<Id,Case> mapOfTerritoryContractor = new Map<Id,Case>();
        Map<Id,Case> mapOfCaseClosed =new Map<Id,Case>();
        Map<Id,Case> mapOfIsComplaintResolved=new  Map<Id,Case>();
        List<id> listOfServiceTerritory=new List<id>();
        for(Case eachCase : MapOfNewCases.values()){
            
            if((eachCase.Service_Territory__c != MapOfOldCases.get(eachCase.id).Service_Territory__c && eachCase.Service_Territory__c !=null)){
                mapOfTerritoryContractor.put(eachcase.Id ,eachCase);
                listOfServiceTerritory.add(eachcase.Service_Territory__c);
            }
            if((eachCase.Status =='Closed' ||eachCase.Status =='resolved') && eachCase.Status!=MapOfOldCases.get(eachCase.id).Status && eachCase.Status!=null  ){
                mapOfCaseClosed.put(eachcase.Id ,eachCase);
            }
            if(eachCase.status == 'Closed' && eachCase.Closed_Reason__c == 'Problem Resolved'){
               // eachcase.status = 'Resolved';
             //   eachCase.Closed_Reason__c = '';
            }
            //if((eachCase.Status =='Closed' ||eachCase.Status =='resolved') && eachCase.Is_your_complaint__c=='No' && eachCase.Status!=MapOfOldCases.get(eachCase.id).Status && eachCase.Status!=null){
               if(eachCase.Status =='Open'  && eachCase.Is_your_complaint__c=='No' && eachCase.Status!=MapOfOldCases.get(eachCase.id).Status && eachCase.Status!=null){ 
            mapOfIsComplaintResolved.put(eachCase.Id,eachCase);
            }
        }
        if(!mapOfTerritoryContractor.isEmpty() && !listOfServiceTerritory.isEmpty()){
            System.debug('Case Trigger before insert handler');
            CaseTriggerHelper.validationAndAssignmentForTerritoryContractor(mapOfTerritoryContractor,listOfServiceTerritory);
        }
        if(!mapOfCaseClosed.isEmpty()){
            CaseTriggerHelper.validationForCaseClosed(mapOfCaseClosed);
        }
        if(!mapOfIsComplaintResolved.isEmpty()){
            CaseTriggerHelper.caseStatusIsReopen(mapOfIsComplaintResolved);
            
        }
    }
    public static void onAfterUpdate(Map<id,Case> MapOfOldCases,Map<id,Case> MapOfNewCases){
        Map<Id,Case> mapOfCases = new Map<Id,Case>();
        Map<Id,Case> mapOfClosedCases = new Map<Id,Case>();
        Map<Id,Case> mapOfClosCases = new Map<Id,Case>();
        Map<Id,Case> mapOfResumedCases = new Map<Id,Case>();
        Map<Id,Case> mapOfReOpenedCases = new Map<Id,Case>();
        Map<Id,Case> mapOfResolvedCases = new Map<Id,Case>();
        Map<Id,Case> mapOfOnHoldCases = new Map<Id,Case>();
        Map<Id,Case> mapOfProductComplaint = new Map<Id,Case>();
        for(Case eachCase : MapOfNewCases.values()){
            if((eachCase.Service_Territory__c !=MapOfOldCases.get(eachCase.id).Service_Territory__c && eachCase.Service_Territory__c !=null)||(eachCase.Contractor__c !=MapOfOldCases.get(eachCase.id).Contractor__c && eachCase.Contractor__c !=null) ||(eachCase.OwnerId !=MapOfOldCases.get(eachCase.id).OwnerId && eachCase.OwnerId !=null)){
                mapOfCases.put(eachcase.Id,eachCase);
            }
            if(eachCase.status != null && eachCase.status != MapOfOldCases.get(eachCase.Id).status && eachCase.status == 'Closed' && eachCase.Closed_Reason__c == 'Customer Not Available'){
                mapOfClosedCases.put(eachCase.Id, eachCase);
            }
             if(eachCase.status != null && eachCase.status != MapOfOldCases.get(eachCase.Id).status && eachCase.status == 'Closed'){
                mapOfClosCases.put(eachCase.Id, eachCase);
            }
            if(eachCase.status != null && eachCase.status != MapOfOldCases.get(eachCase.Id).status && eachCase.status == 'Resolved'){
                mapOfResolvedCases.put(eachCase.Id, eachCase);
            }
            if(eachCase.status != null && eachCase.status == 'Work Order Accepted' && MapOfOldCases.get(eachCase.Id).status == 'On Hold'){
                mapOfResumedCases.put(eachCase.Id, eachcase);
            }
            if(eachCase.status != null && eachCase.status == 'Re-Open' && MapOfOldCases.get(eachCase.Id).status != eachCase.Status){
                mapOfReOpenedCases.put(eachCase.Id, eachcase);
            }
            if(eachCase.status != null && eachCase.status == 'On Hold' && MapOfOldCases.get(eachCase.Id).status != eachCase.Status){
                mapOfOnHoldCases.put(eachCase.Id, eachcase);
            }
            if(eachCase.RecordTypeId == CaseConstants.PRODUCT_COMPLAINT_RT_ID && (eachCase.Status=='Work Order Acceptance Pending')){
                mapOfProductComplaint.put(eachcase.Id ,eachCase);
            }
            
        }
        if(!mapOfClosCases.isEmpty()){
            CaseTriggerHelper.createServiceCharges(mapOfClosCases);
        }
        if(!mapOfProductComplaint.isEmpty()){
            System.debug('Case Trigger after update handler');
            //SMSLogService.generateSMSContentForCase(mapOfProductComplaint);
        }
        
        if(!mapOfCases.isEmpty()){
            System.debug('Case Trigger AFTER update handler');
            CaseTriggerHelper.updateWorkOrder(mapOfCases);
        }
        if(!mapOfClosedCases.isEmpty()){
            SMSLogService.generateSMSContentForCase(mapOfClosedCases);
        }
        if(!mapOfOnHoldCases.isEmpty()){
            SMSLogService.generateSMSContentForCase(mapOfOnHoldCases);
        }
        if(!mapOfResolvedCases.isEmpty()){
            SMSLogService.generateSMSContentForCase(mapOfResolvedCases);
        }
        if(!mapOfResumedCases.isEmpty()){
            SMSLogService.generateSMSContentForCase(mapOfResumedCases);
        }
        if(!mapOfReOpenedCases.isEmpty()){
            SMSLogService.generateSMSContentForCase(mapOfReOpenedCases);
        }
        
    }
}