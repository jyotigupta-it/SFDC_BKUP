trigger ChangeOrderOwner on Opportunity (after update) {
 List<opportunity> updateList=new List<Opportunity>();
            Map<id,id>  oppID=new Map<id,id>();
         Map<id,id>  oppOldID=new Map<id,id>();
    for(opportunity op1:Trigger.old){
         oppOldID.put(op1.id,op1.ownerid);
            
        }
        for(opportunity op:Trigger.New){
             oppID.put(op.id,op.ownerid);
            if(oppOldID.get(op.id)!=oppID.get(op.id)){
                updateList.add(op);
            }

}
 changingOrderOwner.changeOrderOwner(updateList);
 }