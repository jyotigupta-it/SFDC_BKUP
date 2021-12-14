trigger SmsOnTourPlan on AP_Tour_Plan__c (After insert) {
    List<AP_Tour_Plan__c> filteredList=new List<AP_Tour_Plan__c>();
    for(AP_Tour_Plan__c obj:Trigger.new){
        if(obj.Promotional_Type__c!=null && obj.Account_Contact_Number__c!=null){
            filteredList.add(obj);
        }
    }
 SMSonTourPLANCreation.smsSend(filteredList);
}