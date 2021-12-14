trigger LockOpportunityProducts on OpportunityLineItem (before insert, before update,After Insert,After Update) {
    
    
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){

        Map<Id,List<Id>> opptoOLIMap = new Map<Id,List<Id>>();
        Set<Id> oppSet = new Set<Id>();
        for(OpportunityLineItem oLI : Trigger.new) {
            List<Id> oLIIdList;
            if(!opptoOLIMap.containsKey(oLI.OpportunityId)) {
                oLIIdList = new List<Id>();
                oLIIdList.add(oLI.Id);
                opptoOLIMap.put(oLI.OpportunityId, oLIIdList);   
            }
            else {
                opptoOLIMap.get(oLI.OpportunityId).add(oLI.Id);    
            }   
            oppSet.add(oLI.OpportunityId);
            
        }
        Map<Id,ProcessInstance> processInstanceMap = new Map<Id, ProcessInstance>([Select Id, TargetObjectId From ProcessInstance WHERE TargetObjectId IN: oppSet  
        AND Status = 'Pending']);
        System.debug('$$processInstanceMap '+processInstanceMap );
        for(ProcessInstance pI : processInstanceMap.values()) {
            for(Id oLId : opptoOLIMap.get(pI.TargetObjectId)) {
                OpportunityLineItem tempOLI = new OpportunityLineItem();
                tempOLI.Id = oLId;
                tempOLI.addError('Update Not allowed while the Project is in Pending Status');  
            }     
        }
    
    //Set<Id> opportunityIdSet = ([Select Id From ProcessInstance WHERE TargetObjectId =: caseId AND Status = 'Pending']);
    //Trigger.newMap.get(oLId).addError('Update Not allowed while the Project is in Pending Status'); 

    } 
    
    /* Numaan Code */
    /*--Instantiate the handler--*/
    OpportunityLineItemHandler handler = OpportunityLineItemHandler.getInstance();
    

    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter && CommonUtility2.check == true){
        
        CommonUtility2.check = false;
        handler.calculateAvgDisc(Trigger.new);
    }

}