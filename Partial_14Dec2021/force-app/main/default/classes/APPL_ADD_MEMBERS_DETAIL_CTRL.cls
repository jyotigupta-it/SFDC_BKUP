public class APPL_ADD_MEMBERS_DETAIL_CTRL {

 
    public string mem{get;set;}
    public APPL_ADD_MEMBERS_DETAIL_CTRL cc;
      public String promotionId {get; set;}
      public Promotion__c newpromotion {get; set;}
     public static Promotion__c newpromotion1 {get; set;}
     public  string newpromotionId;
      public boolean showAddMemberPanel {get; set;}
      public list<string> productList {get; set;}
      public String accRecTypeId {get; set;}
      public String dealerRtId {get; set;}
      public String directDealerId {get; set;}
      public String distrubutorId {get; set;}
      public integer oldNumber {get; set;}
      public boolean validationCheck {get; set;}
      //public boolean isDinner {get; set;}
      public Boolean showMemberSaveBtn {get; set;}
      public list<Promotion_Member__c> oldMembersAdded {get; set;}
      public Set<String>  oldPromoMembers {get; set;}
      public list<Account> proAccounts {get; set;}
      public boolean errorFlag{get;set;}
      public string incompleteAccount{get;set;}
      public String accToRemove{get;set;}
      public String accToRefresh{get;set;}
      public Boolean validationRequired{get;set;}
      public Boolean disabled{get; set;}
     
    public APPL_ADD_MEMBERS_DETAIL_CTRL(ApexPages.StandardController controller) {
       
        
       // mem=0;
       // isDinner = false;
        showMemberSaveBtn                =     true;
        newpromotion                     =     new Promotion__c();
        showAddMemberPanel               =     false;
        proAccounts                      =     new List<Account>();
        productList                      =     new List<String>();
        validationCheck                  =     false;
        oldPromoMembers                  =     new Set<String>();
        validationRequired =false;
        disabled=true;
         //Getting Products of Travel Dynamic
         Schema.DescribeFieldResult productsResult = Account.Products__c.getDescribe();
         list<Schema.PicklistEntry> pro = productsResult.getPicklistValues();
         
         for( Schema.PicklistEntry f : pro) {
            productList.add(f.getValue());
         }

        //Get the Account Record Type.

        for(RecordType rt : [SELECT DeveloperName,Id,Name FROM RecordType WHERE SobjectType = 'Account']) {

          if(rt.DeveloperName == 'Dealer') {
            dealerRtId = rt.id;
          }else if(rt.DeveloperName == 'Direct_Dealer') {
             directDealerId = rt.id;
          }else if(rt.DeveloperName == 'Distributor') {
             distrubutorId = rt.id;
          }else if(rt.DeveloperName == 'Individual_Contacts') {
             accRecTypeId = rt.id;//individaul contacts
          }
        }

        promotionId = ApexPages.currentPage().getParameters().get('id');
          newpromotion1= new Promotion__c();
        if(promotionId != null && promotionId != '') {
            newpromotion = [Select Id, Name,Vertical__c, Total_no_of_attendees__c,Type__c from Promotion__c where Id =:promotionId];
            newpromotion1=newpromotion;
            newpromotionId = newpromotion.Type__c;
        }
        
        oldNumber = Integer.valueOf(newpromotion.Total_no_of_attendees__c);
        newpromotion.Total_no_of_attendees__c = null;
        
        //Get the Members Already added to Promotion
        oldMembersAdded     =   new List<Promotion_Member__c>();
        oldMembersAdded     =   [Select Id,Account__c,Contact_Number__c from Promotion_Member__c where Promotions2__c =:promotionId];

        if(!oldMembersAdded.isEmpty()) {
          for(Promotion_Member__c oldMember : oldMembersAdded) {
              oldPromoMembers.add(oldMember.Contact_Number__c);
          }
        }
        errorFlag=false;
    }

    
    
    public void ShowMembers() {
               showAddMemberPanel = true;
        
        try {
            for(Integer i=0; i<newpromotion.Total_no_of_attendees__c;i++){
                
                    proAccounts.add(new Account());
                
            }
                
             
    } catch(exception ex){
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
       // ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,ex.getLineNumber()));
        
        }
     }
  
    
     public PageReference more() {
        String numbr=Apexpages.currentPage().getParameters().get('addrowsvalue');
        system.debug('adddding membersssss'+numbr);
        //showAddMemberPanel = true;
        Integer newAddMore=Integer.valueOf(numbr);
        try {
        System.debug(proAccounts.size());
            for(Integer i=0; i<newAddMore;i++)
             proAccounts.add(new Account());
            System.debug(proAccounts.size());
             return null;
    } catch(exception ex){
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
              return null;
        }
     }
  

   public PageReference addMember() {
      
    system.debug('No. Of Members ='+newpromotion.Total_no_of_attendees__c);
    proAccounts.add(new Account());
    system.debug(proAccounts);
    system.debug(proAccounts.size());
    return null;
   }

    /*  Search Customer based on the Name. */
   @RemoteAction
     public static list<Account> getCustomer( string cusMob, string promotype) {
        list<account> accList = new list<Account>();
        try {
            //system.debug('---rectype id is---'+recTypeId);
            if(promotype=='Shop Anniversary Dinner'){ 
            System.debug(promotype);
            accList = [SELECT Id,Name,recordTypeId,Contact_Number_Mobile__c,PARTY_type__c FROM Account WHERE  PARTY_type__c='Dealers Salesman' AND Contact_Number_Mobile__c LIKE :cusMob+'%'];
            }else{
            accList = [SELECT Id,Name,recordTypeId,Contact_Number_Mobile__c FROM Account WHERE Contact_Number_Mobile__c LIKE :cusMob+'%'];
            }
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

       accList = [Select RecordTypeId,Id, Name, Dealer__r.name,Dealer__c, Account__r.name,Account__c, Contact_Number_Mobile__c,Taluk_Tehsil__c,Visit_Type__c, Firm_Name__c,State__c, District__c, City__c,Contact_Number_Phone__c, Status__c,
                   PIN_Code__c,Party_Type__c, Primary_Contact_Person_Name__c, Products__c,Street_Address__c,Custom_Dealer_LookUp__c,Custom_Distributor_LookUp__c,Custom_Taluk_LookUp__c,APPL_Taluk__c,APPL_Taluk__r.name from Account where Contact_Number_Mobile__c =:mobileNumber];
       system.debug('acc ='+accList);

       //Check for Null
       if( !accList.isEmpty() && accList.size() > 0){
           proAccounts.set(rowNumber-1, accList.get(0));
       }else{
          proAccounts.set(rowNumber-1, new Account(Contact_Number_Mobile__c =mobileNumber ));
       }
       if(proAccounts[rowNumber-1].District__c =='' || proAccounts[rowNumber-1].District__c==null){
            errorFlag=true;
            incompleteAccount='/'+proAccounts[rowNumber-1].Id;
       }
       else{
        errorFlag=false;
       }
      return null;
    }

    
    //Save Functionality
    public PageReference SavePromotionMembers(){
    validationRequired = true;
        PageReference pg ;
        List<Promotion_Member__c> pmsList = new List<Promotion_Member__c>();
        system.debug('Save Promomotion Members'+newpromotion.Id);

      try{
          
          if(newpromotion.Id != null){
            system.debug('Save Account Members'+proAccounts);

             for(Account acc : proAccounts){
                  acc.System_Flag__c = true;
                  /****acc.Account__c = acc.Custom_Distributor_LookUp__c;
                  acc.Dealer__c= acc.Custom_Dealer_LookUp__c;
                  acc.APPL_Taluk__c= acc.Custom_Taluk_LookUp__c;********/
                if(acc.RecordTypeId == null){
                     if(acc.Party_Type__c == 'Dealer'){
                              acc.recordtypeId = dealerRtId;
                        }else{
                               acc.recordtypeId = accRecTypeId;
                        } 
                  }
             }
              list<account> proAccountsInsert = new list<account>();
              list<account> proAccountsUpdate = new list<account>();
              for(account acc :proAccounts){
                  if(acc.id != null){
                     proAccountsUpdate.add(acc); 
                  }
                  else{
                      proAccountsInsert.add(acc);
                  }
              }

              set<id> failAccIds = new set<id>();
              Database.SaveResult[] srList = Database.update(proAccountsUpdate,false);
    Integer i=0;
    for (Database.SaveResult sr : srList) {
        if (!sr.isSuccess()) {
            for(Database.Error err : sr.getErrors()) { 
                System.debug(proAccountsUpdate.get(i).Id + ': ' + err.getMessage());
                 ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,err.getMessage()));
                failAccIds.add(proAccountsUpdate.get(i).Id);
            }
        }
        i++;
    }  
              Database.SaveResult[] srList1 = Database.Insert(proAccountsInsert,false);
    Integer i1=0;
    for (Database.SaveResult sr : srList1) {
        if (!sr.isSuccess()) {
            for(Database.Error err : sr.getErrors()) { 
                System.debug(proAccountsInsert.get(i1).Id + ': ' + err.getMessage());
                
                failAccIds.add(proAccountsInsert.get(i1).Id);
            }
        }
        i1++;
    }  
              string failedAccNames = '';
              if(failAccIds.size()>0){
                  for(Account acc :[select name from account where id in :failAccIds]){
                      failedAccNames+= acc.name+',';
                  }
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please check their is an error in Account: '+failedAccNames+' ')); 
                  return null;
              }

                  // upsert proAccounts;
               set<account> proSetAccounts=new set<account>();
                proSetAccounts.addAll(proaccounts);
                
                for(Account acc : proSetAccounts){                           
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
                //Update newpromotion;
              }else{
                System.debug('Members are equal, So No Update..');
              }
          }
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Confirm,'Promotion Members Added Succesfully'));
          validationCheck = true;
          showMemberSaveBtn = false;
          disabled=false;
             pg = new PageReference('/'+newpromotion.Id);
             pg.setRedirect(true); 
             return pg ;
      }catch(exception ex){
          System.debug('********Promotion member List and Account List******'+pmsList +proAccounts);
          system.debug('*****exception********'+ex);
        validationCheck = false;
         // ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Exception when saving'+String.valueOf(ex)));
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Exception: ' + ex.getTypeName() + ': ' + ex.getMessage() + ' -- ' + ex.getCause())); 
          showMemberSaveBtn = true;
          disabled=true;
          return null;
      } 
      
    }
    //Cancel
   public PageReference closeWindow(){
     PageReference pg = new PageReference('/'+newpromotion.Id);
      return pg;
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
        accList = [Select RecordTypeId,Id, Name, Dealer__c,Dealer__r.Name, Account__c,Account__r.Name, Contact_Number_Mobile__c,Visit_Type__c, Firm_Name__c,State__c, District__c, City__c,Contact_Number_Phone__c, Status__c,
                    PIN_Code__c,Party_Type__c, Primary_Contact_Person_Name__c, Products__c,Street_Address__c,Taluk_Tehsil__c,Taluk_Tehsil__r.Name,Custom_Dealer_LookUp__c,Custom_Distributor_LookUp__c,Custom_Taluk_LookUp__c,APPL_Taluk__c,APPL_Taluk__r.name  from Account where Contact_Number_Mobile__c =:accToRefresh];
       
        if( !accList.isEmpty() && accList.size() > 0){
            proAccounts.set(rowNumber-1, accList.get(0));
        }else{
            proAccounts.set(rowNumber-1, new Account(Contact_Number_Mobile__c =accToRefresh));
        }
        }
        return null;
    }

    public void SaveBtnHide(){    //taken from production
        showMemberSaveBtn = true;
        disabled = true;
    }
}