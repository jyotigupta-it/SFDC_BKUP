/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :15-Jan-2015
Modified Date   :
Version         :1.0
Description     :Trigger to update Opportunity line item when ever a opportunity is approved.
Modified By: Rahul Mukherji/Subhajit Ghosh
********************XXX***********************************/
trigger Update_Opp_Records on Opportunity (Before Insert,Before Update,After Insert,After Update) {
    
     /*--Instantiate the handler--*/
    Update_Opp_Records_Handler handler = Update_Opp_Records_Handler.getInstance();
    
   String labelValue = Label.ActivateUpdateOppTriggerRevampLogic;
  system.debug('labelValue--'+labelValue);
    
    if(trigger.isAfter && trigger.isUpdate && CommonUtility.check == true) {
        
        CommonUtility.check = false;
        handler.onBeforeUpdate(Trigger.new,Trigger.newMap);
    }
     if(trigger.isbefore && (trigger.isInsert || trigger.IsUpdate)) {
       finalApproverUpdateFromOwner.finalapproverisnert(trigger.new);
     }
    if(trigger.isInsert && trigger.isAfter && labelValue.equalsIgnoreCase('Yes')){
        system.debug('trigger inside if block...after insert');
        NewOfferSectionDMLHandler.calcMatrixMap(trigger.newMap,'ProjectInsertion');
    }
    if(trigger.isUpdate && trigger.isAfter && labelValue.equalsIgnoreCase('Yes')){
        system.debug('trigger inside if block...after insert');
        NewOfferSectionDMLHandler.updateCalcMatrixData(trigger.oldmap,trigger.newMap);
        
    }
   
}