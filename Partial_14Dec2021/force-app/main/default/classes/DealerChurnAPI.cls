/* *******************************************************************
Created by : Srilakshmi
Description : To upsert churn data from sparsh
************************************************************************ */
public class DealerChurnAPI{
    
    public static HttpResponse invoke(){
        String myLabel = System.Label.ChurnUrl;
        
        map<string,string> accSparshCodeMap = new map<string,string>();
        list<Account> updAccList = new list<Account>();
        list<AccountWrapper> accWrapList;
        list<Database.Error> dbErrorList = new list<Database.Error>();
        set<String> dbSuccessList = new set<String>();
        
        // Get the Dealer Churn document from the external server 
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(myLabel);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        system.debug('Response Body: '+response.getBody());
        
        for(Account each : [Select Id,Sparsh_Code__c FROM Account WHERE Sparsh_Code__c !=null AND Party_Type__c='Dealer' and PredictedClass__c=null LIMIT 8000]){
            accSparshCodeMap.put(each.Sparsh_Code__c, each.Id);
        }
        
        system.debug('Sparsh Code Map: ' + accSparshCodeMap);
        
        if (response.getStatusCode() == 200) {
            //list<Object> results =(list<Object>)JSON.deserializeuntyped(response.getBody());            
            //system.debug(':::::::::::::::::'+results);
            
            list<Account> accUpdList = new list<Account>();
            
            try{ 
                accWrapList = (list<AccountWrapper>)JSON.deserialize(response.getBody(), list<AccountWrapper>.class);
                
                system.debug('Deserialized List: ' + accWrapList);
                
                for(AccountWrapper wrp : accWrapList){
                    system.debug('---each---*'+ wrp);
                    if(accSparshCodeMap!=null && accSparshCodeMap.containsKey(wrp.Dealer_Code)){
                    Account acc = new Account();
                    acc.PredictedClass__c = wrp.Predicted_Class;
                    acc.Sparsh_Code__c = wrp.Dealer_Code;
                    acc.Id = accSparshCodeMap.get(wrp.Dealer_Code);
                    accUpdList.add(acc);
                    }
                } 
                system.debug('Updated List: ' + accUpdList);
                
                //update the accounts whose sparsh code exists in salesforce
                Schema.SObjectField accKey = Account.Fields.Sparsh_Code__c;      
                Database.UpsertResult[] accUpsertRes = Database.Upsert(accUpdList, accKey, false);
                
                dbErrorList.clear();
                dbSuccessList.clear();
                // Iterate through each returned result
                for (Database.UpsertResult each : accUpsertRes) {
                    if (each.isSuccess()) {
                        //successful, get the ID of the record that was processed
                        dbSuccessList.add(each.getId());
                        System.debug('Successfully updated Churn Accounts. ID: ' + each.getId());
                    }
                    else {
                        // get all errors in a list
                        for(Database.Error err : each.getErrors()) {
                            System.debug('The following error has occurred while updating churn - '+err);                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Account fields that affected this error: ' + err.getFields());
                            dbErrorList.add(err);
                        }
                    }
                }//for loop
            }catch(Exception ex){
                system.debug('Churn Integration Exception---*'+ex);
                
            }
        }//if loop end
        
        return response;
    }//method end
    
    public class AccountWrapper{
        public string Dealer_Code;
        public string Predicted_Class;
        public string accid;
    }
}//class end