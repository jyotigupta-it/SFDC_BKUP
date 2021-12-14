/*  
Author: Satyanarayana
Description : Before Update : Populating the recordtype based on the Approval Status field on the Target. 
                              which inturn modifies the pagelayout and hides the Create TourPlan & Visit entry Buttons.
              After Update : Change on the Approval Status in Target object; updates the Target related TourPlan Approval status. 

Modified : 1 - 25/6/2015 - Satyanarayana - Commented Task creation code, on submitting for Approval(Now using Standard Approval Process).
Date : 01/03/2015    */

//Trigger on Target object to update the approval Status of TourPlanobject.
trigger TargetTrigger on Target__c (before update, after update) {
    
     /*--Instantiate the handler--*/
    public TargetTriggerHandler handler = TargetTriggerHandler.getInstance();
    
    
    /* Before Update; Populating the recordtype based on the Approval Status field on the Target. 
               which inturn modifies the pagelayout and hides the Create TourPlan & Visit entry Buttons. */
    if(Trigger.isBefore && Trigger.isUpdate) {
        handler.onBeforeUpdate(Trigger.new, Trigger.newMap, Trigger.oldMap);
    }
    
    // After Update: Change on the Approval Status; updating the Target related TourPlan Approval status. 
    if(Trigger.isUpdate && Trigger.isAfter) {
        handler.onAfterUpdate(Trigger.new, Trigger.newMap, Trigger.oldMap);
    }   
}