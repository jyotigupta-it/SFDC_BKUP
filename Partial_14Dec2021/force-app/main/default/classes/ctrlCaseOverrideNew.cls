/*******************************************************************************
Author: Renjay Surendran
Date: 17 July 2015
Description:  Controller class for 'New' Case Override Button.
********************************************************************************/
public class ctrlCaseOverrideNew {
private ApexPages.StandardController controller;
public String retURL {get; set;}
public String saveNewURL {get; set;}
public ID rType {get; set;}
public String cancelURL {get; set;}
public String ent {get; set;}
public String confirmationToken {get; set;}
private ID prospectRecType;
    
    public ctrlCaseOverrideNew (ApexPages.StandardController controller) {
        
    }

    public PageReference redirect(){
        PageReference returnURL = new PageReference('/500/e');
        this.controller = controller;
        retURL = ApexPages.currentPage().getParameters().get('retURL');
        rType = ApexPages.currentPage().getParameters().get('RecordType');
        cancelURL = ApexPages.currentPage().getParameters().get('cancelURL');
        ent = ApexPages.currentPage().getParameters().get('ent');
        confirmationToken = ApexPages.currentPage().getParameters().get('_CONFIRMATIONTOKEN');
        saveNewURL = ApexPages.currentPage().getParameters().get('save_new_url');
    try{  
    Id coll=[Select id from RecordType where Name ='Collateral Request'].id; 
    Id brandingReq=[Select id from RecordType where Name ='Branding Request' and SobjectType = 'Case' ].id;
    Id auto=[Select id from RecordType where Name ='Auto Dispatch'].id;
    if(rType==coll){
            returnURL = new PageReference('/apex/InventoryRequestPage');
    }
    else if(rType == brandingReq) {
        returnURL = new PageReference('/apex/createBrandingRequests');
    }
    else if(rType==auto){
       returnURL = new PageReference('/apex/AutoDispatchRequest');
    }
    else{
       returnURL = new PageReference('/500/e');
    }
        
    returnURL.getParameters().put('retURL', retURL);
    returnURL.getParameters().put('RecordType', rType);
    returnURL.getParameters().put('cancelURL', cancelURL);
    returnURL.getParameters().put('ent', ent);
    returnURL.getParameters().put('_CONFIRMATIONTOKEN', confirmationToken);
    returnURL.getParameters().put('save_new_url', saveNewURL);
    returnURL.getParameters().put('nooverride', '1');
    returnURL.setRedirect(true);
    }
   catch(exception e){system.debug('Exception Occurred'+e.getMessage());}  
   return returnURL;
   }
}