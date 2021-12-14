/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :23-Jan-2015
Modified Date   :
Version         :1.0
Description		:Handler of LockOpportunityProducts Trigger.

********************XXX***********************************/
public with sharing class OpportunityLineItemHandler {
	public OpportunityLineItemHandler() {
		
	}

	/*-- SINGLETON PATTERN --*/
    private static OpportunityLineItemHandler instance;
    public static OpportunityLineItemHandler getInstance() {
        if (instance == null) {
            instance = new OpportunityLineItemHandler();  
        }
        return instance;
    }
    
    /*-- After Insert or After Update -- */
    public void calculateAvgDisc(list<OpportunityLineItem> oppLineItem) { 

    	set<id> oppIds = new set<id>();
    	map<id,list<OpportunityLineItem>> oppWithList = new map<id,list<OpportunityLineItem>>();
    	Boolean checkOffer = false;
        list<Opportunity> oppList = new list<Opportunity>();

         //if(CommonUtility.check){

                
            	try {

            		for(OpportunityLineItem oli:oppLineItem){

        	    		if(oli.Offer_Check__c == true) {

        	    			oppIds.add(oli.OpportunityId);
                            checkOffer = true;
        	    		}

            		}

                    if(checkOffer == true) {

                        for(OpportunityLineItem oli:[SELECT id,OpportunityId,APPL_Type__c,MRP__c,APPL_STD_Discount__c,NET_Invoice_Value_to_Distributer__c,Offer_MRP__c,Offer_Check__c from OpportunityLineItem where OpportunityId in :oppIds and Offer_Check__c = true and APPL_STD_Discount__c > 0]){

                            if(oppWithList.containsKey(oli.OpportunityId)) {

                                oppWithList.get(oli.OpportunityId).add(oli);
                            }
                            else {

                                oppWithList.put(oli.OpportunityId,new list<OpportunityLineItem>());
                                oppWithList.get(oli.OpportunityId).add(oli);
                            }
                        }


                        system.debug('*******oppWithList*********'+oppWithList);
                        for(Id oppid:oppWithList.keySet()) {

                            Decimal avgProd,total;
                            Decimal totalValue = 0;
                            Decimal totalValueAddl = 0;
                            for(OpportunityLineItem oliList:oppWithList.get(oppid)){

                                Decimal orderValue;
                                if(oliList.Offer_MRP__c != null){
                                    orderValue = oliList.Offer_MRP__c -((oliList.Offer_MRP__c*oliList.APPL_STD_Discount__c)/100);
                                    totalValue += orderValue;
                                    totalValueAddl += oliList.NET_Invoice_Value_to_Distributer__c;
                                }
                                total = totalValue - totalValueAddl;
                                if(totalValue != 0){
                                    avgProd = ((total/totalValue)*100).setScale(0, RoundingMode.HALF_UP); 
                                }
                            }
                            system.debug('*******avgProd*********'+avgProd);
                            Opportunity storeOpp = new Opportunity(Id = oppid,Average_Discount__c = avgProd);
                            oppList.add(storeOpp);

                        }
                        system.debug('*******oppList*********'+oppList);
                        update oppList;
                    }

                		

            	}
            	catch(exception e){

                    system.debug(e.getMessage());      
                }
    	//}

    }
}