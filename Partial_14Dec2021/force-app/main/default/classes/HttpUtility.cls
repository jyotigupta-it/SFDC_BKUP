/* 
* Name      : HttpUtility
* Purpose   : This class is used as an utility for all HttpRequest .
* Company   : DGenX Technologies
* Author    : Dushyant
*/
public class HttpUtility {
    public static HttpResponse sendHTTPRequest(String endpoint, String method, Integer timeOut,String body,Map<String,String> headerMap,String certfName){
        
        Http http = new Http();
        HttpRequest req = new HttpRequest(); 
        
        if(timeOut!=null){
            req.setTimeout(timeOut);
        }else{
            req.setTimeout(120000);
        }
        
        if(certfName != null){
            req.setClientCertificateName(certfName);
        }
        
        req.setEndpoint(endpoint);
        req.setMethod(method);
        
        if(body != null){
            req.setBody(body);
        }
        
        //Header Map to populate html headers
        if(headerMap != null){
            for(String key: headerMap.keySet()){
                req.setHeader(key,headerMap.get(key));
            }
        }
        
        HttpResponse res = http.send(req);
        return res;
    }
}