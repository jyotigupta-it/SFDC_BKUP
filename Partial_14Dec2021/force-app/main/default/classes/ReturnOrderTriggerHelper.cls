public class ReturnOrderTriggerHelper {
    public static void updateInventoryInLocations(Map<id,ReturnOrder> mapOfReturn){
         Set<Id> setOfProductItemIds = new Set<Id>();
        Map<Id,ReturnOrderLineItem> mapOfReturnOrderLineItem =new Map<Id,ReturnOrderLineItem>([Select id,QuantityReturned,ProductItemId from ReturnOrderLineItem where ReturnOrderId in:mapOfReturn.keyset()]); 
     List<ProductItem> listOfProductItemsToUpdate = new  List<ProductItem>();
        for(ReturnOrderLineItem roli : mapOfReturnOrderLineItem.values()){
            setOfProductItemIds.add(roli.ProductItemId);
        }
        Map<Id,ProductItem> mapOfProductItems = new Map<Id,ProductItem>([Select Id, QuantityOnHand  from ProductItem where Id in: setOfProductItemIds]);
        for(ReturnOrderLineItem roli : mapOfReturnOrderLineItem.values()){
            ProductItem pi = mapOfProductItems.get(roli.productItemId);
            pi.QuantityOnHand = pi.QuantityOnHand - roli.QuantityReturned;
            listOfProductItemsToUpdate.add(pi);
        }
        if(!listOfProductItemsToUpdate.isEmpty())
           update listOfProductItemsToUpdate;
    
    }
    public static void returnOrderEmail(Map<id,ReturnOrder> mapOfReturnOrder){
         System.debug('inside product request line item trigger');
        List<Messaging.SingleEmailMessage> massListMails = new List<Messaging.SingleEmailMessage>();
        List<ReturnOrderLineItem> listOfLineItem=[Select Id,ReturnOrderId,ReturnOrder.Order_Date__c,ReturnOrderLineItemNumber,Product2Id,ReturnOrder.ReturnOrderNumber,SourceLocation.Name,ProductItem.Product2.Division__c,ProductItem.Product2.ProductCode,ProductItem.Product2.Description,ProductItemId,QuantityReturned from
                                                                              ReturnOrderLineItem where ReturnOrderId=:mapOfReturnOrder.keySet()];
        Set<Id> setOfOwnerId=new Set<Id>();
        for(ReturnOrder pr:mapOfReturnOrder.values()){
            setOfOwnerId.add(pr.OwnerId);
        }
        List<Territory_Contractors__c> listOfTerritoryContractor=[Select id,Contractor__r.Name,Contractor__c,SAP_Code_ship__c,SAP_Code_sold__c,Service_Territory__r.Name from Territory_Contractors__c where Contractor__c=:setOfOwnerId];
        System.debug('territory contract is'+listOfTerritoryContractor);
        Map<Id,Territory_Contractors__c> mapOfContractWithTrritoryContractor=new Map<Id,Territory_Contractors__c>();
        for(Territory_Contractors__c tc:listOfTerritoryContractor){
           mapOfContractWithTrritoryContractor.put(tc.Contractor__c,tc); 
        }
        Map<Id,List<ReturnOrderLineItem>> productRequestLineItemWithProductDetails=new Map<Id,List<ReturnOrderLineItem>>();
        for(ReturnOrderLineItem prl:listOfLineItem){
            if(!productRequestLineItemWithProductDetails.containskey(prl.ReturnOrderId)){
                productRequestLineItemWithProductDetails.put(prl.ReturnOrderId,new List<ReturnOrderLineItem>{prl});
            }else{
                productRequestLineItemWithProductDetails.get(prl.ReturnOrderId).add(prl);
            }
        }
        
        for(Id prId:productRequestLineItemWithProductDetails.keyset())
        {  
            System.debug('inside for loop');
            ReturnOrder pr=mapOfReturnOrder.get(prId);
            Territory_Contractors__c tc=mapOfContractWithTrritoryContractor.get(pr.OwnerId);
            System.debug('terriroty contract is'+tc);
            System.debug('product request'+pr);
            List<ReturnOrderLineItem> prli=productRequestLineItemWithProductDetails.get(prid);
            string header = 'Division,Customer purchase order number,Customer Purchase Date,Sold to Party Customer Number,Ship to party Customer Number,Material Number,Material Description,Order quantity UoM,Contractor Name,Customer City\n';
            string finalstr = header ;
            for(ReturnOrderLineItem p: prli)
            {
                string recordString =p.ProductItem.Product2.Division__c+','+p.ReturnOrderLineItemNumber+','+p.ReturnOrder.Order_Date__c+','+tc.SAP_Code_ship__c+','+tc.SAP_Code_sold__c+','+p.ProductItem.Product2.ProductCode+','+p.ProductItem.Product2.Description+','+p.QuantityReturned +','+tc.Contractor__r.Name+','+tc.Service_Territory__r.Name+'\n';
                finalstr = finalstr +recordString;
            }
            
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            string csvname= 'Product.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();          
            List<String> sendToId= System.Label.Return_order_emails.Split(',');
            String subject ='Return Order Details';
            email.setSubject(subject);
            email.setToAddresses(sendToId);
            email.setPlainTextBody('CSV ');
            email.setSenderDisplayName('Ashirvadpipes');
            email.setHtmlBody('<html><body>Hi,<br/><br/> Find below the Return Order Details Attached<br/><br/>Thanks<br/>Ashirvadpipes<body/><html/>');
            
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            massListMails.add(email);
        }
        
        if(!massListMails.isEmpty()){
            System.debug('inside if loop');
            // Sends mass emails
            Messaging.sendEmail(massListMails);
        }
    }
    }