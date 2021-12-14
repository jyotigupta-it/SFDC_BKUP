public with sharing class AP_RetailProjectDetailPage_Controller {

    
    public boolean check1{get;set;}
    public String oppId{get;set;}
    public Opportunity thisProject;
    public List<Influencer__c> influList;
    public List<Project_Tracker__c> projectTrackList;
    private List<productWrapper> probabilityInsertList;
    public List<productWrapper> offerInsertList;
    public List<OpportunityLineItem> offerList;
    public List<OpportunityLineItem> supplyList;
    public List<productWrapper> orderLossList;
    public List<orderProductWrapper> orderInsertList;
    public List<SupplyLineItem__c> supplyInsertList;
    public List<Order> parentOrderList;
    public Order parentOrderRecord;
    public boolean delflag{get;set;}
    public List<Supply__c> parentSupplyList; 
    public boolean check{get;set;}
    public boolean spr{get;set;}
    List<selectOption> productNameList;

    public Decimal totalOrderValue {get;set;}
    public Decimal totalOrderQuantity {get;set;}
    public Decimal totalSupplyValue {get;set;}
    public Decimal totalSupplyQuantity {get;set;}
    public  integer percnt;

    public String removeRowType {get;set;}
    
    
    public AP_RetailProjectDetailPage_Controller(ApexPages.StandardController controller) {
        
        String chk              = ApexPages.CurrentPage().getParameters().get('check');
        
        if(chk=='true'){
            check1=true;
        }else{
            check1=false;
        }
        
        
    spr = true;
   
   
   
       
         Profile pro = [select id,name from profile  where name ='System Administrator' LIMIT 1];
        if(pro.Id == userinfo.getprofileid()){
        delflag=false;
        
        }else{
        
        delflag=true;
        
        }
        
        //for 80% validation
          oppId  = ApexPages.CurrentPage().getParameters().get('id');
         Opportunity opp=[select Probability__c,Probability_New__c  from Opportunity where Id =: oppId limit 1];
       system.debug(opp.Probability_New__c);
       
       if(opp.Probability_New__c!=null){
       
       string s=''+opp.Probability_New__c;
       List<string> st=s.split('%');
        percnt=integer.valueof(st[0]);
         }
         if(percnt<80){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Need probability more than 80% to submit'));
    
       }
        
  List<OpportunityLineItem> oli = [select OpportunityId, Special_Pricing_Request_Check__c  from OpportunityLineItem where OpportunityId=: oppId AND Special_Pricing_Request_Check__c = TRUE Limit 1];
        if(!oli.isEmpty() && percnt<80){
          spr = true;
        } 
       totalOrderValue = 0;
        totalOrderQuantity = 0;
        totalSupplyValue = 0;
        totalSupplyQuantity = 0;
        check=false;
        //removeRow      = 'index';
      //oppId was here
        thisProject = [SELECT No_of_Bathrooms__c,No_of_Floors__c, ParentOrderFlag__c, Pricebook2Id, Project_By__c, CloseDate,(SELECT Id from Orders) FROM Opportunity where id =: oppId];
        influList           = new List<Influencer__c>();
        projectTrackList    = new List<Project_Tracker__c>();
        //probabilityList     = new List<productWrapper>();

        productNameList     = new  list<selectOption>();
        productNameList.add(new selectOption('', '--None--'));
        for(PriceBook2 pb : [select id, (select product2.Name,product2id from PriceBookEntries) from pricebook2 where Name = 'Project']) {
            for(priceBookEntry pbEntry : pb.PriceBookEntries) {
            productNameList.add(new selectOption(pbEntry.id, pbEntry.Product2.Name));
            }

        }

        orderLossList = new List<productWrapper> ();
        //Order_Loss__c
        for(OpportunityLineItem oppItem : [SELECT Product_Name__c, product2.name, PricebookEntry.Product_number__c, Order_Loss_by_Disc__c, Order_Lost_to_Competitor__c, Description, Reason_for_Order_Loss__c,Order_Loss__c FROM OpportunityLineItem where OpportunityId =:oppId and Order_Loss_Check__c = true ]) {
            productWrapper proWrap = new productWrapper(false, false, true);
            proWrap.oppLineItem = oppItem;
            orderLossList.add(proWrap);
        }

        offerInsertList = new List<productWrapper>();
        for(OpportunityLineItem oppItem : [SELECT OpportunityId, Product_Name__c, id, product2.Name, Offer_Quantity__c,Unit__c, Offer_MRP__c, Competitor_name_Offer__c, Distributor__c,Distributor__r.name,Tentative_Date__c, Discount_Offered__c, Price_List_Date__c, Price_Valid_Date__c, Offer_Probability__c,  Reason__c FROM OpportunityLineItem where OpportunityId =:oppId and Offer_Check__c = true]) {
            productWrapper proWrap = new productWrapper(false, true, false);
            proWrap.oppLineItem = oppItem;
            offerInsertList.add(proWrap);            
        }

        probabilityInsertList = new List<productWrapper>();
        for(OpportunityLineItem oppItem : [SELECT Probability_Validation__c,Product_Value__c, Project_Finalization_Date__c,Product_Specified__c, OpportunityId, Product_Name__c, id, product2.Name, Probability_Quantity__c, Unit__c, Probability_MRP__c, Competitor_name1__c, Distributor__c, Distributor__r.name,Probability__c, Remark__c FROM OpportunityLineItem where OpportunityId =:oppId and Probability_Check__c = true]) {
            productWrapper proWrap = new productWrapper(true, false, false);
            proWrap.oppLineItem = oppItem;
            probabilityInsertList.add(proWrap);
            check=true;
        }

        parentOrderList = new List<Order>([SELECT OpportunityId, (SELECT Id, OrderId, Competitor_Name__c, Distributor_Name__c, Distributor_Name__r.name,ORC_Markup__c,
                                        ORC_Status__c, Order_Status__c, Order_Value__c, Payment_Terms__c, Unit__c, Validity_for_Price__c, 
                                        PriceBookEntryId, PriceBookEntry.Product2.Name, Quantity, ServiceDate, EndDate FROM OrderItems) from Order where OpportunityId =: oppId LIMIT 1]);        
        
        orderInsertList = new List<orderProductWrapper>();
        if(parentOrderList.size()> 0) {
            for(OrderItem tempOrderItem : parentOrderList[0].OrderItems) {
                orderProductWrapper ordWrap = new orderProductWrapper();
                ordWrap.orderItemInstance =  tempOrderItem;
                orderInsertList.add(ordWrap);
                totalOrderValue += tempOrderItem.Order_Value__c != null ? tempOrderItem.Order_Value__c : 0;
                totalOrderQuantity += tempOrderItem.Quantity != null ? tempOrderItem.Quantity : 0;
            }        
        }

        parentSupplyList = new List<Supply__c>([SELECT Id, (SELECT  Product__c, Quantity__c, Unit__c, Order_Value__c, Invoice_Date__c, Payment_Terms__c, Supply_Status__c, Distributor_Name__c,Distributor_Name__r.name ,
                                                ORC_Markup__c, ORC_Status__c FROM SupplyLineItems__r) FROM Supply__C WHERE Project__c = : oppId LIMIT 1]);

        supplyInsertList = new List<SupplyLineItem__c>();
        if(parentSupplyList.size()> 0) {
            for(SupplyLineItem__c tempSupplyItem : parentSupplyList[0].SupplyLineItems__r) {
                SupplyLineItem__c supplyItem = new SupplyLineItem__c();
                supplyItem = tempSupplyItem;
                supplyInsertList.add(supplyItem);
                totalSupplyValue += tempSupplyItem.Quantity__c != null ? tempSupplyItem.Quantity__c : 0;
                totalSupplyQuantity += tempSupplyItem.Order_Value__c != null ? tempSupplyItem.Order_Value__c : 0;
            }
        }
    }
    
    
      public PageReference addlDiscReq () {

        PageReference pf = new PageReference('/apex/Additional_Dics_Opp?id='+oppId);
        return pf;
    }

    // Display existing records in Probability
    public List<productWrapper> getprobabilityList() {
       
            if(probabilityInsertList.size() == 0) {
             probProd();
        }
        return probabilityInsertList;
    }

    // Display existing records in Offer
    public List<productWrapper> getofferList() {
       
            if(offerInsertList.size() == 0) {
             offerProd();
        }        
        return offerInsertList;
    }
    // Display existing records in Order Loss List
    public List<productWrapper> getorderLossList() {
       
            if(orderLossList.size() == 0) {
             orderLoss();
        }        
        return orderLossList;
    }

    // Display existing records in Order
    public List<orderProductWrapper> getorderList() {
       
            if(orderInsertList.size() == 0) {
                
                    
                    //insert parentOrderRecord;    
                    orderProd();
        }
        return orderInsertList;
    }

    // Display existing records in Supply
    public List<SupplyLineItem__c> getsupplyList() {
       system.debug('--supplyInsertList--='+supplyInsertList);
        if(supplyInsertList.size() == 0) {
             supplyProd();
        }
        return supplyInsertList;
    }


    
    /* This method will get all the influencer list */
    public List<Influencer__c> getInfluencerList() {
        
        influList = [SELECT Id, Account__c, Account__r.Firm_Name__c, Influencer_Type__c, Last_Visit_Date__c, Update_of_Last_Visit__c,Inf_Order__c,Source__c FROM Influencer__c WHERE Opportunity__c = :oppId Order BY Inf_Order__c Asc];
        return influList;
    }
    
    /* Method for redirecting to edit Influencers page*/
    public PageReference editInfluencer() { 
        
        PageReference pf = new PageReference('/apex/MassEditInfulencers?ProjectId='+oppId);
        return pf;
    }
    
    /* This method will get all the project tracker list */
    public List<Project_Tracker__c> getProjectTrackerList() {
        
        projectTrackList = [SELECT Opportunity__c,Question__c,Remarks__c,Response__c,Probability__c,Project_Order__c,Action_Plan__c,Action_Date__c FROM Project_Tracker__c WHERE Opportunity__c = :oppId ORDER by Project_Order__c ASC];
        return projectTrackList;
    }
    /* Method for redirecting to MassEditProjectTracker page*/
    public PageReference editProjectTrack() {
        
        PageReference pf = new PageReference('/apex/AP_MassEditProjectTracker?ProjectId='+oppId);
        return pf;
    }

    
    
    /* Method will add empty Product record to APPL Probability list*/
    public void probProd() {
        
        productWrapper proWrap = new productWrapper(true, false, false);
        proWrap.productValues = productNameList;
        prowrap.oppLineItem.OpportunityId = oppId;
        //getprobabilityList();
        probabilityInsertList.add(proWrap); 
              
    }

    /* Method will add empty Product record to APPL Offer list*/
    public void offerProd() {
        
        productWrapper proWrap = new productWrapper(false, true, false);
        proWrap.productValues = productNameList;
        prowrap.oppLineItem.OpportunityId = oppId;
        //getprobabilityList();
        offerInsertList.add(proWrap);               
    }

    /* Method will add empty Product record to APPL Order Loss*/
    public void orderLoss() {
        
        productWrapper proWrap = new productWrapper(false, false, true);
        proWrap.productValues = productNameList;
        prowrap.oppLineItem.OpportunityId = oppId;
        //getprobabilityList();
        orderLossList.add(proWrap);               
    }



    /* Method will add empty Product record to APPL Order list*/
    public void orderProd() {
        
        orderProductWrapper ordWrap = new orderProductWrapper();        
        ordWrap.productValues = productNameList;
        ordWrap.orderItemInstance.Quantity = 1;
        //ordWrap.orderItemInstance.OpportunityId = oppId; Think Logic to add Opportunity Id in parent Order.
        //getprobabilityList();
        orderInsertList.add(ordWrap);              
    }


    /* Method will add empty Product record to APPL Supply list*/
    public void supplyProd() {
         
        SupplyLineItem__c supplyItem = new SupplyLineItem__c();       
        supplyItem.Quantity__c = 0;
        supplyInsertList.add(supplyItem); 
        system.debug('--supplyInsertList--*'+supplyInsertList);      
    }
//************************* Remove Row ****************************
//Remove rows on click of the Remove rowlink.
    public void removeRow() {   


        
        try {
            integer x_count = Integer.valueOf(Apexpages.currentPage().getParameters().get('rowNum'));

            if(Apexpages.currentPage().getParameters().get('removeRowType') == 'appl_prob') {
                probabilityInsertList.remove(x_count - 1);
            }
            else if (Apexpages.currentPage().getParameters().get('removeRowType') == 'appl_offer') {
                offerInsertList.remove(x_count - 1);
            }
            else if (Apexpages.currentPage().getParameters().get('removeRowType') == 'appl_order') {
                orderInsertList.remove(x_count - 1);
            }
            else if (Apexpages.currentPage().getParameters().get('removeRowType') == 'appl_spply') {
                supplyInsertList.remove(x_count - 1);
            }
            else if (Apexpages.currentPage().getParameters().get('removeRowType') == 'appl_ordlss') {
                orderLossList.remove(x_count - 1);
            }
            
        } catch(Exception e) {
            Apexpages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
        }
    }




// ***************      Save Probability *******************
    public void saveProb() {

        Savepoint sp = Database.setSavepoint();
        try {
            List<OpportunityLineItem> oLIList = new List<OpportunityLineItem>();
            for(productWrapper tempObj: probabilityInsertList) {

                tempObj.oppLineItem.Quantity = 1;
                tempObj.oppLineItem.UnitPrice = 1;
                //tempObj.oppLineItem.OpportunityId = oppId;
                oLIList.add(tempObj.oppLineItem);
            }
            upsert(oLIList);
            
        }
        catch(Exception e) {            
            Database.rollback(sp);
            ApexPages.addMessages(e);            
        }
    }

// ********************************* Save Offer *******************
    public pageReference saveOffer() {
        system.debug('coming??');
        Savepoint sp = Database.setSavepoint();
        try {
            List<OpportunityLineItem> oLIList = new List<OpportunityLineItem>();
            for(productWrapper tempObj: offerInsertList) {
                tempObj.oppLineItem.Quantity = 1;
                tempObj.oppLineItem.UnitPrice = 1;
                //tempObj.oppLineItem.OpportunityId = oppId;
                oLIList.add(tempObj.oppLineItem);                
            } 
            system.debug('coming123??');           
            upsert(oLIList);
            return null;            
        }
        catch(Exception e) {            
            Database.rollback(sp);
            ApexPages.addMessages(e);   
            return null;         
        }
    }   

// ********************************* Save Order Loss *******************
    public pageReference saveOrderLoss() {
    PageReference pf = new PageReference('/'+oppId);
        
        system.debug('Inside saveOrderLoss');
       // Savepoint sp = Database.setSavepoint();
        try {
            List<OpportunityLineItem> oLIList = new List<OpportunityLineItem>();
            for(productWrapper tempObj: orderLossList) {
                tempObj.oppLineItem.Quantity = 1;
                tempObj.oppLineItem.UnitPrice = 1;
                //tempObj.oppLineItem.OpportunityId = oppId;
                if((tempObj.oppLineItem.Order_Loss_by_Disc__c ==null ) || (tempObj.oppLineItem.Order_Lost_to_Competitor__c ==null || tempObj.oppLineItem.Order_Lost_to_Competitor__c =='') || (tempObj.oppLineItem.Reason_for_Order_Loss__c == null) 
             || (tempObj.oppLineItem.Description == null || tempObj.oppLineItem.Description =='') || (tempObj.oppLineItem.Order_Loss__c == null || tempObj.oppLineItem.Order_Loss__c == '')){
                
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'Please enter all values in Order Loss section'));

                return null;                }
                oLIList.add(tempObj.oppLineItem); 
   system.debug('Inside saveOrderLosstry');             
            } 
                       
            upsert(oLIList); 
                     
        }
        catch(Exception e) {  
         system.debug('Inside saveOrderLossCatch');         
        //    Database.rollback(sp);
            ApexPages.addMessages(e); 
            return null;           
        }
         return pf;
    } 

// ********************************* Save Order *******************
    public void saveOrder() {        
        
        try {         
            List<OrderItem> orderItemInsertList = new List<OrderItem>();  
            Boolean parentOrderflag = false;          
            
            if(parentOrderList.size() == 0) {   
                parentOrderRecord = new Order();
                parentOrderRecord.Status = 'Draft';
                parentOrderRecord.AccountId = thisProject.Project_By__c;
                parentOrderRecord.OpportunityId = oppId;
                parentOrderRecord.EffectiveDate = thisProject.CloseDate;
                parentOrderRecord.Pricebook2Id = thisProject.Pricebook2Id;             
                insert parentOrderRecord;
                parentOrderflag = true;
                                
            }
            
            for(orderProductWrapper tempObj: orderInsertList) {

                
                OrderItem tempOrderItem = new OrderItem();
                tempOrderItem = tempObj.orderItemInstance;

                if(parentOrderflag) {                 
                    tempOrderItem.OrderId = parentOrderRecord.Id;                    
                }
                if(orderInsertList.size() > 0 && tempOrderItem.OrderId == null) {                    
                    tempOrderItem.OrderId = parentOrderList[0].Id;
                }

                tempOrderItem.UnitPrice = 0.0;                
                orderItemInsertList.add(tempOrderItem);                                                 
            }            
            
            if(orderItemInsertList.size() > 0 ) {                            
                upsert orderItemInsertList;   
            }                   
        }
        catch(Exception e) {      
            System.debug('!!!!!!!!!!eeeeeeee'+e);
            ApexPages.addMessages(e);            
        }
    } 
    // ********************************* Save Supply *******************

    public void saveSupply() {
        
        List<SupplyLineItem__c> supplylineItemUpsert = new List<SupplyLineItem__c>();
        Supply__c parentSupply = new Supply__c();
        Boolean parentSupplyflag = false;

        if(parentSupplyList.size() == 0){
            //Supply__c parentSupplyrecord = new Supply__C();
            parentSupply.Project__c = oppId;
            try {
                insert parentSupply;      
                System.debug('!!!!!!!!!!@@@@@@'+parentSupply);          
                parentSupplyflag = true;                
            }
            catch(Exception e) {
                System.debug('!!!!!!!!!!eeeeeeee'+e);                                
                ApexPages.addMessages(e);
            }
        }
        for(SupplyLineItem__c tempObj : supplyInsertList) {
            SupplyLineItem__c supplyLineItem = new SupplyLineItem__c();
            supplyLineItem = tempObj;
            if(parentSupplyflag) {
                supplyLineItem.SupplyDetails__c = parentSupply.Id;
            }
            if(parentSupplyList.size() > 0 && supplyLineItem.Id == null) {
                supplyLineItem.SupplyDetails__c = parentSupplyList[0].id;                                
            }                
            supplylineItemUpsert.add(supplyLineItem);
        }
        try {
            if(supplylineItemUpsert.size() > 0 ) {   
                System.debug('!!!!!!!!!!#######'+supplylineItemUpsert);             
                upsert supplylineItemUpsert;
            }
        }
        catch(Exception e) {                
            System.debug('!!!!!!!!!!eeeeeeee'+e);
            ApexPages.addMessages(e);
        }        
    }
    //************************************ Methods for PDF *********
    public pageReference SPRPDFPreviewRedirect(){
        System.debug('pageReference outside ' + oppId);
        PageReference pf = new PageReference('/apex/SPR_PDF_Preview_Redirect?att='+oppId);
        System.debug('pageReference outside ' + oppId);
        return pf;
    }
    public pageReference SPRPDFPreviewRedirect2(){
        System.debug('pageReference outside ' + oppId);
        PageReference pf = new PageReference('/apex/SPR_PDF_Preview_Redirect2?att='+oppId);
        System.debug('pageReference outside ' + oppId);
        return pf;
    }
    

    //********************************* Wrapper Classes *************************** 
    public class productWrapper {
        
        public list<selectOption> productValues {get; set;}
        public OpportunityLineItem oppLineItem {get; set;}
        
        public productWrapper(boolean probCheck, boolean offerCheck, boolean orderloss) {
            
            productValues = new list<selectOption>();
            oppLineItem = new OpportunityLineItem(Probability_Check__c = probCheck, Offer_Check__c = offerCheck, Order_Loss_Check__c = orderloss);
        }
    }

    public class orderProductWrapper {
        
        public list<selectOption> productValues {get; set;}
        public OrderItem orderItemInstance {get; set;}
        
        public orderProductWrapper() {
            
            productValues = new list<selectOption>();
            orderItemInstance = new OrderItem();
        }
    }

        
}