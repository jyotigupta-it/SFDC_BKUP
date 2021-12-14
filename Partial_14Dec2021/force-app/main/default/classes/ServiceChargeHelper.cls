public class ServiceChargeHelper {
    public static void updateWorkorderDetails(Map<id,Service_Charge__c> mapOfservice){
       
        Set<Id> setOfCaseId=new Set<Id>();
        Set<Id> setOfContractor=new Set<Id>();
        List<WorkOrder> listOfWorkOrders = new List<WorkOrder>();
        Map<id,ServiceAppointment> mapOfServiceAppointment=new Map<id,ServiceAppointment>();
  
        Map<id,WorkOrder> mapOfWorkOrder=new Map<id,WorkOrder>();
        Map<id,id> mapOfContractorWithId =new Map<id,id>();
        Map<id,Case> mapOfCase=new Map<id,Case>();
        List<Case> listOfCase =new List<Case>();
        
        List<ServiceAppointment> listOfServiceAppointment=new  List<ServiceAppointment>();
        
        listOfWorkOrders=[Select id,OwnerId,CaseId,Case.Account.Name,Case.Account.Town_Name__r.Name from WorkOrder where id in:mapOfservice.keyset() ];
        if(!listOfWorkOrders.isEmpty()){
            for(WorkOrder cse:listOfWorkOrders){
                mapOfContractorWithId.put(cse.OwnerId,cse.id);
                mapOfWorkOrder.put(cse.id,cse);
                if(cse.OwnerId !=null){
                    setOfContractor.add(cse.OwnerId);
                }
                if(cse.CaseId !=null){
                    setOfCaseId.add(cse.CaseId);
                }
            }
            
        }
        
        listOfCase=[select id,Account.Name,Contractor__c from Case where id in:setOfCaseId];
       
     
        listOfServiceAppointment=[Select id,ParentRecordId,Owner.Name from ServiceAppointment where ParentRecordId in:mapOfservice.keyset()];
        if(!listOfServiceAppointment.isEmpty()){
        for(ServiceAppointment sa:listOfServiceAppointment){
            mapOfServiceAppointment.put(sa.ParentRecordId,sa);
        }}
        
        if(!listOfCase.isEmpty()){
            for(Case cs:listOfCase){
                mapOfCase.put(cs.id,cs);
            }
        }
        
        for(id workid:mapOfservice.keyset()){
           Service_Charge__c sc=mapOfservice.get(workid);
            sc.Plumber__c=mapOfServiceAppointment.get(workid).Owner.Name;
            
            sc.Location_Name__c=mapOfWorkOrder.get(workid).Case.Account.Town_Name__r.Name;
            
           sc.Customer_Name__c=mapOfWorkOrder.get(workid).Case.Account.Name;
            
           
        }  
        
    }

}