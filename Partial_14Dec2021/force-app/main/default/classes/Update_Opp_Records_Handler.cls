/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :15-Jan-2015
Modified Date   :
Version         :1.0
Description		:Handler of Update_Opp_Records Trigger.

********************XXX***********************************/
public with sharing class Update_Opp_Records_Handler {
	
	
    /*-- SINGLETON PATTERN --*/
    private static Update_Opp_Records_Handler instance;
    public static Update_Opp_Records_Handler getInstance() {
        if (instance == null) {
            instance = new Update_Opp_Records_Handler();  
        }
        return instance;
    }
    

     public void onBeforeUpdate(list<Opportunity> oppList,map<Id,Opportunity> oppMap) {

            //if(CommonUtility.check){

                    //CommonUtility.check = false;
                    list<OpportunityLineItem> proList = new list<OpportunityLineItem>();
                    list<Opportunity> updateOppList = new list<Opportunity>();
                    map<Id,list<OpportunityLineItem>> oppIdProItem = new map<Id,list<OpportunityLineItem>>();
                    set<id> oppIds = new set<id>();

                    for(Opportunity opp:oppList) {

                            if(opp.isApproved__c == true && opp.Special_Pricing_Request_Approval__c == 'Approved'){

                                oppIds.add(opp.id);
                            }

                    }

                    if(!oppIds.isEmpty()) {
                            system.debug('*********oppIds*********'+oppIds);
                            for(OpportunityLineItem pro:[SELECT Id,OpportunityId,UnitPrice,APPL_Type__c,NET_Invoice_Value_to_Distributer__c from OpportunityLineItem where Offer_Check__c = true and OpportunityId in :oppIds]) {
                                
                                    if(oppIdProItem.containsKey(pro.OpportunityId)) {

                                        oppIdProItem.get(pro.OpportunityId).add(pro);
                                    }
                                    else {

                                        oppIdProItem.put(pro.OpportunityId,new list<OpportunityLineItem>());
                                        oppIdProItem.get(pro.OpportunityId).add(pro);
                                    }
                            }
                        
                            for(Id oppid:oppIdProItem.keySet()) {

                                
                                    for(OpportunityLineItem oliList:oppIdProItem.get(oppid)){

                                        oliList.UnitPrice = oliList.NET_Invoice_Value_to_Distributer__c;
                                        proList.add(oliList);
                                        
                                    }
                                    //updateOppList.add
                                
                            }

                            if(proList.size() > 0) {
                                try {

                                    update proList;
                                } catch(Exception e) {

                                    system.debug(e.getMessage());
                                }
                            }

                    }

            //}
     }

}