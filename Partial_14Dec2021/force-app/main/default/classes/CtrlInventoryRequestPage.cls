/***************************************************************************************
Copyright Â© 2015 Ashirvad. All rights reserved.
Author: vasanthi K N
Email: vasanthi_KN@infosys.com
Description:  Class to create the collateral request
 ****************************************************************************************/
public with sharing class CtrlInventoryRequestPage{

    public Case currentCase{get;set;}
    public List<CollateralWrapper> productCollList{get;set;}
    public List<CollateralWrapper> giftList{get;set;}
    public List<CollateralWrapper> sampleList{get;set;}
    public List<CollateralWrapper> packMaterialList{get;set;}
    public List<inventory_Gift_request__c> gifReq {set; get;}
    public Map<Id,Inventory_Request__c> invReqMap{get;set;}

    
    
    public CtrlInventoryRequestPage(ApexPages.StandardController stdController) { 
        
        RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Case' AND Name='Collateral Request' LIMIT 1];
        Final Id CaseRecordType=rt.id;
        currentCase = new Case();
        currentCase.RecordTypeId = CaseRecordType;
        productCollList= new List<CollateralWrapper>();
        giftList= new List<CollateralWrapper>();
        sampleList= new List<CollateralWrapper>();
        packMaterialList= new List<CollateralWrapper>();
        gifReq = new List<inventory_Gift_request__c>();
        invReqMap= new Map<Id,Inventory_Request__c>();       
        
        currentCase.Request_Raised_by__c = UserInfo.getUserid();
        currentcase.Subject = 'Request for collateral by '+ UserInfo.getFirstname()+ ' ' + UserInfo.getLastName();
        currentCase.priority ='Medium';
        currentCase.origin = 'Self';
        User UserDetail =  [select address, depot_zone__c, depo__c, head_office__c, team_lead__c from  User where id =: UserInfo.getUserid()];    

        Address addr = UserDetail.Address;
        
        if(addr != null){
            currentcase.Shipping_Address__c = addr.getStreet()+ ' ' + addr.getcity() + ' '  + addr.getstate()+ ' '
            +  addr.getPostalCode() +' '+ addr.getcountry();
        }
        else{
            currentcase.Shipping_Address__c =''; 
        }
        currentCase.depo__c=userDetail.depo__c;
        currentCase.head_office__c = userDetail.head_office__c;
        currentCase.Team_Lead__c = userDetail.team_lead__c;
        if(userDetail.depo__c != null){
        User DepoDetail =  [select address, depot_zone__c, depo__c, head_office__c, team_lead__c from  User where id =: userDetail.depo__c];    
        if(DepoDetail !=null){
        currentCase.depot_zone__c =DepoDetail.depot_zone__c;}
        }
        String profileName =[Select Id,Name from Profile where Id=:userinfo.getProfileId()].Name;
        if(profileName == 'Warehouse'){
        currentCase.Collateral_Flows__c ='Depot';
        currentCase.depot_zone__c = userDetail.depot_zone__c;
        }
        else if(profileName  == 'CSO Depot'){
        currentCase.Collateral_Flows__c ='CSO';
        }
        else{
        currentCase.Collateral_Flows__c ='Requestor';
        }
        
        for(integer i=0; i<5; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
            productCollList.add(wrapper);

        }
        for(integer i=0; i<3; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
            giftList.add(wrapper);

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
       
            for(integer i=0; i< 2; i++){
            inventory_Gift_request__c gifRequest = new inventory_Gift_request__c();
             gifRequest.Request_Raised_by__c = UserInfo.getUserid(); 
             if(i==0){
                 gifRequest.Type_Of_Meet__c =  'Mega Meet';}
                 else{
             gifRequest.Type_Of_Meet__c =  'Mini Meet';}
             gifReq.add(gifRequest);

            }  
            
            
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

    public PageReference getinventoryDetails(){
       
        CommonHelper.clearInventories(productCollList, sampleList, packMaterialList,giftList, giftList);
        for(Integer i=0; i<productCollList.size(); i++){
           
            if(productCollList[i].invRequest.inventory_Product__c!=null){
                Inventory__c invDetails= queryInventory(productCollList[i].invRequest.inventory_Product__c);
               
                productCollList[i].invRequest.inventory_Product__r=invDetails;
               
            }
           
        }
    
        for(Integer i=0; i<giftList.size(); i++){
            if(giftList[i].invRequest.Type_of_item__c!=null){
                Inventory__c invDetails= queryInventory(giftList[i].invRequest.Type_of_item__c);
                // if(CommonHelper.validateCreateRequestNew(accountRecord ,currentCase)){
                giftList[i].invRequest.Type_of_item__r=invDetails;
                //   }
            }
           

        }

        for(Integer i=0; i<sampleList.size(); i++){
            if(sampleList[i].invRequest.inventory_Sample__c!=null){
                Inventory__c invDetails= queryInventory(sampleList[i].invRequest.inventory_Sample__c);
                // if(CommonHelper.validateCreateRequestNew(accountRecord ,currentCase)){
                sampleList[i].invRequest.inventory_Sample__r=invDetails;
                //   }
            }
            
        }

        for(Integer i=0; i<packMaterialList.size(); i++){
            if(packMaterialList[i].invRequest.inventory_PackMaterials__c!=null){
                Inventory__c invDetails= queryInventory(packMaterialList[i].invRequest.inventory_PackMaterials__c);
                // if(CommonHelper.validateCreateRequestNew(accountRecord ,currentCase)){
                packMaterialList[i].invRequest.inventory_PackMaterials__r=invDetails;
                //   }
            }
          
        }
        return null;
    }


    Public inventory__c queryInventory(Id invId){
        inventory__c invRecord= new inventory__c();
        invRecord=[select id,name,Color_Language_Size__c, Product_Description__c, Type__c, Item_Code__c, Product__c from inventory__c where id=: invId];
        return invRecord;
    } 
    
     public PageReference saveDetails( ){
        invReqMap.clear();
        
       List<inventory_Gift_request__c> finalInvReqGiftList = new List<inventory_Gift_request__c>();
             for(Integer i=0; i<productCollList.size(); i++){
       
              if(productCollList[i].invRequest.inventory_Product__c!=null){
                    productCollList[i].invRequest.type_of_item__c = productCollList[i].invRequest.inventory_Product__c;
                invReqMap.put(productCollList[i].invRequest.inventory_Product__c,productCollList[i].invRequest);
          
                 } 
        }
             
       for(Integer i=0; i<sampleList.size(); i++){
        if(sampleList[i].invRequest.inventory_sample__c!=null ){
          sampleList[i].invRequest.type_of_item__c =sampleList[i].invRequest.inventory_sample__c;
          invReqMap.put(sampleList[i].invRequest.inventory_sample__c,sampleList[i].invRequest);
                           } 
        }
        
       for(Integer i=0; i<packMaterialList.size(); i++){
        if(packMaterialList[i].invRequest.inventory_PackMaterials__c!=null){
        packMaterialList[i].invRequest.type_of_item__c=packMaterialList[i].invRequest.inventory_PackMaterials__c;
                invReqMap.put(packMaterialList[i].invRequest.inventory_PackMaterials__c,packMaterialList[i].invRequest);
             } 
        }
        if(commonhelper.ValidateCollList(productCollList,sampleList,packMaterialList,giftList,giftList)){
        upsert currentCase;
                   
      for(inventory_Gift_request__c gif: gifReq){
        if(gif.Required_Quantity__c != null){
        gif.Case__c= currentCase.id;
        finalInvReqGiftList.add(gif);
        }
        } 
         
               
          for(inventory_Request__c req:invReqMap.values() ){
                req.Inventory_Request_Number__c=currentCase.id;
             }   
          if(commonhelper.validateCollateral(invReqMap,finalInvReqGiftList, currentCase)){
 
            insert invReqMap.values(); 
            
            if( finalInvReqGiftList.size()!= 0){
            currentCase.check_gifts__c = true;
            upsert currentCase;
            }
            insert finalInvReqGiftList;
            List<caseShare> caseShareList = new List<caseShare>();
            if(currentCase.Team_Lead__c != null){
               CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.Team_Lead__c;
               caseShare.CaseAccessLevel= 'Read';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare);      
            }
           if(currentCase.depo__c !=null){
            CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.depo__c;
               caseShare.CaseAccessLevel= 'Edit';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare); 
           }
           if(currentCase.head_office__c !=null){
            CaseShare caseShare=new CaseShare();
               caseShare.UserOrGroupID = currentCase.head_office__c;
               caseShare.CaseAccessLevel= 'Edit';
               caseShare.CaseId= currentCase.Id;
               caseShare.RowCause = 'Manual';
               caseShareList.add(CaseShare); 
           }
          if(caseShareList.size()!=0 && caseShareList !=null){
           insert caseShareList;}
           
            PageReference reference=new PageReference('/'+currentCase.id);
            reference.setRedirect(true);
            
            return reference;
            
            
        
           }
           
           }
           return null;
}
   }