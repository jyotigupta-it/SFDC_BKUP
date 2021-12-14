/*<!--++----------------------------------------------------------------------
||        Author      :  Krishnareddy
||
||        Purpose     :  Before Update - Populating Expense visitType value in TourPlan Visit Type for Reporting Purpose.
||                       After Update  - Rollup Summary of Retailing VisitType(Head Quarter - Metro, Head Quarter-State Capital, Head Quarter, Ex-Station, Out-Station) from TourPlan to Target object.
||                  
||        Created By  :  26/07/2015 / Krishna
||
++----------------------------------------------------------------------- -->*/

trigger Update_Rollup_ApplTarget on AP_Tour_Plan__c (before update, after update, after insert) {
    
    public static Update_Rollup_ApplTarget_Handler handler = Update_Rollup_ApplTarget_Handler.getInstance();
    System.debug('Update_Rollup_ApplTarget_Helper.isTarget'+Update_Rollup_ApplTarget_Helper.isTarget);
    
    if(trigger.isUpdate) {
        
        if(trigger.isBefore && Update_Rollup_ApplTarget_Helper.isTarget) {
            handler.populateVisitType(trigger.new);
        } 
        
        if(trigger.isAfter && Update_Rollup_ApplTarget_Helper.isTarget) {
            handler.update_Retail_RollupSumarries_Target(trigger.new);
            //Updated By Chakresh
            handler.updateVisitsBeforeApproved(Trigger.new,Trigger.oldMap);
         	handler.updateVisitsAfterApproved(Trigger.new,Trigger.oldMap);
            
        }  
    }
    
    //Updated By Chakresh
    if(Trigger.isInsert && Trigger.isAfter){
        handler.createVisits(Trigger.new,Trigger.oldMap);
    }
}