public  class APPL_NEW_PARTY_CTRL {
    //Varibles
    public Account quickAccount {get;set;}
    public String accRecTypeId {get;set;}
    public String dealerRtId {get;set;}
    public String directDealerId {get;set;}
    public String distrubutorId {get;set;}

    //Contructor
    public APPL_NEW_PARTY_CTRL() {
        accRecTypeId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Individual Contacts'].id;
        dealerRtId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Dealer'].id;
        directDealerId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Direct Dealer'].id;
        distrubutorId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Distributor'].id;
        
        quickAccount = new Account();

    }

   public PageReference createAccount(){
      system.debug('Account to Insert(quickAccount) '+quickAccount);
      
      try{
          if(quickAccount.Name != null &&
             quickAccount.Party_Type__c != null &&
             quickAccount.Contact_Number_Mobile__c != null &&
             quickAccount.Visit_Type__c != null
             ){ 
                if(quickAccount.Party_Type__c == 'Dealer'){
                    quickAccount.recordtypeId = dealerRtId;
                }else if(quickAccount.Party_Type__c == 'Direct Dealer'){
                    quickAccount.recordtypeId = directDealerId;

                }else if(quickAccount.Party_Type__c == 'Distributor'){
                    quickAccount.recordtypeId = distrubutorId;
                    
                }else{
                    quickAccount.recordtypeId = accRecTypeId;
                    
                }
                
                  quickAccount.Products__c = 'Multiquick';
                  Insert quickAccount;
              }
        }catch(Exception ex){
            system.debug(ex);
        }
      
    return null;
   }

   public PageReference CanelAccount(){
        quickAccount = new Account();
        return null;
   }
}