/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:class for creating a branding request
 ****************************************************************************************/ 
public  class ctrlCreateBrandingRequests {

// variable Declaration
 
 public Case currentCase{get;set;} 
 public Boolean disabled{get;set;}
 public List<brandingNewWrapper> wrapperView{get;set;}
 
 //private variables
 private user currentuser;
 private Account accountId;
 private Map<Id,Branding_Request__c> accountMap;
 private Id RecordTypeId;
 private final id finalRecordTypeId;
 private Boolean saveAndNew;
 private STATIC FINAL string metro='Metro';
 private STATIC FINAL string nonMetro='Non Metro';
 private STATIC FINAL string others='Others';
 private STATIC FINAL string approved='Approved';
 public Id shoppId{get;set;}
 public Id shoppToRemove{get;set;}
 public Vendor_Details__c vendorDetail;
 Id brandingReqRecType=[Select id from RecordType where Name ='Branding Request' and SobjectType = 'Branding_Request__c' ].id;
 public List<SelectOption> pickList{get; set;}
 public String selectedId {get; set;}

 Set<String> clusterSet= new Set<String>();
 /**
 * Name: ctrlCreateBrandingRequests
 * Params: None
 * Description: Constructor for initializing variables
 */
public ctrlCreateBrandingRequests (ApexPages.StandardController controller) {
try{
wrapperView = new List<brandingNewWrapper>();
currentuser=new User();
currentCase = new Case();
accountMap = new Map<Id,Branding_Request__c>();
 vendorDetail=new Vendor_Details__c();

RecordTypeId = apexpages.currentpage().getparameters().get('RecordType');
finalRecordTypeId = RecordTypeId ;
Final Id CaseRecordType=(RecordTypeId==null)?finalRecordTypeId :RecordTypeId ; 
currentuser=[Select Id,Name,Branding_Manager__c,Branding_Team_Member__c,Team_Lead__c,Vendor__c,Vendor_Code__c from User where Id=:userinfo.getuserId()];

currentCase.RecordTypeId = CaseRecordType;
currentCase.Branding_Manager__c=(currentuser.Branding_Manager__c==null)?'':currentuser.Branding_Manager__c;
currentCase.Branding_Team_Member__c=(currentuser.Branding_Team_Member__c==null)?'':currentuser.Branding_Team_Member__c;
currentCase.Team_Lead__c=(currentuser.Team_Lead__c==null)?'':currentuser.Team_Lead__c;
//currentCase.Vendor__c=(currentuser.Vendor__c==null)?'':currentuser.Vendor__c;

List<User_Taluk_Master_Junction__c> clus =[select Cluster__c, User__r.name, user__C from User_Taluk_Master_Junction__c where user__c=:userinfo.getuserId()]; 

for(User_Taluk_Master_Junction__c clusters :clus ){
    clusterSet.add(clusters.cluster__c);
    } 

    if (pickList == null) {
            pickList = new List<SelectOption>();
        }

        SelectOption firstOption = new SelectOption('', '-None-');
        pickList.add(firstOption);
        for (String mpgObj : clusterSet) {
                this.pickList.add(new SelectOption(mpgObj,mpgObj.touppercase().trim()));
        }



currentCase.City__c =metro;
for(integer i=0; i<10; i++){
    brandingNewWrapper brandingRequest = new brandingNewWrapper();
    brandingRequest.brRequest.Branding_Request__r=currentCase;
    brandingRequest.brRequest.RecordTypeId =brandingReqRecType;
    wrapperView.add(brandingRequest );
    }
    wrapperView[0].disabled=false;
    }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
}



 /**
 * Name: showCityText
 * Params: None
 * Description: Method for determining whether city is metro or a non-metro
 */
public PageReference showCityText() {
        currentcase.City_Name__c='';
        getIsCity();
        return null;
    }  

 /**
 * Name: getIsCity
 * Params: None
 * Description: Method for determining whether city is metro or a non-metro
 */
public Boolean getIsCity() {
       if(currentCase.City__c!=null && currentCase.City__c.equals(others)) 
             {  
                currentcase.Metro_Non_Metro__c=nonMetro;
                return true;
             }
       else{
           currentcase.Metro_Non_Metro__c=metro;
           currentcase.City_Name__c=currentcase.City__c;
       }
       return false; 
    } 
    
 /**
 * Name: getAccountDetails
 * Params: None
 * Description: Method for fetching the account details
 */    
public PageReference getAccountDetails(){
try{ 
    CommonHelper.clearAccountsNew(wrapperView);
    for(Integer i=0; i<wrapperView.size(); i++){
        if(wrapperView[i].brRequest.Shop_Name__c!=null && (wrapperView[i].brRequest.Shop_Name__r ==null || wrapperView[i].brRequest.Shop_Name__r.id!=wrapperView[i].brRequest.Shop_Name__c) ){
        Id accountId=wrapperView[i].brRequest.Shop_Name__c;
        wrapperView[i].brRequest.clear();
        wrapperView[i].brRequest.Shop_Name__c = accountId; 
        Account accountRecord = queryAccount(wrapperView[i].brRequest.Shop_Name__c);
    if(CommonHelper.validateCreateRequestNew(accountRecord ,currentCase,true)){
            if(CommonHelper.brRequests == true){
                wrapperView[i].duplicateShop=true;
            } 
            wrapperView[i].brRequest.Shop_Name__r=accountRecord ;
            wrapperView[i].disabled=false;
            if(i!=10)
                wrapperView[i+1].disabled=false;
     }
     else{
           return null;
         }
}
}
return null;
}catch(Exception e){
System.debug('Exception Occurred'+e.getMessage());
return null;
}
}

 /**
 * Name: saveDetails
 * Params: None
 * Description: Method for saving the branding requests.
 */  
public PageReference saveDetails( ){
try{
    accountMap.clear();
    
    if(selectedId==null){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Kindly fill in the vendor cluster.'));
        return null;
    }    
    else if(currentCase.Vendor__c == null){
    
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Error: The selected Vendor cluster does not have vendor assigned. Please contact your System Administrator!!!'));
    return null;
    }
    else{
    if(currentcase.City__c==null || currentcase.City__c==metro ||(currentCase.City__c.equals(others)&&currentcase.City_Name__c == null)){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_City_Validation));
        return null;
    }
    else {
        for(Integer i=0; i<wrapperView.size(); i++){
          if(wrapperView[i].brRequest.Shop_Name__c!=null && wrapperView[i].brRequest.Shop_Name__r!=null){
              if((CommonHelper.validateNew(wrapperView[i].brRequest,accountMap,currentCase,true)) && (CommonHelper.validateSixMonthShop(wrapperView[i].brRequest,currentCase,true))){
 
                    accountMap.put(wrapperView[i].brRequest.Shop_Name__c,wrapperView[i].brRequest);
                }
                else{
                return null;
                }
            } 
        }
        if(accountMap.isEmpty()){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Enter_atleast_1_shop));
            return null;
        }
        else{
            List<AccountShare>  finalAccShareList = new List<AccountShare >();
            List<CaseShare>  caseShareList = new List<CaseShare >();
            insert currentCase;
            if(currentCase.Branding_Manager__c!=null || currentCase.Branding_Manager__c!=''){
                finalAccShareList.addAll(createAccountShare(currentCase.Branding_Manager__c,'Edit'));
                caseShareList.add(createCaseShare(currentCase.Branding_Manager__c,'Edit'));}
            if(currentCase.Branding_Team_Member__c!=null || currentCase.Branding_Team_Member__c!=''){
                finalAccShareList.addAll(createAccountShare(currentCase.Branding_Team_Member__c,'Edit'));
                caseShareList.add(createCaseShare(currentCase.Branding_Team_Member__c,'Edit'));}
            if(currentCase.Team_Lead__c!=null || currentCase.Team_Lead__c!=''){
                finalAccShareList.addAll(createAccountShare(currentCase.Team_Lead__c,'Edit'));
                caseShareList.add(createCaseShare(currentCase.Team_Lead__c,'Edit'));}
            if(currentCase.Vendor__c!=null || currentCase.Vendor__c!=''){
                finalAccShareList.addAll(createAccountShare(currentCase.Vendor__c,'Edit'));
                caseShareList.add(createCaseShare(currentCase.Vendor__c,'Read'));}
           finalAccShareList.addAll(createAccountShare('0053000000BDcEs','Read'));
           caseShareList.add(createCaseShare('0053000000BDcEs','Edit'));
            
            for(Branding_Request__c req:accountMap.values() ){
                req.Branding_Request__c=currentCase.id;
                req.Branding_Approved_Rejected__c=approved;
            }
            insert accountMap.values();
            system.debug('caseShareList:::'+ caseShareList);
            if(caseShareList.size()>0){insert caseShareList;}
            if(finalAccShareList.size()>0){upsert finalAccShareList;}
            
            if(saveAndNew == true){  
                PageReference reference=new PageReference('/apex/createBrandingRequests?RecordType='+RecordTypeId);
                return reference;
            }
        else {
            PageReference reference=new PageReference('/'+currentCase.id);
            reference.setRedirect(true);
            return reference;
        }
    
    }
  }
  }
}catch(Exception e){
System.debug('Exception Occurred'+e.getMessage());
return null;
}
}

 /**
 * Name: saveNew
 * Params: None
 * Description: Method for saving and creating a new branding requests.
 */ 
public PageReference saveNew(){
  saveAndNew = true;
  try{
      PageReference reference = saveDetails();
        reference.setRedirect(true);
        return reference;
    }catch(Exception e){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Error_Occurred));
        System.debug('Exception Occurred'+e.getMessage());
        return null;
    }
}

 /**
 * Name: Cancel
 * Params: None
 * Description: Method to implement the Cancel button.
 */ 
public PageReference Cancel(){  
   Schema.DescribeSObjectResult result = Case.SObjectType.getDescribe();
   PageReference pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
   pageRef.setRedirect(true);
   return pageRef;
}

 /**
 * Name: queryAccount
 * Params: Id accountID
 * Description: Method to get the account details
 */
Public Account queryAccount(Id accountID){
 Account accountRecord = new Account();
try{
 accountRecord =[select id,name,RecordType.name,phone,Owner.name,Metro_non_metro__c,Metro_Non__c,owner.id,
 BillingStreet, BillingCity, BillingState, BillingPostalCode,BillingCountry,Billing_Address__c,Primary_Contact_Person_Name__c,
 street_address__c, City__c,district__c,state__c,Contact_Number_Mobile__c  
 from Account where id=: accountID limit 1];
 return accountRecord;
}catch(Exception e){
System.debug('Exception Occurred'+e.getMessage());
return new Account();
}  
} 

 /**
 * Name: createAccountShare
 * Params: Id userId, String access
 * Description: Method to share accounts
 */
Public List<AccountShare> createAccountShare(Id userId, String access){
List<AccountShare> accShareList = new List<AccountShare>();
    for(Branding_Request__c brReq : accountMap.values()){
        if(userId!=brReq.Shop_Name__r.owner.id){
            AccountShare accShare=new AccountShare();
            accShare.UserOrGroupID = userId;
            accShare.AccountAccessLevel= access;
            accShare.AccountId= brReq.Shop_Name__c;
            accShare.RowCause = 'Manual';
            accShare.OpportunityAccessLevel='None';
            accShareList.add(accShare);
        }
     }
    return accShareList;
}

/**
 * Name: createCaseShare
 * Params: Id userId, String access
 * Description: Method to share Case
 */
Public CaseShare createCaseShare(Id userId, String access){
    CaseShare caseShare=new CaseShare();
    caseShare.UserOrGroupID = userId;
    caseShare.CaseAccessLevel= access;
    caseShare.CaseId= currentCase.Id;
    caseShare.RowCause = 'Manual';
    return caseShare;
}
/*added as part of new change request - 8/10/2015*/
public void getTalukDetails(){
 
AP_Taluk_Master__c brandingTaluk;
 
brandingTaluk = [select Name, Cluster__c, District__c, State__c from AP_Taluk_Master__c where id =: currentCase.taluk__c];
 
currentCase.state__c =brandingTaluk.State__c;
currentCase.district__c = brandingTaluk.District__c;
currentCase.clustor__c = brandingTaluk.Cluster__c;
 
 
}
/*added as part of new change request - 8/10/2015*/
 
public PageReference RefreshAccountDetails(){
try{ 
        Account accountRecord = queryAccount(shoppId);  
    if(CommonHelper.validateCreateRequestNew(accountRecord ,currentCase,true)){
     for(Integer i=0; i<wrapperView.size(); i++){
        if(wrapperView[i].brRequest.Shop_Name__c==shoppId){ 
        
         wrapperView[i].brRequest.Shop_Name__r=accountRecord ;
 
}
}    
}
return null;
}catch(Exception e){
System.debug('Exception Occurred'+e.getMessage());
return null;
}
}
 
public PageReference DeleteShop(){
try{ 
          
     for(Integer i=0; i<wrapperView.size(); i++){
        if(wrapperView[i].brRequest.Shop_Name__c==shoppToRemove){ 
        
         wrapperView.remove(i);
         brandingNewWrapper brandingRequest = new brandingNewWrapper();
         brandingRequest.brRequest.Branding_Request__r=currentCase;
         brandingRequest.brRequest.RecordTypeId =brandingReqRecType;
         wrapperView.add(brandingRequest);
    
}
}

 for(Integer i=0; i<wrapperView.size(); i++){
     if(wrapperView[i].brRequest.Shop_Name__c != null){
         if( wrapperView[i+1].brRequest.Shop_Name__c == null){
         wrapperView[i+1].disabled=false;
         break;
         }
         
         }
         else{
         wrapperView[i].disabled=false;
         break;
         }
         
}

  system.debug('size is:::' +wrapperView.size());   
return null;
}catch(Exception e){
System.debug('Exception Occurred'+e.getMessage());
return null;
}
}
 
 public PageReference AsignVendor(){
  try{
    system.debug('here');
    currentCase.Vendor_Cluster__c= selectedId;
    
   
    if(selectedId != null){
    try{
    vendorDetail=[Select id,Vendor__c from Vendor_Details__c where vendor_cluster__c =: currentcase.vendor_cluster__c and Primary_Vendor__c =true limit 1];
    }
    catch(QueryException e){
         
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Error: The selected Vendor cluster does not have vendor assigned. Please contact your System Administrator!!!'));
         System.debug('Exception Occurred111'+e.getMessage());
         
        
    } 
    if(vendorDetail!=null){
    system.debug('here1');
    currentCase.Vendor__c=vendorDetail.Vendor__c;
    currentCase.Vendor_Details__c=(currentuser.Vendor_Code__c==null)?'':vendorDetail.id;}
    system.debug('here22'+currentCase.Vendor_Details__c);
   }
   }
   catch(Exception e){
        System.debug('Exception Occurred'+e.getMessage());
        return null;
}
    return null;
    }

}