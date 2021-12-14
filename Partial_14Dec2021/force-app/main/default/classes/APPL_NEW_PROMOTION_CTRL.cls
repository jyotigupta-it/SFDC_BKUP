/*--++----------------------------------------------------------------------
||        Author      : BABA
||
||        Purpose     : Creating Promotion and adding Promotion members to it.
If member is not there, then Create Account.
||                  
||        Modified By : 02/07/2015 / Baba
|| 
||        Reason      : Code beautification/Review and made code to follow the best practices. 
||
++----------------------------------------------------------------------- */
global class APPL_NEW_PROMOTION_CTRL {
    
    //Varibles
    public Promotion__c newpromotion {get;set;}
    public Boolean showPromotion  {get;set;}
    public boolean showAddMemberPanel {get;set;}
    public List<string> productList {get; set;}
    public String accRecTypeId {get;set;}
    public String dealerRtId {get;set;}
    public String directDealerId {get;set;}
    public String distrubutorId {get;set;}
    public String promotionName {get;set;}
    public boolean validationCheck {get; set;}
    public Boolean showMemberSaveBtn {get;set;}
    public Boolean showPromotionSaveBtn {get;set;}
    public List<Account> proAccounts {get;set;}
    public Map<String,Account> proAccountMap {get;set;}
    public List<String> giftsGiven {get;set;}
    public list<RecordType> accountRecordTypes = new List<RecordType>();
    public String accToRemove{get;set;}
    public String accToRefresh{get;set;}
    public Boolean validationRequired{get;set;}
    public Boolean disabled{get; set;}
    
    //Constructor showPromotion
    public APPL_NEW_PROMOTION_CTRL() {
        showMemberSaveBtn = true;
        showPromotionSaveBtn = true;
        promotionName = '';
        validationCheck = false;
        newpromotion = new Promotion__c();
        showPromotion = true;
        proAccounts = new List<Account>();
        productList = new List<String>();
        proAccountMap = new Map<String,Account>();
        giftsGiven = new List<String>();
        validationRequired =false;
        disabled=true;
        //Getting Products of Travel Dynamic
        Schema.DescribeFieldResult productsResult = Account.Products__c.getDescribe();
        List<Schema.PicklistEntry> pro = productsResult.getPicklistValues();
        for( Schema.PicklistEntry f : pro)
        {
            productList.add(f.getValue());
        } 

        Schema.DescribeFieldResult giftGivenResult =Promotion__c.Gifts_given__c.getDescribe();
        List<Schema.PicklistEntry> gifts = giftGivenResult.getPicklistValues();
        for( Schema.PicklistEntry g : gifts)
        {
            giftsGiven.add(g.getValue());
        } 
        //Get the Account Record Types
        accountRecordTypes = [SELECT DeveloperName,Id,Name FROM RecordType WHERE SobjectType = 'Account'];
        
        for(RecordType rt:accountRecordTypes){
            
            if(rt.DeveloperName == 'Dealer'){
                dealerRtId = rt.id;
            }else if(rt.DeveloperName == 'Direct_Dealer'){
                directDealerId = rt.id;
            }else if(rt.DeveloperName == 'Distributor'){
                distrubutorId = rt.id;
            }else if(rt.DeveloperName == 'Individual_Contacts'){
                accRecTypeId = rt.id;//individaul contacts
            }
        }
    }
    
    public PageReference addMember(){
        system.debug('No. Of Members ='+newpromotion.Total_no_of_attendees__c);
        proAccounts.add(new Account());
        proAccountMap.putAll(proAccounts);
        return null;
    }
    //Create
    public PageReference CreatePromotion(){
        showPromotion = false;

        try{
            if(newpromotion.Type__c != null &&
               newpromotion.Total_Expenses__c != null &&
               newpromotion.Total_no_of_attendees__c != null &&
               newpromotion.State__c != null
              ){
                  system.debug('newpromotion '+newpromotion);
                  insert newpromotion;
                  system.debug('newpromotion'+newpromotion.id);  
                  showPromotion = false;
                  promotionName = [Select Name from Promotion__c where id =:newpromotion.id].Name;
                  
              }else{
                  system.debug('All Fields are not Entered');
              }
            showPromotionSaveBtn = false;
            Apexpages.addMessage(new ApexPages.message(Apexpages.severity.Confirm,'Promotion saved Succesfully'));   
        }catch(exception ex){ 
            system.debug('Ex '+ex);
            showPromotionSaveBtn = true;
            Apexpages.addMessage(new ApexPages.message(Apexpages.severity.Error,ex.getMessage()));
        }
        return null;
    }
    
    public PageReference CancelToPromo(){
        showPromotion = true;
        return null;
    }
    
    public void ShowMembers(){
        showAddMemberPanel = true;
        try{
            for(Integer i=0; i<newpromotion.Total_no_of_attendees__c;i++)
                proAccounts.add(new Account());
        }catch(exception ex){
            system.debug(ex);
            Apexpages.addMessage(new ApexPages.message(Apexpages.severity.Error,ex.getMessage()));
        }   
        
    }
    
    /*  Search Customer based on the Name. */
    @RemoteAction
    global static list<Account> getCustomer( string cusMob) {
        list<account> accList = new list<Account>();
        try {
            
            accList = [SELECT Id,Name,recordTypeId,Contact_Number_Mobile__c FROM Account WHERE Contact_Number_Mobile__c LIKE :cusMob+'%'];
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
        List<Account> accList = new List<Account>();
        accList = [Select RecordTypeId,Id, Name, Dealer__c, Account__c, Contact_Number_Mobile__c,Visit_Type__c, Firm_Name__c,State__c, District__c, City__c,Contact_Number_Phone__c,
                   Status__c, PIN_Code__c,Party_Type__c, Primary_Contact_Person_Name__c, Products__c,Street_Address__c 
                   from Account where Contact_Number_Mobile__c =:mobileNumber];
       
        if( !accList.isEmpty() && accList.size() > 0){
            proAccounts.set(rowNumber-1, accList.get(0));
        }else{
            proAccounts.set(rowNumber-1, new Account(Contact_Number_Mobile__c =mobileNumber ));
        }
        return null;
    }
    
    
    //Save Functionality
    public PageReference SavePromotionMembers(){
        validationRequired = true;
         
        List<Promotion_Member__c> pmsList = new List<Promotion_Member__c>();
        try{
            if(newpromotion.Id != null){
                system.debug('Save Account Members'+proAccounts);
                
                for(Account acc : proAccounts){
                    acc.System_Flag__c = true;
                   
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
                
            }
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Promotion Members Added Succesfully'));
            validationCheck = true;
            showMemberSaveBtn = false;
             disabled=false;
        }catch(exception ex){
            system.debug('exception'+ex);
            validationCheck = false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
            showMemberSaveBtn = true;
            disabled=true;
            return null;
        } 
        return null;
    }
    
    //Cancel
    public PageReference CanelPromotion(){
        newpromotion = new Promotion__c();
        return null;
    }
    
    //Delete Entry
    public PageReference DeleteEntry(){
    validationRequired = false;
   
    system.debug('proAccounts::'+proAccounts);
    //String tempRow = String.valueOf(ApexPages.currentPage().getParameters().get('rowIndex'));
   // String mobileNumber = String.valueOf(ApexPages.currentPage().getParameters().get('cusMobile'));
    Integer rowNumber = Integer.valueOf(accToRemove);
    system.debug('rowNumber:::'+ rowNumber );
    proAccounts.remove(rowNumber - 1);
    
    return null;
    }
    
    //Refresh Entry
    public PageReference RefreshEntry(){
    
         Integer rowNumber = Integer.valueOf(accToRemove);
        if(accToRefresh != ''){
        List<Account> accList = new List<Account>();
        accList = [Select RecordTypeId,Id, Name, Dealer__c, Account__c, Contact_Number_Mobile__c,Visit_Type__c, Firm_Name__c,State__c, District__c, City__c,Contact_Number_Phone__c, Status__c,
                   PIN_Code__c,Party_Type__c, Primary_Contact_Person_Name__c, Products__c,Street_Address__c from Account where Contact_Number_Mobile__c =:accToRefresh];
       
        if( !accList.isEmpty() && accList.size() > 0){
            proAccounts.set(rowNumber-1, accList.get(0));
        }else{
            proAccounts.set(rowNumber-1, new Account(Contact_Number_Mobile__c =accToRefresh));
        }
        }
        return null;
    }
}