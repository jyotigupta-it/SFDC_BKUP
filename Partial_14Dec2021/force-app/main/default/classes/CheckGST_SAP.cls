/* 
* Name      : CheckGST_SAP
* Purpose   : This class is used to check GST status in SAP .
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class CheckGST_SAP{
    public static CheckGST_SAP_Response checkGST(String gstNumber){
        HTTPResponse response        = new HTTPResponse();
        String endPoint              = 'http://ashirvad-pipes-po-lb-1794463462.ap-south-1.elb.amazonaws.com:8000/RESTAdapter/gstvalidation';
        Map<String,String> headerMap = new Map<String,String>();
        
        headerMap.put('Content-Type','application/json');
        
        CheckGST_SAP_Request reqObj = new CheckGST_SAP_Request();
        CheckGST_SAP_Request.RequestClass reqWrapObj = new CheckGST_SAP_Request.RequestClass();
        reqWrapObj.TAXNUMXL = gstNumber;
        reqObj.REQUEST = reqWrapObj;
         //reqObj.REQUEST.TAXNUMXL = gstNumber;
        String reqString = JSON.serialize(reqObj);
        System.debug('requestbody-->'+reqString);
        
        String username = 'PO_USER';
        String password = 'Ashirvad@123';
        
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authorizationHeader = 'Basic ' +
            EncodingUtil.base64Encode(headerValue);
        headerMap.put('Authorization', authorizationHeader);
        
        CheckGST_SAP_Response res = new CheckGST_SAP_Response();
        response = HttpUtility.sendHTTPRequest(endPoint, 'GET',null,reqString,headerMap,null);
        system.debug('jsonStringresponse--->'+response);
        try{
            if(response.getStatusCode() == 200 || response.getStatusCode() == 201){
                String jsonString = response.getBody();
                system.debug('jsonString-->'+jsonString);
                res = (CheckGST_SAP_Response)System.JSON.deserializeStrict(jsonString, CheckGST_SAP_Response.class);
                //res = CheckGST_SAP_Response.parse(jsonString);
                system.debug('res in sf-->'+res);
            }
        }catch(Exception e){
            HandleBusinessException.captureError('CheckGST_SAP','checkGST', e);
        }
        RETURN res;
    }
}