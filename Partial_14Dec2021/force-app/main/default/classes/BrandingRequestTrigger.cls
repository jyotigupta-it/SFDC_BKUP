/***************************************************************************************
Copyright © 2015 Ashirvad. All rights reserved.
Author: Pranitha S
Email: Pranitha_S@infosys.com
Description:  Handler class for trigBrandingRequestTrigger.
 ****************************************************************************************/
public class BrandingRequestTrigger{

public static RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];

public static RecordType Rtb = [select Id from RecordType where Name ='Branding Request' and SobjectType = 'case'];

    /***********************************
 Description: Method to update the dispatch date for the batch classes
     ************************************/
 
 /*public void updateDispatchDate(){
  try{
         if(trigger.isbefore && trigger.isupdate){
             List<Case> CollateralRequestRecords=new List<Case>();
             RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
                String oldstatus;
                String newstatus;
                for(sobject collRequest : trigger.new){
                 Case caseRequest= (Case)collRequest;
                  if(caseRequest.recordtypeId ==Rt.id){
                      newstatus = caseRequest.status;

                 if(caseRequest.status=='Dispatched'){


                 CollateralRequestRecords.add(caseRequest);
                 }
                 }
                 }
                  for(sobject collRequest1 : trigger.old){
                    Case invRequest1 = (Case)collRequest1;
                    if(invRequest1.recordtypeId ==Rt.id){
                       oldstatus=invRequest1.status;
                                           } 
                }
if(oldstatus != newstatus){
              List<Case> finalList = new List<case>();   
            for(Case dispatchCase :CollateralRequestRecords ){
            dispatchCase.Email_Date__c=Date.today();
        dispatchCase.Dispatch_Date__c=Date.today();
        finalList .add(dispatchCase);

            }
            update finalList;
                 }
                 }
                 }

                    catch(exception e){system.debug(e.getMessage());}
 }    */       
  
  public void beforeUpdateCall(){
  List<Case> CollateralRequestRecords=new List<Case>();
  List<Case> BrandingRequestRecords=new List<Case>();
  for(sobject collRequest : trigger.new){
                    Case CaseRequest = (Case)collRequest;
                    if(CaseRequest.recordtypeId ==Rt.id){
                    CollateralRequestRecords.add(CaseRequest);
                    }
                    else if(CaseRequest.recordtypeId ==Rtb.id){
                    BrandingRequestRecords.add(CaseRequest);
                    }
                    }
    BrandingRequestTrigger triggerHandler =  new BrandingRequestTrigger();
    TaskForApprovalProcess tasks = new TaskForApprovalProcess();
   system.debug('CollateralRequestRecords.size()::'+CollateralRequestRecords.size());
   if(CollateralRequestRecords.size() != 0){
        triggerHandler.updateStock();        
        tasks.taskForInventory();
        triggerhandler.checkCollateralApproval();
   }
   system.debug('BrandingRequestRecords.size()::'+BrandingRequestRecords.size());
   if(BrandingRequestRecords.size() != 0){
        triggerhandler.checkBrandingApproval();
        triggerhandler.checkBrandingRejection();
        triggerHandler.fetchVendor();
        triggerHandler.shareBrandingRequests();        
        tasks.taskForBranding();
   }
   
  
  }
  
  
  public void AfterUpdateCall(){
  
  List<Case> CollateralRequestRecords=new List<Case>();
  List<Case> BrandingRequestRecords=new List<Case>();
  for(sobject collRequest : trigger.new){
                    Case CaseRequest = (Case)collRequest;
                    if(CaseRequest.recordtypeId ==Rt.id){
                    CollateralRequestRecords.add(CaseRequest);
                    }
                    else if(CaseRequest.recordtypeId ==Rtb.id){
                    BrandingRequestRecords.add(CaseRequest);
                    }
                    }
   if(CollateralRequestRecords.size() != 0){
       
   }
   
   if(BrandingRequestRecords.size() != 0){
        RecceHWUpdation recceUpdate= new RecceHWUpdation();
        recceUpdate.updtHeightWidth();
   }
  
  
  
  
  }  
    /***********************************
 Description: Method to update the stock 
 in the requestor and Depo/Warehouse
     ************************************/
 public void updateStock(){
        try{
        system.debug('here');
            if(trigger.isbefore && trigger.isupdate){
                List<Case> CollateralRequestRecords=new List<Case>();

                List<id> caseid = new List<id>();
                List<Id> depoOwner = new List<Id>();
                List<Id> HoOwner= new List<Id>();
                List<Id> requestOwner = new List<Id>();
                List<Inventory_request__C> masterDataIR = new List<inventory_request__c>();
                List<Inventory__c> invDepo = new  List<Inventory__c>();
                List<Inventory__c> invho = new  List<Inventory__c>();
                List<Inventory__c> requestown= new  List<Inventory__c>();
                Map<id, List<Inventory_request__C>> IrMap1 = new Map<id, List<Inventory_request__C>>();
                Map<id, List<Inventory_request__C>> IrMap2 = new Map<id, List<Inventory_request__C>>();
                Map<id, List<Inventory_request__C>> IrMap3 = new Map<id, List<Inventory_request__C>>();
              
                String oldStatus;
                String newStatus;

                for(sobject collRequest : trigger.new){
                    Case CaseRequest = (Case)collRequest;
                    if(CaseRequest.recordtypeId ==Rt.id){                     
                        Case caseRequestOld = (Case)Trigger.oldMap.get(CaseRequest.id);
                        system.debug('CaseRequest.status' + CaseRequest.status);
                        system.debug('caseRequestOld.status' + caseRequestOld.status);
                        oldStatus = caseRequestOld.status;
                        newStatus =  CaseRequest.status;                     
                        if(CaseRequest.status != caseRequestOld.status){
                            caseid.add(CaseRequest.id);
                            depoOwner.add(CaseRequest.Depo__c);
                            CollateralRequestRecords.add(CaseRequest);
                            HoOwner.add(CaseRequest.Head_Office__c);
                            requestOwner.add(CaseRequest.Request_Raised_By__c);
                        } 
                    }
                }

        if(caseid.size() !=0){
                masterDataIR=[select Inventory_Request_Number__c, Quantity_Dispatched__c, Request_Rasied_by__c, Type_of_Item__c,
                              Type_of_Item__r.Received_Stock__c, Type_of_Item__r.Closing_Stocks__c,
                              Type_of_item__r.type__c, Type_of_item__r.product__c, Type_of_item__r.Product_Description__c, 
                              type_of_item__r.Color_Language_Size__c, type_of_item__r.Type_Of_Meet__c                         
                              from Inventory_request__C where Inventory_Request_Number__c in : caseid];

                invDepo = [Select Received_Stock__c,Closing_Stocks__c,type__c, product__c ,Product_Description__c, Color_Language_Size__c,Type_Of_Meet__c, Owner_Account__c from inventory__c
                           where Owner_Account__c in:DepoOwner];

                invho = [Select Received_Stock__c,Closing_Stocks__c,type__c, product__c ,Product_Description__c, Color_Language_Size__c,Type_Of_Meet__c, Owner_Account__c from inventory__c
                         where Owner_Account__c in:HoOwner];

                requestown= [Select Received_Stock__c,Closing_Stocks__c,type__c, product__c ,Product_Description__c, Color_Language_Size__c,Type_Of_Meet__c, Owner_Account__c from inventory__c
                             where Owner_Account__c in:requestOwner];
               
                if(CollateralRequestRecords.size()!=0){

                    List<Inventory__c> finalList = new List<Inventory__c>();

                    for(Case caseRequest :CollateralRequestRecords) {
                        If(caseRequest.status.equals('Dispatched')){
                            List<Inventory_request__c> irList1 = new List<Inventory_request__c>();

                            for(Inventory_request__C IR : masterDataIR) {
                                if(ir.Inventory_Request_Number__c.equals(caseRequest.Id)){     
                                    
                                    irList1.add(ir);
                                }
                            }
                           
                            if(irList1.size() !=0){
                                irmap1.put(caseRequest.Id, irList1);
                            }

                        }

                        else if(caseRequest.status.equals('Completed')){
                            List<Inventory_request__c> irList2 = new List<Inventory_request__c>();
                            for(Inventory_request__C IR : masterDataIR) {

                                if(ir.Inventory_Request_Number__c.equals(caseRequest.Id)){     
                                    
                                    irList2.add(ir);
                                }
                            }

                          
                            if(irList2.size() !=0){
                                irmap2.put(caseRequest.Id, irList2);
                            } 

                        }

                        else if(caseRequest.status.equals('Corrected Dispatch')){
                            List<Inventory_request__c> irList3 = new List<Inventory_request__c>();
                            for(Inventory_request__C IR : masterDataIR) {

                                if(ir.Inventory_Request_Number__c.equals(caseRequest.Id)){     
                                    
                                    irList3.add(ir);
                                }
                            }
                           
                            if(irList3.size() !=0){
                                irmap3.put(caseRequest.Id, irList3);
                            }      
                        }
                    }
                }



                /* for Dispatched status*/
                if(irMap1.size()!=0){
                    
                    computeDispatchedStock(irMap1, invDepo, invHO, CollateralRequestRecords, requestown);
                }   

                /*for completed status*/
                if(irMap2.size()!=0){
                if(oldStatus =='Auto Approved' && newStatus=='Completed'){
                 computeCompletedStockForCSO(irMap2,CollateralRequestRecords,requestown);
                }
                else
                {   
                 computeCompletedStock(irMap2,CollateralRequestRecords,requestown);
                }    
                }
                /*for corrected dispatch status*/

                if(irMap3.size()!=0){

                    computeCorrectedDispatchStock(irMap3, invDepo, invHO, CollateralRequestRecords, requestown);

                }  
            } 
            }         
        }
        catch(exception e){system.debug(e.getMessage());}
    }


    public void computeDispatchedStock(Map<id, List<Inventory_request__C>> IrMap1,List<Inventory__c> invDepo, List<Inventory__c> invho, List<Case> CollateralRequestRecords, List<Inventory__c> requestown){
         try{
        List<inventory__c> invent = new List<inventory__c>();
        for(Case caseRequest :CollateralRequestRecords){
            List<inventory_request__c> inv = new List<Inventory_request__c>();

            inv=irMap1.get(caseRequest.id);
            for(inventory_Request__c inr: inv){
                
                if(inr.Type_of_Item__r.type__c ==System.label.GIFT_ITEMS){
                for(inventory__c inc :requestown){
                
                 if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){                          
                                
                inc.Received_Stock__c = inr.Quantity_Dispatched__c;
                 invent.add(inc);
                                }
                }
                
                }
                else{
                inr.Type_of_Item__r.Received_Stock__c = inr.Quantity_Dispatched__c;
                
                invent.add(inr.Type_of_Item__r);
                    }
                if(caseRequest.depo__c != null){
                    for(inventory__c inc :invDepo){
                        
                        // if(inr.type_of_item__r.name.equals(inc.name)){
                        if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){                          
                           
                            inc.Closing_Stocks__c = inc.Closing_Stocks__c - inr.Quantity_Dispatched__c;
                           
                            invent.add(inc);

                        }
                    }
                }
                else if((caseRequest.depo__c == null)&&(caseRequest.head_office__c != null)){
                    for(inventory__c inc :invHO){
                        if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){
                            inc.Closing_Stocks__c = inc.Closing_Stocks__c - inr.Quantity_Dispatched__c;
                            invent.add(inc);       
                        }
                    }
                }
            }         
        }  
        update invent;
}
catch(exception e){system.debug(e.getMessage());}
    }

    public void computeCompletedStock(Map<id, List<Inventory_request__C>> IrMap2, List<Case> CollateralRequestRecords, List<Inventory__c> requestown){
        try{
        List<inventory__c> inventry = new List<inventory__c>();
        for(Case caseRequest :CollateralRequestRecords){
            List<inventory_request__c> inv = new List<Inventory_request__c>();
            inv=irMap2.get(caseRequest.id);
            for(inventory_Request__c inr: inv){
            
             if(inr.Type_of_Item__r.type__c ==System.label.GIFT_ITEMS){
                for(inventory__c inc :requestown){
                if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){                          
                        
                inc.Closing_Stocks__c = inc.Closing_Stocks__c + inc.Received_Stock__c;
                inc.Received_Stock__c =0;                        
                inventry.add(inc);
                }
            
            }
            }
                else{inr.Type_of_Item__r.Closing_Stocks__c = inr.Type_of_Item__r.Closing_Stocks__c + inr.Type_of_Item__r.Received_Stock__c;
                inr.Type_of_Item__r.Received_Stock__c =0;                        
                inventry.add(inr.Type_of_Item__r); }       
            }
        }
        update inventry;
        }
catch(exception e){system.debug(e.getMessage());}
    }

public void computeCompletedStockForCSO(Map<id, List<Inventory_request__C>> IrMap2, List<Case> CollateralRequestRecords, List<Inventory__c> requestown){
        try{
        List<inventory__c> inventry = new List<inventory__c>();
        for(Case caseRequest :CollateralRequestRecords){
            List<inventory_request__c> inv = new List<Inventory_request__c>();
            inv=irMap2.get(caseRequest.id);
            for(inventory_Request__c inr: inv){            
            
                for(inventory__c inc :requestown){
                if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){                          
                        
                inc.Closing_Stocks__c = inc.Closing_Stocks__c + inr.quantity_dispatched__c;
                                  
                inventry.add(inc);
              
            
            }
            }     
            }
        }
        update inventry;
        }
catch(exception e){system.debug(e.getMessage());}
    }

    public void computeCorrectedDispatchStock(Map<id, List<Inventory_request__C>> IrMap3, List<Inventory__c> invDepo, List<Inventory__c> invho, List<Case> CollateralRequestRecords,List<Inventory__c> requestown){
        try{
        Boolean flag = false;
        List<inventory__c> invent = new List<inventory__c>();
        for(Case caseRequest :CollateralRequestRecords){
            List<inventory_request__c> inv = new List<Inventory_request__c>();
            inv=irMap3.get(caseRequest.id);
            Decimal recStock=0;
            for(inventory_Request__c inr: inv){
               if(inr.Type_of_Item__r.type__c ==System.label.GIFT_ITEMS){
                for(inventory__c inc :requestown){
                 if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){                          
                   recStock= inc.Received_Stock__c;    
                        
                }
                }
                }
                else
                {
                recStock= inr.Type_of_Item__r.Received_Stock__c;
                }
                if(caseRequest.depo__c != null){
                    for(inventory__c inc :invDepo){
                        if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                            inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){
                            Decimal differ =  recStock - inr.Quantity_Dispatched__c;
                           
                            if(differ !=0){inc.Closing_Stocks__c = inc.Closing_Stocks__c + differ;
                            flag=true;  
                            invent.add(inc);
                            }
                        }
                    }
                }
                else{
                    for(inventory__c inc :invHO){
                        if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){
                            Decimal differ = recStock -inr.Quantity_Dispatched__c ;

                            if(differ !=0){inc.Closing_Stocks__c = inc.Closing_Stocks__c + differ;
                            flag=true;
                            invent.add(inc);
                            }
                        }
                    }
                } 
                if(flag){
                if(inr.Type_of_Item__r.type__c ==System.label.GIFT_ITEMS){
                for(inventory__c inc :requestown){
                if(inr.type_of_item__r.type__c==  inc.type__c && inr.type_of_item__r.product__c == inc.product__c &&
                                inr.type_of_item__r.product_description__c == inc.product_description__c && inr.type_of_item__r.Color_Language_Size__c == inc.Color_Language_Size__c){                          
                        
                inc.Received_Stock__c = inr.Quantity_Dispatched__c;                    
                invent.add(inc);
                }
            
            }
            }
               else{ 
                    inr.Type_of_Item__r.Received_Stock__c = inr.Quantity_Dispatched__c;
                    invent.add(inr.Type_of_Item__r);}
                }      
            }  
        }   

        if(invent.size() !=0){
            update invent;
        }
        }
        catch(exception e){system.debug(e.getMessage());}
    }
    
    /*  
     * Author     : Renjay Surendran
     * Purpose    : Used for Case-Auto Dispatch request. 
     */ 
    public void trigAutoDispColl() {
        try{
            if(trigger.isafter && trigger.isupdate){
                List<Case> CollateralRequestRecords=new List<Case>();
                List<id> caseid = new List<id>();
                List<Id> us = new List<Id>();
                List<Inventory__c> finalList=new List<Inventory__c>();
                List<Inventory_request__C> masterData = new List<Inventory_request__C>();
                List<Inventory__c> invUs = new List<Inventory__c>();
                Map<id, List<Inventory_request__C>> invMap = new Map<id, List<Inventory_request__C>>();
                Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
                for(sobject collRequest : trigger.new){  
                    Case invReq = (Case)collRequest;
                        if(invReq.RecordTypeId==auto&&invReq.Request_User__c!=null)
                        { 
                            CollateralRequestRecords.add(invReq);  
                            caseid.add(invReq.id);
                            us.add(invReq.Request_User__c);      
                        }
                    }
                 
                 if(caseid.size()!=0){
                 
                 masterData=[select Inventory_Request_Number__c, Quantity_Dispatched__c, Request_Rasied_by__c, Type_of_Item__c,
                              Type_of_Item__r.Received_Stock__c, Type_of_Item__r.Closing_Stocks__c,
                              Type_of_item__r.type__c, Type_of_item__r.product__c, Type_of_item__r.Product_Description__c, 
                              type_of_item__r.Color_Language_Size__c, type_of_item__r.Type_Of_Meet__c                         
                              from Inventory_request__C where Inventory_Request_Number__c in : caseid];   
                 invUs =  [Select Received_Stock__c,Closing_Stocks__c,type__c, product__c ,Product_Description__c, Color_Language_Size__c,Type_Of_Meet__c, Owner_Account__c from inventory__c where Owner_Account__c in:us]; 
                if(CollateralRequestRecords.size()!=0){

                    for(Case caseRequest :CollateralRequestRecords) {
                        if(caseRequest.status.equals('Completed')){  
                            for(Inventory_request__C IR : masterData) {
                                if(ir.Inventory_Request_Number__c.equals(caseRequest.Id)){     
                                    for(inventory__c i: invUs)
                                    {
                                        if(ir.type_of_item__r.type__c == i.type__c && ir.type_of_item__r.product__c == i.product__c && ir.type_of_item__r.product_description__c == i.product_description__c && ir.type_of_item__r.Color_Language_Size__c == i.Color_Language_Size__c)
                                        {
                                            i.Closing_Stocks__c+=ir.Quantity_Dispatched__c;
                                            //i.Received_Stock__c=ir.Quantity_Dispatched__c;

                                            finalList.add(i);
                                        }
                                    }
                                }
                            }
                        }

                    }  
                    update finalList;       
                }
            }
            }
        }
        catch(exception e){system.debug('####'+e.getMessage());}
    }
    
/**
 * Name: checkBrandingApproval
 * Params: None
 * Description: Method to apply mandatory check on approvals in Branding process
 */ 
 public void checkBrandingApproval(){
 Map<Id, case> approvedStatements = new Map<Id, case>{};
 Map<Id,Case> mapofAllCases = new  Map<Id,Case>();
 List<case> filteredRecceCases= new List<case>();
 List<case> filteredBrandingCases= new List<case>(); 
 List<case> filteredSupportCases= new List<case>();
 List<case> filteredOfflineCases= new List<case>();
 List<case> caseUpdateList= new List<case>();
 List<Case> allCases = new List<Case>();
 List<Recce_Detail__c> recceList= new List<Recce_Detail__c>();
 if(trigger.isBefore && trigger.isupdate){
 //RecordType Rt = [select Id from RecordType where Name ='Branding Request' and SobjectType = 'case'];
  try{ 
      for(sObject sObj: trigger.new)
      {
        case currentReq=(case)sObj;
            if (currentReq.recordtypeId==Rtb.id && currentReq.Approve_Check__c=='True' )
                { 
                  currentReq.Approve_Check__c='False';
                  if(currentReq.status==System.label.Branding_Request_Recce_Submitted_by_Vendor)
                  filteredRecceCases.add(currentReq); 
                  else if(currentReq.status==System.label.Branding_Request_Completed_by_Vendor)
                  filteredBrandingCases.add(currentReq);  
                  else if(currentReq.status==System.Label.Branding_Request_Recce_Approved_by_Branding_team)
                  filteredOfflineCases.add(currentReq); 
                  else if(currentReq.status==System.Label.Branding_Request_Completed)
                  filteredSupportCases.add(currentReq); 
                }system.debug('kyon'+filteredBrandingCases);
      } 
      
      
      allCases = [Select id,status,(Select id,Shop__c,Branding_Request__c from Recce_Details__r),(SELECT Id,Shop_Name__c,Shop_Name__r.name,Branding_Request__c,Branding_Request__r.CaseNumber,Call_Center_Feedback__c,Branding_Installation__c FROM Branding_Requests__r)
      from Case where id in :filteredBrandingCases or id in :filteredSupportCases];
      for(Case singleCase : allCases){
          mapofAllCases.put(singleCase.id,singleCase );
      }
      
      /*** recce record check****/
      if(filteredRecceCases.size()>0){
      List<case> caseList= new List<case>();
      caseList=[Select id,status,(Select id,Shop__c,Branding_Request__c from Recce_Details__r),(SELECT Id,Shop_Name__c,Branding_Request__c,Branding_Approved_Rejected__c FROM Branding_Requests__r)
      from Case where id in :filteredRecceCases];
      for(sObject sObj: trigger.new){
      case currentReq=(case)sObj;
          for(Case request : caseList){
          if(currentReq.id==request.id){
              Set<Id> shops = new Set<Id>();
              Set<Id> recceShopsPerRequest= new Set<Id>();
              for(Branding_Request__c brReq : request.Branding_Requests__r) {
                  if(brReq.Branding_Approved_Rejected__c=='Approved'){
                       shops.add(brReq.Shop_Name__c);
                  }
              }
              for(Recce_Detail__c recce : request.Recce_Details__r) {
              recceList.add(recce);
              recceShopsPerRequest.add(recce.Shop__c);
              }
              for(Id shop: shops){
                      if(!recceShopsPerRequest.contains(shop)){
                          approvedStatements.put(currentReq.id, currentReq);
                      }
              } 
              }    
          }
          }
          List<Attachment> recceAttachments= new List<Attachment>();  
          Set<Id> recceRecords= new Set<id>();
          recceAttachments = [select id,parentid,name from Attachment where parentid in: recceList];   
          for(Attachment att : recceAttachments ){
              recceRecords.add(att.parentid);
          }
          
          for(Recce_Detail__c rec: recceList){
          for(sObject sObj: trigger.new){
          case currentReq=(case)sObj;
          if(currentReq.id==rec.Branding_Request__c){
              if(recceRecords.size()==0 ){
               approvedStatements.put(currentReq.id, currentReq);
              }
             else if(!recceRecords.contains(rec.id)){
                      approvedStatements.put(currentReq.id, currentReq);
             }
            }
          }
        }
          
      } 
      
      /*** offline BDM consent****/
      if(filteredOfflineCases.size()>0){
      for(sObject sObj: trigger.new){
      case currentReq=(case)sObj;
          if(currentReq.Received_BDM_Consent__c!=true){
              approvedStatements.put(currentReq.id, currentReq);
          }
      }
     } 
     
     /*** acc attachements consent****/
     if(filteredBrandingCases.size()>0){
     List<Id> accountList= new List<Id>();
     Map<Id,Branding_Request__c> brRequestsMap = new Map<Id,Branding_Request__c>();
     List<Branding_Request__c> brRequests = new List<Branding_Request__c>();
         for(Case brCase : filteredBrandingCases){
             if(mapofAllCases.get(brCase.id).Branding_Requests__r!=null){
                 for(Branding_Request__c filterReq : mapofAllCases.get(brCase.id).Branding_Requests__r){
                     if(filterReq.Branding_Installation__c!='Not Installed'){
                     system.debug(filterReq+'here21');
                         brRequests.add(filterReq);
                     }
                 } 
             }
         }
         for(Branding_Request__c req: brRequests ){
             accountList.add(req.Shop_Name__c);
         }
         List<Attachment> brandingAttachments= new List<Attachment>();  
         Set<Id> brandingRequestRecords= new Set<id>();
         brandingAttachments = [select id,name,parentid from Attachment where parentid in: accountList];  
         if(brandingAttachments.size()==0){
             for(Case brCase : filteredBrandingCases){
                 for(sObject sObj: trigger.new){
                 case currentReq=(case)sObj;
                     if(currentReq.id==brCase.id){
                         for(Branding_Request__c filterReq : mapofAllCases.get(currentReq.id).Branding_Requests__r){
                             if(filterReq.Branding_Installation__c=='Installed' || filterReq.Branding_Installation__c=='Partially Installed' ){
                                 approvedStatements.put(currentReq.id, currentReq);
                             }
                         }
                     }    
                 }
             }
          }    
         else{
         Set<Branding_Request__c > positiveAtt = new Set<Branding_Request__c>();
         List <Branding_Request__c > finalAll = new List<Branding_Request__c >();
          for(Branding_Request__c  brAll: brRequests){
                    for(Attachment accAtt:brandingAttachments ){
                         if(accAtt.name.contains(brAll.Branding_Request__r.CaseNumber+'-'+brAll.Shop_Name__r.name+'-')){
                             positiveAtt.add(brAll);
                             break;
                         }
                        
                      }    
                  }
                for(Branding_Request__c reqAdd : brRequests){
                    for(sObject sObj: trigger.new){
                        case currentReq=(case)sObj;
                        if(currentReq.id==reqAdd.Branding_Request__c && !positiveAtt.contains(reqAdd)){
                            approvedStatements.put(currentReq.id, currentReq);
                        }
                   }
               }
          }    

        /* else{
          for(Branding_Request__c  brAll: brRequests){
              for(sObject sObj: trigger.new){
                 case currentReq=(case)sObj;
                 if(currentReq.id==brAll.Branding_Request__c){
                    for(Attachment accAtt:brandingAttachments ){
                         if(accAtt.name.contains(brAll.Branding_Request__r.CaseNumber+'-'+brAll.Shop_Name__r.name+'-')){
                             //approvedStatements.remove(currentReq.id);
                             break;
                         }
                         else{
                             approvedStatements.put(currentReq.id, currentReq);
                         }
                      }    
                  }
               }
            }
          }*/
    }
    
    /*** customer support consent****/
     if(filteredSupportCases.size()>0){
         List<Branding_Request__c> brRequests = new List<Branding_Request__c>();
         for(Case brCase : filteredSupportCases){
             if(mapofAllCases.get(brCase.id).Branding_Requests__r!=null){   
                 brRequests.addall(mapofAllCases.get(brCase.id).Branding_Requests__r);  
             }         
         }
         for(Branding_Request__c  brAll: brRequests){
              for(sObject sObj: trigger.new){
                 case currentReq=(case)sObj;
                 if(currentReq.id==brAll.Branding_Request__c){
                     if(brAll.Call_Center_Feedback__c==null){
                         approvedStatements.put(currentReq.id, currentReq);
                     }
                 }
              }
         }
     }
          
 if(!approvedStatements.isEmpty())  
  {
    List<Id> processInstanceIds = new List<Id>{};
    for (case reqs : [SELECT (SELECT ID
                                              FROM ProcessInstances
                                              ORDER BY CreatedDate DESC
                                              LIMIT 1)
                                      FROM case
                                      WHERE ID IN :approvedStatements.keySet()])
    {
        processInstanceIds.add(reqs.ProcessInstances[0].Id);
    }
      
    for (ProcessInstance pi : [SELECT TargetObjectId,
                                   (SELECT Id, StepStatus, Comments 
                                    FROM Steps
                                    ORDER BY CreatedDate DESC
                                    LIMIT 1 )
                               FROM ProcessInstance
                               WHERE Id IN :processInstanceIds
                               ORDER BY CreatedDate DESC])   
    {                   
      if ((approvedStatements.get(pi.TargetObjectId).status== System.label.Branding_Request_Recce_Submitted_by_Vendor))
      {    
        approvedStatements.get(pi.TargetObjectId).addError(
          '<hr/><br/><span style=\"color:crimson; font-weight: bold; font-size: 8pt;\">'+System.label.Branding_Request_Recce_Validation+'</span><a href="/'+pi.TargetObjectId+'" style="text-decoration: none; text-align:center;"  ><br/>Click here to return to Request page.</a>');
      }
      else if ((approvedStatements.get(pi.TargetObjectId).status== System.Label.Branding_Request_Recce_Approved_by_Branding_team    ))
      {    
        approvedStatements.get(pi.TargetObjectId).addError(
          '<hr/><br/><span style=\"color:crimson; font-weight: bold; font-size: 8pt;\">'+System.label.Branding_Request_BDM_consent_validation+'</span><a href="/'+pi.TargetObjectId+'" style="text-decoration: none; text-align:center;"  ><br/>Click here to return to Request page.</a>');
      }
      else if ((approvedStatements.get(pi.TargetObjectId).status== System.label.Branding_Request_Completed_by_Vendor))
      {    
        approvedStatements.get(pi.TargetObjectId).addError(
          '<hr/><br/><span style=\"color:crimson; font-weight: bold; font-size: 8pt;\">'+System.label.Branding_Request_Branding_images_validation+'</span><a href="/'+pi.TargetObjectId+'" style="text-decoration: none; text-align:center;"  ><br/>Click here to return to Request page.</a>');
      }
      else if ((approvedStatements.get(pi.TargetObjectId).status== System.Label.Branding_Request_Completed))
      {    
        approvedStatements.get(pi.TargetObjectId).addError(
          '<hr/><br/><span style=\"color:crimson; font-weight: bold; font-size: 8pt;\">'+System.label.Branding_Request_Customer_Support_validation+'</span><a href="/'+pi.TargetObjectId+'" style="text-decoration: none; text-align:center;" ><br/>Click here to return to Request page.</a>');
      }
      }
    }  
   } catch(exception e){system.debug('Exception Occurred'+e.getMessage());}
  }
 }
 
 /**
 * Name: checkBrandingRejection
 * Params: None
 * Description: Method to apply mandatory check on comments field when record is rejected in Branding process
 */ 
 public void checkBrandingRejection(){
 Map<Id, case> rejectedStatements = new Map<Id, case>{};
 if(trigger.isBefore && trigger.isupdate){
 //RecordType Rt = [select Id from RecordType where Name ='Branding Request' and SobjectType = 'case'];
 try{
     for(sObject sObj: trigger.new)
      {
        case currentReq=(case)sObj;
        if (currentReq.recordtypeId==Rtb.id){
            rejectedStatements.put(currentReq.Id, currentReq);  
        }
      }
     if (!rejectedStatements.isEmpty()){
        List<Id> processInstanceIds = new List<Id>{};
        for (case reqs: [SELECT (SELECT ID
                                         FROM ProcessInstances
                                         ORDER BY CreatedDate DESC
                                         LIMIT 1)
                                      FROM case
                                      WHERE ID IN :rejectedStatements.keySet()])
    {
        processInstanceIds.add(reqs.ProcessInstances[0].Id);
    }
      
    for (ProcessInstance pi : [SELECT TargetObjectId,
                                   (SELECT Id, StepStatus, Comments 
                                    FROM Steps
                                    Where StepStatus = 'Rejected'
                                    ORDER BY CreatedDate DESC
                                    LIMIT 1 )
                               FROM ProcessInstance
                               WHERE Id IN :processInstanceIds
                               ORDER BY CreatedDate DESC])   
    {   
        system.debug(pi.Steps[0].Comments+'lol');              
      if ((pi.Steps[0].Comments == null || 
           pi.Steps[0].Comments.trim().length() == 0))
      {
            
        rejectedStatements.get(pi.TargetObjectId).addError(
          '<hr/><br/><span style=\"color:crimson; font-weight: bold; font-size: 8pt;\">'+System.label.Branding_Request_Rejection_Comments+'</span><a href="/'+pi.TargetObjectId+'" style="text-decoration: none; text-align:center;" ><br/>Click here to return to Request page.</a>');
      }
    }  
  }
     
 } catch(exception e){system.debug('Exception Occurred'+e.getMessage());}
 }
 } 
  
  
  /**
 * Name: checkCollateralApproval
 * Params: None
 * Description: Method to apply mandatory check on approvals for shipping details in collateralprocess
 */ 
 public void checkCollateralApproval(){
 try{
 Map<Id, case> approvedStatements = new Map<Id, case>{};
 Map<Id,Case> mapofAllCases = new  Map<Id,Case>();
 List<Case> CollateralCases = new List<Case>();
 if(trigger.isBefore && trigger.isupdate){
 //RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
  
      for(sObject sObj: trigger.new)
      {
        case currentCase=(case)sObj;
            if (currentCase.recordtypeId==Rt.id ){
            
            if(currentCase.status =='Dispatched' || currentCase.status == 'Corrected Dispatch'){
            
            if(currentCase.Shipping_Details__c == null || String.isBlank(currentCase.Shipping_Details__c) ||
            currentCase.Shippment_Mode__c == null || String.isBlank(currentCase.Shippment_Mode__c)){
            CollateralCases.add(currentCase);
             approvedStatements.put(currentCase.id, currentCase);}
            }
            }
            }
  
  if(!approvedStatements.isEmpty())  
  {
    List<Id> processInstanceIds = new List<Id>();
    for (case reqs : [SELECT (SELECT ID
                                              FROM ProcessInstances
                                              ORDER BY CreatedDate DESC
                                              LIMIT 1)
                                      FROM case
                                      WHERE ID IN :approvedStatements.keySet()])
    {
    if(reqs.ProcessInstances[0].Id != null){
        processInstanceIds.add(reqs.ProcessInstances[0].Id);}
    }
      
    for (ProcessInstance pi : [SELECT TargetObjectId,
                                   (SELECT Id, StepStatus, Comments 
                                    FROM Steps
                                    ORDER BY CreatedDate DESC
                                    LIMIT 1 )
                               FROM ProcessInstance
                               WHERE Id IN :processInstanceIds
                               ORDER BY CreatedDate DESC])  
     {
     approvedStatements.get(pi.TargetObjectId).addError(
          '<hr/><br/><span style=\"color:crimson; font-weight: bold; font-size: 12pt;\">'+System.label.mandatory_Shipping_Details+'</span><a href="/'+pi.TargetObjectId+'" style="text-decoration: none; text-align:center;"  ><br/><br/><center>Click here to return to Request page.</center></a>');
     
     }        
 }             
 }
 } catch(exception e){system.debug('Exception Occurred'+e.getMessage());}
 }
 
 /**
 * Name: shareBrandingRequests
 * Params: None
 * Description: Method to share branding request with user if stakeholders are changed.
 */ 
 public void shareBrandingRequests(){
 List<Case> allCases = new List<Case>();
 List<Case> tlCases = new List<Case>();
 List<Case> rbmCases = new List<Case>();
 List<Case> hbCases = new List<Case>();
 List<Case> vendorCases = new List<Case>();
 List<Branding_Request__c> vendorbr = new List<Branding_Request__c>();
 List<AccountShare>  accShareList = new List<AccountShare >();
 List<CaseShare>  caseShareList = new List<CaseShare>();
  if(trigger.isBefore && trigger.isupdate){
      //RecordType Rt = [select Id from RecordType where Name ='Branding Request' and SobjectType = 'case'];
      try{ 
          for(sObject sObj: trigger.new){
              case currentReq=(case)sObj;
              if (currentReq.recordtypeId==Rtb.id ){
                  Case oldReq = (Case)Trigger.oldMap.get(currentReq.id);
                  if(currentReq.Team_Lead__c!= oldReq.Team_Lead__c){
                      tlCases.add(currentReq);
                  }
                   if(currentReq.Branding_Team_Member__c!= oldReq.Branding_Team_Member__c){
                       rbmCases.add(currentReq);
                  }
                   if(currentReq.Branding_Manager__c!= oldReq.Branding_Manager__c){
                       hbCases.add(currentReq);
                  }
                   if(currentReq.Vendor__c!= oldReq.Vendor__c){
                       vendorCases.add(currentReq);
                  }
              }
          }
     allCases = [Select id,status,(SELECT Id,Shop_Name__c FROM Branding_Requests__r)
      from Case where id in :tlCases or id in :rbmCases or id in :hbCases or id in :vendorCases];
        
     for(Case all : allCases){
        for(Branding_Request__c br : all.Branding_Requests__r){
           vendorbr.add(br);
        }
        }
        
    // vendorbr.add(all.Branding_Requests__r);      
       system.debug('vendorbr::'+vendorbr);
          if(tlCases.size()>0){
              for(Case tlCase: tlCases){
                  CaseShare caseShare=new CaseShare();
                  caseShare.UserOrGroupID = tlCase.Team_Lead__c;
                  caseShare.CaseAccessLevel= 'Edit';
                  caseShare.CaseId= tlCase.Id;
                  caseShare.RowCause = 'Manual';
                  caseShareList.add(caseShare);
                  for(Branding_Request__c brReq : vendorbr){
                    AccountShare accShare=new AccountShare();
                    accShare.UserOrGroupID = tlCase.Team_Lead__c;
                    accShare.AccountAccessLevel= 'Edit';
                    accShare.AccountId= brReq.Shop_Name__c;
                    accShare.RowCause = 'Manual';
                    accShare.OpportunityAccessLevel='None';
                    accShareList.add(accShare);
                }
              }
          }
          if(rbmCases.size()>0){
              for(Case rbmCase: rbmCases){
                  CaseShare caseShare=new CaseShare();
                  caseShare.UserOrGroupID = rbmCase.Branding_Team_Member__c;
                  caseShare.CaseAccessLevel= 'Edit';
                  caseShare.CaseId= rbmCase.Id;
                  caseShare.RowCause = 'Manual';
                  caseShareList.add(caseShare);
                  for(Branding_Request__c brReq : vendorbr){
                    AccountShare accShare=new AccountShare();
                    accShare.UserOrGroupID = rbmCase.Branding_Team_Member__c;
                    accShare.AccountAccessLevel= 'Edit';
                    accShare.AccountId= brReq.Shop_Name__c;
                    accShare.RowCause = 'Manual';
                    accShare.OpportunityAccessLevel='None';
                    accShareList.add(accShare);
                }
              }
          }
          if(hbCases.size()>0){
              for(Case hbCase: hbCases){
                  CaseShare caseShare=new CaseShare();
                  caseShare.UserOrGroupID = hbCase.Branding_Manager__c;
                  caseShare.CaseAccessLevel= 'Edit';
                  caseShare.CaseId= hbCase.Id;
                  caseShare.RowCause = 'Manual';
                  caseShareList.add(caseShare);
                  for(Branding_Request__c brReq : vendorbr){
                    AccountShare accShare=new AccountShare();
                    accShare.UserOrGroupID = hbCase.Branding_Manager__c;
                    accShare.AccountAccessLevel= 'Edit';
                    accShare.AccountId= brReq.Shop_Name__c;
                    accShare.RowCause = 'Manual';
                    accShare.OpportunityAccessLevel='None';
                    accShareList.add(accShare);
                }
              }
          }
          if(vendorCases.size()>0){

              for(Case vendorCase: vendorCases){
                  CaseShare caseShare=new CaseShare();
                  caseShare.UserOrGroupID = vendorCase.Vendor__c;
                  caseShare.CaseAccessLevel= 'Read';
                  caseShare.CaseId= vendorCase.Id;
                  caseShare.RowCause = 'Manual';
                  caseShareList.add(caseShare);
                  for(Branding_Request__c brReq : vendorbr){//vendorCase.Branding_Requests__r){
                    AccountShare accShare=new AccountShare();
                    accShare.UserOrGroupID = vendorCase.Vendor__c;
                    accShare.AccountAccessLevel= 'Edit';
                    accShare.AccountId= brReq.Shop_Name__c;
                    accShare.RowCause = 'Manual';
                    accShare.OpportunityAccessLevel='None';
                    accShareList.add(accShare);
                }
              }
          }
       if(caseShareList.size()>0){upsert caseShareList;}
       if(accShareList.size()>0){upsert accShareList;}
      }catch(exception e){system.debug('Exception Occurred'+e.getMessage());}
      
        
  }
                      
         
 }
 
 /**
 * Name: fetchVendor
 * Params: None
 * Description: Method to fetchVendor when vendor is chnaged.
 */ 
 public void fetchVendor(){
 List<Vendor_Details__c> allVendorDetails = new List<Vendor_Details__c>();
 Map<id,Vendor_Details__c> vendorDetailMap = new Map<id,Vendor_Details__c>();
 List<Case> caseList = new List<Case>();
 Map<Id,Id> vendorMap = new Map<Id,Id>();
     if(trigger.isBefore && trigger.isupdate){
      //RecordType Rt = [select Id from RecordType where Name ='Branding Request' and SobjectType = 'case'];
      try{ 
          for(sObject sObj: trigger.new){
              case currentReq=(case)sObj;
              if (currentReq.recordtypeId==Rtb.id ){
                  Case oldReq = (Case)Trigger.oldMap.get(currentReq.id);
                  if(currentReq.Vendor_Details__c!= oldReq.Vendor_Details__c){
                      caseList.add(currentReq);
                  }
              }
          }
          
          if(caseList.size()>0){ 
              for(Case brCase : caseList){
                  vendorMap.put(brCase.id,brCase.Vendor_Details__c);
              }
              allVendorDetails = [Select id,Vendor__c from Vendor_Details__c where id in :vendorMap.values()];
              for(Vendor_Details__c detailRec : allVendorDetails ){
                vendorDetailMap.put(detailRec.id,detailRec);
              }
              for(Case caseRec : caseList){
                  for(sObject sObj: trigger.new){
                     case currentReq=(case)sObj;
                     if(currentReq.id==caseRec.id){
                         currentReq.Vendor__c=vendorDetailMap.get(vendorMap.get(caseRec.id)).Vendor__c;
                     }
                  }
              }
          }   
      }catch(exception e){system.debug('Exception Occurred'+e.getMessage());}
    }
  }
 
 }