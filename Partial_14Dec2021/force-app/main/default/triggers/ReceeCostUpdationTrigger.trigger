/*****************************************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S , vasanthi K N
Email: Pranitha _S@infosys.com,Vasanthi_KN@infosys.com
Description: Trigger on Recce Detail to compute cost for job types in branding process.
 *****************************************************************************************************************/
trigger ReceeCostUpdationTrigger on Recce_Detail__c (after insert, before insert, before update, after update, before delete) {
CtrlRecceCostUpdation triggerHandler = new CtrlRecceCostUpdation();
    if((trigger.isbefore &&  (trigger.isdelete || trigger.isupdate)) || (trigger.isafter && trigger.isinsert)){
        triggerHandler.computeTotalCost();
    }  
    if(trigger.isbefore && trigger.isinsert){
        triggerHandler.ComputeCostpersqFeet();        
    }
}