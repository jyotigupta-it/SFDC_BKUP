/*Modified by :SudhaMurthy On 30-july-2019
test class:Test_Additional_Dics_Opp_Controller
Changes made:bulkification,exception handling and code optimization--*/

trigger TriggerToUpdateOLIfieldSPR on Opportunity (After Update) {
    set<Id> oppIDs =new set<ID>();
    for (Opportunity opp : Trigger.new) {
        system.debug('trigger new...'+trigger.new);
        // Access the "old" record by its ID in Trigger.oldMap
        if(opp!=null){
            Opportunity oldOpp = Trigger.oldMap.get(opp.Id);
             system.debug('oldOpp ...'+oldOpp );
            if(oldOpp!=null && opp!=null){
             if(oldOpp.Special_Pricing_Request_Approval__c!='Approved' && opp.Special_Pricing_Request_Approval__c=='Approved'  ){
                oppIDs.add(opp.id); 
                system.debug('oppIDs set ...'+oppIDs );
            }   
        }
        }
    }
    List<opportunityLineItem> oli=new List<opportunityLineItem>();
    List<opportunityLineItem> oli2=new List<opportunityLineItem>();
    if(oppIDs.size()>0 && oppIDs!=null){
    oli=[select id,checked_if_approved__c from opportunityLineItem where opportunityid IN:oppIDs];
    }
    if(oli.size()>0 && !oli.IsEmpty()){
        for(opportunityLineItem opoli:oli){
            opoli.checked_if_approved__c=true;
            oli2.add(opoli);
        }
    }    
    try{
        if(!oli2.IsEmpty()){
            update oli2;
        } 
     }catch(exception e){
          System.debug('exception....'+e);
     }      
}