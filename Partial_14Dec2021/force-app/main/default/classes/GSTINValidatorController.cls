public inherited sharing class GSTINValidatorController {
    /**
    * @Method       : validateGSTIN
    * @Invoke       : From Lightning Component GSTINValidator.
    * @Description  : Get GSTIN from related Account and from API get relevant info and
    * 				  store on same record
    * @Return       : String
    * @Params       : Id recordId 
    **/
    @auraEnabled
    public static String validateGSTIN(Id recordId){
        
        system.debug('recordId'+recordId);
        
        if(recordId == null){
            throw new AuraHandledException(System.Label.GSTIN_No_Account);
        }
        
        Account objAccount = [SELECT ID, VAT_CST_Number__c, gst_trade_name__c, gst_entity_type__c, 
                              gst_legal__c, gst_ad_bname__c, gst_dealer_type__c, gst_ad_lg__c,
                              gst_ad_floor__c, gst_ad_street__c, gst_ad_bno__c, gst_ad_location__c,
                              gst_ad_lt__c, gst_ad_city__c, gst_ad_state__c, gst_ad_pincode__c
                              FROM Account WHERE ID =: recordId AND VAT_CST_Number__c != null];
        
        if(objAccount == null){
            throw new AuraHandledException(System.Label.GSTIN_no_gstin_number);
        }
        
        String response = 'Success';
        try {
            REST_API_Configuration__mdt restSetup = [SELECT Authentication_Key__c, Authentication_Value__c, Content_Type__c,
                                                     End_Point_URL__c, Request_Type__c 
                                                     FROM REST_API_Configuration__mdt WHERE DeveloperName ='GSTIN_API'];
            System.debug('meta-->'+restSetup);
            String authurl = String.format(restSetup.End_Point_URL__c, new List<String>{ objAccount.VAT_CST_Number__c });
            system.debug('authurl1 '+authurl);            
            
            HttpRequest request = new HttpRequest();
            Http http = new Http();
            request.setEndpoint(authurl);
            request.setMethod(restSetup.Request_Type__c);
            request.setHeader('Content-Type', restSetup.Content_Type__c);
            request.setHeader(restSetup.Authentication_Key__c, restSetup.Authentication_Value__c);
            HttpResponse httpResponse = http.send(request);
            system.debug('Status Code == '+ httpResponse.getStatusCode());
            system.debug('Response Status == '+ httpResponse.getStatus());
            system.debug('Raw Response ------>>'+httpResponse.getBody());
            
            if (httpResponse.getStatusCode() == 200) {
                //Formatting response JSON
                GSTINValidatorParser wrapObj = GSTINValidatorParser.parse(httpResponse.getBody());
                system.debug('wrapObj: Order ------>>'+wrapObj);
                
                if(wrapObj.status_code == 0){
                    throw new AuraHandledException(wrapObj.error);
                }
                
                objAccount.gst_trade_name__c = wrapObj.trade_name;
                objAccount.gst_entity_type__c = wrapObj.entity_type;
                objAccount.gst_legal__c = wrapObj.legal_name;
                objAccount.gst_ad_bname__c = wrapObj.business;
                objAccount.gst_dealer_type__c = wrapObj.dealer_type;
                objAccount.gst_ad_lg__c = wrapObj.adress.lg;
                objAccount.gst_ad_floor__c = wrapObj.adress.floor;
                objAccount.gst_ad_street__c  = wrapObj.adress.street;
                objAccount.gst_ad_bno__c  = wrapObj.adress.bno;
                objAccount.gst_ad_location__c  = wrapObj.adress.location;
                objAccount.gst_ad_lt__c  = wrapObj.adress.lt;
                objAccount.gst_ad_city__c  = wrapObj.adress.city;
                objAccount.gst_ad_state__c = wrapObj.adress.state;
                objAccount.gst_ad_pincode__c = wrapObj.adress.pincode;
                
                update objAccount;
            }
        }
        catch( System.Exception e) {  
            System.debug('ERROR: '+ e.getMessage());  
            throw e;
        }
        return response;
    }
    
}