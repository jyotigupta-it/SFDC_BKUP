public class DealerSecondaryApi {
    public static HttpResponse invoke(){
        String url = System.Label.SecondaryUrl;
        String oneTimeUrl = System.Label.SecondaryOneTimeUrl;
        
        system.debug('Coming inside invoke method');
        List<Secondary_Sales_Order__c> secondaryList = new List<Secondary_Sales_Order__c>();
        map<string,string> accSparshCodeMap = new map<string,string>();
        list<Account> updAccList = new list<Account>();
        list<AccountWrapper> accWrapList;
        
        // Get the Dealer Churn document from the external server 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        //request.setEndpoint(SecondaryOneTimeUrl);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        for(Account each : [Select Id,Sparsh_Code__c FROM Account WHERE Sparsh_Code__c !=null]){
            accSparshCodeMap.put(each.Sparsh_Code__c, each.Id);
        }
        
        system.debug('Sparsh Code Map: ' + accSparshCodeMap);
        
        if (response.getStatusCode() == 200) {
            
            list<Account> accUpdList = new list<Account>();
            
            try{ 
                System.debug('heap size before deserialization'+Limits.getHeapSize());
                accWrapList = (list<AccountWrapper>)JSON.deserialize(response.getBody(), list<AccountWrapper>.class);
                //system.debug('accWrapList : ' + accWrapList);
                System.debug('heap size after deserialization'+Limits.getHeapSize());
                for(AccountWrapper wrp : accWrapList){
                    system.debug('accSparshCodeMap size ' + accSparshCodeMap.size() + 'containsKey ' + accSparshCodeMap.containsKey(wrp.Dealer_Code));
                    if(accSparshCodeMap!=null && accSparshCodeMap.containsKey(wrp.Dealer_Code)){
                    Secondary_Sales_Order__c ss = new Secondary_Sales_Order__c();
                    ss.Amount__c = Double.valueOf(wrp.Sales_Value);
                    ss.Account__c = accSparshCodeMap.get(wrp.Dealer_Code);
                    ss.MergedField__c = wrp.Trans_No;
                    
                    String myDate = wrp.Invoice_Date;
                    Date myFinalDate = date.newInstance(Integer.valueOf(myDate.substring(6)),Integer.valueOf(myDate.substring(3, 5)),Integer.valueOf(myDate.substring(0, 2)));
                    
                    ss.Date__c = myFinalDate;
                    secondaryList.add(ss);
                    }
                }      
                
                //insert secondaryList;
                
                Schema.SObjectField mergedField = Secondary_Sales_Order__c.Fields.MergedField__c;
                Database.UpsertResult[] accUpsertRes = Database.Upsert(secondaryList,mergedField,false);
                
            }catch(Exception ex){
                system.debug('Integration Exception---*'+ex);
            }
        }
        return response;
    }
    
    public class AccountWrapper{
        public String Dealer_Code;
        public String Invoice_Date;
        public String Sales_Value;
        public String Trans_No;
    }
}