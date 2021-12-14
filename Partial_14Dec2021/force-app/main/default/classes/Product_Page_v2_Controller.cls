/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :18-Jan-2015
Modified Date   :22-Jan-2015
Version         :2.0
Description     :Controller of Product_Page_v2 page, This page is to insert APPL Probability,APPL Offer and APPL Order.

********************XXX***********************************/
public class Product_Page_v2_Controller {

    public String oppProId {get;set;}
    public String applType {get;set;} 
    public List<wrapperOLI> probabList {get;set;}
    public Opportunity oppTC {get;set;}
    

    public List<OpportunityLineItem> probabilityList {get; set;}
    public List<OpportunityLineItem> offerList {get; set;}
    public List<OpportunityLineItem> orderList {get; set;}
    public List<OpportunityLineItem> supplyList {get; set;}
    public List<OrderLossWrapperClass> orderLossList {get; set;}
    public List<OpportunityLineItem> probabilityListTemp {get; set;}
  
    public Boolean renderAddProb {get; set;}
    public Boolean renderAddOffer {get; set;}
    public Boolean renderAddOrder {get; set;}
    public Boolean renderAddSupply {get; set;}
    
    public List<OrderWrapperClass> OrderItemList {get; set;}
    public List<SupplyWrapperClass> SupplyItemList {get; set;}
    public Opportunity thisOpportunity;
    public String priceEntryId;
    public List<Order> parentOrderRecord;
    public List<Supply__c> parentSupplyRecord;
    public Order parentOrder;
    public Supply__c parentSupply;
    public boolean supplyInfo{get;set;}

    public Product_Page_v2_Controller(ApexPages.StandardController stdController) {
      
        renderAddProb = false;
        renderAddOffer = false;
        renderAddOrder = false;
        supplyInfo = false;
        oppProId = Apexpages.currentPage().getParameters().get('id');  
        thisOpportunity = [SELECT No_of_Bathrooms__c, ParentOrderFlag__c, Pricebook2Id, Project_By__c, CloseDate,(SELECT Id from Orders) FROM Opportunity where id =: oppProId];
        parentOrderRecord = new List<Order>([Select Id, (SELECT Id, PricebookEntry.Product2.Name, Payment_Terms__c, Order_Value__c,Order_Status__c, PricebookEntryId,PricebookEntry.Product2Id, ServiceDate, EndDate, Quantity, Unit__c, Distributor_Name__c, ORC_Markup__c, ORC_Status__c from OrderItems)from Order where Opportunityid =: oppProId Limit 1]);
        parentSupplyRecord = new List<Supply__c>([SELECT Id, ParentSupplyFlag__c from Supply__c WHERE Project__c =: oppProId Limit 1]);
        //System.debug('###########'+thisOpportunity);
        applType = Apexpages.currentPage().getParameters().get('applType'); 
        probabList = new List<wrapperOLI>();
        
        addProbabilityProduct();   
        addProductsInProbability();   // Adding OpportunityLineItems .

    }
    
    public PageReference saveProbability() {
        
        PageReference pf = new PageReference('/'+oppProId);
          
        try{
            for(OpportunityLineItem oL:probabilityListTemp){

               if((oL.Probability_Validation__c == 'Yes' || oL.Probability_Validation__c == 'No') && (oL.Product_Value__c == null ) ) {
                 
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            return null;
                    }   
    if((oL.Probability_Validation__c == '' || oL.Probability_Validation__c == null) && (oL.Product_Value__c <> null ) ) {
                 
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                            return null;
                    }                           
            
            }

            if(probabilityListTemp.size() != 0) {

                insert probabilityListTemp;
            }
        }  
        catch(exception e){
                system.debug(e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
            return null;      
        } 
        return pf;
    }


    public void addProbabilityProduct()
    {
        renderAddProb = true;
        OpportunityLineItem oPL=new OpportunityLineItem(OpportunityId = oppProId,UnitPrice = 0,APPL_Type__c = 'APPL Probability',Probability_Check__c=true);
        wrapperOLI tempWrapOli=new wrapperOLI();
        tempWrapOli.oli=oPL;
        probabList .add(tempWrapOli);
    } 

    
    public void generateOffer(){

        List<OpportunityLineItem> proList;
        offerList = new List<OpportunityLineItem>();
        oppTC = new Opportunity();

        oppTC = [SELECT Id,Freight__c,Delivery__c,Price_Basis__c,Delivery_Lots__c,Taxes__c,Offer_Valid_Till__c,Payment_Term__c,Delivery_Conditions_Gurantee__c,Order_Placement__c FROM Opportunity WHERE Id =:oppProId];
        proList = [SELECT Id,Competitor_name1__c,Competitor_name_Order__c,Competitor_name_Offer__c,Competitor_name_Supply__c,OpportunityId,product2.name,product2Id,Probability__c,Offer_Probability__c,Unit__c,Distributor__c,
                   Project_Finalization_Date__c,Probability_MRP__c,Offer_MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Probability_Quantity__c,Offer_Quantity__c,Remark__c,Reason__c,APPL_Type__c,Delivery_Start_Date__c,Delivery_End_Date__c,Probability_Check__c,Offer_Check__c,Discount_Offered__c,Price_List_Date__c,Price_Valid_Date__c FROM OpportunityLineItem where OpportunityId =:oppProId and Probability_Check__c = true and Probability_Validation__c != null ];

        if(proList.size() != 0) {
        system.debug(proList);
            for(OpportunityLineItem prob:proList) {

               // prob.Offer_Quantity__c      = prob.Probability_Quantity__c;
                prob.Offer_MRP__c           = prob.Probability_MRP__c;
                prob.Offer_Probability__c   = prob.Probability__c;
                prob.Offer_Check__c         = true;                              
                offerList.add(prob);

            }
            //return offerList;
        }
        
    }

    public void generateOrder(){
        
        //List<OpportunityLineItem> proList;
        //orderList = new List<OpportunityLineItem>();
        //proList = [SELECT Id,Competitor_name_Order__c,PricebookEntry.Id, OpportunityId,product2.name,product2Id,ORC_Markup__c,Order_Status__c,ORC_Status__c,Unit__c,Order_Quantity__c,Distributor__c,Project_Finalization_Date__c,Probability_MRP__c,Offer_MRP__c,APPL_STD_Discount__c,Addl_Discount_Required__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Probability_Quantity__c,Offer_Quantity__c,Remark__c,Reason__c,APPL_Type__c,Supply_Start_Date__c,Supply_End_Date__c,Offer_Check__c,Order_Check__c FROM OpportunityLineItem where OpportunityId =:oppProId and Offer_Check__c = true];
        
        
        OrderItemList = new List<OrderWrapperClass>();
            for(OpportunityLineItem tempItem: [SELECT Id,Competitor_name_Offer__c,PricebookEntryId,OpportunityId,product2.name,product2Id,ORC_Markup__c,Order_Status__c,ORC_Status__c,Unit__c,Order_Quantity__c,Distributor__c,Probability_MRP__c,Offer_MRP__c,ORC_Margin_to_Dlr_Dist__c,Payment_Terms__c,Delivery_Schedule__c,Why_Additional_Discount__c,Validity_for_the_Price__c,UnitPrice,Tentative_Date__c,Product_Specified__c,Probability_Quantity__c,Offer_Quantity__c,Remark__c,Reason__c,APPL_Type__c,Delivery_Start_Date__c,Delivery_End_Date__c, Offer_Check__c,Order_Check__c FROM OpportunityLineItem where OpportunityId =:oppProId and Offer_Check__c = true]) {

                OrderWrapperClass ordWrpObj = new OrderWrapperClass();
                ordWrpObj.orderItemInstance.PricebookEntryId = tempItem.PricebookEntryId;
                ordWrpObj.productName = tempItem.product2.name;
               ordWrpObj.orderItemInstance.Quantity = 1;//tempItem.Offer_Quantity__c;
               // ordWrpObj.orderItemInstance.Unit__c = tempItem.Unit__c;
                ordWrpObj.orderItemInstance.Order_Value__c = tempItem.Offer_MRP__c;
                ordWrpObj.orderItemInstance.ServiceDate = tempItem.Delivery_Start_Date__c;
                ordWrpObj.orderItemInstance.EndDate = tempItem.Delivery_End_Date__c;
                ordWrpObj.orderItemInstance.Payment_Terms__c = tempItem.Payment_Terms__c;
                ordWrpObj.orderItemInstance.Validity_for_Price__c = tempItem.Validity_for_the_Price__c;
                ordWrpObj.orderItemInstance.Distributor_Name__c = tempItem.Distributor__c;
                //System.debug('@@@@@@@@'+tempItem.Competitor_name_Offer__c);
                //ordWrpObj.orderItemInstance.Competitor_Name__c = tempItem.Competitor_name_Offer__c;
                OrderItemList.add(ordWrpObj);

            }
            //System.debug('$$$$$$$$$'+OrderItemList.size());            
        
    }
    public class OrderWrapperClass {        
        public boolean createOrder{get; set;}
        public OrderItem orderItemInstance {get; set;} 
        public String productName {get; set;}
        
        public OrderWrapperClass() {
            orderItemInstance = new orderItem();
            productName = '';
            
        }   
    }

    public void generateSupply() {        
         supplyInfo = true;
        SupplyItemList = new List<SupplyWrapperClass>();

        if(parentOrderRecord.size() > 0) {
            for (OrderItem tempOrderItem : parentOrderRecord[0].OrderItems) {

                SupplyWrapperClass supplyWrpObj = new SupplyWrapperClass();

                supplyWrpObj.SupplyLineItemInstance.OrderLineItem__c = tempOrderItem.Id;
                supplyWrpObj.SupplyLineItemInstance.Quantity__c = 1;//tempOrderItem.Quantity;
               // supplyWrpObj.SupplyLineItemInstance.Unit__c = tempOrderItem.Unit__c;
                supplyWrpObj.SupplyLineItemInstance.Order_Value__c = tempOrderItem.Order_Value__c;
                supplyWrpObj.SupplyLineItemInstance.Product__c = tempOrderItem.PricebookEntry.Product2Id;
                supplyWrpObj.SupplyLineItemInstance.Supply_Status__c = tempOrderItem.Order_Status__c;
                supplyWrpObj.SupplyLineItemInstance.Payment_Terms__c = tempOrderItem.Payment_Terms__c;
                supplyWrpObj.SupplyLineItemInstance.Distributor_Name__c = tempOrderItem.Distributor_Name__c;
                supplyWrpObj.SupplyLineItemInstance.ORC_Markup__c = tempOrderItem.ORC_Markup__c;
                supplyWrpObj.SupplyLineItemInstance.ORC_Status__c = tempOrderItem.ORC_Status__c;
                //supplyWrpObj.SupplyLineItemInstance.Supply_End_Date__c = tempOrderItem.EndDate;
                supplyWrpObj.productName = tempOrderItem.PricebookEntry.Product2.Name;
                SupplyItemList.add(supplyWrpObj);
            }
        }
                
    }
    public class SupplyWrapperClass {        
        public boolean createSupply{get; set;}
        public SupplyLineItem__c SupplyLineItemInstance {get; set;} 
        public String productName {get; set;}
        
        public SupplyWrapperClass() {
            SupplyLineItemInstance = new SupplyLineItem__c();
            productName = '';
            createSupply = false;
        }   
    }

    //********************* Generate Order Loss ****************************

    public void generateOrderLoss(){
        
        orderLossList = new List<OrderLossWrapperClass>();        
        //Order_Loss__c
            for(OpportunityLineItem offer : [SELECT Id, product2.name, Order_Loss_by_Disc__c, Order_Lost_to_Competitor__c, Description, Reason_for_Order_Loss__c, Offer_Check__c, Order_Loss_Check__c, Order_Loss__c FROM OpportunityLineItem where OpportunityId =:oppProId and Offer_Check__c = true]) { 
                
                OrderLossWrapperClass ordLssWrpObj = new OrderLossWrapperClass();
                ordLssWrpObj.oLIinstanace = offer;
                 //ordLssWrpObj.createOrderLoss=true;
                orderLossList.add(ordLssWrpObj);
            }           
    }

    public class OrderLossWrapperClass {        
        public boolean createOrderLoss {get; set;}
        public OpportunityLineItem oLIinstanace {get; set;}        
        
        public OrderLossWrapperClass() {
            oLIinstanace = new OpportunityLineItem();            
           createOrderLoss = false;
        }   
    }



    //********************* Generate Order Loss ****************************

    public PageReference saveOffer() {

        List<OpportunityLineItem> updateOliList = new List<OpportunityLineItem>();
        PageReference pf = new PageReference('/'+oppProId);
        if(offerList.size()!=null) {

            for(OpportunityLineItem oL:offerList){

                if(oL.Offer_Check__c == true){
                   //if(oL.Offer_Quantity__c != null && 
                   if(oL.Offer_MRP__c != null && oL.Tentative_Date__c != null &&
                        oL.Discount_Offered__c != null && oL.Price_List_Date__c != null && oL.Price_Valid_Date__c != null &&
                        oL.Competitor_name_Offer__c != null && oL.Offer_Probability__c != null && oL.Reason__c != null) {                     
                            updateOliList.add(oL);
                            system.debug(updateOliList);
                    }

                    else {                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                        return null;
                    }

                    
                }
            }
            if(updateOliList.size() > 0){
                try {

                    update updateOliList;
                    update oppTC;
                    
                }catch(Exception e) {

                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));
                }
               
            }
        }
        
        return pf;
    }

    public PageReference saveOrder() {


        PageReference pf = new PageReference('/'+oppProId);
        Savepoint sp = Database.setSavepoint();
        List<OrderItem> orderItems = new List<OrderItem>();

        if(parentOrderRecord.size() == 0) {
            parentOrder = new Order();
            parentOrder.Status = 'Draft';
            parentOrder.AccountId = thisOpportunity.Project_By__c;
            parentOrder.OpportunityId = oppProId;
            parentOrder.EffectiveDate = thisOpportunity.CloseDate;
            parentOrder.Pricebook2Id = thisOpportunity.Pricebook2Id;            

            try {
                insert parentOrder;
                update thisOpportunity;
            }
            catch(Exception e) {                
                Database.RollBack(sp);
            }
            for (OrderWrapperClass tempObj : OrderItemList) {

                if(tempObj.createOrder) {
    if(tempObj.orderItemInstance.Order_Value__c != null && tempObj.orderItemInstance.ServiceDate != null &&
                       tempObj.orderItemInstance.EndDate != null && tempObj.orderItemInstance.Validity_for_Price__c != null && tempObj.orderItemInstance.Payment_Terms__c != null &&
                       tempObj.orderItemInstance.Competitor_Name__c != null && tempObj.orderItemInstance.Distributor_Name__c != null  && tempObj.orderItemInstance.ORC_Markup__c != null && tempObj.orderItemInstance.ORC_Status__c != null && tempObj.orderItemInstance.Order_Status__c != null) {   
                    OrderItem orderItemObj = new OrderItem();
                    orderItemObj = tempObj.orderItemInstance;                   
                    orderItemObj.OrderId = parentOrder.Id;                    
                    orderItemObj.UnitPrice = 0.0;
                    orderItems.add(orderItemObj);
                    }
                    else{
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                        return null;
                    }
                }
            }
            try {
                insert orderItems;                
            }
            catch(Exception e) {
                Database.RollBack(sp);
            }
        }


        if(parentOrderRecord.size() > 0) {

            for (OrderWrapperClass tempObj : OrderItemList) {
            


                if(tempObj.createOrder) {
                  if(tempObj.orderItemInstance.Order_Value__c != null && tempObj.orderItemInstance.ServiceDate != null &&
                       tempObj.orderItemInstance.EndDate != null && tempObj.orderItemInstance.Validity_for_Price__c != null && tempObj.orderItemInstance.Payment_Terms__c != null &&
                       tempObj.orderItemInstance.Competitor_Name__c != null && tempObj.orderItemInstance.Distributor_Name__c != null  && tempObj.orderItemInstance.ORC_Markup__c != null && tempObj.orderItemInstance.ORC_Status__c != null && tempObj.orderItemInstance.Order_Status__c != null) {   

                    OrderItem orderItemObj = new OrderItem();
                    orderItemObj = tempObj.orderItemInstance;                                     
                    if(parentOrderRecord.size() > 0) { 
                        orderItemObj.OrderId = parentOrderRecord[0].Id;
                    }
                    orderItemObj.UnitPrice = 0.0;
                    orderItems.add(orderItemObj);
                }
                else{
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                        return null;
                }
               } 
            }          
            try {
                upsert orderItems;                
            }
            catch(Exception e) {
                Database.RollBack(sp);
            }
        } 
   
        return pf;
    }

    public PageReference saveSupply() {


        PageReference pf = new PageReference('/'+oppProId);
        Savepoint sp = Database.setSavepoint();
        List<SupplyLineItem__c> supplyLineItems = new List<SupplyLineItem__c>();

        if(parentSupplyRecord.size() == 0) {
            parentSupply = new Supply__c();
            parentSupply.Order__c = parentOrderRecord[0].Id;            
            parentSupply.Project__c = oppProId;            
            parentSupply.ParentSupplyFlag__c = true;

            try {
                insert parentSupply;                
            }
            catch(Exception e) {                
                Database.RollBack(sp);
            }

            for (SupplyWrapperClass tempObj : SupplyItemList) {
                if(tempObj.createSupply) {
                
 if(tempObj.SupplyLineItemInstance.Order_Value__c != null && tempObj.SupplyLineItemInstance.Invoice_Date__c != null &&
                       tempObj.SupplyLineItemInstance.Distributor_Name__c != null && tempObj.SupplyLineItemInstance.ORC_Markup__c != null && tempObj.SupplyLineItemInstance.ORC_Status__c != null &&
                       tempObj.SupplyLineItemInstance.Payment_Terms__c != null && tempObj.SupplyLineItemInstance.Supply_Status__c != null ) {
                    SupplyLineItem__c supplyLineItem = new SupplyLineItem__c();
                    supplyLineItem = tempObj.SupplyLineItemInstance;
                    supplyLineItem.SupplyDetails__c = parentSupply.Id;
                    supplyLineItems.add(supplyLineItem);
                    }
                    else{
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                        return null;
                    }
                }                
            }
            try {
                insert supplyLineItems;                
            }
                catch(Exception e) {
                Database.RollBack(sp);
            }
            
        }


        
        if(parentSupplyRecord.size() > 0) {
            for (SupplyWrapperClass tempObj : SupplyItemList) {
                if(SupplyItemList.size() > 0) {
                
                
                    //System.debug('###########'+tempObj);
                    if(tempObj.createSupply) {
                    

 if(tempObj.SupplyLineItemInstance.Order_Value__c != null && tempObj.SupplyLineItemInstance.Invoice_Date__c != null &&
                       tempObj.SupplyLineItemInstance.Distributor_Name__c != null && tempObj.SupplyLineItemInstance.ORC_Markup__c != null && tempObj.SupplyLineItemInstance.ORC_Status__c != null &&
                       tempObj.SupplyLineItemInstance.Payment_Terms__c != null && tempObj.SupplyLineItemInstance.Supply_Status__c != null ) {
                        SupplyLineItem__c supplyLineItem = new SupplyLineItem__c();
                        supplyLineItem = tempObj.SupplyLineItemInstance;                    
                        supplyLineItem.SupplyDetails__c = parentSupplyRecord[0].Id;                         
                        supplyLineItems.add(supplyLineItem);
                       }
            else{
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please enter all values for the selected products'));
                        return null;
                }          
                    
                    } 
                }               
            }          
            try {
                insert supplyLineItems;                
            }
                catch(Exception e) {
                
                System.debug('**********'+e.getMessage());
                //Database.RollBack(sp);
            }
        }
        return pf;
    
    }

    //******************************** Save Order Loss Items *************************//

       public PageReference saveOrderLoss() {

        List<OpportunityLineItem> updateOliList = new List<OpportunityLineItem>();
        PageReference pf = new PageReference('/'+oppProId);

        if(orderLossList.size()!=null) {

            for(OrderLossWrapperClass ordLss : orderLossList) {       
                if (ordLss.createOrderLoss) {  
                if((ordLss.oLIinstanace.Order_Loss_by_Disc__c <> null ) && (ordLss.oLIinstanace.Order_Lost_to_Competitor__c <> null || ordLss.oLIinstanace.Order_Lost_to_Competitor__c <>'') && (ordLss.oLIinstanace.Reason_for_Order_Loss__c <> null)
 && (ordLss.oLIinstanace.Description <> null || ordLss.oLIinstanace.Description =='') && (ordLss.oLIinstanace.Order_Loss__c <> null )){
                
                    OpportunityLineItem oLI = new OpportunityLineItem();
                    oLI = ordLss.oLIinstanace;
                    oLI.Order_Loss_Check__c = true;  
                    updateOliList.add(oLI);
                }
             else {                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Please fill all values for the selected product'));
                        return null;
                    }   
                }
            } 
            //System.debug('%%%%%%%%%%%%111'+updateOliList);                   
        }

        if(updateOliList.size() > 0){
            try {
                update updateOliList;
                //System.debug('%%%%%%%%%%%%222'+updateOliList);                  
                
            }catch(Exception e) {
                //System.debug('AAAAAAAAAAAAA'+updateOliList); 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage()));

            }           
        }        
        return pf;
    }




    //*********************************************************************************

    //Wrapper Class
    public class wrapperOLI {

        public String productName {get;set;}
        public OpportunityLineItem oli{get;set;}

        public wrapperOLI() {
            productName='';

        }
    }

    public void deleteRow() {

        String pIndex = Apexpages.currentPage().getParameters().get('pIndex');

            if(probabilityListTemp.size() != 0){

                integer pI = integer.valueof(pIndex);
                probabilityListTemp.remove(pI);
            }  
        
    }

    public void addProductsInProbability() {

       
        probabilityListTemp = new list<OpportunityLineItem>();
            
            for(PricebookEntry pe:[SELECT Id, Name,UnitPrice,Pricebook2.Name,product2.Name,product2Id FROM PricebookEntry where Pricebook2.Name =:'Project' ORDER by Product_number__c]){

                OpportunityLineItem oPL=new OpportunityLineItem(OpportunityId = oppProId,UnitPrice = 0,Probability_Check__c=true);
                if(pe.Name == 'CPVC') {
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 20;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*6000;                
                }
                else if(pe.Name == 'UPVC'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 20;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*4000;
                }
                else if(pe.Name == 'SWR'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 12;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*4000;
                }
                else if(pe.Name == 'Silent SWR'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 12;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*8000;
                }
                else if(pe.Name == 'WC Pan Connector'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 1;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*400;
                }
                else if(pe.Name == 'Concealed Cisterns'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 1;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*7950;
                }
                else if(pe.Name == 'Waste & Traps'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 1;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*900;
                }
              
                else if(pe.Name == 'Concealed Valves'){
                    oPL.Probability_Quantity__c = thisOpportunity.No_of_Bathrooms__c * 1;
                    oPL.Unit__c = 'Mtrs';
                    oPL.Probability_MRP__c = thisOpportunity.No_of_Bathrooms__c*1400;
                }
                oPL.PricebookEntryId = pe.Id;
                oPL.PricebookEntry = pe;
                oPL.Quantity = 1; 
                probabilityListTemp.add(oPL);
                
            }
        
    }
}