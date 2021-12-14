/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email: Pranitha_S@infosys.com
Description:  handler class for trigBrandingRequest to concatenate shop Names
 ****************************************************************************************/
public class trigBrandingRequestHandler {
 public void trigBrandingRequests() {
  List<Id> brcaseids = new List<Id>();
  Map<Id,String> brToShopNameMap = new Map<Id,String>();
  try{
   if(Trigger.Isinsert || Trigger.Isupdate) {
      for(Sobject brs :Trigger.new ) {
         Branding_Request__c brRequest = (Branding_Request__c)brs;
         brcaseids.add(brRequest.Branding_Request__c);
      } 
      for(Branding_Request__c br : [Select Id,Shop_Name__r.Name,Branding_Request__c from Branding_Request__c where Branding_Request__c IN :brcaseids]) {
         if(brToShopNameMap.containsKey(br.Branding_Request__c )) {
            brToShopNameMap.put(br.Branding_Request__c ,brToShopNameMap.get(br.Branding_Request__c)+';'+br.Shop_Name__r.Name); 
         }
         else {
            brToShopNameMap.put(br.Branding_Request__c,br.Shop_Name__r.Name);
         }
       }
       List<Case> cases = new List<Case>();
       for(Case c : [SELECT ID,Shop_Names__c from Case where Id IN :brToShopNameMap.keyset()]) {
          c.Shop_Names__c = brToShopNameMap.get(c.id);
          cases.add(c);
       }
       update cases;
   }
   if(Trigger.Isdelete) {
     for(SObject brs :Trigger.old ) {
         Branding_Request__c brRequest = (Branding_Request__c)brs;
         brcaseids.add(brRequest.Branding_Request__c);
      } 
      for(Branding_Request__c br : [Select Id,Shop_Name__r.Name,Branding_Request__c from Branding_Request__c where Branding_Request__c IN :brcaseids ]) {
         if(brToShopNameMap.containsKey(br.Branding_Request__c )) {
            brToShopNameMap.put(br.Branding_Request__c ,brToShopNameMap.get(br.Branding_Request__c)+';'+br.Shop_Name__r.Name); 
         }
         else {
            brToShopNameMap.put(br.Branding_Request__c,br.Shop_Name__r.Name);
         }
       }
       List<Case> cases = new List<Case>();
       for(Case c : [SELECT ID,Shop_Names__c from Case where Id IN :brToShopNameMap.keyset()]) {
          c.Shop_Names__c = brToShopNameMap.get(c.id);
          cases.add(c);
       }
       update cases;
   }
  } catch(exception e){system.debug('Exception Occurred'+e.getMessage());}
}
}