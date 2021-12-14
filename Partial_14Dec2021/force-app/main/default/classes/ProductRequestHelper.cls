public class ProductRequestHelper {
    public static void ProductRequestLineItem(Map<Id,ProductRequest> mapOfProductRequest){
        List<ProductRequestLineItem> listOfLineItem=[Select id,Status,ParentId from ProductRequestLineItem where ParentId=:mapOfProductRequest.keySet()];
        List<ProductRequestLineItem> listOfLineItemToInsert=new List<ProductRequestLineItem>();
        for(ProductRequestLineItem pro:listOfLineItem){
            pro.Status = mapOfProductRequest.get(pro.ParentId).Status;
            listOfLineItemToInsert.add(pro);
        }
        if(!listOfLineItemToInsert.isEmpty())
        update listOfLineItemToInsert;
    }
    public static void ProductRequestEmail(Map<Id,ProductRequest> mapOfProductReq){
        System.debug('inside product request line item trigger');
        List<Messaging.SingleEmailMessage> massListMails = new List<Messaging.SingleEmailMessage>();
        List<ProductRequestLineItem> listOfLineItem=[Select id,ParentId,ProductRequestLineItemNumber,Product_family__c,Product2Id,DestinationLocation.Name,Product2.Division__c,Product2.ProductCode,Parent.ProductRequestNumber,Parent.NeedByDate,Product2.Name,Product2.Description,QuantityRequested,Quantity_Received__c from
                                                     ProductRequestLineItem where ParentId=:mapOfProductReq.keySet()];
        Set<Id> setOfOwnerId=new Set<Id>();
        for(ProductRequest pr:mapOfProductReq.values()){
            setOfOwnerId.add(pr.OwnerId);
        }
        List<Territory_Contractors__c> listOfTerritoryContractor=[Select id,Contractor__r.Name,Contractor__c,SAP_Code_ship__c,SAP_Code_sold__c,Service_Territory__r.Name from Territory_Contractors__c where Contractor__c=:setOfOwnerId];
        System.debug('territory contract is'+listOfTerritoryContractor);
        Map<Id,Territory_Contractors__c> mapOfContractWithTrritoryContractor=new Map<Id,Territory_Contractors__c>();
        for(Territory_Contractors__c tc:listOfTerritoryContractor){
           mapOfContractWithTrritoryContractor.put(tc.Contractor__c,tc); 
        }
        Map<Id,List<ProductRequestLineItem>> productRequestLineItemWithProductDetails=new Map<Id,List<ProductRequestLineItem>>();
        for(ProductRequestLineItem prl:listOfLineItem){
            if(!productRequestLineItemWithProductDetails.containskey(prl.ParentId)){
                productRequestLineItemWithProductDetails.put(prl.ParentId,new List<ProductRequestLineItem>{prl});
            }else{
                productRequestLineItemWithProductDetails.get(prl.ParentId).add(prl);
            }
        }
        
        for(Id prId:productRequestLineItemWithProductDetails.keyset())
        {  
            System.debug('inside for loop');
            ProductRequest pr=mapOfProductReq.get(prId);
            Territory_Contractors__c tc=mapOfContractWithTrritoryContractor.get(pr.OwnerId);
            System.debug('terriroty contract is'+tc);
            System.debug('product request'+pr);
            List<ProductRequestLineItem> prli=productRequestLineItemWithProductDetails.get(prid);
            string header = 'Division,Customer purchase order number,Customer Purchase Date,Sold to Party Customer Number,Ship to party Customer Number,Material Number,Material Description,Order quantity UoM,Contractor Name,Customer City\n';
            string finalstr = header ;
            for(ProductRequestLineItem p: prli)
            {
                string recordString =p.Product2.Division__c+','+p.ProductRequestLineItemNumber+','+p.Parent.NeedByDate+','+tc.SAP_Code_ship__c+','+tc.SAP_Code_sold__c+','+p.Product2.ProductCode+','+p.Product2.Description+','+p.QuantityRequested +','+tc.Contractor__r.Name+','+tc.Service_Territory__r.Name+'\n';
                finalstr = finalstr +recordString;
            }
            
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            string csvname= 'Product.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();          
            List<String> sendToId= System.Label.Product_Details_Team_Email_Id.Split(',');
            String subject ='Product Details';
            email.setSubject(subject);
            email.setToAddresses(sendToId);
            email.setPlainTextBody('CSV ');
            email.setSenderDisplayName('Ashirvadpipes');
            email.setHtmlBody('<html><body>Hi,<br/><br/> Find Below the Product Details Attached<br/><br/>Thanks<br/>Ashirvadpipes<body/><html/>');
            
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