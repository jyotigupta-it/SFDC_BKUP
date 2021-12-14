/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:class for showing branding requests on an account
 ****************************************************************************************/ 
public with sharing class ctrlBrandingRequest{
  
 // variable Declaration
 public list<Branding_Request__c > brandingRequests{get;set;}
 private String currentAccountId{get;set;}

 /**
 * Name: ctrlBrandingRequest
 * Params: None
 * Description: Constructor for initializing variables
 */
 public ctrlBrandingRequest(ApexPages.StandardController controller){
    try{
        currentAccountId = System.currentPageReference().getParameters().get('id');
        showBrandingRequestCases();
    }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
  }
  
   /**
   * Name: showBrandingRequests
   * Description: To get branding requests for an account
   */
  public List<Branding_Request__c > showBrandingRequestCases(){
      brandingRequests = new List<Branding_Request__c >();
      brandingRequests = [select id,Branding_Request__c,Branding_Request__r.status,Shop_Type__c,Branding_Request__r.CaseNumber,Branding_Request__r.owner.name
      from Branding_Request__c 
      where Shop_Name__c =: currentAccountId ];
      return brandingRequests ;
  }
  
  /**
   * Name: newRequest
   * Description: To create a new case for branding.
   */
  public PageReference newRequest(){
      PageReference pageReference = new PageReference ('/setup/ui/recordtypeselect.jsp?ent=Case&retURL='+currentAccountId+'&save_new_url=/500/e?retURL='+currentAccountId );
      return pageReference;
  }
}