public class CtrlInventoryDetailPage{

    public Boolean flagVar{get;set;}
    public Case currentCase{get; set;}
    public List<Inventory_Request__c> invReqList{get;set;}
    public List<Inventory_Request__c> existinginvReqList{get;set;}
    public Boolean editable{get;set;}
     public Boolean autoflag{get;set;}
    public Boolean giftEdit{get; set;}
    public Boolean objectRender1{get;set;}
    public Boolean objectRender2{get;set;}
    public Boolean objectRendergift1{get;set;}
    public Boolean objectRendergift2{get;set;}
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
    public List<inventory_Gift_request__c> existinggifReq{set; get;}
    public List<inventory_Gift_request__c> gifReq{set; get;}
    public Map<Id,Inventory_Request__c> invReqMap{get;set;}
    public Map<Id,Inventory_Request__c> RejInvReqMap{get;set;}
 public List<inventory_Gift_request__c> gifReq1{set; get;}
public List<inventory_Gift_request__c> gifReq2{set; get;}

    public CtrlInventoryDetailPage(ApexPages.StandardController stdController) { 
    autoflag = false;
        editable= false;
        giftEdit = false;
        objectRender1=false;
        objectRender2=false;
        objectRendergift1=false;
        objectRendergift2=false;
        invReqMap = new Map<Id,Inventory_Request__c>();
        RejInvReqMap = new Map<Id,Inventory_Request__c>();
        gifReq = new List<inventory_Gift_request__c>();
        existinggifReq = new List<inventory_Gift_request__c>();
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
        gifReq1 = new List<inventory_Gift_request__c>();
         gifReq2 = new List<inventory_Gift_request__c>();
        currentCase = [select Request_Raised_By__c,collateral_flows__c,id,Team_Lead__c,depo__c,Check_Gifts__c,origin,head_office__c, status,Is_In_Approval_Process__c, RecordTypeId from case where id =:ApexPages.currentPage().getParameters().get('id')];//'500V00000042mBuIAI'];
        existinginvReqList = new List<Inventory_Request__c>();
        existinginvReqList = [select Type_of_Item__c,Type_of_Item__r.name,Type_of_Item__r.type__c,Type_of_Item__r.type_of_meet__c, Type_of_Item__r.product__c, Type_of_Item__r.product_description__c, Type_of_Item__r.Color_Language_Size__c,
                              Type_of_Item__r.Item_Code__c, inventory_Sample__c, inventory_PackMaterials__c, inventory_Product__c,Required_Quantity__c,Quantity_Dispatched__c,Comments_Remarks__c,Inventory_Request_Number__c,Type_of_Item__r.opening_stock__c,Type_of_Item__r.Owner_Account__c,
                              Type_of_Item__r.Closing_Stocks__c,Type_of_Item__r.Used_Stock__c, inventory_Sample__r.name,inventory_Sample__r.type__c, inventory_Sample__r.product__c, inventory_Sample__r.product_description__c, inventory_Sample__r.Color_Language_Size__c,
                              inventory_Sample__r.Item_Code__c,inventory_PackMaterials__r.name,inventory_PackMaterials__r.type__c, inventory_PackMaterials__r.product__c, inventory_PackMaterials__r.product_description__c, inventory_PackMaterials__r.Color_Language_Size__c,
                              inventory_PackMaterials__r.Item_Code__c,inventory_Product__r.name,inventory_Product__r.type__c, inventory_Product__r.product__c, inventory_Product__r.product_description__c, inventory_Product__r.Color_Language_Size__c,inventory_Product__r.Item_Code__c,
                              inventory_mini__c,inventory_mini__r.name,inventory_mini__r.type__c, inventory_mini__r.product__c, inventory_mini__r.product_description__c, inventory_mini__r.Color_Language_Size__c,inventory_mini__r.Item_Code__c,
                              inventory_mega__c,inventory_mega__r.name,inventory_mega__r.type__c, inventory_mega__r.product__c, inventory_mega__r.product_description__c, inventory_mega__r.Color_Language_Size__c,inventory_mega__r.Item_Code__c
                              from Inventory_Request__c where Inventory_Request_Number__c =: currentCase.id];

        existinggifReq = [select type_of_meet__c, Required_Quantity__c, Comments__c from inventory_Gift_request__c where case__c =: currentCase.id];

        invReqList = [select Type_of_Item__c,Type_of_Item__r.name,Type_of_Item__r.type__c, Type_of_Item__r.product__c, Type_of_Item__r.type_of_meet__c,Type_of_Item__r.product_description__c, Type_of_Item__r.Color_Language_Size__c,
                      Type_of_Item__r.Item_Code__c, inventory_Sample__c, inventory_PackMaterials__c, inventory_Product__c,Required_Quantity__c,Quantity_Dispatched__c,Comments_Remarks__c,Inventory_Request_Number__c,Type_of_Item__r.opening_stock__c,Type_of_Item__r.Owner_Account__c,
                      Type_of_Item__r.Closing_Stocks__c,Type_of_Item__r.Used_Stock__c, inventory_Sample__r.name,inventory_Sample__r.type__c, inventory_Sample__r.product__c, inventory_Sample__r.product_description__c, inventory_Sample__r.Color_Language_Size__c,
                      inventory_Sample__r.Item_Code__c,inventory_PackMaterials__r.name,inventory_PackMaterials__r.type__c, inventory_PackMaterials__r.product__c, inventory_PackMaterials__r.product_description__c, inventory_PackMaterials__r.Color_Language_Size__c,
                      inventory_PackMaterials__r.Item_Code__c,inventory_Product__r.name,inventory_Product__r.type__c, inventory_Product__r.product__c, inventory_Product__r.product_description__c, inventory_Product__r.Color_Language_Size__c,inventory_Product__r.Item_Code__c, 
                      inventory_mini__c,inventory_mini__r.name,inventory_mini__r.type__c, inventory_mini__r.product__c, inventory_mini__r.product_description__c, inventory_mini__r.Color_Language_Size__c,inventory_mini__r.Item_Code__c,
                              inventory_mega__c,inventory_mega__r.name,inventory_mega__r.type__c, inventory_mega__r.product__c, inventory_mega__r.product_description__c, inventory_mega__r.Color_Language_Size__c,inventory_mega__r.Item_Code__c
                      from Inventory_Request__c where Inventory_Request_Number__c =: currentCase.id];


        for(Inventory_Request__c request : existinginvReqList){
            CollateralWrapper collateralRequest= new CollateralWrapper();
            if(request.Type_of_Item__r.type__c == System.Label.PRODUCT_COLLATERALS){
                collateralRequest.invRequest= request;
                productCollList1.add(collateralRequest);
            }
            if(request.Type_of_Item__r.type__c  == System.Label.SAMPLES){
                collateralRequest.invRequest= request;
                sampleList1.add(collateralRequest);
            }

            if(request.Type_of_Item__r.type__c == System.Label.PACKING_MATERIALS){
                collateralRequest.invRequest= request;
                packMaterialList1.add(collateralRequest);
            } 
            
            if(request.Type_of_Item__r.type__c == System.Label.GIFT_ITEMS && request.Type_of_Item__r.type_of_meet__c == 'Mega Meet'){
                collateralRequest.invRequest= request;
                giftListMega1.add(collateralRequest);
            }
            
            if(request.Type_of_Item__r.type__c == System.Label.GIFT_ITEMS && request.Type_of_Item__r.type_of_meet__c == 'Mini Meet'){
                collateralRequest.invRequest= request;
                giftListMini1.add(collateralRequest);
            }   
        } 


        for(Inventory_Request__c request : invReqList){
            CollateralWrapper collateralRequest= new CollateralWrapper();
            if(request.Type_of_Item__r.type__c == System.Label.PRODUCT_COLLATERALS){
                collateralRequest.invRequest= request;
                productCollList.add(collateralRequest);
            }
            if(request.Type_of_Item__r.type__c  == System.Label.SAMPLES){
                collateralRequest.invRequest= request;
                sampleList.add(collateralRequest);
            }

            if(request.Type_of_Item__r.type__c == System.Label.PACKING_MATERIALS){
                collateralRequest.invRequest= request;
                packMaterialList.add(collateralRequest);
            }   
            
             if(request.Type_of_Item__r.type__c == System.Label.GIFT_ITEMS && request.Type_of_Item__r.type_of_meet__c == 'Mega Meet'){
                collateralRequest.invRequest= request;
                giftListMega.add(collateralRequest);
            }
            
            if(request.Type_of_Item__r.type__c == System.Label.GIFT_ITEMS && request.Type_of_Item__r.type_of_meet__c == 'Mini Meet'){
                collateralRequest.invRequest= request;
                giftListMini.add(collateralRequest);
            }  
        } 
        
        Integer maxRows =0;
        Integer ProdaddRows=0;
        Integer SampleaddRows=0;
        Integer PackaddRows=0;
        Integer minigiftRows=0;
        Integer megaGiftRows=0;
        
        if(currentCase.collateral_flows__c == 'Requestor' || (currentCase.collateral_flows__c == 'Depot' && currentCase.origin=='Self')){
        
        maxRows = 5;
        ProdaddRows = maxRows - productCollList.size();
        SampleaddRows = maxRows - sampleList.size();
        PackaddRows = maxRows - packMaterialList.size();
        minigiftRows= 3 - giftListMini.size();
        megaGiftRows= 1 - giftListMega.size();
        }
        
       /* else if((currentCase.collateral_flows__c == 'Depot' &&  currentCase.origin=='User') || currentCase.collateral_flows__c == 'CSO'|| currentCase.collateral_flows__c == 'BiMonthlyRequest'){
        ProdaddRows = productCollList.size();
        SampleaddRows = sampleList.size();
        PackaddRows = packMaterialList.size();
        minigiftRows= giftListMini.size();
        megaGiftRows= giftListMega.size();
        
        }*/
       
        
        
        for(integer i=0; i<ProdaddRows; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid();
            wrapper.invRequest.Inventory_Request_Number__c=currentCase.id; 
            productCollList.add(wrapper);
        }

        for(integer i=0; i<SampleaddRows ; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
            wrapper.invRequest.Inventory_Request_Number__c=currentCase.id;
            sampleList.add(wrapper);
        }

        for(integer i=0; i<PackaddRows ; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid();
            wrapper.invRequest.Inventory_Request_Number__c=currentCase.id;
            packMaterialList.add(wrapper);
        }

        for(integer i=0; i<megaGiftRows; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
            wrapper.invRequest.Inventory_Request_Number__c=currentCase.id;
            giftListMega.add(wrapper);
        }

        for(integer i=0; i<minigiftRows; i++){
            CollateralWrapper wrapper= new CollateralWrapper();
            wrapper.invRequest.Request_Rasied_by__c= UserInfo.getUserid(); 
            wrapper.invRequest.Inventory_Request_Number__c=currentCase.id;
            giftListMini.add(wrapper);
        }

        if(existinggifReq.size() == 0){
            for(integer i=0; i< 2; i++){
                inventory_Gift_request__c gifRequest = new inventory_Gift_request__c();
                gifRequest.Request_Raised_by__c = UserInfo.getUserid(); 
                if(i==0){
                    gifRequest.Type_Of_Meet__c =  'Mega Meet';
                    gifRequest.case__c = currentCase.id;
                    gifReq1.add(gifRequest);}
                else{
                    gifRequest.Type_Of_Meet__c =  'Mini Meet';
                    gifRequest.case__c = currentCase.id;
                    gifReq2.add(gifRequest);}
                gifReq.add(gifRequest);
            }  
        }
        else if(existinggifReq.size() == 1){
           
            for(Integer i = 0; i<existinggifReq.size(); i++){
                if(existinggifReq[i].Type_Of_Meet__c == 'Mega Meet'){
                    inventory_Gift_request__c gifRequestMega = new inventory_Gift_request__c();
                    gifRequestMega.Type_Of_Meet__c = 'Mega Meet';
                    gifRequestMega.Required_Quantity__c = existinggifReq[i].Required_Quantity__c;
                    gifRequestMega.Comments__c = existinggifReq[i].comments__c;
                    gifRequestMega.case__c = currentCase.id;
                    gifRequestMega.Request_Raised_by__c= UserInfo.getUserid(); 
                    gifReq.add(gifRequestMega);
                    gifReq1.add(gifRequestMega);
                    inventory_Gift_request__c gifRequestMini = new inventory_Gift_request__c();
                    gifRequestMini.Type_Of_Meet__c = 'Mini Meet';
                    gifRequestMini.case__c = currentCase.id;
                    gifRequestMini.Request_Raised_by__c = UserInfo.getUserid(); 
                    gifReq.add(gifRequestMini);
                    gifReq2.add(gifRequestMini);
                }

                else if(existinggifReq[i].Type_Of_Meet__c == 'Mini Meet'){ 
                    inventory_Gift_request__c gifRequest = new inventory_Gift_request__c();
                    gifRequest.Type_Of_Meet__c = 'Mini Meet';
                    gifRequest.Required_Quantity__c = existinggifReq[i].Required_Quantity__c;
                    gifRequest.Comments__c = existinggifReq[i].comments__c;
                    gifRequest.case__c = currentCase.id;
                      gifReq1.add(gifRequest);    

                    inventory_Gift_request__c gifRequestMini = new inventory_Gift_request__c();
                    gifRequestMini.Type_Of_Meet__c = 'Mega Meet';
                    gifRequestMini.case__c = currentCase.id;
                    gifRequestMini.Request_Raised_by__c = UserInfo.getUserid(); 
                    gifReq.add(gifRequestMini);
                     gifReq2.add(gifRequestMini);    
                    gifReq.add(gifRequest);   
                }
            }
        }
        else if(existinggifReq.size() == 2) {             
          
                for(Integer i = 0; i<existinggifReq.size(); i++){
                if(existinggifReq[i].Type_Of_Meet__c == 'Mega Meet'){
                gifReq1.add(existinggifReq[i]);
                }
                else
                gifReq2.add(existinggifReq[i]);
                gifReq.add(existinggifReq[i]);         
            }
        } 
       
        if(existinggifReq.size()!= 0){
            if(currentCase.status == 'New' && currentCase.collateral_flows__c == 'Requestor'){
                giftEdit = false;
            }
            else
            {
                giftEdit = true;
            }
        }
        
        if((currentCase.status =='Auto Approved' || currentCase.status =='Completed') && ( currentCase.origin =='User')){
       //autoflag = false;
        giftEdit = true;
        }
        else{
        //autoflag = true;
        }
        
        if(currentcase.status == 'New' && currentCase.Is_In_Approval_Process__c == false){
        currentcase.Check_Gifts__c = false;
        }
        else if (((giftListMega.size() == 0 && giftListMini.size() == 0)) &&(currentCase.Is_In_Approval_Process__c == true)){
               currentcase.Check_Gifts__c = false;
        }
        else
          currentcase.Check_Gifts__c = true; 
          
       
       
       
    }

   public PageReference editDetails( ){
        Id currentUser = UserInfo.getUserId();
        
    if((currentCase.Request_Raised_By__c == currentUser && currentCase.Is_In_Approval_Process__c == false) && (currentCase.status == 'New')){
        editable = true;
        }
        else if(currentCase.Team_Lead__c == currentUser && currentCase.Is_In_Approval_Process__c == true){
            editable=false;
            flagVar=true;
        }
        else if((currentCase.depo__c == currentUser || currentCase.head_office__c == currentUser) && (currentCase.status=='Approved by Team Leader' || CurrentCase.status=='Correction of Dispatch Quantity' ||
        currentCase.status == 'Auto Approved' || currentCase.status == 'Auto Approved for Bi-Monthly Batch' || currentCase.status == 'New' || currentCase.status == 'Auto Approved for Mini-Mega Meet') && (currentCase.Is_In_Approval_Process__c == true) ){
            editable = true;
             
            }
            else{
           editable= false;
             flagVar=true;
            }
        /* validation for gift section*/
        
        if((currentCase.Request_Raised_By__c == currentUser && currentCase.status !='Auto Approved') || currentCase.Team_Lead__c == currentUser){
                giftEdit=false;
        }
        else if ((currentCase.Depo__c == currentUser || currentCase.Head_Office__c == currentUser) || (currentCase.status =='Auto Approved')){
            giftEdit = true;
        }
        else
            giftEdit = false;


        if(currentCase.status=='New' && currentCase.Is_In_Approval_Process__c == false){
        objectRender1 = true;
        objectRender2 = false;
        }
        else{
        objectRender2 = true;
        objectRender1 = false;
        }
        if(currentCase.status=='Auto Approved' && currentCase.Is_In_Approval_Process__c == true){ 
        objectRendergift2 = true;
        objectRendergift1 = false;
        }
        else{
        objectRendergift1 = true;
        }
        
        return null;
    }
    public PageReference Cancel(){
        flagVar=true;
        return null;
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


    Public inventory__c queryInventory(Id invId){
        inventory__c invRecord= new inventory__c();
        invRecord=[select id,name,Color_Language_Size__c, Product_Description__c, Type__c, Item_Code__c, Product__c from inventory__c where id=: invId];
       
        return invRecord;
    } 
 public PageReference saveDetails( ){ 
        invReqMap.clear();
        flagVar = false;   
        List<inventory_Gift_request__c> finalInvReqGiftList = new List<inventory_Gift_request__c>();
        List<inventory_Gift_request__c> rejectedInvReqGiftList = new List<inventory_Gift_request__c>();
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

        for(Integer i=0; i<giftListMega.size(); i++){
            if(giftListMega[i].invRequest.inventory_mega__c!=null){        
             if(giftListMega[i].invRequest.Inventory_Request_Number__c == null){
              giftListMega[i].invRequest.Inventory_Request_Number__c=currentCase.id;}
             
                giftListMega[i].invRequest.type_of_item__c=giftListMega[i].invRequest.inventory_mega__c;
               
                invReqMap.put(giftListMega[i].invRequest.inventory_mega__c,giftListMega[i].invRequest);
            }
            

        }

        for(Integer i=0; i<giftListMini.size(); i++){
            if(giftListMini[i].invRequest.inventory_mini__c!=null){    
            if(  giftListMini[i].invRequest.Inventory_Request_Number__c == null){   
                giftListMini[i].invRequest.Inventory_Request_Number__c=currentCase.id;}
             giftListMini[i].invRequest.type_of_item__c=giftListMini[i].invRequest.inventory_mini__c;
                invReqMap.put(giftListMini[i].invRequest.inventory_mini__c,giftListMini[i].invRequest);
            }
          

        }
        List<Inventory_request__c> delList = [select Id from inventory_request__c where type_of_item__c not in:invReqMap.keyset()
        and Inventory_Request_Number__c=:currentCase.id];
       
        for(inventory_Gift_request__c gif: gifReq){
            if(gif.Required_Quantity__c != null){
                finalInvReqGiftList.add(gif);
            }
        } 
         
system.debug('giftListMini:::'+ giftListMini);
system.debug('giftListMega:::'+ giftListMega);
   if(commonhelper.ValidateCollList(productCollList,sampleList,packMaterialList,giftListMini, giftListMega)){
    if(commonhelper.validateCollateral(invReqMap,finalInvReqGiftList, currentCase)){

            
        upsert invReqMap.values();
        delete delList;  
        if(finalInvReqGiftList.size() !=0 && currentCase.status =='New' && currentCase.is_in_approval_process__c == false){
        currentCase.check_gifts__c = true;
        upsert currentCase;
       
      
        }
         
           upsert finalInvReqGiftList;
            editable=false;
            giftEdit=false;
            flagVar=true;
       }
           }
           flagVar=true;
        return null; 
    }

    

}