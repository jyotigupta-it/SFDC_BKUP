/* *******************************************************************
Created by : Samarth Nadig
Description : To upsert NPTB data from sparsh HttpResponse 
************************************************************************ */
global class DealerNptbApi2{
    //global List<NPTB__c> tempNptb = new List<NPTB__c>();
    global  void invoke(){
        system.debug('limit queueable job: ' + Limits.getLimitQueueableJobs());
        String myLabel = System.Label.NptbUrl;
        List<NPTB__c> tempNptb;
        List<Database.Error> errorList = new List<Database.Error>();
        List<NPTB__c> nptbList = new List<NPTB__c>();
        map<string,string> accSparshCodeMap = new map<string,string>();
        list<AccountWrapper> accWrapList;
        
        /********/
        Integer modulus;
        Integer indx = 1;
        Integer maxSize = 10000;
        List<List<NPTB__c>> dataChunks = new List<List<NPTB__c>>();
        List<NPTB__c> dataWrapChunks;
        
        /************/
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(myLabel);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        for(Account each : [Select Id,Sparsh_Code__c FROM Account WHERE Sparsh_Code__c !=null]){
            accSparshCodeMap.put(each.Sparsh_Code__c, each.Id);
        }                   
        
        if (response.getStatusCode() == 200) {
            list<Account> accUpdList = new list<Account>();
            dataWrapChunks = new List<NPTB__c>();
            try{ 
                accWrapList = (list<AccountWrapper>)JSON.deserialize(response.getBody(), list<AccountWrapper>.class);
                
                Map<String,List<Products>> productMap = new Map<String,List<Products>>();
                Map<String,String> productsOnly = new Map<String,String>();
                List<Products> prodToBeAdded = new List<Products>();
                
                for(AccountWrapper wrp : accWrapList){
                    //system.debug('accWrapList:: ' + accWrapList);
                    //system.debug('outside if:: '+ accSparshCodeMap + ' and dealer code:: ' + wrp.Dealer_Code);
                    if(accSparshCodeMap!=null && accSparshCodeMap.containsKey(wrp.Dealer_Code)){
                        for(Products obj:wrp.Products){
                            NPTB__c nptb = new NPTB__c();
                            nptb.Account__c = accSparshCodeMap.get(wrp.Dealer_Code);
                            nptb.Product__c = obj.Name;
                            nptbList.add(nptb); 
                        }
                    }
                }
                //system.debug('number of records inserted:: ' + Limits.getDMLRows());
                system.debug('list size:: ' + nptbList.size());
                
                for(NPTB__c dataWrap: nptbList) {            
                    modulus = math.mod(indx, maxSize);
                    if(indx <= maxSize) {                            
                        dataWrapChunks.add(dataWrap);
                    }                        
                    indx++;
                    
                    if(modulus == 0) {                            
                        dataChunks.add(dataWrapChunks);
                        //system.debug('modulus:'+indx+' ## '+modulus);
                        indx = 1;
                        dataWrapChunks = new List<NPTB__c>();
                    }                        
                }
                
                if(dataWrapChunks.size() > 0) {                    
                    dataChunks.add(dataWrapChunks);
                }
                
                Integer cnt = 0;
                Boolean nextqueue = true;
                
                for(List<NPTB__c> tmp: dataChunks) {
                    tempNptb = new List<NPTB__c>();
                    tempNptb.addAll(tmp);
                    system.debug('entered for');
                    
                    Database.executeBatch(new DealerNptbChunkBatch(tmp));
                    
                    //system.debug('Each set---*'+ cnt +' --- '+tmp.size()); 
                    cnt++;
                    system.debug('limit used queueable job: ' + Limits.getQueueableJobs());
                    
                    
                }
                
                system.debug('Total set---*: '+dataChunks.size());            
                
                
            }catch(Exception ex){
                system.debug('Integration Exception---*'+ex);  
            }
        }
        //return response;        
    }
    
    public class AccountWrapper {
        public String Dealer_Code;
        public List<Products> Products;
        public Products prod; //only one level of nesting is allowed in apex
    }
    public class Products {
        public String Name;
    }  
}