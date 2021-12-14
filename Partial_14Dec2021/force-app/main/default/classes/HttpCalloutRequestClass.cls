public class HttpCalloutRequestClass {

    public static HttpResponse httpRequest(String requestType,String requestUrl, Map<String, String> headerMap, String requestBody,Integer timeOut){
       System.debug('2nd method');
       System.debug('requestType '+requestType);
       System.debug('requestUrl '+requestUrl);
       System.debug('headerMap '+headerMap);
       
       System.debug('requestBody '+requestBody);
       System.debug('timeOut '+timeOut);
       Http h = new Http();
       HttpRequest req = new HttpRequest();
       try{
           req.setMethod(requestType);
           req.setEndpoint(requestUrl);
           req.setTimeout(120000);
           
           if(headerMap.size() > 0){
               for(String headerKey : headerMap.keySet()){
                   req.setHeader(headerKey, headerMap.get(headerKey));
               }
               
           }
           
           if(requestBody != null){
               req.setBody(requestBody);
           }
           if(timeOut!=null){
               req.setTimeout(timeOut);
           }
           System.debug('req: '+req);
           for(String s : headerMap.keySet()){
               System.debug(s+' : '+req.getHeader(s));
           }
           
           HttpResponse res = h.send(req);    
           System.debug('res: '+res);
           System.debug('res.getBody: '+res.getBody());
           return res;
       }catch(Exception e){
           System.debug('Exception: '+ e);
           //LogService.insertGenericErrorLog(e,'Custom Code','API callout');
       }
       return null;
    }
    
}