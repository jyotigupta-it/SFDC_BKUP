public class SearchandCreateMembers {

    Public Id prmId; 
    public Promotion__c prm{get;set;}
    
    //Integer count= 0;
    Public Boolean showmsg{get;set;}
    public integer num{ get; set; }
    
    public List<Account> MobileNumbers;
    public List<Account> existingAccountList;
    public List<Account> newAccountList;
    public List<Account> combinedAccountList;
    Public Map<String,Promotion_Member__c> MapMobiles;

    public SearchandCreateMembers(ApexPages.StandardController controller) {
        prmId=ApexPages.CurrentPage().getParameters().get('id');
        MapMobiles = new Map<String,Promotion_Member__c>();
        if(prmId!=null)
            prm=[SELECT id,Name,Type__c,(SELECT id,Name,Contact_Number__c FROM Promotion_Members__r) FROM Promotion__c WHERE id=:prmId];
            if(!prm.Promotion_Members__r.isEmpty())
            {
                for(Promotion_Member__c pm : prm.Promotion_Members__r)
                {
                    if(pm.Contact_Number__c!=Null)
                    {
                        MapMobiles.put(pm.Contact_Number__c,pm);
                    }
                }
            }
    
        
    }
    
     public Void add_rows() {
     
        if(MobileNumbers==null){
            MobileNumbers = new List<Account>();
        }
        
        for(integer i=0;i<num ;i++){           
            MobileNumbers.add(new Account()); 
        } 
    }
    
    
    public List<Account> getMobileNumbers() {
        return MobileNumbers;
    }
    
    public List<Account> getCombinedAccountList() {
        return combinedAccountList;
    }
    
     public List<Account> getExistingAccountList() {
        return existingAccountList;
    }


     public List<Account> getNewAccountList() {
        return newAccountList;
    }
    /**
    public SearchandCreateMembers() {
        if(MobileNumbers==null){
            MobileNumbers = new List<Account>();
        }
        
        MobileNumbers.add(new Account());
        MobileNumbers.add(new Account());
    }**/
    
    public PageReference searchMobileNumber(){
    try
    {
        boolean errorFlag = false;
        set<String> mobileNumberset = new set<String>();
        for(Account eachMob: MobileNumbers){
            String phoneNumber = eachMob.Contact_Number_Mobile__c;
            Pattern isnumbers = Pattern.Compile('^[0-9]+$');
            if(eachMob.Contact_Number_Mobile__c!=null && eachMob.Contact_Number_Mobile__c.trim()!='' ){
                Matcher MobileMatch = isnumbers.matcher(phoneNumber);
                if(!MobileMatch.Matches() || phoneNumber.length()!=10){
                     //System.debug('@@@@@@@@@@@@Match Match@@@@@@@@@@@@'+MobileMatch );
                     //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Correct the below errors'));
                     eachMob.Contact_Number_Mobile__c.addError('Please enter valid 10 digit number');
                     errorFlag = true;
                }else {
                    mobileNumberset.add(eachMob.Contact_Number_Mobile__c);
                }
            }else{
                eachMob.Contact_Number_Mobile__c.addError('Please enter valid 10 digit number');
                errorFlag = true;
            }
        }
        if(errorFlag )return null;
        existingAccountList = [Select Id, Name, Dealer__c, Account__c, Contact_Number_Mobile__c, 
                                      Visit_Type__c, Firm_Name__c, State__c, District__c, City__c, 
                                      Contact_Number_Phone__c, Status__c, PIN_Code__c,Party_Type__c, Primary_Contact_Person_Name__c, Products__c,Street_Address__c
                                      from Account where Contact_Number_Mobile__c in : mobileNumberset];
        
        set<String> existingMobileNumberset =  new set<string>();
        for(Account eachExistAcct : existingAccountList ){
            existingMobileNumberset.add(eachExistAcct.Contact_Number_Mobile__c);
        }
        newAccountList = new List<Account>();
        for(Account eachMob: MobileNumbers){
          if(eachMob.Contact_Number_Mobile__c!=null && eachMob.Contact_Number_Mobile__c.trim()!='' )
          {
            if(!existingMobileNumberset.contains(eachMob.Contact_Number_Mobile__c)){
                newAccountList.add(eachMob);
            }}
        }
        combinedAccountList = new List<Account>();
        combinedAccountList.addall(existingAccountList );
        combinedAccountList.addall(newAccountList);
        
        
        
        PageReference p=new PageReference('/apex/createMembers');
        return p;
        }
        catch(exception e)
        {return null;}
        
    }
    
    public PageReference saveMembers(){
       try
       {
        for(Account eachAccount: existingAccountList ){
            System.debug('**** DK .. Mobile = '+eachAccount.Contact_Number_Mobile__c +' Email = ');
        }
        
        for(Account eachAccount: newAccountList){
            System.debug('**** DK .. Mobile = '+eachAccount.Contact_Number_Mobile__c +' Email = ');
        }
        
        for(Account eachAccount: combinedAccountList){
            System.debug('**** DK .. Mobile = '+eachAccount.Contact_Number_Mobile__c +' Email = ');
        }
        
        for(Account each12 : newAccountList){
      
       if(each12.PIN_Code__c!=null && each12.PIN_Code__c.length()!=6)
       {
        each12.PIN_Code__c.addError('Please enter valid 6 digit number');
        return null;
        } 
            }
            Insert newAccountList;
        //update existingAccountList ;
       
        
        //upsert combinedAccountList;
        List<Promotion_Member__c> promotionMemberList = new List<Promotion_Member__c>(); 
        
        List<String> dupemobile=new List<String>();
        for(Account each : combinedAccountList){
       
        if(MapMobiles.Containskey(each.Contact_Number_Mobile__c))
            {
            dupemobile.add(each.Contact_Number_Mobile__c);
            }
           
        }
        if(!dupemobile.IsEmpty())
        {
        String error='';
        for(String S:dupemobile)
        {
        error=error+','+S;
        }
        ApexPages.addmessage(new Apexpages.message(apexpages.Severity.Error,'Already Promotion Members created with this Mobile Number'+error));
        return null;
        }
        if(dupemobile.IsEmpty()==True)
        {
            for(Account each : combinedAccountList)
            {
             promotionMemberList.add(new Promotion_Member__c(Promotions2__c=prm.id,Type1__c=prm.Type__c,Account__c=each.id));
            }
        }
        insert promotionMemberList;
        
        PageReference p = new PageReference('/'+ApexPages.CurrentPage().getParameters().get('id'));
        return p;
       }
        catch(exception e)
        {ApexPages.addMessages(e);} 
        return null;
    }
    


}