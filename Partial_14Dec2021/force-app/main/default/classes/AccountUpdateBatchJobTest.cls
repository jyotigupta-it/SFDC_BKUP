@isTest 
public class AccountUpdateBatchJobTest 
{
    static testMethod void testMethod1() 
    {
        List<Account> lstAccount= new List<Account>();
        User u=new User();
       u.Id=UserInfo.getUserId();
       

       // for(Integer i=0 ;i <200;i++)
       // {
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
            acc.OwnerId=u.id;
            acc.Discount__c=50.50;
            
            lstAccount.add(acc);
            
        //}
         Insert lstAccount;
        Account acc1 =[Select Name, AccountCreatedDate__c From Account where Name='akh' limit 1];
         
           Integer d = acc1.AccountCreatedDate__c.day();
Integer mo = acc1.AccountCreatedDate__c.month();
Integer yr = acc1.AccountCreatedDate__c.year();

Date dte= Date.newInstance(yr, mo, d);
        
       Target__c lstTarget =new Target__c ();
       lstTarget.ownerid= acc.OwnerId;       
        lstTarget.Start_Date__c=dte ;
        insert lstTarget ;
        
       // Target__c lstTarget1 =[select ownerid,Start_Date__c,New_dealers_activation_Actual__c From Target__c limit 1];
      
       Order orderLst=new Order ();
       orderLst.accountId=acc.id;
       orderLst.EffectiveDate=dte;
       orderLst.status='Draft';
       orderLst.Name='test';
       Insert orderLst;
       
       // orderLst.EffectiveDate=dte.addDays(1000);
      // Update orderLst;
      // Order orderLst=[select accountId,EffectiveDate from order limit 1];
               Test.startTest();

            BatchUpdateAC obj = new BatchUpdateAC();
            DataBase.executeBatch(obj); 
            
        Test.stopTest();
    }
}