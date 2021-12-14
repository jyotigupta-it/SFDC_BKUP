global class SendSMSController{
@future(callout=true)
     global static void sendMessage(string mobileNo,string message){
   
       // String url='https://alerts.icisms.in/api/v3/?method=sms&api_key=Ababc126b65c69b5e2599dc5d4a9cb253&to=9482488066&sender=ASHRVD&message=Welcome%20to%messaging';
       // string apiKey='Ababc126b65c69b5e2599dc5d4a9cb253'; //set in the custom settings
        
         string apiKey= Label.API_KEY_ASHIRWAD;
         string sender='ASHRVD';
        // Pass in the endpoint to be used using the string url
         string  url= 'http://alerts.icisms.in/api/v3/?method=sms&api_key=' + apiKey + '&to=' + mobileNo + '&sender=' + sender + '&message=' + message + '&unicode=1';
         Http h = new Http();
          system.debug(url);
     
         // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
         HttpRequest req = new HttpRequest();
         req.setEndpoint(url);
         req.setMethod('POST');
        
         // Send the request, and return a response
         HttpResponse res = h.send(req);
         System.debug(res.getBody());     
        
     
         SMS obj = SMS.parse(res.getBody());
         system.debug(obj);
         system.debug(obj.Status);
         system.debug(res);
               
    }
    
}