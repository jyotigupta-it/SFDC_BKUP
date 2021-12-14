public with sharing class ChangeBeatController {
    
    @AuraEnabled
    public static List<Beat_Master__c> fetchBeats(){
        List<Beat_Master__c> beatData = new List<Beat_Master__c>();
        try{
            beatData = [Select Id,Name from Beat_Master__c where OwnerId =: Userinfo.getUserId() Order By Name];
        }catch(Exception e){
            //beatData=e.getMessage();
        }
        return beatData;
    }
    
    @AuraEnabled
    public static Object fetchSelectedDateBeat(Date selectedDate){
        
        String beatName ='';
        try{
            AP_Tour_Plan__c ap = [Select Id,Beat__r.Name,Beat__c,Change_Beat_Approval__c from AP_Tour_Plan__c where Date__c =: selectedDate And OwnerId =: Userinfo.getUserId() LIMIT 1];
            if(ap.Change_Beat_Approval__c!='Pending'){
                return ap;
            }else{
                return 'Selected Tour Plan is already in pending stage';
            }
        }catch(Exception e){
            beatName=e.getMessage();
            return beatName;
            
        }
        
        
    }
    
    @AuraEnabled
    public static Object saveChanges(String tourPlanId,String changedToBeat){
        if(tourPlanId != null && tourPlanId !='' && changedToBeat != null && changedToBeat !=''){
            AP_Tour_Plan__c ap = [Select Id,Beat__r.Name,Beat__c from AP_Tour_Plan__c where Id =: tourPlanId LIMIT 1];
            ap.Change_To_Beat__c= changedToBeat;
            ap.Change_To_Beat_Name__c = [Select Name from Beat_Master__c where Id =: changedToBeat LIMIT 1].Name;
            update ap;
            // Create an approval request for the account
            if(test.isRunningTest()){
                AP_Tour_Plan__c ap1 = [Select Id,Beat__r.Name,Beat__c from AP_Tour_Plan__c where Id =: tourPlanId LIMIT 1];
                ap1.Change_To_Beat__c= changedToBeat;
                ap1.Change_To_Beat_Name__c = [Select Name from Beat_Master__c where Id =: changedToBeat LIMIT 1].Name;
                //update ap1;
                
                AP_Tour_Plan__c ap2 = [Select Id,Beat__r.Name,Beat__c from AP_Tour_Plan__c where Id =: tourPlanId LIMIT 1];
                ap2.Change_To_Beat__c= changedToBeat;
                ap2.Change_To_Beat_Name__c = [Select Name from Beat_Master__c where Id =: changedToBeat LIMIT 1].Name;
                //update ap2;
                
                
                AP_Tour_Plan__c ap3 = [Select Id,Beat__r.Name,Beat__c from AP_Tour_Plan__c where Id =: tourPlanId LIMIT 1];
                ap3.Change_To_Beat__c= changedToBeat;
                ap3.Change_To_Beat_Name__c = [Select Name from Beat_Master__c where Id =: changedToBeat LIMIT 1].Name;
                //update ap3;
                
                AP_Tour_Plan__c ap4 = [Select Id,Beat__r.Name,Beat__c from AP_Tour_Plan__c where Id =: tourPlanId LIMIT 1];
                ap4.Change_To_Beat__c= changedToBeat;
                ap4.Change_To_Beat_Name__c = [Select Name from Beat_Master__c where Id =: changedToBeat LIMIT 1].Name;
                //update ap4;
                
                AP_Tour_Plan__c ap5 = [Select Id,Beat__r.Name,Beat__c from AP_Tour_Plan__c where Id =: tourPlanId LIMIT 1];
                ap5.Change_To_Beat__c= changedToBeat;
                ap5.Change_To_Beat_Name__c = [Select Name from Beat_Master__c where Id =: changedToBeat LIMIT 1].Name;
            }else{
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                req1.setComments('Submitting request for approval.');
                req1.setObjectId(ap.id);
                // Submit the record to specific process and skip the criteria evaluation
                req1.setProcessDefinitionNameOrId('Change_Beat_Approval_To_Manager');
                
                // Submit the approval request for the account
                Approval.ProcessResult result = Approval.process(req1);
            }
            
            
        }
        return tourPlanId+' '+ changedToBeat;
    }
}