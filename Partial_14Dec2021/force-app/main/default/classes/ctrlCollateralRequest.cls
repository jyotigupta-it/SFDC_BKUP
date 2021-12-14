public with sharing class ctrlCollateralRequest{

    public Boolean flagVar{get;set;}
    public Case currentCase{get; set;}
    public List<Inventory_Request__c> existinginvReqList{get;set;}
    
    
    
    public List<CollateralWrapper> productCollList{get;set;}
    public List<CollateralWrapper> giftListMega{get;set;}
    public List<CollateralWrapper> giftListMini{get;set;}
    public List<CollateralWrapper> sampleList{get;set;}
    public List<CollateralWrapper> packMaterialList{get;set;}
    public List<CollateralWrapper> productCollList1{get;set;}
    public List<CollateralWrapper> giftListMega1{get;set;}
    public List<CollateralWrapper> giftListMini1{get;set;}
    public List<CollateralWrapper> sampleList1{get;set;}
    public List<CollateralWrapper> packMaterialList1{get;set;}

    public ctrlCollateralRequest(ApexPages.StandardController stdController) { 
        
        
        productCollList= new List<CollateralWrapper>();
        giftListMega= new List<CollateralWrapper>();
        giftListMini= new List<CollateralWrapper>();
        sampleList= new List<CollateralWrapper>();
        packMaterialList= new List<CollateralWrapper>();
        productCollList1= new List<CollateralWrapper>();
        giftListMega1= new List<CollateralWrapper>();
        giftListMini1= new List<CollateralWrapper>();
        sampleList1= new List<CollateralWrapper>();
        packMaterialList1= new List<CollateralWrapper>();

        currentCase = [select Request_Raised_By__c,id,Team_Lead__c,depo__c,Check_Gifts__c,origin,head_office__c, status,Is_In_Approval_Process__c, RecordTypeId from case where id =:ApexPages.currentPage().getParameters().get('id')];//'500V00000042mBuIAI'];
        existinginvReqList = new List<Inventory_Request__c>();
        existinginvReqList = [select Type_of_Item__c,Type_of_Item__r.name,Type_of_Item__r.type__c,Type_of_Item__r.type_of_meet__c, Type_of_Item__r.product__c, Type_of_Item__r.product_description__c, Type_of_Item__r.Color_Language_Size__c,
                              Type_of_Item__r.Item_Code__c, inventory_Sample__c, inventory_PackMaterials__c, inventory_Product__c,Required_Quantity__c,Quantity_Dispatched__c,Comments_Remarks__c,Inventory_Request_Number__c,Type_of_Item__r.opening_stock__c,Type_of_Item__r.Owner_Account__c,
                              Type_of_Item__r.Closing_Stocks__c,Type_of_Item__r.Used_Stock__c, inventory_Sample__r.name,inventory_Sample__r.type__c, inventory_Sample__r.product__c, inventory_Sample__r.product_description__c, inventory_Sample__r.Color_Language_Size__c,
                              inventory_Sample__r.Item_Code__c,inventory_PackMaterials__r.name,inventory_PackMaterials__r.type__c, inventory_PackMaterials__r.product__c, inventory_PackMaterials__r.product_description__c, inventory_PackMaterials__r.Color_Language_Size__c,
                              inventory_PackMaterials__r.Item_Code__c,inventory_Product__r.name,inventory_Product__r.type__c, inventory_Product__r.product__c, inventory_Product__r.product_description__c, inventory_Product__r.Color_Language_Size__c,inventory_Product__r.Item_Code__c,
                              inventory_mini__c,inventory_mini__r.name,inventory_mini__r.type__c, inventory_mini__r.product__c, inventory_mini__r.product_description__c, inventory_mini__r.Color_Language_Size__c,inventory_mini__r.Item_Code__c,
                              inventory_mega__c,inventory_mega__r.name,inventory_mega__r.type__c, inventory_mega__r.product__c, inventory_mega__r.product_description__c, inventory_mega__r.Color_Language_Size__c,inventory_mega__r.Item_Code__c
                              from Inventory_Request__c where Inventory_Request_Number__c =: currentCase.id];
        system.debug('###'+currentcase);
        system.debug('###'+existinginvReqList);

        for(Inventory_Request__c request : existinginvReqList){
            CollateralWrapper collateralRequest= new CollateralWrapper();
            if(request.Type_of_Item__r.type__c == 'PRODUCT COLLATERALS'){
                collateralRequest.invRequest= request;
                productCollList1.add(collateralRequest);
            }
            if(request.Type_of_Item__r.type__c  == 'SAMPLES'){
                collateralRequest.invRequest= request;
                sampleList1.add(collateralRequest);
            }

            if(request.Type_of_Item__r.type__c == 'PACKING MATERIALS'){
                collateralRequest.invRequest= request;
                packMaterialList1.add(collateralRequest);
            } 
            
            if(request.Type_of_Item__r.type__c == 'GIFT ITEMS' && request.Type_of_Item__r.type_of_meet__c == 'Mega Meet'){
                collateralRequest.invRequest= request;
                giftListMega1.add(collateralRequest);
            }
            
            if(request.Type_of_Item__r.type__c == 'GIFT ITEMS' && request.Type_of_Item__r.type_of_meet__c == 'Mini Meet'){
                collateralRequest.invRequest= request;
                giftListMini1.add(collateralRequest);
            }   
        } 
    }  
}