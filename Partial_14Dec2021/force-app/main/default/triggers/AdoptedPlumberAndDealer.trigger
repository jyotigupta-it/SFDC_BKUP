trigger AdoptedPlumberAndDealer on AP_Site_Visit__c (after insert,after update,after delete,after undelete) {
     String labelValue = Label.Trigger_Active_Visit;
    String labeldelete='';
    Integer num=0;
     String labelValuedelete = Label.Trigger_delete_visit;
    RollupForProjectVisitCount handler=new RollupForProjectVisitCount();
    if(trigger.isAfter && (trigger.isInsert || trigger.IsUndelete)){
    ProductiveVisitWithOrders.neworderbooking(trigger.new);
    RollupInfluencerVisitsColumn.InfluencerVisitsColumn(trigger.new);
    NoOfProjectVisitRollUp.noofvisitmethod(trigger.new); 
    DistributorVisitsRollup_Handler.visitinsertmethod(trigger.new);
    AdoptedPlumberAndDealer.AdoptedDealerAndPlumberMethod(trigger.new);
    No_of_Leaves_Rollup_Handler.leavemethod(trigger.new);
        No_of_days_worked_Visits.visitisertmethod(trigger.new);
        No_of_days_worked_Visits.projectvisitisertmethod(trigger.new);
    //No_of_days_worked_At_Office.visitisertmethod(trigger.new);
    }
    if(trigger.isAfter && trigger.isInsert ){
        
        GeoLocationInAccount.toPopulateGeoinsert(trigger.new);}
          
        if(trigger.isAfter && trigger.isInsert ){
        handler.projectVisitinsertmethod(trigger.new);
         handler.projectVisitDealerinsertmethod(trigger.new);
         handler.projectVisitInfluencerinsertmethod(trigger.new);
         handler.brandingVisitinsertmethod(trigger.new);
         handler.brandingVisitDealerinsertmethod(trigger.new);
         handler.brandingVisitInfluencerinsertmethod(trigger.new);
    }
     
      if(trigger.isAfter && trigger.isupdate && labelValue.equalsIgnoreCase('No') ){
            handler.projectVisitupdatemethod(trigger.oldmap,trigger.new);
         handler.projectVisitDealerupdatemethod(trigger.oldmap,trigger.new);
         handler.projectVisitInfluencerupdatemethod(trigger.oldmap,trigger.new);
         handler.brandingVisitupdatemethod(trigger.oldmap,trigger.new);
         handler.brandingVisitDealerupdatemethod(trigger.oldmap,trigger.new);
          handler.brandingVisitInfluencerupdatemethod(trigger.oldmap,trigger.new);
      }
          if(trigger.isAfter && trigger.isupdate ){
         
    ProductiveVisitWithOrders.neworderbookingforupdate(trigger.oldmap,trigger.new);
     DistributorVisitsRollup_Handler.visitupdatemethod(trigger.oldmap,trigger.new);
           RollupInfluencerVisitsColumn.InfluencerVisitsColumnforupdate(trigger.new,trigger.oldmap);
           GeoLocationInAccount.toPopulateGeoInAccount(trigger.new,trigger.oldmap);
        //No_of_days_worked_Visits.deletemethod(trigger.old); 
      
    }
   if(trigger.isAfter && trigger.Isdelete){
     No_of_days_worked_Visits.deletemethod(trigger.old);  
       No_of_days_worked_Visits.projectVisitDeletemethod(trigger.old);
        RollupInfluencerVisitsColumn.InfluencerVisitsColumndelete(trigger.old);
        ProductiveVisitWithOrders.neworderbookingdelete(trigger.old);
    NoOfProjectVisitRollUp.noofvisitmethodupdate(trigger.old); 
    DistributorVisitsRollup_Handler.visitdeletemethod(trigger.old);
       No_of_Leaves_Rollup_Handler.leaveupdatemethod(trigger.old);}
    
    
     if(trigger.isAfter && trigger.Isdelete  && labelValuedelete.equalsIgnoreCase('Yes')){  
    handler.projectVisitdeletemethod(trigger.old);
       handler.projectVisitDealerdeletemethod(trigger.old);
        handler.projectVisitInfluencerdeletemethod(trigger.old);
        handler.brandingVisitdeletemethod(trigger.old);
        handler.brandingVisitDealerdeletemethod(trigger.old);
        handler.brandingVisitInfluencerdeletemethod(trigger.old);
         
    }
     
}