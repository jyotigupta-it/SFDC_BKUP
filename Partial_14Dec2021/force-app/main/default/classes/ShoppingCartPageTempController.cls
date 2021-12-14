/*Created By : KVP- Chakresh Verma
*Name : ShoppingCartPageTempController
*Created on :  Aug 2020
*Description : This class is used for diplaying the products and for placing the order from Order Portal once the Dealer is Authenticate in ShoppingCartTempPage.
*/

public class ShoppingCartPageTempController {
    private List<ProductWrapper> productWrap;
    public static String mainString{get;private set;}
    public String jsonString{get;set;}
    private Set<String> productFamily;
    public String producFamilyData{get;private set;}
    public List<Dealer_Order_line_item__c> createdOrder{get;private set;}
    public String dealerName{get;private set;}
    public String dealerPhone{get;private set;}
    public String dsitributorName{get;private set;}    
    public String dsitributorPhone{get;private set;}
    public String dealer;
    public DateTime orderDate{get;private set;}
    public date orderDateToConvert{get;private set;}
    public time orderTimeToConvert{get;private set;}
    public String orderDateToPDF{get;private set;}
    public String orderTimeToPDF{get;private set;}
    public static Blob cryptoKey = Blob.valueOf(System.Label.Crypto_Key);
    
    
    
    public ShoppingCartPageTempController(){
         
        createdOrder= new List<Dealer_Order_line_item__c>();
        //Wrapper for the Lisr of the Products
        productWrap = new List<ProductWrapper>();
        //Set of String of for the product Family
        productFamily = new Set<String>();
        //fetching the dealerId from the URL
        dealer =System.currentPagereference().getParameters().get('dealer');
        //checking the null check of the dealer
        if(dealer != null){
            dealer = String.escapeSingleQuotes(dealer);
            system.debug('dealer===>'+dealer);
            //Query for the Showing the products in tha order Page
            for(Product2 prd: [SELECT Id,Name,ProductCode,Family,Description from Product2 where Name != null And Available_Fot_cart__c=true Order BY Product_Sequence__c Nulls Last LIMIT 20000]){
                ProductWrapper pr = new ProductWrapper();
                pr.productName = prd.Name;
                if(prd.Family != null){
                    productFamily.add(prd.Family);
                }
                pr.productFamily =prd.Family;
                pr.productDescription = prd.Description;
                pr.productId = prd.Id;
                pr.productCode = prd.ProductCode;
                pr.quantity=0;
                productWrap.add(pr);
            }
            system.debug('productWrap==>'+productWrap);
            
            //Serializing the Product Wrapper
            if(productWrap != null){
                mainString = JSON.serialize(productWrap);
            }
            //Serializing the Product Family
            if(productFamily != null){
                producFamilyData = JSON.serialize(productFamily); 
            }
        }
    }
    
    
    //Method for placing the Order
    public Pagereference placeOrder(){
        string sessionId =System.currentPagereference().getParameters().get('sessionId');
        Map<String,Order_portal_session_Id__c> sessionIdMap = Order_portal_session_Id__c.getAll();
        if(sessionIdMap.containsKey(dealer)){
            string sessionIdCs = String.valueOf(sessionIdMap.get(dealer).session_Id__c);
            system.debug('sessionId==>'+sessionId);
            system.debug('sessionIdCs==>'+sessionIdCs);
            if(sessionId != sessionIdCs){
                Pagereference px2 = page.sessionExpiredPage;
            px2.setRedirect(true);
            system.debug('before return');
            return px2;
            }
        }
        else{
            Pagereference px2 = page.sessionExpiredPage;
            px2.setRedirect(true);
            system.debug('before return');
            return px2;
        }
        //Sample JSON of the Placing the Order
        // jsonString='[{"productToPlace":"01tg000000AcrM3AAJ","quantityOfProduct":"2"},{"productToPlace":"01tg000000AcrbnAAB","quantityOfProduct":"2"}]';
        //deserializing the CartProductWrapper
        try{
            List<CartProductWrapper> cartProduct = (List<CartProductWrapper>)JSON.deserialize(jsonString, List<CartProductWrapper>.class);
            //Fetching the Portal Record Type
            Id orderRecID = Schema.SObjectType.Order.getRecordTypeInfosByName().get('Portal').getRecordTypeId();
            List<Dealer_Order_line_item__c> orderItem = new List<Dealer_Order_line_item__c>();
            Order order;
            
            System.debug('dealer'+dealer);
            //Creating the Order
            if(dealer != null && dealer != '' && orderRecID != null){
                
                if(!Test.isRunningTest()  && dealer.length() >= 20){
                    dealer = ShoppingCartPageTempController.decryptData(dealer);
                }
                
                //Added by Riya for CRUD and FLS check
                String [] orderFields = new String [] {'AccountId','RecordTypeId','Status','EffectiveDate'};
                // Obtaining the field name/token map for the Order object  
                                                                  
            	Map<String,Schema.SObjectField> m = Schema.SObjectType.Order.fields.getMap();
            	for (String fieldToCheck : orderFields)
            	{
        			// Check if the user has create access on the each field
        			if (!m.get(fieldToCheck).getDescribe().isCreateable()) 
            		{
                        system.debug('Access error');
          				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to create Order'));
                        return null;
            		}
                }
                		System.debug(dealer);
                		order = new Order();
                		order.AccountId = dealer;
                		order.RecordTypeId = orderRecID;
                		order.Status='Submitted';
                		order.EffectiveDate=System.today();
                		System.debug('order'+order);
                		Database.insert(order);
                system.debug('order==>'+order);
                        
                        //Added by Riya for CRUD and FLS check
                		String [] orderLineFields = new String [] {'Order__c','Quantity__c','Product__c'};
                		// Obtaining the field name/token map for the Dealer_Order_line_item__c object                                                    
            			Map<String,Schema.SObjectField> mo = Schema.SObjectType.Dealer_Order_line_item__c.fields.getMap();
            			for (String fieldToCheckOrderLine : orderLineFields)
            			{
        					// Check if the user has create access on the each field
        					if (!mo.get(fieldToCheckOrderLine).getDescribe().isCreateable()) 
            				{
                                system.debug('Access error order line item');
          						ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Insufficient access to create Order Line Item'));
                                return null;
            				}
                        }
                system.debug('cartProduct==>'+cartProduct);
                				//Creating the DealerOrderItem Under the Order Record
                				if(cartProduct.size()>0 && cartProduct != null){
                    				for(CartProductWrapper ctwr :cartProduct){
                        				Dealer_Order_line_item__c li = new Dealer_Order_line_item__c();
                        				li.Order__c=order.Id;
                        				li.Quantity__c= ctwr.quantityOfProduct;
                        				li.Product__c =ctwr.productToPlace;
                        				orderItem.add(li);  
                    				}
                    				insert orderItem;
                    				dealer =null;
                                }         
            }
            system.debug('Redirecting===');
        system.debug('order.Id==>'+order);
            Pagereference px2 = page.ShoppingCartPDF;
        system.debug('order.Id==>'+order.Id);
            px2.getParameters().put('orderId',ShoppingCartPageTempController.encryptData(order.Id));
            px2.setRedirect(true);
            return px2;
            
        }catch(Exception e){
            System.debug('error at line: '+e.getLineNumber());
            System.debug('error message: '+e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Unable to insert Dealer Order Line Item'));
            return null;
        }        
    }
    
    //Method for Showing the Product After Placing The order
    public void fetchProductLine(){
        String orderId = System.currentPagereference().getParameters().get('orderId');
        System.debug('orderId'+orderId);
        if(orderId != null){
            
            orderId = String.escapeSingleQuotes(orderId);
            orderId = ShoppingCartPageTempController.decryptData(orderId);
            String [] delaerOrderLineItemFields = new String [] {'Product__r.Name','Product__r.Family','Quantity__c','Order__r.Account.Contact_Number_Mobile__c','Order__r.Account.Name',
                                                           'Order__r.Account.Parent.Name','Order__r.Account.Parent.Contact_Number_Mobile__c','Order__r.CreatedDate'};
 
      		// Obtaining the field name/token map for the Contact object
      		Map<String,Schema.SObjectField> mdo = Schema.SObjectType.Dealer_Order_line_item__c.fields.getMap();
      		for (String fieldToCheckDO : delaerOrderLineItemFields) {
        	// Check if the user has create access on the each field
                if(mdo.containsKey(fieldToCheckDO)){
                    if (!mdo.get(fieldToCheckDO).getDescribe().isAccessible()) 
                    {
                        System.debug('Access error');
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Insufficient access'));
                    }  
                }
        		
            }
                system.debug('orderId==>'+orderId);
           			createdOrder =[Select Product__r.Name,Product__r.Family,Quantity__c,Order__r.Account.Contact_Number_Mobile__c,Order__r.Account.Name,Order__r.Account.Parent.Name,Order__r.Account.Parent.Contact_Number_Mobile__c,Order__r.CreatedDate from Dealer_Order_line_item__c where Order__c=:orderId LIMIT 10000];       
            		if(createdOrder.size()> 0)
                    {
                		dealerName = createdOrder[0].Order__r.Account.Name != null ? createdOrder[0].Order__r.Account.Name:'Not Found';
                		dealerPhone = createdOrder[0].Order__r.Account.Contact_Number_Mobile__c != null ? createdOrder[0].Order__r.Account.Contact_Number_Mobile__c:'Not Found';
                		dsitributorName = createdOrder[0].Order__r.Account.Parent.Name != null ? createdOrder[0].Order__r.Account.Parent.Name:'Not Found';
                		dsitributorPhone = createdOrder[0].Order__r.Account.Parent.Contact_Number_Mobile__c != null ? createdOrder[0].Order__r.Account.Parent.Contact_Number_Mobile__c:'Not Found';
                		orderDate = createdOrder[0].Order__r.CreatedDate;
                		orderDateToConvert = orderDate.date();
                		String dateTemp = string.valueOf(orderDateToConvert);
                		orderDateToPDF = dateTemp;
                		orderTimeToConvert = orderDate.time();
                		String timeTemp = String.valueOf(orderTimeToConvert);
                		orderTimeToPDF = timeTemp.substring(0, 8);
                    } 
                }
            }
    
    public Pagereference backToOrder(){
        Pagereference px2 = page.DealerAuthentication;
        px2.setRedirect(false);
        return px2;
    }
    
    
    
    
    public class ProductWrapper{
        public String productName{get;set;}
        public String productDescription{get;set;}
        public String productFamily{get;set;}
        public String productId{get;set;}
        public Integer quantity{get;set;}
        public String productCode{get;set;}
        
        
    }
    //[{"cartProductIds":"01tg000000AcrM3AAJ","cartQuantity":"3","cartProductName":{"quantity":0,"productName":"2111011 -1\" V4-15 (3 MTR) COLUMN PIPE","productId":"01tg000000AcrM3AAJ","productFamily":"SUB. PIPES"}}]
    public class CartProductWrapper{
        public String productToPlace;
        public Integer quantityOfProduct;
    }
    
    //for encryption the data
    public static String encryptData(String dataToEncrypt) {
        system.debug('dataToEncrypt:'+dataToEncrypt);
        Blob data = Blob.valueOf(dataToEncrypt);
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', ShoppingCartPageTempController.cryptoKey, data);
        String b64Data = EncodingUtil.base64Encode(encryptedData);
        system.debug('Encrypted Data:'+b64Data);
        return b64Data;
    }
    
    //for decrypt the data
    public static String decryptData(String encryptedData) {
        system.debug('Encrypted Data:'+encryptedData);
        Blob data = EncodingUtil.base64Decode(encryptedData);
        Blob decryptedData = Crypto.decryptWithManagedIV('AES128', ShoppingCartPageTempController.cryptoKey, data);
        String dryptData = decryptedData.toString();
        system.debug('Decrypted Data:'+dryptData);
        return dryptData;
    }
    
    public Pagereference logOutCon(){
        system.debug('Logging out....');
        dealer =System.currentPagereference().getParameters().get('dealer');
        if(dealer != null && dealer != ''){
                if(!Test.isRunningTest()){
                    dealer = ShoppingCartPageTempController.decryptData(dealer);
                }
        }
        Map<String,Order_portal_session_Id__c> sessionIdMap = Order_portal_session_Id__c.getAll();
        string sessionId;
        if(sessionIdMap.containsKey(dealer)){
            try{
				Order_portal_session_Id__c cs = new Order_portal_session_Id__c();
            	cs = sessionIdMap.get(dealer);
            	decimal temp = cs.session_id__c;
            	temp = temp + 1;
            	cs.session_id__c = temp;
            	update cs;
            }
            catch(Exception e){
                System.debug('Error at line:'+e.getLineNumber());
            	System.debug('Error Message: '+e.getMessage());
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Unable to update Order Portal Session Id'));
                return null;
            }
                
        }
        else{
            try{
            	Order_portal_session_Id__c cs = new Order_portal_session_Id__c();
            	system.debug('testttt=='+dealer);
            	cs.name = dealer;
            	cs.session_id__c = 100;
            	insert cs;
            }
            catch(Exception e){
                System.debug('Error at line:'+e.getLineNumber());
            	System.debug('Error Message: '+e.getMessage());
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL,'Unable to insert Order Portal Session Id'));
                return null;
            }
                
        }
        
        Pagereference px2 = page.DealerAuthentication;
            px2.setRedirect(true);
            return px2;
    }
    public Pagereference onLoad(){
        string sessionId =System.currentPagereference().getParameters().get('sessionId');
        dealer =System.currentPagereference().getParameters().get('dealer');
        system.debug('dddddddd==>'+dealer);
        if(dealer != null && dealer != ''){
                if(!Test.isRunningTest()){
                    dealer = ShoppingCartPageTempController.decryptData(dealer);
                }
        }
        Map<String,Order_portal_session_Id__c> sessionIdMap = Order_portal_session_Id__c.getAll();
        if(sessionIdMap.containsKey(dealer)){
            string sessionIdCs = String.valueOf(sessionIdMap.get(dealer).session_Id__c);
            system.debug('sessionId==>'+sessionId);
            system.debug('sessionIdCs==>'+sessionIdCs);
            if(sessionId == sessionIdCs){
                return null;
            }
            else{
             Pagereference px2 = page.sessionExpiredPage;
            px2.setRedirect(true);
            system.debug('before return');
            return px2;
            }
        }
        else{
            Pagereference px2 = page.sessionExpiredPage;
            px2.setRedirect(true);
            system.debug('before return');
            return px2;
        }
        
    }
    
}
/*
<!-- h1 { color:  black;font-family: Times New Roman, Times, serif; line-height: 1.25; margin: 0 0 10px; font-weight: bold; }
h2 { color:  black;font-family: Times New Roman, Times, serif; line-height: 1.25; margin: 0 0 10px;  font-weight: bold; } -->

*/