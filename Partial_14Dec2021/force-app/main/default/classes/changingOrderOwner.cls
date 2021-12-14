public without sharing class changingOrderOwner {

    public static void changeOrderOwner(List<Opportunity> oppList){
        system.debug('oppList'+oppList);
    try{
        List<Order>ord=new List<Order>();
        List<Order>ordList=new List<Order>();
        ord=[select id,ownerid,OpportunityId from order where opportunityId IN:oppList];
         system.debug('Order List'+ord);
        Map<id,id>  oppIDMap=new Map<id,id>();
        for(opportunity oppor:oppList){
        oppIDMap.put(oppor.id,oppor.ownerId);
        }
        if(ord.size()>0){
        for(order o:ord){
            if(oppIDMap.containskey(o.opportunityId)){ 
                
                o.OwnerId=oppIDMap.get(o.opportunityId);
                ordList.add(o);
                
                                }
        
                    } 
        } 
    if(ordList.size()>0)  {
    update ordList;
        system.debug('List'+ordList);
        }
     }
     catch(exception e){
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'There are no order to update'));
      
     }
    }
}