/* 
* Name      : CustomerCreation_SAP
* Purpose   : This class is used to create customer in SAP
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class CustomerCreation_SAP {
    public static CustomerCreation_SAP_Response createCustomer(CustomerCreation_SAP_Request wrapperDetails){
        HTTPResponse response        = new HTTPResponse();
        String endPoint              = 'http://ashirvad-pipes-po-lb-1794463462.ap-south-1.elb.amazonaws.com:8000/RESTAdapter/customermaster';
        Map<String,String> headerMap = new Map<String,String>();
        
        headerMap.put('Content-Type','application/json');
        
        String reqString = JSON.serialize(wrapperDetails);
        System.debug('requestbody-->'+reqString);
        
        String username = 'PO_USER';
        String password = 'Ashirvad@123';
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' +
            EncodingUtil.base64Encode(headerValue);
        headerMap.put('Authorization', authorizationHeader);
        
        CustomerCreation_SAP_Response res = new CustomerCreation_SAP_Response();
        response = HttpUtility.sendHTTPRequest(endPoint, 'GET',null,reqString,headerMap,null);
        system.debug('jsonStringresponse--->'+response);
        try{
            if(response.getStatusCode() == 200 || response.getStatusCode() == 201){
                String jsonString = response.getBody();
                system.debug('jsonString-->'+jsonString);
                res = (CustomerCreation_SAP_Response)System.JSON.deserializeStrict(jsonString, CustomerCreation_SAP_Response.class);
                system.debug('res in sf-->'+res);
            }
        }catch(Exception e){
            HandleBusinessException.captureError('CheckGST_SAP','checkGST', e);
        }
        RETURN res;
    }
}