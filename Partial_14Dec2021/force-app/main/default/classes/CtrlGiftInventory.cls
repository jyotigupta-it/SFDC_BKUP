/*  
 * Author     : Vasanthi K N
 */ 
public with sharing class CtrlGiftInventory{

public List<inventory__c> giftListMini{get; set;}
public List<inventory__c> giftListMega{get; set;}
public string soql;
Public boolean renderpage {get; set;}
Public boolean renderother {get; set;}
private ApexPages.StandardController controller;
public Case currentCase{get; set;}
public List<inventory_Gift_request__c> existinggifReq{set; get;}
public List<Inventory_Request__c> existinginvgifReq{set; get;}
public Boolean flagVar{get;set;}
public String  Userdata{get; set;}

   
public CtrlGiftInventory(ApexPages.StandardController stdcontroller) {
        this.controller = stdcontroller;
        existinggifReq = new List<inventory_Gift_request__c>();
        currentCase = [select Request_Raised_By__c,Request_Raised_By__r.name, id, Team_Lead__c,status,Is_In_Approval_Process__c, RecordTypeId from case where id =:ApexPages.currentPage().getParameters().get('id')];
        existinggifReq = [select type_of_meet__c, Required_Quantity__c, Comments__c from inventory_Gift_request__c where case__c =: currentCase.id];
        existinginvgifReq = [select Type_of_Item__c, Request_Rasied_by__c,Required_Quantity__c,Quantity_Dispatched__c, Comments_Remarks__c from Inventory_Request__c where Inventory_Request_Number__c =: currentCase.id and Type_of_Item__r.type__c = 'GIFT ITEMS'];
        Userdata=currentCase.Request_Raised_By__r.name;
        
        if(existinginvgifReq.Size() != 0 || existinggifReq.size() != 0){
        getCollaterals(currentCase.Request_Raised_By__c);
        renderpage = true;
         renderother = false;}
        else{renderpage = false;
        renderother = true;}
    }

    public void getCollaterals(id ownerId){
        List<inventory__c> inventoryList= new List<inventory__c>();
        giftListMini=new List<inventory__c>();
        giftListMega=new List<inventory__c>();        
        
        soql = 'select product__C,type_of_meet__c, name, Type__c,Product_Description__c, Color_Language_Size__c, opening_stock__c, Used_Stock__c,Received_Stock__c, Closing_Stocks__c, Owner_Account__c  from inventory__c where Owner_Account__c =:ownerId';     
        inventoryList = Database.query(soql);

        for(inventory__c userInventory : inventoryList){
            if(userInventory.type__c == System.Label.GIFT_ITEMS){
            if(userInventory.type_of_meet__c =='Mega Meet'){
                giftListMega.add(userInventory); 
                }
            if(userInventory.type_of_meet__c =='Mini Meet'){
                giftListMini.add(userInventory);
                
                }
                         
            }

        }
        
          }


}