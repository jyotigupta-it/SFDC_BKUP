public class ServiceChargeHandler {
    public static void onAfterInsert(List<Service_Charge__c> listOfService){
        Map<Id,Service_Charge__c> mapOfServiceWithWorkorder=new Map<Id,Service_Charge__c>();
        for(Service_Charge__c ser:listOfService){
            if(ser.Work_Order__c!=null){
               mapOfServiceWithWorkorder.put(ser.Work_Order__c,ser) ;
            }
        }
        If(!mapOfServiceWithWorkorder.isEmpty()){
           ServiceChargeHelper.updateWorkorderDetails(mapOfServiceWithWorkorder) ;
        }
    }

}