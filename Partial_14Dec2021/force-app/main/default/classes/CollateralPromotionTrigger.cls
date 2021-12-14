public with sharing class CollateralPromotionTrigger{

 public void bulkAfter(){
 
    if(trigger.isafter && trigger.isupdate){
      updateclosingStockAfterUpdate();
    }
  }

public void updateclosingStockAfterUpdate(){
   try{
        List<Promotion__c> promList = new   List<promotion__c>();
        if(trigger.isafter && trigger.isupdate){
            Set<id> promIds=new Set<id>();
            for(sObject promNew : trigger.new){
                promotion__c promotionNew = (promotion__c)promNew ;
                promotion__c  promotionOld = (promotion__c)Trigger.oldMap.get(promotionNew.id);
                if(promotionOld.Verified__c == false && promotionNew.Verified__c == true && promotionNew.Verified_Number_of_Attended_Members__c != null){
                    promIds.add(promotionNew.createdById);
                    promList.add(promotionNew);
                }
            }
            if(promIds.size()>0){
                List<inventory__c> invList = [select name, Used_Stock__c, Owner_Account__c, Closing_Stocks__c from inventory__c where Owner_Account__c in : promIds];
                List<inventory__c> invListtoUpdate= new List<inventory__c>();
                
                for(Promotion__c newProm: promList){
                
                    for(inventory__c inv : invList ){

                            if(newProm.Gift_Given_1__c!=null && newProm.Gift_Given_1__c == inv.ID){
                            inv.Closing_Stocks__c = inv.Closing_Stocks__c - newProm.Verified_Number_of_Attended_Members__c;
                            inv.Used_Stock__c = newProm.Verified_Number_of_Attended_Members__c;
                            invListtoUpdate.add(inv); 
                            }
                            
                            if(newProm.Gift_Given_11__c!=null && newProm.Gift_Given_11__c == inv.ID){
                            inv.Closing_Stocks__c = inv.Closing_Stocks__c - newProm.Verified_Number_of_Attended_Members__c;
                            inv.Used_Stock__c = newProm.Verified_Number_of_Attended_Members__c;
                            invListtoUpdate.add(inv); 
                            }
                            
                            if(newProm.Gift_Given_2__c!=null && newProm.Gift_Given_2__c == inv.ID){
                            inv.Closing_Stocks__c = inv.Closing_Stocks__c - newProm.Verified_Number_of_Attended_Members__c;
                            inv.Used_Stock__c = newProm.Verified_Number_of_Attended_Members__c;
                            invListtoUpdate.add(inv); 
                            }
                            
                            if(newProm.Gift_Given_22__c!=null && newProm.Gift_Given_22__c == inv.ID){
                            inv.Closing_Stocks__c = inv.Closing_Stocks__c - newProm.Verified_Number_of_Attended_Members__c;
                            inv.Used_Stock__c = newProm.Verified_Number_of_Attended_Members__c;
                            invListtoUpdate.add(inv); 
                            }
                        }    
                    }
            if(invListtoUpdate.size()>0){
             update invListtoUpdate;}
           }
        }
      }
      catch(exception e)
       {system.debug(e.getMessage());}
}
}