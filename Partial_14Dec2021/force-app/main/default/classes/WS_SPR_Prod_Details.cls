@RestResource(urlMapping='/getSprProdDetails')
global with sharing class WS_SPR_Prod_Details {
    @HttpGet
    global static Response getSprDetails() {
        Response resObj = new Response();
        List<Opportunity> projList = new List<Opportunity>();
        List<Unique_SPR__c> sprList = new List<Unique_SPR__c>();
        List<SPRWrap> sprWrapList = new List<SPRWrap>();
        List<String> prodNameList = new List<String>();
        Map<String,List<Product2>> prodMap = new Map<String,List<Product2>>();
        Map<String,List<ProdDescription>> prodDescMap = new Map<String,List<ProdDescription>>();
        List<Product2> prodList = new List<Product2>();
        resObj.SPR_Details = sprWrapList;
        
        sprList = [SELECT Id,Unique_Name__c,Project__r.SAP_ID__c,Project__r.Project_Number__c,
                   (Select Id,Extra_Discount__c,Product_name__c,APPL__c,ORC_MARGIN_TO_DLR_DIST__c,Validity_for_the_Price__c FROM New_Special_Pricing_Requests__r) FROM Unique_SPR__c WHERE Approval_Status__c = 'Approved']; 
        for(Unique_SPR__c uqSPR : sprList){
            for(New_Special_Pricing_Request__c newSPR : uqSPR.New_Special_Pricing_Requests__r){
                if(newSPR.Product_name__c != null)
                    prodNameList.add(newSPR.Product_name__c);
            }
        }
        if(prodNameList.size() > 0)
            prodList = [SELECT Id,Name,ProductCode,Product_Group_Code__c,Family,Product_Category_Code_Discount_Group__c,Product_Category_Description_Discount__c FROM Product2 WHERE Family IN :prodNameList];
        for(Product2 prodObj : prodList){
            if(prodDescMap.keySet().contains(prodObj.Family)){
                List<ProdDescription> prodDetails = prodDescMap.get(prodObj.Family);
                ProdDescription prodDescObj = new ProdDescription();
                prodDescObj.prodCode = prodObj.ProductCode != null ? Decimal.valueOf(prodObj.ProductCode) : null;
                prodDescObj.prodGroupCode = prodObj.Product_Group_Code__c != null ? prodObj.Product_Group_Code__c : '';
                prodDescObj.prodGroupDesc = prodObj.Family != null ? prodObj.Family : '';
                prodDescObj.prodCatCode = prodObj.Product_Category_Code_Discount_Group__c != null ? Decimal.valueOf(prodObj.Product_Category_Code_Discount_Group__c) : null;
                prodDescObj.prodCatDesc = prodObj.Product_Category_Description_Discount__c != null ? prodObj.Product_Category_Description_Discount__c : '';
                prodDetails.add(prodDescObj);
                prodDescMap.put(prodObj.Family,prodDetails);
            }
            else{
                List<ProdDescription> prodDetails = new List<ProdDescription>();
                ProdDescription prodDescObj = new ProdDescription();
                prodDescObj.prodCode = prodObj.ProductCode != null ? Decimal.valueOf(prodObj.ProductCode) : null;
                prodDescObj.prodGroupCode = prodObj.Product_Group_Code__c != null ? prodObj.Product_Group_Code__c : '';
                prodDescObj.prodGroupDesc = prodObj.Family != null ? prodObj.Family : '';
                prodDescObj.prodCatCode = prodObj.Product_Category_Code_Discount_Group__c != null ? Decimal.valueOf(prodObj.Product_Category_Code_Discount_Group__c) : null;
                prodDescObj.prodCatDesc = prodObj.Product_Category_Description_Discount__c != null ? prodObj.Product_Category_Description_Discount__c : '';
                prodDetails.add(prodDescObj);
                prodDescMap.put(prodObj.Family,prodDetails);
            }
        }
        System.debug(prodDescMap.keySet());
        for(Unique_SPR__c uqSPR : sprList){
            List<SPRPricingWrap> sprPricingWrapList = new List<SPRPricingWrap>();
            SPRWrap sprDet = new SPRWrap();
            sprDet.distributorCode = uqSPR.Project__r.SAP_ID__c!= null ? uqSPR.Project__r.SAP_ID__c : '';
            sprDet.sprNumber = uqSPR.Unique_Name__c != null ? uqSPR.Unique_Name__c : '';
            sprDet.projNumber = uqSPR.Project__r.Project_Number__c != null ? uqSPR.Project__r.Project_Number__c : '';
            
            for(New_Special_Pricing_Request__c newSPR : uqSPR.New_Special_Pricing_Requests__r){
                if(newSPR.Extra_Discount__c != null && newSPR.ORC_MARGIN_TO_DLR_DIST__c != null && newSPR.Extra_Discount__c != 0 && newSPR.ORC_MARGIN_TO_DLR_DIST__c != 0){
                    SPRPricingWrap sprPricingDet = new SPRPricingWrap();
                    //sprPricingDet.prodCode = prdNameValueMap.get(newSPR.Product_name__c).ProductCode != null ? Decimal.valueOf(prdNameValueMap.get(newSPR.Product_name__c).ProductCode) :null;
                    //sprPricingDet.prodGroupCode = prdNameValueMap.get(newSPR.Product_name__c).Product_Group_Code__c != null ? prdNameValueMap.get(newSPR.Product_name__c).Product_Group_Code__c : '' ;
                    //sprPricingDet.prodGroupDesc = prdNameValueMap.get(newSPR.Product_name__c).Family != null ? prdNameValueMap.get(newSPR.Product_name__c).Family : '';
                    //sprPricingDet.prodCatCode = prdNameValueMap.get(newSPR.Product_name__c).Product_Category_Code_Discount_Group__c != null ? Decimal.valueOf(prdNameValueMap.get(newSPR.Product_name__c).Product_Category_Code_Discount_Group__c) : null;
                    //sprPricingDet.prodCatDesc = prdNameValueMap.get(newSPR.Product_name__c).Product_Category_Description_Discount__c != null ? prdNameValueMap.get(newSPR.Product_name__c).Product_Category_Description_Discount__c : '';
                    
                    sprPricingDet.stdDiscount = newSPR.APPL__c;
                    sprPricingDet.sprDiscount = newSPR.Extra_Discount__c != null ? newSPR.Extra_Discount__c : 0;
                    sprPricingDet.orcPercentage = newSPR.ORC_MARGIN_TO_DLR_DIST__c != null ? newSPR.ORC_MARGIN_TO_DLR_DIST__c : 0;
                    sprPricingDet.validity = newSPR.Validity_for_the_Price__c != null ? newSPR.Validity_for_the_Price__c.format() : '';
                    System.debug(newSPR.Product_name__c);
                    sprPricingDet.prodDetails = prodDescMap.get(newSPR.Product_name__c);
                    sprPricingWrapList.add(sprPricingDet);
                }
            }
            sprDet.pricingDetails = sprPricingWrapList;
            sprWrapList.add(sprDet);
        }
        RETURN resObj;
    }
    global class Response{
        List<SPRWrap> SPR_Details = new List<SPRWrap>();
    }
    global class SPRWrap{
        String sprNumber;
        String distributorCode;
        String projNumber;
        List<SPRPricingWrap> pricingDetails;
    }
    global class SPRPricingWrap{
        Decimal stdDiscount;
        Decimal sprDiscount;
        Decimal orcPercentage;
        String validity;
        List<ProdDescription> prodDetails;
    }
    global class ProdDescription{
        Decimal prodCode;
        String prodGroupCode;
        String prodGroupDesc;
        Decimal prodCatCode;
        String prodCatDesc;
    }
}