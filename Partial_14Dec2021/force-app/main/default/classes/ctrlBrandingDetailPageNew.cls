/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description:class for case detail page that shows the branding requests.
 ****************************************************************************************/ 
 public class ctrlBrandingDetailPageNew {
 
 // variable Declaration
 
 public Case currentCase{get;set;}
 public Boolean editable{get;set;}
 public List<Branding_Request__c> brandingRequests{get;set;}
 public List<brandingNewWrapper> wrapperView{get;set;}
 public Boolean flagVar{get;set;}
 public List<SelectOption> allSubProds{ get; set; }
 public List<User> approver{get;set;}
 public Boolean disableInput{get;set;}
 public Boolean disableshopName{get;set;}
 public Boolean brandingInput{get;set;}
 public Boolean tlInput{get;set;}
 public Boolean callCenterInput{get;set;}
 public Boolean vendorInput{get;set;}
 public String shopName{get;set;}
 public String shopId{get;set;}
 public Boolean vendorEdit{get; set;}
 //private variables
 private Map<Id,Branding_Request__c> accountMap{get;set;}
 private STATIC FINAL string brandingManager='Head Branding';
 private STATIC FINAL string brandingTeam='Regional Branding Manager';
 private STATIC FINAL string TL='TL NEW';
 private STATIC FINAL string approved='Approved';
 private STATIC FINAL string plumbing='Plumbing';
 private STATIC FINAL string column='Column';
 private STATIC FINAL string allProducts='All Products';
 private STATIC FINAL string newString='New';
 private STATIC FINAL string callCenter='Customer Support Team';
 public Id shoppId{get;set;}
 public Id shoppToRemove{get;set;}
 /**
 * Name: ctrlBrandingDetailPageNew
 * Params: None
 * Description: Constructor for initializing variables
 */
public ctrlBrandingDetailPageNew (ApexPages.StandardController controller) {
 brandingInput = false;
 disableInput = false;
 callCenterInput=true;
 vendorInput = true;
 vendorEdit=false;
 wrapperView = new List<brandingNewWrapper>();
 brandingRequests = new List<Branding_Request__c>();
 accountMap = new Map<Id,Branding_Request__c>();
 currentCase = new Case();
 allSubProds = new List<SelectOption>();
 try{
 currentCase = [select id,CaseNumber,status,Metro_Non_Metro__c,City__c,district__c, state__c, clustor__c,vendor_details__c, vendor_cluster__c,City_Name__c,Vendor__c,Branding_Manager__c,Branding_Team_Member__c,Team_Lead__c,Is_In_Approval_Process__c
 from case where id =: apexpages.currentpage().getparameters().get('id')];
 brandingRequests = [Select id,Metro_Non_Metro__c,Call_Center_Feedback__c,Branding_Request__c,Shop_Name__c,Shop_Name__r.name,Shop_Name__r.Owner.name,
 Shop_Name__r.Phone,Shop_Name__r.Billing_Address__c,Shop_Name__r.owner.id,Shop_Name__r.Primary_Contact_Person_Name__c,
 Shop_Name__r.Contact_Number_Mobile__c,Shop_Name__r.Street_Address__c,Shop_Name__r.City__c,Shop_Name__r.District__c,Shop_Name__r.State__c,
 Shop_Type__c,Comments__c,Shop_Description__c,Language__c,Branding_Products__c,Branding_Sub_Products__c,Branding_Type__c,Shop_Name__r.RecordType.name,
 Branding_Sub_Type__c,Branding_Approved_Rejected__c,Shop_Name__r.Metro_Non_Metro__c,Branding_Installation__c,Vendor_Comments__c,Call_Center_Comments__c
 from Branding_Request__c where Branding_Request__c=: apexpages.currentpage().getparameters().get('id') ORDER BY Name];
editable = false;

List<Schema.PicklistEntry> picklistValues=Branding_Request__c.Branding_Sub_Products__c.getDescribe().getPicklistValues();
 for(Branding_Request__c request:brandingRequests){
    brandingNewWrapper brandingRequest = new brandingNewWrapper();
    brandingRequest.brRequest= request;
    brandingRequest.disabled=false;
     brandingRequest.refDelFlag=true;
    wrapperView.add(brandingRequest );
 }
 Integer maxRows = 10;
 Integer addRows = maxRows - brandingRequests.size();
 for(integer i=0; i<addRows; i++){
     brandingNewWrapper brandingRequest = new brandingNewWrapper();
     brandingRequest.brRequest.Branding_Approved_Rejected__c='';
     brandingRequest.brRequest.Branding_Installation__c='';
     wrapperView[i].selectedSubProds.clear();
     wrapperView[i].allSubProds.clear();
     wrapperView.add(brandingRequest );
  }
 if(brandingRequests.size()<10){
    wrapperView[brandingRequests.size()].disabled=false;
    wrapperView[brandingRequests.size()].refDelFlag=true;
 }
/******get approver details***********/
 approver = new List<User>();
 approver = CommonHelper.getUser(currentCase.id);
   if(currentCase.status!=newString || (currentCase.status==newString && approver.size()!=0 )){
       disableInput=true;
       for(Integer i=0; i<wrapperView.size(); i++){
       disableshopName=true;
       }
   }
   if(currentCase.status==System.label.Branding_Request_Completed_by_Vendor && approver.size()==0 &&
   UserInfo.getUserId() == currentCase.Vendor__c ){
       vendorInput=false;
   }
   if(approver.size()!=0 ){
       brandingInput=true;
       tlInput = true;
    if( approver.size()!=0 && approver[0].name==userinfo.getName() && (approver[0].id==currentCase.Branding_Manager__c
     || approver[0].id==currentCase.Branding_Team_Member__c)
        && currentCase.Status!='Completed by Vendor'){
        brandingInput=false;
        disableInput=false;
    }   
   if(  approver.size()!=0 &&  approver[0].name==userinfo.getName() && (approver[0].id==currentCase.Team_Lead__c||
   approver[0].id==currentCase.Branding_Manager__c|| approver[0].id==currentCase.Branding_Team_Member__c)){
        tlInput=false;
        disableInput=false;
    }  
    if(  approver.size()!=0 &&  approver[0].name==userinfo.getName() && (approver[0].profile.name==callCenter)){
        callCenterInput=false;
        disableInput=false;
    }  
    if( approver.size()!=0 &&  approver[0].name==userinfo.getName() && approver[0].id==currentCase.Vendor__c && currentCase.status==System.Label.Branding_Request_Approved_by_Branding_Manager){
        vendorInput=false;
        disableInput=false;
    }
        if( approver.size()!=0 &&  approver[0].name==userinfo.getName() && approver[0].id==currentCase.Vendor__c){
        vendorEdit=true;
        vendorInput=false;
    }
    
  }
 }Catch(Exception e){
        system.debug('Exception Occured'+e.getMessage());
    }
}

/**
 * Name: getAccountDetails
 * Params: None
 * Description: Method for fetching the account details
 */
public PageReference getAccountDetails(){
try{ 
 flagVar=false;
 CommonHelper.clearAccountsNew(wrapperView);
 for(Integer i=0; i<wrapperView.size(); i++){
    if(wrapperView[i].brRequest.Shop_Name__c!=null && (wrapperView[i].brRequest.Shop_Name__r ==null || wrapperView[i].brRequest.Shop_Name__r.id!=wrapperView[i].brRequest.Shop_Name__c) ){
    Id accountId=wrapperView[i].brRequest.Shop_Name__c;
    wrapperView[i].brRequest.clear();
    wrapperView[i].brRequest.Shop_Name__c = accountId;
    Account accountRecord = queryAccount(wrapperView[i].brRequest.Shop_Name__c);
    if(CommonHelper.validateCreateRequestNew(accountRecord ,currentCase,false)){
            if(commonHelper.brRequests == true){
                wrapperView[i].duplicateShop=true;
            }
            wrapperView[i].brRequest.Shop_Name__r=accountRecord ;
            wrapperView[i].brRequest.Branding_Approved_Rejected__c=approved;
            wrapperView[i].disabled=false;
            wrapperView[i].refDelFlag=true;
            if(i!=10)
            wrapperView[i+1].disabled=false;
             wrapperView[i+1].refDelFlag=true;
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
 * Name: subProdSelect
 * Params: None
 * Description: Method for dependant picklist of sub products
 */
public void subProdSelect(){
try{
    for(Integer i=0; i<wrapperView.size(); i++){
        wrapperView[i].selectedSubProds.clear();
        wrapperView[i].allSubProds.clear();
        subProdFilter(wrapperView[i]);    
    }
   }catch(Exception e){
     System.debug('Exception Occurred'+e.getMessage());
    }

}

/**
 * Name: subProdFilter
 * Params: brandingNewWrapper item
 * Description: Method for dependant picklist of sub products
 */
public void subProdFilter(brandingNewWrapper item){
try{
    List<Branding_Request_Sub_Products__c> subProds = new List<Branding_Request_Sub_Products__c>();
    if(item.brRequest.Branding_Products__c==plumbing || item.brRequest.Branding_Products__c==column ){
            subProds = [Select Name from Branding_Request_Sub_Products__c where Branding_Request_Product__c =:item.brRequest.Branding_Products__c order by Name];
            for(Branding_Request_Sub_Products__c se : subProds){                             
                item.allSubProds.add(new SelectOption(se.Name, se.Name)); 
            }
        }
        else if(item.brRequest.Branding_Products__c==allProducts){
            subProds = [Select Name from Branding_Request_Sub_Products__c order by Name];
            for(Branding_Request_Sub_Products__c se : subProds){                             
                item.allSubProds.add(new SelectOption(se.Name, se.Name)); 
            }
        }
    }catch(Exception e){
        System.debug('Exception Occurred'+e.getMessage());
    }       
}

 /**
 * Name: queryAccount
 * Params: Id accountID
 * Description: Method to get the account details
 */
Public Account queryAccount(Id accountID){
Account accountRecord = new Account();
try{
    accountRecord =[select id,Metro_Non_Metro__c,name,RecordType.name,phone,Owner.name,owner.id,
    BillingStreet, BillingCity, BillingState, BillingPostalCode,BillingCountry,Billing_Address__c,Primary_Contact_Person_Name__c,
 street_address__c, City__c,district__c,state__c,Contact_Number_Mobile__c
     from Account where id=: accountID];
    return accountRecord;
    }catch(Exception e){
        System.debug('Exception Occurred'+e.getMessage());
        return new Account();
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
    flagVar = false;
    Boolean first= true;
    String message1;
    for(Integer i=0; i<wrapperView.size(); i++){
        if(wrapperView[i].brRequest.Shop_Name__c!=null){
           if((CommonHelper.validateNew(wrapperView[i].brRequest,accountMap,currentCase,false)) && (CommonHelper.validateSixMonthShop(wrapperView[i].brRequest,currentCase,false))){

                if(wrapperView[i].selectedSubProds.size()==0){
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,wrapperView[i].brRequest.Shop_Name__r.name ));
                   return null;
                }
                else{
                message1='';
                      for ( SelectOption so : wrapperView[i].selectedSubProds) {
                  if (!first) {
                        message1 += ';';
                    }
                        message1 += so.getvalue();
                        first= false;
                }
                wrapperView[i].brRequest.Branding_Sub_Products__c=message1;
                accountMap.put(wrapperView[i].brRequest.Shop_Name__c,wrapperView[i].brRequest);
                }
            }
            else{
            return null;
            }
        } 
    }
    if(accountMap.isEmpty()){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.label.Branding_Request_Enter_atleast_1_shop));
        return null;
    }
    else{
    List<Branding_Request__c> delList = new List<Branding_Request__c>();
    List<AccountShare>  finalAccShareList = new List<AccountShare >();
    delList = [select Id from Branding_Request__c where id not in:accountMap.values()
        and Branding_Request__c=:currentCase.id];
    update currentCase;
    for(Branding_Request__c req:accountMap.values() ){
        if(req.Branding_Request__c==null){
            req.Branding_Request__c=currentCase.id;
        }   
    }  
    if(currentCase.Branding_Manager__c!=null || currentCase.Branding_Manager__c!=''){
        finalAccShareList.addAll(createAccountShare(currentCase.Branding_Manager__c,'Edit'));}
    if(currentCase.Branding_Team_Member__c!=null || currentCase.Branding_Team_Member__c!=''){
        finalAccShareList.addAll(createAccountShare(currentCase.Branding_Team_Member__c,'Edit'));}
    if(currentCase.Team_Lead__c!=null || currentCase.Team_Lead__c!=''){
        finalAccShareList.addAll(createAccountShare(currentCase.Team_Lead__c,'Edit'));}
    if(currentCase.Vendor__c!=null || currentCase.Vendor__c!=''){
        finalAccShareList.addAll(createAccountShare(currentCase.Vendor__c,'Edit'));}
    finalAccShareList.addAll(createAccountShare('0053000000BDcEs','Read'));
    
    upsert accountMap.values(); 
    if(finalAccShareList.size()>0){upsert finalAccShareList;}
    if(delList.size()>0){delete delList;}  
    flagVar=true;
    return null; 
    }
  }catch(Exception e){
    System.debug('Exception Occurred###'+e.getMessage());
    return null;
    }  
}

 /**
 * Name: editDetails
 * Params: None
 * Description: Method for editing the branding requests.
 */  
public PageReference editDetails( ){
try{
 editable=true;
 for(Integer i=0; i<wrapperView.size(); i++){
   if(currentCase.status !='New' || currentCase.Is_In_Approval_Process__c == true){
   wrapperView[i].refDelFlag=false;
  }
    if(!String.isEmpty(wrapperView[i].brRequest.Branding_Sub_Products__c)){
     String[] subProd_split=wrapperView[i].brRequest.Branding_Sub_Products__c.split('\\;');
          for(integer j=0 ;j<subProd_split.size();j++ ){
              wrapperView[i].selectedSubProds.add(new SelectOption(subProd_split[j], subProd_split[j]+'',true));
          }
     }
    Set<String> selectedSubProdsList = new Set<String>();
    for ( SelectOption so : wrapperView[i].selectedSubProds) {
         selectedSubProdsList .add(so.getvalue());
    }
    subProdFilter(wrapperView[i]);
    List<SelectOption >finalvalues=new List<SelectOption >();
    for(SelectOption pickVal : wrapperView[i].allSubProds){
        if(wrapperView[i].selectedSubProds.size()>0){
             if(!selectedSubProdsList .contains(pickVal.getvalue()))
                 finalvalues.add(pickVal);
                 //wrapperView[i].allSubProds.add(new SelectOption(pickVal.getvalue() ,pickVal.getLabel()));
        }
        else{
                   finalvalues.add(pickVal);
                 //wrapperView[i].allSubProds.add(new SelectOption(pickVal.getvalue() ,pickVal.getLabel()));
        }
    }
    wrapperView[i].allSubProds.clear();
    wrapperView[i].allSubProds.addall(finalvalues);
    
 }
return null;
}catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    return null;
    }  
}

 /**
 * Name: Cancel
 * Params: None
 * Description: Method to implement the Cancel button.
 */ 
public PageReference Cancel( ){
flagVar=true;
return null;
}

 /**
 * Name: newReceeRecord
 * Params: None
 * Description: Method to create a new recce record from the branding request.
 */ 
public PageReference newReceeRecord(){
      PageReference pageReference = new PageReference ('/a15/e?CF00N3000000CHEPu='+currentCase.CaseNumber+'&CF00N3000000CHEPz='+EncodingUtil.urlEncode(shopName,'UTF-8')+'&CF00N3000000CHEPz_lkid='+shopId+'&retURL='+currentCase.Id);
      system.debug('hereeeee'+pageReference );
      pageReference.setRedirect(true);
      return pageReference;
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
         brandingRequest.brRequest.Branding_Approved_Rejected__c='';
     brandingRequest.brRequest.Branding_Installation__c='';
     wrapperView[i].selectedSubProds.clear();
     wrapperView[i].allSubProds.clear();
         wrapperView.add(brandingRequest);
    
}
}
for(Integer i=0; i<wrapperView.size(); i++){
     if(wrapperView[i].brRequest.Shop_Name__c != null){
         if( wrapperView[i+1].brRequest.Shop_Name__c == null){
         wrapperView[i+1].disabled=false;
         wrapperView[i+1].refDelFlag=true;
         break;
         }
         
         }
         else{
         wrapperView[i].disabled=false;
         wrapperView[i].refDelFlag=true;
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
}