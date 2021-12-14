/*****************************************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S , vasanthi K N
Email: Pranitha _S@infosys.com,Vasanthi_KN@infosys.com
Description: Trigger on Case to perform functionalities for the branding and collateral process 
 *****************************************************************************************************************/
trigger trigCaseTrigger on Case (before insert, after update, before update) {
    BrandingRequestTrigger triggerHandler =  new BrandingRequestTrigger();
  if(trigger.isbefore && trigger.isupdate ){
       /* triggerHandler.updateStock();
        triggerhandler.checkBrandingApproval();
        triggerhandler.checkBrandingRejection();
        triggerHandler.fetchVendor();
        triggerHandler.shareBrandingRequests();
        TaskForApprovalProcess tasks = new TaskForApprovalProcess();
        tasks.taskForBranding();
        tasks.taskForInventory();
        triggerhandler.checkCollateralApproval();*/
        
        triggerhandler.beforeUpdateCall();
    }
    if(trigger.isafter && trigger.isupdate ){
        triggerhandler.trigAutoDispColl();
        /*RecceHWUpdation recceUpdate= new RecceHWUpdation();
        recceUpdate.updtHeightWidth();*/
        triggerhandler.AfterUpdateCall();
    }
}