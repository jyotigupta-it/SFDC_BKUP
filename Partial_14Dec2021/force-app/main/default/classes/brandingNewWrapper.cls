/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:Wrapper class for branding requests.
 ****************************************************************************************/ 
Public class brandingNewWrapper{

 // variable Declaration
 
 public Branding_Request__c brRequest{get;set;}
 public Boolean disabled{get;set;}
 public Boolean duplicateShop{get;set;}
 public SelectOption[] selectedSubProds { get; set; }
 public List<SelectOption> allSubProds{ get; set; }
 public Boolean refDelFlag{get;set;}  
  /**
 * Name: brandingNewWrapper
 * Params: None
 * Description: Constructor for initializing variables
 */   
 public brandingNewWrapper() {
    brRequest=new Branding_Request__c (); 
    try{
        disabled=true;
        refDelFlag=false;
        selectedSubProds = new List<SelectOption>();
        allSubProds= new List<SelectOption>();
         }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
  }
}