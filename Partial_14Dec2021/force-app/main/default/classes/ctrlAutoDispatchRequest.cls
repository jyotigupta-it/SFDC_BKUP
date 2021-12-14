/*  
 * Author     : Renjay Surendran
 */ 
public with sharing class ctrlAutoDispatchRequest{

public Case currentCase{get;set;}
public Boolean flagVar{get;set;}
public List<Inventory_Request__c> invReqList{get;set;}
public String disabled{get; set;}
public List<inventory__c> inv;
public boolean flag=false;
public List<CollateralWrapper> productCollList{get;set;}
public List<CollateralWrapper> giftListMega{get;set;}
public List<CollateralWrapper> giftListMini{get;set;}
public List<CollateralWrapper> giftList{get;set;}
public List<CollateralWrapper> sampleList{get;set;}
public List<CollateralWrapper> packMaterialList{get;set;}
public List<inventory_Gift_request__c> gifReq {set; get;}
public Map<Id,Inventory_Request__c> invReqMap{get;set;}

public ctrlAutoDispatchRequest(ApexPages.StandardController stdController) { 
    try{
    disabled='y';
    RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Case' AND Name='Auto Dispatch' LIMIT 1];
    Final Id CaseRecordType=rt.id;
    
    inv=[select id, Name, Closing_Stocks__c, Used_Stock__c from inventory__c where Owner_Account__c=:UserInfo.getUserid()];
    
    currentCase = new Case();
    currentCase.status='Dispatched';
    currentCase.RecordTypeId = CaseRecordType;
    currentCase.Request_Raised_by__c = UserInfo.getUserid();
    invReqList = new List<Inventory_Request__c>();
    currentcase.Subject = 'Auto Dispatch of collateral requested by '+ UserInfo.getFirstname()+ ' ' + UserInfo.getLastName();
    productCollList= new List<CollateralWrapper>();
    sampleList= new List<CollateralWrapper>();
    packMaterialList= new List<CollateralWrapper>();
    giftListMega= new List<CollateralWrapper>();
    giftListMini= new List<CollateralWrapper>();
    invReqMap= new Map<Id,Inventory_Request__c>(); 


    for(integer i=0; i<5; i++){
    CollateralWrapper wrapper= new CollateralWrapper();
    wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
    productCollList.add(wrapper);
    }
    
    for(integer i=0; i<2; i++){
    CollateralWrapper wrapper= new CollateralWrapper();
    wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
    giftListMega.add(wrapper);
    }
    
    for(integer i=0; i<2; i++){
    CollateralWrapper wrapper= new CollateralWrapper();
    wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
    giftListMini.add(wrapper);
    }

    for(integer i=0; i<5; i++){
    CollateralWrapper wrapper= new CollateralWrapper();
    wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
    sampleList.add(wrapper);  
    }
    
    for(integer i=0; i<5; i++){
    CollateralWrapper wrapper= new CollateralWrapper();
    wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
    packMaterialList.add(wrapper);
    }
   } catch(exception e){system.debug(e.getMessage());}
}

 public PageReference getinventoryDetails(){
    
    flagVar=false;
     CommonHelper.clearInventories(productCollList, sampleList, packMaterialList,giftListMega,giftListMini);
        for(Integer i=0; i<productCollList.size(); i++){
            if(productCollList[i].invRequest.inventory_Product__c!=null){
                Inventory__c invDetails= queryInventory(productCollList[i].invRequest.inventory_Product__c);
                productCollList[i].invRequest.inventory_Product__r=invDetails;
            }
        }
        
        for(Integer i=0; i<giftListMega.size(); i++){
        if(giftListMega[i].invRequest.inventory_mega__c!=null){
        Inventory__c invDetails= queryInventory(giftListMega[i].invRequest.inventory_mega__c);
        system.debug('invDetails:::'+ invDetails);
        giftListMega[i].invRequest.inventory_mega__r=invDetails;
        } 
        }
        
        for(Integer i=0; i<giftListMini.size(); i++){
        if(giftListMini[i].invRequest.inventory_mini__c!=null){
        Inventory__c invDetails= queryInventory(giftListMini[i].invRequest.inventory_mini__c);
        giftListMini[i].invRequest.inventory_mini__r=invDetails;
        }
        }
        
        for(Integer i=0; i<sampleList.size(); i++){
            if(sampleList[i].invRequest.inventory_Sample__c!=null){
                Inventory__c invDetails= queryInventory(sampleList[i].invRequest.inventory_Sample__c);

                sampleList[i].invRequest.inventory_Sample__r=invDetails;
            }
        }
        
        for(Integer i=0; i<packMaterialList.size(); i++){
            if(packMaterialList[i].invRequest.inventory_PackMaterials__c!=null){
                Inventory__c invDetails= queryInventory(packMaterialList[i].invRequest.inventory_PackMaterials__c);
                packMaterialList[i].invRequest.inventory_PackMaterials__r=invDetails;
        }
        }
        
        return null;
}

public inventory__c queryInventory(Id invId){
    inventory__c invRecord= new inventory__c();
    invRecord=[select id,name,Color_Language_Size__c, Product_Description__c, Type__c, Item_Code__c, Product__c from inventory__c where id=: invId];
    return invRecord;
} 

public PageReference saveDetails( ){
try{
        system.debug('currentCase.Request_User__c::'+currentCase.Request_User__c);
        if(currentCase.Request_User__c==null && currentCase.Request_Account__c==null)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_AutoDispatch1));
            return null;
        }
        
        if(currentCase.Request_User__c==null)
        {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,System.Label.Infy_AutoDispatch1));
            return null;
        }
        
        if(currentCase.Request_User__c!=null)
        {
            User u1=[select ProfileId, Depo__c from User where id=:currentCase.Request_User__c];
            User u2=[select ProfileId from User where id=:UserInfo.getUserid()];
            Profile p1=[select name from Profile where id=:u1.ProfileId];
            Profile p2=[select name from Profile where id=:u2.ProfileId];
            if((p1.name=='BDM'||p1.name=='BD')&&p2.name!='Warehouse'&&u1.Depo__c!=null)
            {
                currentCase.Check_Gifts__c=TRUE;
                currentCase.Depo__c=u1.Depo__c;
                User UserDetail =  [select address from  User where id =: u1.Depo__c];        
                Address addr = UserDetail.Address;
                if(addr!=null)
                currentCase.Through_Depot_Shipping_Address__c= addr.getStreet()+' '+addr.getcity()+' '+ addr.getstate()+' '+addr.getPostalCode()+' '+addr.getcountry();
            }
        }
       // if(currentCase.Request_User__c==null && currentCase.Request_Account__c!=null)
        //{    
          //  Account acc = [select OwnerId from account where id =:currentCase.Request_Account__c];
            //currentCase.Request_User__c=acc.OwnerId;
        //}

        invReqMap.clear();
        invReqList.clear();
        flagVar = false;
        List<inventory__c> finalInv= new List<inventory__c>();
        List<Inventory_Request__c> finalInvReqList = new List<Inventory_Request__c>();  
        List<inventory_Gift_request__c> finalInvReqGiftList = new List<inventory_Gift_request__c>();
        List<inventory_Gift_request__c> rejectedInvReqGiftList = new List<inventory_Gift_request__c>();
        
        for(Integer i=0; i<productCollList.size(); i++){

            if(productCollList[i].invRequest.inventory_Product__c!=null){
                productCollList[i].invRequest.type_of_item__c = productCollList[i].invRequest.inventory_Product__c;
                invReqMap.put(productCollList[i].invRequest.inventory_Product__c,productCollList[i].invRequest);
                invReqList.add(productCollList[i].invRequest);
            }
        }
        
        for(Integer i=0; i<sampleList.size(); i++){
            if(sampleList[i].invRequest.inventory_sample__c!=null ){
                sampleList[i].invRequest.type_of_item__c =sampleList[i].invRequest.inventory_sample__c;
                invReqMap.put(sampleList[i].invRequest.inventory_sample__c,sampleList[i].invRequest);
                invReqList.add(sampleList[i].invRequest);
            } 
        }

        for(Integer i=0; i<packMaterialList.size(); i++){
            if(packMaterialList[i].invRequest.inventory_PackMaterials__c!=null){
                packMaterialList[i].invRequest.type_of_item__c=packMaterialList[i].invRequest.inventory_PackMaterials__c;
                invReqMap.put(packMaterialList[i].invRequest.inventory_PackMaterials__c,packMaterialList[i].invRequest);
                invReqList.add(packMaterialList[i].invRequest);
            }
        }

        for(Integer i=0; i<giftListMega.size(); i++){
            if(giftListMega[i].invRequest.inventory_mega__c!=null){        
                giftListMega[i].invRequest.type_of_item__c=giftListMega[i].invRequest.inventory_mega__c;
                invReqMap.put(giftListMega[i].invRequest.inventory_mega__c,giftListMega[i].invRequest);
                invReqList.add(giftListMega[i].invRequest);
            }
        }

        for(Integer i=0; i<giftListMini.size(); i++){
            if(giftListMini[i].invRequest.inventory_mini__c!=null){        
                giftListMini[i].invRequest.type_of_item__c=giftListMini[i].invRequest.inventory_mini__c;
                invReqMap.put(giftListMini[i].invRequest.inventory_mini__c,giftListMini[i].invRequest);
                invReqList.add(giftListMini[i].invRequest);
            }
        }
  //
  //commonhelper.validateCollateral(invReqMap,finalInvReqGiftList,currentCase)&&commonhelper.ValidateCollList(productCollList,sampleList,packMaterialList,giftListMini, giftListMega)
  if(CommonHelper.validateAutoDisp(invReqList)){

    upsert currentCase;
    for(Inventory_Request__c request : invReqList){
    if(request.Type_of_Item__c!=null || !String.isBlank(request.Type_of_Item__c) ){
        for(inventory__c req: inv)
        { 
           if(req.id==request.type_of_item__c)
           {  
                req.Closing_Stocks__c-=request.Quantity_Dispatched__c;
                req.Used_Stock__c+=request.Quantity_Dispatched__c;
                finalInv.add(req);
           }
        }
    request.Inventory_Request_Number__c = currentCase.id;
    request.Request_Rasied_by__c= currentCase.Request_Raised_by__c;
    finalInvReqList.add(request);
    }
    }
    update finalInv;
    insert finalInvReqList;
    
    //currentCase.OwnerId=currentCase.Request_User__c;                             
    update currentCase;
    system.debug('!!!!'+currentCase);
    List<caseShare> caseShareList = new List<caseShare>();
      if(currentCase.depo__c !=null){
            CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.depo__c;
               caseShare.CaseAccessLevel= 'Edit';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare); 
           }
        CaseShare caseShare1=new CaseShare();
               caseShare1.UserOrGroupID = currentCase.Request_User__c;
               caseShare1.CaseAccessLevel= 'Edit';
               caseShare1.CaseId= currentCase.Id;
               caseShare1.RowCause = 'Manual';
                caseShareList.add(CaseShare1); 
           
     if(caseShareList.size()!=0 && caseShareList !=null){
           upsert caseShareList;}
    
    List<Inventory__share> invShareList = new List<Inventory__share>();
    for(inventory__c inv : finalInv){
    
    if(currentCase.depo__c !=null){
    Inventory__share invShare = new Inventory__share();    
   invShare.UserOrGroupID = currentCase.depo__c;
   invShare.AccessLevel= 'Read';
   invShare.parentId= inv.Id;
   invShare.RowCause = 'Manual';
   invShareList.add(invShare);
    
    }
    
   Inventory__share invShare1 = new Inventory__share();    
   invShare1.UserOrGroupID = currentCase.Request_User__c;
   invShare1.AccessLevel= 'Read';
   invShare1.ParentId= inv.Id;
   invShare1.RowCause = 'Manual';
   invShareList.add(invShare1);
    }
    
   if(invShareList.size()!=0 && invShareList !=null){
           upsert invShareList;}
           
            
    Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
    req1.setObjectId(currentCase.id);
    system.debug('@@@@'+req1);
    Approval.ProcessResult result = Approval.process(req1);
    
  
             
    PageReference reference=new PageReference('/'+currentCase.id);
    reference.setRedirect(true);
    return reference;
}
else
   return null;
}
catch(exception e){system.debug('####'+e.getMessage()); return null;}
}

public PageReference Cancel(){  
 try{
   Schema.DescribeSObjectResult result = Case.SObjectType.getDescribe();
    PageReference pageRef = new PageReference('/' + result.getKeyPrefix()+ '/o');
    pageRef.setRedirect(true);
    return pageRef;
  }

 catch(exception e){system.debug(e.getMessage()); return null;}

}
public Boolean getIsAccount() {
      try{ 
       if(disabled.equals('Account')) 
        return true;
        
       return false; 
       }
 catch(exception e){system.debug(e.getMessage()); return null;}
    }
public Boolean getIsUser() {
      try{
       if(disabled.equals('User')) 
        return true;
        
       return false; 
       }
 catch(exception e){system.debug(e.getMessage()); return null;}

}

public PageReference test() {
    try{
        currentcase.Shipping_Address__c=' ';
        currentcase.Request_User__c=null;
        currentCase.Request_Account__c=null;
        return null;
        }
 catch(exception e){system.debug(e.getMessage()); return null;}

}   
public void getShipping(){
try{

    if(disabled.equals('User'))
    {
      User UserDetail =  [select address from  User where id =: currentCase.Request_User__c];        
      Address addr = UserDetail.Address;
      if(addr!=null)
      currentcase.Shipping_Address__c = addr.getStreet()+' '+addr.getcity()+' '+ addr.getstate()+' '+addr.getPostalCode()+' '+addr.getcountry();
    } 
    if(disabled.equals('Account'))
    {
      Account acc = [select BillingStreet,BillingCity, BillingState, BillingPostalCode,BillingCountry,Street_Address__c,City__c,State__c, District__c,
      PIN_Code__c from account where id =:currentCase.Request_Account__c];
      if(acc.Street_Address__c!=null||acc.City__c!=null||acc.State__c!=null||acc.PIN_Code__c!=null||acc.District__c!=null)
      currentcase.Shipping_Address__c = acc.Street_Address__c+' '+acc.City__c+' '+ acc.State__c+' '+acc.District__c+' '+acc.PIN_Code__c; 
      if(acc.BillingStreet!=null||acc.BillingCity!=null||acc.BillingState!=null||acc.BillingPostalCode!=null||acc.BillingCountry!=null)
      currentcase.Billing_Address__c = acc.BillingStreet+' '+acc.BillingCity+' '+ acc.BillingState+' '+acc.BillingPostalCode+' '+acc.BillingCountry ;
    }
}
 catch(exception e){system.debug(e.getMessage());}

}
}