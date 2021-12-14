/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email: Pranitha_S@infosys.com
Description:  trigger on Branding request 
 ****************************************************************************************/
trigger trigBrandingRequest  on Branding_Request__c (after insert,after update, after delete) {
   trigBrandingRequestHandler triggerHandler =  new trigBrandingRequestHandler();
   triggerHandler.trigBrandingRequests();
}