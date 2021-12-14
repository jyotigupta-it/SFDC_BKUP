/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email:Pranitha_S@infosys.com
Description: Helper class for branding and collateral requests
 ****************************************************************************************/ 
public class CommonHelper {

// variable Declaration

public static List<profile> profileIds;
public static Boolean brRequests;

//private variables
 private STATIC FINAL string dealer='Dealer';
 private STATIC FINAL string distributor='Distributor';
 private STATIC FINAL string directDealer='Direct Dealer';
 private STATIC FINAL string RepairShop='Repair/Rework Dealer';

 /**
 * Name: CommonHelper
 * Params: None
 * Description: Constructor for initializing variables
 */
public CommonHelper(){

}

/**
 * Name: getUser
 * Params: None
 * Description: Method for fetching the current approver details
 */ 
public static List<user> getUser(id i){
 String s='Case';
 List<user> retUser = new List<User>();
 List<id> idList=new List<id>();  
 List<ProcessInstance> piList= new List<ProcessInstance>(); 
 try{
 piList=[SELECT Id, TargetObject.Name, TargetObjectID, TargetObject.Type, (SELECT Id, Actor.Name FROM WorkItems) FROM ProcessInstance WHERE Status ='Pending' AND IsDeleted = False AND TargetObjectID=:i AND TargetObject.Type=:s];      
    if(piList.size()!=0 && piList[0].WorkItems !=null){
        for(ProcessInstanceWorkitem WI : piList[0].WorkItems) {
          idList.add(WI.Actor.Id);
        } 
   retUser=[select id, Name, ProfileId, UserRoleId,profile.name from user where id IN: idList]; 
   } 
  }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    }
   return retUser;
  }

/**
 * Name: validateNew
 * Params: Branding_Request__c request,Map<Id,Branding_Request__c> accountMap, Case currentCase,Boolean validate
 * Description: Method for validation while saving the branding requests
 */ 
public static Boolean validateNew(Branding_Request__c request,Map<Id,Branding_Request__c> accountMap, Case currentCase,Boolean validate){ 
List<Branding_Request__c> brandingRequests = new List<Branding_Request__c>();
List<User> approver = new List<User>();
try{
Datetime d = datetime.now().addmonths(-6);
approver = CommonHelper.getUser(currentCase.id);
if(validate){
    brandingRequests = [SELECT Id,Branding_Request__c,Shop_Name__c,Branding_Products__c,Shop_Type__c,Branding_Sub_Type__c,Branding_Sub_Products__c FROM Branding_Request__c WHERE createdDate > :d  and
    recordtype.name='Branding Request'  and Shop_Name__c =:request.Shop_Name__c ];
}
else{
    brandingRequests = [SELECT Id,Branding_Request__c,Shop_Name__c,Branding_Products__c,Shop_Type__c,Branding_Sub_Type__c FROM Branding_Request__c WHERE createdDate > :d  and
    recordtype.name='Branding Request'  and Shop_Name__c =:request.Shop_Name__c and Branding_Request__c!=:currentCase.id];   
}

/*part of enhancement */

if(request.Shop_Name__r.Contact_Number_Mobile__c == null || request.Shop_Name__r.Primary_Contact_Person_Name__c == null
||request.Shop_Name__r.street_address__c == null || request.Shop_Name__r.City__c == null ||
request.Shop_Name__r.district__c==null || request.Shop_Name__r.state__c==null)
{

ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Primary contact or phone number or billing address is empty for the shop - ' + request.Shop_Name__r.name +'. Please click on the shop link and update. Once updated, please click on refresh.'));
        return false;
}

/*part of enhancement */

    if(request.Shop_Name__r.Metro_Non_Metro__c!=currentCase.Metro_Non_Metro__c){
     
     if(currentCase.Metro_Non_Metro__c =='Metro'){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Metro_Non_Metro_shops+' '+currentCase.city__c +'. Please select the '+currentCase.Metro_Non_Metro__c+' shop only'));}
    else{
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Metro_Non_Metro_shops+' '+currentCase.district__c +'. Please select the '+currentCase.Metro_Non_Metro__c+' shop only'));}
            
        return false;
    }
    
    if(request.Shop_Name__r.RecordType.name!=dealer && request.Shop_Name__r.RecordType.name!= distributor && request.Shop_Name__r.RecordType.name!=directDealer ){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper1));
        return false;
    }
     
    if(accountMap.size()!=0 && accountMap.containsKey(request.Shop_Name__c)){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper2));
        return false;
    }
    if(brandingRequests.size()>0 &&(request.Comments__c==null|| String.isBlank(request.Comments__c)) ){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter comments for shop '+
        request.Shop_Name__r.name+' as more than one branding request has been created for this shop in the last 6 months'));
        return false;
    }  
    if(validate){ 
    if(request.Shop_Name__r.name==null || String.isBlank(request.Shop_Name__r.name) || request.Shop_Description__c==null || request.Language__c==null || request.Branding_Products__c==null || 
    request.Branding_Type__c==null || request.Shop_Type__c==null || request.Branding_Sub_Products__c ==null){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper4+request.Shop_Name__r.name ));
        return false;
    }
    }
    else{
    if(request.Shop_Name__r.name==null || String.isBlank(request.Shop_Name__r.name) || request.Shop_Description__c==null || request.Language__c==null || request.Branding_Products__c==null || 
    request.Branding_Type__c==null || request.Shop_Type__c==null){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper4+request.Shop_Name__r.name ));
        return false;
    } 
    
    }   
    if(request.Shop_Type__c==RepairShop &&(request.Comments__c==null|| String.isBlank(request.Comments__c)) ){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter comments for Repair/Rework Dealer : '+request.Shop_Name__r.name ));
        return false;
    }  
    if(currentCase.status==System.Label.Branding_Request_Approved_by_Branding_Manager && approver.size()!=0 && approver[0].id==currentCase.Vendor__c &&
    (request.Branding_Installation__c=='' || (request.Branding_Installation__c!=''&&
    (request.Branding_Installation__c=='Partially Installed' || request.Branding_Installation__c=='Not Installed') && String.isBlank(request.Vendor_Comments__c))) ){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please make sure Branding Installation and Vendor comments are entered for : '+request.Shop_Name__r.name ));
        return false;
    }   
    if(currentCase.status==System.Label.Branding_Request_Completed_By_BDM && approver.size()!=0 && approver[0].id=='0053000000AkJlS' &&
    (request.Call_Center_Feedback__c=='' || (request.Call_Center_Feedback__c!=''&&
    String.isBlank(request.Call_Center_Comments__c)))){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please make sure Call Center Feedback and Call Center Comments are entered for : '+request.Shop_Name__r.name ));
        return false;
    }
    else
        return true;
   }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    return false;
    }
}

/**
 * Name: validateCreateRequestNew
 * Params: Account shop, Case currentCase,Boolean validate
 * Description: Method for validation while selecting shop in the branding requests
 */
public static Boolean validateCreateRequestNew(Account shop, Case currentCase,Boolean validate){ 
List<Branding_Request__c> brandingRequests = new List<Branding_Request__c>(); 
try{
Datetime d = datetime.now().addmonths(-6);
if(validate){
    brandingRequests = [SELECT createdDate,Name,Id,Branding_Request__c,Shop_Name__c,Branding_Request__r.status,Branding_Request__r.caseNumber,Branding_type__c,Branding_Request__r.createdDate,Branding_Request__r.owner.name,Branding_Products__c,Shop_Type__c
    FROM Branding_Request__c WHERE 
    Shop_Name__c =:shop.id and recordtype.name='Branding Request' ORDER BY name DESC LIMIT 1];
}
else{
    brandingRequests = [SELECT createdDate,Name,Id,Shop_Name__c,Branding_Request__c,Branding_Request__r.status,Branding_Request__r.caseNumber,Branding_type__c,Branding_Request__r.createdDate,Branding_Request__r.owner.name,Branding_Products__c,Shop_Type__c
    FROM Branding_Request__c WHERE 
    Shop_Name__c =:shop.id and recordtype.name='Branding Request' and Branding_Request__c!=:currentCase.id ORDER BY name DESC LIMIT 1];   
}

    if(shop.RecordType.name!=dealer &&shop.RecordType.name!= distributor && shop.RecordType.name!=directDealer ){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper1));
        return false;
    }
   /* if(shop.Metro_Non_Metro__c!=currentCase.Metro_Non_Metro__c){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Metro_Non_Metro_shops+' '+currentCase.City_Name__c));
        return false;
    }*/
    
    if(shop.Metro_Non_Metro__c!=currentCase.Metro_Non_Metro__c){
     
     if(currentCase.Metro_Non_Metro__c =='Metro'){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Metro_Non_Metro_shops+' '+currentCase.city__c +'. Please select the '+currentCase.Metro_Non_Metro__c+' shop only'));}
    else{
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Branding_Request_Metro_Non_Metro_shops+' '+currentCase.district__c +'. Please select the '+currentCase.Metro_Non_Metro__c+' shop only'));}
            
        return false;
    }
       return true;
    }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    return false;
    }
   
}

/**
 * Name: validateSixMonthShop
 * Params: Account shop, Case currentCase,Boolean validate
 * Description: Method for validation while selecting shop in the branding requests
 */

public static Boolean validateSixMonthShop(Branding_Request__c request,Case currentCase,Boolean validate){ 
List<Branding_Request__c> brandingRequests = new List<Branding_Request__c>(); 
try{
Datetime d = datetime.now().addmonths(-6);
if(validate){
    brandingRequests = [SELECT createdDate,Name,Id,Branding_Request__c,Shop_Name__c,Shop_Name__r.name,Branding_Request__r.status,Branding_Request__r.caseNumber,Branding_type__c,Branding_Request__r.createdDate,Branding_Request__r.owner.name,Branding_Products__c,Shop_Type__c
    FROM Branding_Request__c WHERE 
    Shop_Name__c =:request.Shop_Name__c and recordtype.name='Branding Request' ORDER BY name DESC LIMIT 1];
}
else{
    brandingRequests = [SELECT createdDate,Name,Id,Shop_Name__c,Shop_Name__r.name,Branding_Request__c,Branding_Request__r.status,Branding_Request__r.caseNumber,Branding_type__c,Branding_Request__r.createdDate,Branding_Request__r.owner.name,Branding_Products__c,Shop_Type__c
    FROM Branding_Request__c WHERE 
    Shop_Name__c =:request.Shop_Name__c and recordtype.name='Branding Request' and Branding_Request__c!=:currentCase.id ORDER BY name DESC LIMIT 1];   
}

    if(brandingRequests.size()>0){
    system.debug('coming:::');
        brRequests = true;
    if(brandingRequests[0].Branding_Products__c == request.Branding_Products__c){
    system.debug('coming1111:::'+brandingRequests[0].Branding_Products__c);
    system.debug('coming1111:::'+request.Branding_Products__c);
    
    if(request.Shop_Type__c != 'Repair/Rework Dealer'){
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Branding Requests have already been created for the shop '+ brandingRequests[0].Shop_Name__r.name+ '. The is a '+brandingRequests[0].Branding_Products__c + ' shop and the branding request is already created having the current status as '+brandingRequests[0].Branding_Request__r.status+'. This request was created by the '+brandingRequests[0].Branding_Request__r.owner.name+' on : '+brandingRequests[0].Branding_Request__r.createdDate));
       system.debug('coming222211:::'+request.Shop_Type__c);
        return false;
      }  
        
    }
   // else{ 
        //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'Branding Requests have already been created for the shop '+ brandingRequests[0].Shop_Name__r.name + '. The is a '+brandingRequests[0].Branding_Products__c + ' shop and the branding request is already created having the current status as '+brandingRequests[0].Branding_Request__r.status+'. This request was created by the '+brandingRequests[0].Branding_Request__r.owner.name +' on : '+brandingRequests[0].Branding_Request__r.createdDate));

        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Warning,'Branding Requests have already been created for the shop '+
       // shop.name+' in the last 6 months. The latest Branding Request No : '+brandingRequests[0].Branding_Request__r.caseNumber+' for this shop was created by '+brandingRequests[0].Branding_Request__r.owner.name+' for '+brandingRequests[0].Branding_type__c +' on : '+brandingRequests[0].Branding_Request__r.createdDate));
       // return true;
      // }
    }
   
       return true;
    }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    return false;
    }
   
}

/**
 * Name: clearAccountsNew
 * Params: List<brandingNewWrapper> wrapperView
 * Description: Method for clearing the branding requests
 */
public static void clearAccountsNew(List<brandingNewWrapper> wrapperView){
try{
    for(Integer i=0; i<wrapperView.size(); i++){
        if(wrapperView[i].brRequest.Shop_Name__c==null && wrapperView[i].brRequest.Shop_Name__r !=null ){
            wrapperView[i].brRequest.Shop_Name__r=null;
            wrapperView[i].brRequest.clear();
        }
      }
    }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    }  
}
 

/**
 * Name: validateAutoDisp
 * Params: List<Inventory_Request__c>  inr
 * Description: Method for for auto dispatch
 */
public static Boolean validateAutoDisp(List<Inventory_Request__c> inr){
try{
    Integer checkSize = 0;
    for(Inventory_Request__c inv : inr){
    if(inv.type_of_item__c != null || !String.isBlank(inv.Type_of_Item__c)){
    checkSize = checksize + 1;
    }
    
    }
    
    if (checkSize == 0){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper9));
    return false;
    }
    
    for(Inventory_Request__c inv : inr){
        integer Count = 0;
        if((inv.Quantity_Dispatched__c == 0 || inv.Quantity_Dispatched__c ==null) && inv.type_of_item__c != null){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper10));
        return false;
        }
        if((inv.Quantity_Dispatched__c != 0 && inv.Quantity_Dispatched__c != null) && inv.type_of_item__c == null){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper11));
        
        return false;        
        }
        
        for(Inventory_Request__c checkDupes : inr){
        
        if((inv.type_of_item__c ==checkDupes.type_of_item__c) && (inv.type_of_item__c != null) && (checkDupes.type_of_item__c != null)){
        Count = count +1;
        
        }
        
        
        }
        if(Count >= 2){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper8));
        return false;
        
        }
    
    }
    
  
     }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    } 
      return true;
}


/**
 * Name: validateCollateral
 * Params: Map<Id,Inventory_Request__c> invReqMap
 * Description: Method for validating collateral request
 */
 public static Boolean validateCollateral(Map<Id,Inventory_Request__c> invReqMap , List<inventory_Gift_request__c> giftList, Case currentCase){
   
   try{
    if(invReqMap.size() ==0 && giftList.size() == 0){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper6));
        return false;
    }
     integer Count = 0;

    for( ID invId : invReqMap.keyset()){
            if(invId == null){
         
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Invalid'));
            return false; 
        }
        Inventory_Request__c inv = invReqMap.get(invId);
           if(inv.type_of_item__c != null){
            
       // if((inv.type_of_item__r.type__c != 'Gifts' && inv.type_of_item__r.type__c != null)|| (inv.inventory_mega__r.type__c != 'Gifts' && inv.inventory_mega__r.type__c !=null) || (inv.inventory_mini__r.type__c != 'Gifts' && inv.inventory_mini__r.type__c!=null) ){
        if(inv.inventory_PackMaterials__r.type__c == System.Label.PACKING_MATERIALS || inv.inventory_product__r.type__c == System.Label.PRODUCT_COLLATERALS || inv.inventory_Sample__r.type__c == System.Label.SAMPLES ){
                       
            if((inv.Required_Quantity__c == 0 || inv.Required_Quantity__c ==null)) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_CommonHelper5));
                return false;
            } 
            } 
         
      if(currentCase.collateral_flows__c =='Requestor' && (currentcase.depo__c==UserInfo.getUserId() || currentcase.head_office__c == UserInfo.getUserId())){
          
          if((inv.Quantity_Dispatched__c == null)) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.QuantityDispatched_cannot_be_blank));
                return false;
            }
             
          } 
          
      else if(currentCase.Collateral_Flows__c =='Depot' && currentcase.head_office__c == UserInfo.getUserId()){
      
      if((inv.Quantity_Dispatched__c == null)) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.QuantityDispatched_cannot_be_blank));
                return false;
            }
             
              
           }
       
    }
    
          

   }
     }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    } 
     return true;
} 

/**
 * Name: clearInventories
 * Params: List<CollateralWrapper> productCollList, List<CollateralWrapper> sampleList, List<CollateralWrapper> packMaterialListequest
 * Description: Method for clearing inventories based on user entry
 */
public static void clearInventories(List<CollateralWrapper> productCollList, List<CollateralWrapper> sampleList, List<CollateralWrapper> packMaterialList, List<CollateralWrapper> megaGiftList, List<CollateralWrapper> MiniGiftList){
try{
for(Integer i=0; i<productCollList.size(); i++){

    if(productCollList[i].invRequest.inventory_Product__c==null){
  
        productCollList[i].invRequest.inventory_Product__r=null;          
        productCollList[i].invRequest.clear();
    }
  }

  for(Integer i=0; i<sampleList.size(); i++){
    if(sampleList[i].invRequest.inventory_Sample__c==null ){
        
        sampleList[i].invRequest.inventory_Sample__r=null;            
        sampleList[i].invRequest.clear();
    }
  }
  for(Integer i=0; i<packMaterialList.size(); i++){
    if(packMaterialList[i].invRequest.inventory_PackMaterials__c==null){
        
        packMaterialList[i].invRequest.inventory_PackMaterials__r=null;
               
        packMaterialList[i].invRequest.clear();
    }
  }
  
  for(Integer i=0; i<megaGiftList.size(); i++){

    if(megaGiftList[i].invRequest.inventory_mega__c==null){
  
        megaGiftList[i].invRequest.inventory_mega__r=null;          
        megaGiftList[i].invRequest.clear();
    }
  }

 for(Integer i=0; i<miniGiftList.size(); i++){

    if(miniGiftList[i].invRequest.inventory_mini__c==null){
  
        miniGiftList[i].invRequest.inventory_mini__r=null;          
        miniGiftList[i].invRequest.clear();
    }
  }

   }catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    } 
 
}

/**
 * Name: ValidateCollList
 * Params: List<CollateralWrapper> productCollList, List<CollateralWrapper> sampleList, List<CollateralWrapper> packMaterialList
 * Description: Method for validate the collaterals entered by user
 */
public static boolean ValidateCollList(List<CollateralWrapper> productCollList, List<CollateralWrapper> sampleList, List<CollateralWrapper> packMaterialList, List<CollateralWrapper> miniList, List<CollateralWrapper> megaList){

/* product List */
try{
Integer CountProd = 0;
for(CollateralWrapper prod : productCollList){
CountProd = 0;
if(prod.invRequest.Type_of_item__c!= null){
    for(CollateralWrapper prod1 : productCollList){
    if(prod1.invRequest.Type_of_item__c!= null){
    if(prod.invRequest.Type_of_item__c == prod1.invRequest.Type_of_item__c){
    CountProd = CountProd + 1;
    }
    }
}

if(CountProd >= 2){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.duplicate_collaterals));
       return false;
        }

}

  
}


/* Sample List */
Integer CountSamp = 0;
for(CollateralWrapper samp: sampleList){
CountSamp = 0;
if(samp.invRequest.Type_of_item__c!= null){
    for(CollateralWrapper samp1: sampleList){
    if(samp1.invRequest.Type_of_item__c!= null){
    
    if(samp.invRequest.Type_of_item__c == samp1.invRequest.Type_of_item__c){
    CountSamp = CountSamp + 1;
    }
 
}
}
if(CountSamp >= 2){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,system.Label.Duplicate_sample_collateral));
       return false;
        }
}
}

/* package Inventory List */
Integer Countpack = 0;
for(CollateralWrapper pack: packMaterialList){
Countpack = 0;
if(pack.invRequest.Type_of_item__c!= null){

    for(CollateralWrapper pack1: packMaterialList){
    if(pack1.invRequest.Type_of_item__c!= null){
    if(pack.invRequest.Type_of_item__c == pack1.invRequest.Type_of_item__c){
    Countpack = Countpack + 1;
    }
}
}
if(Countpack >= 2){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,system.label.Duplicate_packaging_collateral));
       return false;
        }
}
}

Integer Countmini = 0;
for(CollateralWrapper prod : miniList){
Countmini = 0;
if(prod.invRequest.Type_of_item__c!= null){
    for(CollateralWrapper prod1 : miniList){
    if(prod1.invRequest.Type_of_item__c!= null){
    if(prod.invRequest.Type_of_item__c == prod1.invRequest.Type_of_item__c){
    Countmini = Countmini + 1;
    }
    }
}

if(Countmini >= 2){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.duplicate_mini_gifts));
       return false;
        }

}

  
}


Integer Countmega = 0;
for(CollateralWrapper prod : megaList){
Countmega = 0;
if(prod.invRequest.Type_of_item__c!= null){
    for(CollateralWrapper prod1 : megaList){
    if(prod1.invRequest.Type_of_item__c!= null){
    if(prod.invRequest.Type_of_item__c == prod1.invRequest.Type_of_item__c){
    Countmega = Countmega + 1;
    }
    }
}

if(Countmega >= 2){
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.duplicate_mega_gifts));
       return false;
        }

}

  
}


 }
 catch(Exception e){
    System.debug('Exception Occurred'+e.getMessage());
    } 
         
return true;
}




}