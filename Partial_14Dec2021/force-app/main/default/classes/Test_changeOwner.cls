@istest
public class Test_changeOwner{


   
   Static TestMethod Void change() {
   List<Opportunity> opList=new List<Opportunity>();
   List<Order> orList=new List<Order>();
    User_Taluk_Master_Junction__c getId=new User_Taluk_Master_Junction__c ();
    getId.name='Testing';
    //getId=[select id from User_Taluk_Master_Junction__c limit 1];get
    
    //insert getId;
    
    
    
     Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD']; 
        User userData = new User(Alias = 'standt1', 
                                  Email= 'FName'+'LName'+'@TestUser99.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName',
                                  LastName = 'LName', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName+LName+@TestUs232.com'
                                  );
    
    insert userData;
    
     
    Opportunity op= new Opportunity();
    op.ownerId=userinfo.getuserId();
    op.name='Test';
    op.ownerId=userData.Id;
    op.StageName='Designing';
    op.Project_Type__c='Mixed';
    op.Probability_New__c='80%';
   // op.Taluk__c=getId.id;
   op.CloseDate=system.today();
    op.No_of_Bathrooms__c=7;
    op.Special_Pricing_Request_Approval__c='Not Submitted';
    opList.add(op);
     insert opList;
 List<Account> lstAccount= new List<Account>();
        Account acc = new Account();
           
            acc.Name ='akh';
            acc.Primary_Contact_Person_Name__c='Vivek Rungta ';
            acc.Classification__c='A';
            acc.Purchase_Cycle__c='Weekly';
            acc.Contact_Number_Mobile__c='9308622241';
            acc.Street_Address__c='Station road';
            acc.Display_of_our_product__c='Prominent';
            acc.Type_of_Dealer__c='Sanitary';
            acc.Media__c='Outshop';    
            acc.Market__c ='Existing';
            acc.Party_Type__c='Dealer';
            acc.Status__c = 'Prospective'; 
            acc.OwnerId=userData.id;
            acc.Discount__c=50.50;
            acc.District__c='Bangalore';
            acc.State__c='Karnataka';
            acc.Business_Line__c='Plumbing';
            
            lstAccount.add(acc);
            
        //}
         Insert lstAccount;
    
   // opportunity o= new opportunity();
   // o=[select id from opportunity where id=:op.id];
     
      Contract ct = new Contract();
ct.AccountId = acc.Id;
ct.Status = 'Draft';
ct.StartDate = Date.Today();
ct.ContractTerm = 12;
insert ct;

     //Insert op;
     Order od= new Order();
   
     //objOrder.opportunityId=op.Id;
     od.ownerid=userinfo.getuserId();
     od.Name = '14TPE000001';
    od.AccountId = acc.Id;
     od.EffectiveDate = Date.Today();
    od.ContractId = ct.Id;
    od.Status = 'Draft';
       od.OpportunityId=op.Id;
     orList.add(od);
     
    
   try{
     system.debug('oopppID'+op.Id);
    system.debug('oppList((((((((((('+opList);
     system.debug('ordlist$$$$$$$$$$$$$$$$$$$'+orList);
    
     insert od;
     
    
     }
     catch(exception e){
     system.debug(e.getMessage()+'Line Number********'+e.getLineNumber());
     }
     test.startTest();
      op.ownerId=userData.id;
     changingOrderOwner.changeOrderOwner(opList);
    
     
     
    
     //objOrder.ownerId=
     
     test.stopTest();
     
     
     
    
   }
  
}