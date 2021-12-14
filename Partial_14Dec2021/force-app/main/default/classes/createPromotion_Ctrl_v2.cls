public class createPromotion_Ctrl_v2 {
    //Varibles
    public Promotion__c newpromotion {get;set;}
    
    public Boolean showPromotion  {get;set;}
    public List<string> productList {get; set;}
    
    public String accRecTypeId {get;set;}
    public String dealerRtId {get;set;}
    public String directDealerId {get;set;}
    public String distrubutorId {get;set;}
    
    public List<Account> proAccounts {get;set;}
    
    //public Promotion_Member__c
    
    
    //Constructor showPromotion
    public createPromotion_Ctrl_v2() {
        newpromotion = new Promotion__c();
        showPromotion = true;
        proAccounts = new List<Account>();
        productList = new List<String>();
        //Getting Products of Travel Dynamic
        Schema.DescribeFieldResult productsResult =
            Account.Products__c.getDescribe();
        List<Schema.PicklistEntry> pro = productsResult.getPicklistValues();
        for( Schema.PicklistEntry f : pro)
        {
            
            productList.add(f.getValue());
        } system.debug(productList);
        
        accRecTypeId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Individual Contacts'].id;
        dealerRtId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Dealer'].id;
        directDealerId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Direct Dealer'].id;
        distrubutorId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Distributor'].id;
        
    }
    
    public PageReference addMember(){
        system.debug('No. Of Members ='+newpromotion.Total_no_of_attendees__c);
        proAccounts.add(new Account());
        return null;
    }
    
    //Create
    public PageReference CreatePromotion(){
        showPromotion = false;
        
        system.debug('Number of Members Attainted '+newpromotion.Total_no_of_attendees__c);
        system.debug('showPromotion'+showPromotion);
        
        for(Integer i=0; i<newpromotion.Total_no_of_attendees__c;i++){
            proAccounts.add(new Account());
        }
        system.debug('Size of Account List'+proAccounts.size());
        try{
            if(newpromotion.Type__c != null &&
               newpromotion.Total_Expenses__c != null &&
               newpromotion.Total_no_of_attendees__c != null &&
               newpromotion.State__c != null &&
               newpromotion.Location__c != null 
              ){
                  system.debug('newpromotion '+newpromotion);
                  insert newpromotion;
                  system.debug('newpromotion'+newpromotion.id);  
                  showPromotion = false;
                  // showMembersSec = false;
              }else{
                  system.debug('All Fields are not Entered');
              }   
        }catch(exception ex){ 
            system.debug('Ex '+ex);
        }
        return null;
    }
    
    public PageReference CancelToPromo(){
        showPromotion = true;
        return null;
    }
    
    /*  Search Customer based on the Name. */
    @RemoteAction
    public static list<Account> getCustomer( string cusMob) {
        list<account> accList = new list<Account>();
        try {
            //Schema.DescribeSObjectResult d = Schema.SObjectType.Account;
            //Schema.RecordTypeInfo rtByName =  d.getRecordTypeInfosByName().get('Residential Account');
            //system.debug(rtByName);
            //string query = 'select  Name, id from Account where RecordTypeId= \''+rtByName.getRecordTypeId() +'\' ';
            
            //query += 'And name LIKE \'%'+ String.escapeSingleQuotes(cusName)+ '%\'';
            
            //mm =database.query(query);
            accList = [SELECT Id,Name,Contact_Number_Mobile__c FROM Account WHERE Contact_Number_Mobile__c LIKE :cusMob+'%'];
            System.debug(accList);
        } catch(Exception e) {
            system.debug(e.getMessage());
        }
        return accList;
    }
    
    //Action Fucntion proAccounts
    public PageReference getAccoutRow(){
        
        String tempRow = String.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
        String mobileNumber = String.valueOf(ApexPages.currentPage().getParameters().get('cusMobile'));
        
        Integer rowNumber = Integer.valueOf(tempRow);
        system.debug('RowNumber ='+rowNumber);
        system.debug('mobileNumber ='+mobileNumber);
        system.debug('proAccounts ='+proAccounts.get(rowNumber-1));
        
        List<Account> accList = new List<Account>();
        
        accList = [Select RecordTypeId,Id, Name, Dealer__c, Account__c, Contact_Number_Mobile__c,Visit_Type__c, Firm_Name__c,State__c, District__c, City__c,Contact_Number_Phone__c, Status__c, PIN_Code__c,Party_Type__c, Primary_Contact_Person_Name__c, Products__c,Street_Address__c from Account where Contact_Number_Mobile__c =:mobileNumber];
        system.debug('acc ='+accList);
        
        //Check for Null
        if( !accList.isEmpty() && accList.size() > 0){
            proAccounts.set(rowNumber-1, accList.get(0));
        }else{
            proAccounts.set(rowNumber-1, new Account(Contact_Number_Mobile__c =mobileNumber ));
        }
        
        
        return null;
    }
    
    
    //Save Functionality
    
    
    public void SavePromotionMembers(){
        
        List<Promotion_Member__c> pmsList = new List<Promotion_Member__c>();
        system.debug('Save Promomotion Members'+newpromotion.Id);
        
        try{
            if(newpromotion.Id != null){
                system.debug('Save Account Members'+proAccounts);
                
                for(Account acc : proAccounts){
                    if(acc.RecordTypeId == null){
                        if(newpromotion.Type__c == 'Dealer'){
                            acc.recordtypeId = dealerRtId;
                        }else{
                            acc.recordtypeId = accRecTypeId;
                        } 
                    }
                }
                
                upsert proAccounts;
                
                for(Account acc : proAccounts){
                    
                    Promotion_Member__c pms = new Promotion_Member__c();
                    pms.Account__c = acc.Id;
                    pms.Promotions2__c = newpromotion.Id;
                    
                    pmsList.add(pms);
                }   
                
                if(!pmsList.isEmpty()){
                    insert pmsList;
                }
                
                //Updating the Number of Members in Promotion
                if(proAccounts.size() != Integer.valueOf(newpromotion.Total_no_of_attendees__c)){
                    system.debug('Members are not equal.. So Update it');
                    newpromotion.Total_no_of_attendees__c = proAccounts.size();
                    
                    Update newpromotion;
                }else{
                    System.debug('Members are equal, So No Update..');
                }
                
            }
        }catch(exception ex){
            system.debug('exception'+ex);
        } 
    }
    
    //Cancel
    public PageReference CanelPromotion(){
        newpromotion = new Promotion__c();
        return null;
    }
    
}