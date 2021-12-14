global with sharing class AmeyoCallController {
    
    public AmeyoCallController(Apexpages.Standardcontroller controller) {
    }
    
    @RemoteAction
    global static String callCustomer(String visitId, String userPhone, String taskId) {
        
        String customerPhone = [SELECT Id, Parry_name_contact_number__c FROM AP_Site_Visit__c WHERE
                               Id =: visitId].Parry_name_contact_number__c;
        if(String.isNotBlank(userPhone)){
            userPhone = userPhone.removeStart('+91').trim();
        }
        if(String.isNotBlank(customerPhone)){
            customerPhone = customerPhone.removeStart('+91').trim();
        }
		String strData = 'data={"campaignId":"12","phone":"';
        strData += userPhone;
        strData += '","shouldAddCustomer":false,"additionalParams":{"call_task_id":"';
        strData += taskId;
        strData += '","customerPhoneNumber":"';
        strData += customerPhone;
        strData += '"}}';
        
        system.debug(strData);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://emergems.ameyo.net:8443/ameyowebaccess/command/?command=clickToCallWithTokenAsync');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('hash-key', 'fecace70bff6ea0c450c5b2071cbavd9 ');
        request.setHeader('policy-name', 'token-based-authorization-policy');
        request.setHeader('requesting-host', 'ashirvad');
        request.setHeader('Cookie', 'JSESSIONID=88ED5B78530212572F613DDF101C2540; __METADATA__=3b6c22b4-c115-4c61-84cc-0d7101eb96f0');
        // Set the body as a JSON object
        request.setBody(strData);
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' +
                         response.getStatusCode() + ' ' + response.getStatus());
        } else {
            System.debug(response.getBody());
        }        
        return response.getBody();
    }
    
}