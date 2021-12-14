public class AmeyoCalloutService {
    @future(callout=true)
    public static void dialAmeyo(String customerPhone, String agentPhone, String taskId){
        
        List<Ameyo_Credentials__c> ameyoCreds = Ameyo_Credentials__c.getall().values();
        Map<String,String> headerMap = new Map<String, String>();
        headerMap.put('Content-Type','application/x-www-form-urlencoded');
        headerMap.put('hash-key',ameyoCreds[0].Hash_Key__c);
        headerMap.put('policy-name',ameyoCreds[0].Policy_Name__c);
        headerMap.put('requesting-host',ameyoCreds[0].Requesting_Host__c);
        headerMap.put('Cookie',ameyoCreds[0].Cookie__c);
        
        wrapper data = new wrapper();
        data.campaignId = ameyoCreds[0].CampaignId__c;
        data.phone = agentPhone;
        data.shouldAddCustomer = false;
        AddParams additionalParameters = new AddParams();
        additionalParameters.call_task_id = taskId;
        additionalParameters.customerPhoneNumber = customerPhone;
        data.additionalParams = additionalParameters;
        System.debug('JSON.serialize(data): '+'data='+JSON.serialize(data));
        HttpCalloutRequestClass.httpRequest('POST', ameyoCreds[0].endPoint__c, headerMap, 'data='+JSON.serialize(data), 2000);
        
    }
    
    public class wrapper{
        public String campaignId;
        public String phone;
        public Boolean shouldAddCustomer;
        public AddParams additionalParams; 
    }
    public Class AddParams{
        public String call_task_id;
        public String customerPhoneNumber;
    }
}