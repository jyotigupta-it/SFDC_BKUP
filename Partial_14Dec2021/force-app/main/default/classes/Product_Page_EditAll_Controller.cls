/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :19-Jan-2015
Modified Date   :
Version         :1.0
Description     :Controller of Product_Page_EditAll page

********************XXX***********************************/
public class Product_Page_EditAll_Controller {

    public String oppProId {get;set;}
    public String applType {get;set;}
    public list<OpportunityLineItem> oppList{set; get;}
    public list<OpportunityLineItem> oppOfferList {get;set;}
    public list<OpportunityLineItem> oppOrderList {get;set;}
    public list<OpportunityLineItem> oppSupplyList {get;set;}
    public list<OpportunityLineItem> ordLssList;
    public Opportunity oppTc {get; set;}
    public Opportunity opp;
    public List<OrderItemWrapperClass> ordItmWrpList;
    public List<Order> parentOrderList;
    public List<SupplyLineItem__c> SupplyItemList;
    public List<Supply__c> parentSupplyRecord;
    public List<SupplyLineItem__c> supplyLineItemsList;
    public List<SupplyWrapperClass>SupplyItemWrapperList;
    public Boolean saveOrder {get;set;}
    public Boolean saveSupply {get;set;}

    
    public String delID {get;set;}
 

    public Product_Page_EditAll_Controller(ApexPages.StandardController stdController) {
      
        oppProId = Apexpages.currentPage().getParameters().get('id');   
        applType = Apexpages.currentPage().getParameters().get('applType'); 
        
        oppTC = new Opportunity();
        oppTC = [SELECT Id,Freight__c,Delivery__c,Price_Basis__c,Delivery_Lots__c,Taxes__c,Offer_Valid_Till__c,Payment_Term__c,Delivery_Conditions_Gurantee__c,Order_Placement__c FROM Opportunity WHERE Id =:oppProId];
        parentSupplyRecord = new List<Supply__c>([SELECT Id from Supply__c WHERE Project__c =: oppProId Limit 1]);
        
        if(applType == 'offerType') {
            
            oppOfferList = new list<OpportunityLineItem>();
            oppOfferList = [SELECT Id,OpportunityId,Probability_Quantity__c,Competitor_name_Order__c, Competitor_name_Supply__c,PricebookEntry.Product_number__c,product2.name,product2Id,Distributor__c,Distributor__r.name,MRP__c,Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,Unit__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Competitor_name1__c,Competitor_name_Offer__c,Offer_Quantity__c,Reason__c,APPL_Type__c,Offer_Probability__c,Offer_MRP__c,Offer_Check__c,Discount_Offered__c,Price_List_Date__c,Price_Valid_Date__c FROM OpportunityLineItem where OpportunityId =:oppProId and (Offer_Check__c = true or (Probability_Validation__c != null or  Product_Value__c != null)) ORDER by PricebookEntry.Product_number__c];
              system.debug('oppOfferList'+oppOfferList);
            system.debug('product2.name'+product2.name);
            for (OpportunityLineItem Op : oppOfferList) {
                op.Offer_Check__c = true;
            }
        } 
                if(applType == 'probType') {
        
          oppList = [SELECT Id,OpportunityId,Probability_Validation__c,Competitor_name_Order__c, Competitor_name_Supply__c, Competitor_name_Offer__c, PricebookEntry.Product_number__c,product2.name,product2Id,MRP__c,Probability_MRP__c,Probability_Quantity__c,Remark__c,Project_Finalization_Date__c,Unit__c,Probability__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Competitor_name1__c,Order_Quantity__c,Reason__c,APPL_Type__c,Product_Value__c FROM OpportunityLineItem where OpportunityId =:oppProId and Probability_Check__c = true ORDER by PricebookEntry.Product_number__c];
}
        if(applType == 'retailOfferType') {
            
            oppOfferList = new list<OpportunityLineItem>();
            oppOfferList = [SELECT OpportunityId, Product_Name__c, id, product2.Name, Offer_Quantity__c,Unit__c, Offer_MRP__c, Competitor_name_Offer__c, Distributor__c,Distributor__r.name,Tentative_Date__c, Discount_Offered__c, Price_List_Date__c, Price_Valid_Date__c, Offer_Probability__c,  Reason__c FROM OpportunityLineItem where OpportunityId =:oppProId and Offer_Check__c = true ORDER by PricebookEntry.Product_number__c];
            //System.debug('@@@@@@@@@@@'+oppOfferList);
            for (OpportunityLineItem Op : oppOfferList) {
                op.Offer_Check__c = true;
            }
        }
    }
    
    /* Method will save based on Appl type */
    public PageReference savePage() {   

        PageReference pf = new PageReference('/'+oppProId);
        
        if(applType == 'probType' && oppList.size() > 0) {
       
        system.debug('opplist values'+opplist );
            for(OpportunityLineItem oppLineItem : oppList) {
                    
               system.debug(' Probability_Validation__c ::::'+oppLineItem.Probability_Validation__c );
               system.debug(' Product_Value__c ::::' +oppLineItem.Product_Value__c );
        
                if((oppLineItem.Probability_Validation__c == 'Yes' || oppLineItem.Probability_Validation__c == 'No') && (oppLineItem.Product_Value__c == null ) ) {
                //oppLineItem.Unit__c == null ||
                 
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            return null;
                    }    
                if((oppLineItem.Probability_Validation__c == '' || oppLineItem.Probability_Validation__c == null) && (oppLineItem.Product_Value__c <> null ) ) {
                //oppLineItem.Unit__c == null ||
                         
                           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            return null;
                    }                           
                }
                
             try{
                system.debug('opplist valuesTry'+opplist );
                 Upsert oppList;
                 system.debug('opplist valuesTry'+opplist );
                 }
                 catch(Exception e) {

                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            }             
                 
                 
            }
           
        
        else if(applType == 'offerType' && oppOfferList.size() > 0) {
            

            for(OpportunityLineItem offer: oppOfferList) {

                /*offer.Offer_Quantity__c      = offer.Probability_Quantity__c;
                offer.Offer_MRP__c           = offer.Probability_MRP__c;
                offer.Offer_Probability__c   = offer.Probability__c;
                offer.Offer_Check__c         = true;
                //offerList.add(offer);*/
                if(!offer.Offer_Check__c) {
                offer.Tentative_Date__c = null;
                offer.Discount_Offered__c = null;
                offer.Price_List_Date__c = null;
                offer.Price_Valid_Date__c = null;
                }
                if(offer.Offer_Check__c == true){
                   //if(offer.Offer_Quantity__c == null || 
                   if(offer.Offer_MRP__c == null  || offer.Tentative_Date__c == null ||offer.Tentative_Date__c == '' ||
                        offer.Discount_Offered__c == null || offer.Price_List_Date__c == null || offer.Price_Valid_Date__c == null ||
                        offer.Competitor_name_Offer__c == null ||offer.Competitor_name_Offer__c == ''|| offer.Offer_Probability__c == null ||offer.Offer_Probability__c == ''|| offer.Reason__c == null||offer.Reason__c == '') {                     
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            return null;
                            //System.debug('@@@@@@'+offer);
                    }    
                    //System.debug('!!!!!!!'+offer);                                    
                }

            }
            try {
                update oppOfferList;
                update oppTc;
            }
            catch(Exception e) {

                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            }              
        } 
        else if(applType == 'retailOfferType' && oppOfferList.size() > 0) {
            

            for(OpportunityLineItem offer: oppOfferList) {

                /*offer.Offer_Quantity__c      = offer.Probability_Quantity__c;
                offer.Offer_MRP__c           = offer.Probability_MRP__c;
                offer.Offer_Probability__c   = offer.Probability__c;
                offer.Offer_Check__c         = true;
                //offerList.add(offer);*/
                if(!offer.Offer_Check__c) {
                offer.Tentative_Date__c = null;
                offer.Discount_Offered__c = null;
                offer.Price_List_Date__c = null;
                offer.Price_Valid_Date__c = null;
                }
                if(offer.Offer_Check__c == true){
                   //if(offer.Offer_Quantity__c == null || 
                   if(offer.Offer_MRP__c == null  || offer.Tentative_Date__c == null ||offer.Tentative_Date__c == '' ||
                        offer.Discount_Offered__c == null || offer.Price_List_Date__c == null || offer.Price_Valid_Date__c == null ||
                        offer.Competitor_name_Offer__c == null ||offer.Competitor_name_Offer__c == ''|| offer.Offer_Probability__c == null ||offer.Offer_Probability__c == ''|| offer.Reason__c == null||offer.Reason__c == '') {                     
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            return null;
                            //System.debug('@@@@@@'+offer);
                    }    
                    //System.debug('!!!!!!!'+offer);                                    
                }

            }
            try {
                update oppOfferList;
                update oppTc;
            }
            catch(Exception e) {

                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            }              
        } 





        else if(applType == 'orderType' && ordItmWrpList.size() > 0) {
                List<OrderItem> orderItemList = new List<OrderItem>();
                for(OrderItemWrapperClass tempObject : ordItmWrpList) {
                    OrderItem orderItemObject = new OrderItem();
                    orderItemObject = tempObject.orderItemInstance;
                    orderItemList.add(orderItemObject);
                }
         Update orderItemList;    //oppOrderList
         System.debug('orderItemList is ' + orderItemList);
        }  
        
        else if(applType == 'supplyType' && SupplyItemWrapperList.size() > 0) {
                List<SupplyLineItem__c> supplyLineItemList = new List<SupplyLineItem__c>();
                for(SupplyWrapperClass tempObject : SupplyItemWrapperList) {
                    SupplyLineItem__c supplyItemObject  = new SupplyLineItem__c();
                    supplyItemObject = tempObject.SupplyLineItemInstance;
                    supplyLineItemList.add(supplyItemObject);
                }

            Update supplyLineItemList;
        }  

        else if(applType == 'orderLost' && ordLssList.size() > 0) {
          for(OpportunityLineItem lossOffer: ordLssList){
            if((lossOffer.Order_Loss_by_Disc__c ==null ) || (lossOffer.Order_Lost_to_Competitor__c ==null || lossOffer.Order_Lost_to_Competitor__c =='') || (lossOffer.Reason_for_Order_Loss__c == null) 
             || (lossOffer.Description == null || lossOffer.Description =='') || (lossOffer.Order_Loss__c == null || lossOffer.Order_Loss__c == ''))
           {
           
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
         
                            return null;
                            }
   }
         try{
               system.debug('inside try');
                 update ordLssList;
                    }                
                catch(Exception e) {
                system.debug('inside catch');
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                } 
        }

        return pf;

    }
    
    /*public List<OpportunityLineItem> getoppList() {
       
        oppList = [SELECT Id,OpportunityId,Probability_Validation__c,Competitor_name_Order__c, Competitor_name_Supply__c, Competitor_name_Offer__c, PricebookEntry.Product_number__c,product2.name,product2Id,MRP__c,Probability_MRP__c,Probability_Quantity__c,Remark__c,Project_Finalization_Date__c,Unit__c,Probability__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Competitor_name1__c,Order_Quantity__c,Reason__c,APPL_Type__c,Product_Value__c FROM OpportunityLineItem where OpportunityId =:oppProId and Probability_Check__c = true ORDER by PricebookEntry.Product_number__c];
        if(oppList.size() != 0) {
            
            
            return oppList;
        }
        else {
            return null;
        }
    }*/

    public List<OpportunityLineItem> getOrderLossList() {
        //Order_Loss__c
        ordLssList =  [SELECT Id, OpportunityId, product2.name, PricebookEntry.Product_number__c, Order_Loss_by_Disc__c, Order_Lost_to_Competitor__c, Description, Reason_for_Order_Loss__c, Order_Loss__c FROM OpportunityLineItem where OpportunityId =:oppProId and Order_Loss_Check__c = true ORDER by PricebookEntry.Product_number__c];
        

        if(ordLssList.size() != 0) {           
            //System.debug('&&&&&&&&&&'+ordLssList);
            return ordLssList;            
        }
        else {
            return null;
        }
    }

    /*public list<OpportunityLineItem> getOfferListPro() {
        
        oppOfferList = [SELECT Id,OpportunityId,Probability_Quantity__c, Competitor_name_Order__c, Competitor_name_Supply__c,PricebookEntry.Product_number__c,product2.name,product2Id,Distributor__c,Distributor__r.name,MRP__c,Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,Unit__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Competitor_name1__c,Competitor_name_Offer__c,Offer_Quantity__c,Reason__c,APPL_Type__c,Offer_Probability__c,Offer_MRP__c,Offer_Check__c,Discount_Offered__c,Price_List_Date__c,Price_Valid_Date__c FROM OpportunityLineItem where OpportunityId =:oppProId and (Offer_Check__c = true or (Probability_Quantity__c != null or Probability_MRP__c != null or Product_Specified__c != null or Probability__c != null)) ORDER by PricebookEntry.Product_number__c];
        if(oppOfferList.size() != 0) {
            
            system.debug('*******oppOfferList**********'+oppOfferList);
            
            return oppOfferList;
        }
        else {
            return null;
        }
    }*/

    public List<OrderItemWrapperClass> getOrderListPro() {

        parentOrderList = new List<Order>([SELECT OpportunityId,(SELECT Id, Competitor_Name__c,Distributor_Name__c, Distributor_Name__r.name,ORC_Markup__c,
                                        ORC_Status__c, Order_Status__c, Order_Value__c, Payment_Terms__c, Unit__c, Validity_for_Price__c, 
                                        PriceBookEntryId, PriceBookEntry.Product2.Name, Quantity, ServiceDate, EndDate FROM OrderItems) from Order where OpportunityId =: oppProId LIMIT 1]);
        ordItmWrpList = new List<OrderItemWrapperClass>();
        if(parentOrderList.size()> 0) {
            for (OrderItem tempOrderItem : parentOrderList[0].OrderItems) {

                OrderItemWrapperClass ordItmWrp =  new OrderItemWrapperClass();
                ordItmWrp.orderItemInstance = tempOrderItem;
                ordItmWrp.productName = tempOrderItem.PriceBookEntry.Product2.Name;
                /*ordItmWrp.orderItemInstance.PriceBookEntryId = tempOrderItem.PriceBookEntryId;
                ordItmWrp.productName = tempOrderItem.PriceBookEntry.Product2.Name;
               // ordItmWrp.orderItemInstance.Quantity = tempOrderItem.Quantity;
                //ordItmWrp.orderItemInstance.Unit__c = tempOrderItem.Unit__c;
                ordItmWrp.orderItemInstance.Order_Value__c = tempOrderItem.Order_Value__c;
                ordItmWrp.orderItemInstance.ServiceDate = tempOrderItem.ServiceDate;
                ordItmWrp.orderItemInstance.EndDate = tempOrderItem.EndDate;
                ordItmWrp.orderItemInstance.Validity_for_Price__c = tempOrderItem.Validity_for_Price__c;
                ordItmWrp.orderItemInstance.Payment_Terms__c = tempOrderItem.Payment_Terms__c;
                //ordItmWrp.orderItemInstance.Competitor_Name__c = tempOrderItem.Competitor_Name__c;
                ordItmWrp.orderItemInstance.ORC_Markup__c = tempOrderItem.ORC_Markup__c;
                ordItmWrp.orderItemInstance.ORC_Status__c = tempOrderItem.ORC_Status__c;
                ordItmWrp.orderItemInstance.Order_Status__c = tempOrderItem.Order_Status__c;*/
                
                ordItmWrpList.add(ordItmWrp);
            }
        }
        if(ordItmWrpList.size() != 0) {

            return ordItmWrpList;
        }
        else {
            return null;
        }
        
    }

    public class OrderItemWrapperClass {
        public OrderItem orderItemInstance {get; set;}
        public String productName {get;set;}

        public OrderItemWrapperClass() {
            orderItemInstance = new OrderItem();
            productName = '';
        }
    }
    
    public list<SupplyWrapperClass> getSupplyListPro() {

        SupplyItemWrapperList = new List<SupplyWrapperClass>();
        supplyLineItemsList = new List<SupplyLineItem__c>([SELECT Id, Distributor_Name__c, Distributor_Name__r.name,OrderLineItem__c, Product__c, Product__r.Name, Quantity__c, Unit__c, Order_Value__c, Invoice_Date__c, Payment_Terms__c, Supply_Status__c, ORC_Markup__c, ORC_Status__c from SupplyLineItem__c WHERE SupplyDetails__c = : parentSupplyRecord[0].Id]);
        
        for (SupplyLineItem__c  tempSupplyItem : supplyLineItemsList) {

            SupplyWrapperClass supplyWrpObj = new SupplyWrapperClass();
            supplyWrpObj.SupplyLineItemInstance = tempSupplyItem;
            
            /*supplyWrpObj.SupplyLineItemInstance.Product__c = tempSupplyItem.Product__c;
            //supplyWrpObj.SupplyLineItemInstance.Quantity__c = tempSupplyItem.Quantity__c;
           // supplyWrpObj.SupplyLineItemInstance.Unit__c = tempSupplyItem.Unit__c;
            supplyWrpObj.SupplyLineItemInstance.Order_Value__c = tempSupplyItem.Order_Value__c;
            supplyWrpObj.SupplyLineItemInstance.Invoice_Date__c = tempSupplyItem.Invoice_Date__c;
            supplyWrpObj.SupplyLineItemInstance.Payment_Terms__c = tempSupplyItem.Payment_Terms__c;
            supplyWrpObj.SupplyLineItemInstance.Supply_Status__c = tempSupplyItem.Supply_Status__c;*/
            
            //supplyWrpObj.SupplyLineItemInstance.Supply_End_Date__c = tempOrderItem.EndDate;
            //supplyWrpObj.productName = tempSupplyItem.Product__c;
            SupplyItemWrapperList.add(supplyWrpObj);
        }
        return SupplyItemWrapperList;        
    }

    public class SupplyWrapperClass {    
        
        public SupplyLineItem__c SupplyLineItemInstance {get; set;} 
        public String productName {get; set;}
        
        public SupplyWrapperClass() {
            SupplyLineItemInstance = new SupplyLineItem__c();
            productName = '';
        }   
    }

    public void deleteRow() {

        String delId = Apexpages.currentPage().getParameters().get('delId');
        if(delId.length() != 0){

            OpportunityLineItem delOLI= [SELECT id from OpportunityLineItem where id=:delId];
            //system.debug('*******delId********'+delId);
            if(delOLI != null) {

               delete delOLI;
            }
            
        }
    }

    public void deleteData() {

        String emptyDataId = Apexpages.currentPage().getParameters().get('emptyDataId');
        //System.debug('@@@@@@@@@'+emptyDataId);
        OpportunityLineItem delOLI;
        try{            
            
            if(applType == 'offerType'){
                delOLI= [SELECT Id,OpportunityId,product2.name,product2Id,Order_Loss_Check__c, Distributor__c,Distributor__r.name,ORC_Markup__c,Order_Check__c,Supply_Start_Date__c,Supply_End_Date__c,Order_Quantity__c,MRP__c,Probability__c,Delivery_Start_Date__c,Delivery_End_Date__c,Unit__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Competitor_name1__c,Offer_Quantity__c,Reason__c,APPL_Type__c,Offer_Probability__c,Offer_MRP__c,Offer_Check__c FROM OpportunityLineItem WHERE id=:emptyDataId];
                //delOLI.Offer_Quantity__c        = null;
                delOLI.Offer_MRP__c             = null;
                delOLI.Tentative_Date__c        = null;
                delOLI.Delivery_Start_Date__c   = null;
                delOLI.Delivery_End_Date__c     = null;
                delOLI.Product_Specified__c     = null;
                delOLI.Offer_Probability__c     = null;
                delOLI.Reason__c                = null;
                delOLI.Offer_Check__c           = false;

            } 
            
            else if(applType == 'orderType'){

                OrderItem deleteRecord = new OrderItem();
                deleteRecord.Id = emptyDataId;
                delete deleteRecord;                
            }
            else if(applType == 'supplyType') {

                SupplyLineItem__c deleteRecord = new SupplyLineItem__c();
                deleteRecord.Id = emptyDataId;
                delete deleteRecord;
                /*delOLI.Supply_Quantity__c       = null;
                delOLI.Invoice_Value__c         = null;
                delOLI.Invoice_Date__c          = null;
                delOLI.Supply_Check__c          = false;*/
            
            }  
            else if(applType == 'orderLost') {

                delOLI= [SELECT Order_Loss_Check__c FROM OpportunityLineItem WHERE id=:emptyDataId];
                delOLI.Order_Loss_Check__c = false;

            
            }  
           /* else if if(applType == 'orderLost'){
                delOLI.Order_Loss_Check__c = false;
            }*/
            update delOLI;
            
        }catch(Exception e) {

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));  
        }
    }

}