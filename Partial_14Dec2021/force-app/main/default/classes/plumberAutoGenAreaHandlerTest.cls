@isTest
public class plumberAutoGenAreaHandlerTest {
    @isTest
    public static void insertAccount()
    {
        List<Account> accInsertList = new List<Account>();
        List<Account> accInsertList2 = new List<Account>();
        Id plumberClubId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Plumber Club  Enrollment').getRecordTypeId();
        Id delearRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        Id account_RTYPE = Schema.Sobjecttype.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();
        
        Account acc1=new Account();
        acc1.Name='accTest';
        acc1.Firm_Name__c ='test';
        acc1.Contact_Number_Mobile__c='9568742352';
        acc1.recordTypeId=account_RTYPE;
        insert acc1;
        
          AP_Taluk_Master__c  ap = new  AP_Taluk_Master__c ();
        ap.name='Bangalore';
        ap.Cluster__c='qweqwe';
        ap.District__c='bangalore';
        ap.State__c = 'karnataka';
        insert ap;
        
        plumber_club__c pc = new plumber_club__c();
        pc.Name ='Yelahanka';
        pc.Plumber_Club_Id__c ='BLR02';
        pc.count__c=9;
        insert pc;
        
        Account DelearAccount = new Account();
        DelearAccount.RecordTypeId=delearRecordTypeId;
        DelearAccount.Name='test';
        DelearAccount.Status__c='Cold Call';
        DelearAccount.Primary_Contact_Person_Name__c='test';
        DelearAccount.Business_Line__c='Column';
        DelearAccount.Products__c='V4';
        DelearAccount.Classification__c='A';
        DelearAccount.Purchase_Cycle__c='Weekly';
        DelearAccount.Taluk_Tehsil__c=ap.Id;
        DelearAccount.Display_of_our_product__c='Prominent';
        DelearAccount.Media__c='In Shop';
        DelearAccount.Type_of_Dealer__c='Others';
        insert DelearAccount;
                
        Account acc = new Account();
        acc.RecordTypeId = plumberClubId;
     
        acc.Plumber_club__c=pc.Id;
        acc.Name='test';
        acc.Contact_Number_Mobile__c='8652135478';
        acc.ID_proof_submitted__c='Voter ID';
        acc.Local_Work_Address__c='test';
        acc.Birth_Date__c=system.today();
        acc.City1__c='test';
        acc.Blood_Group__c='c+';
        acc.Ashirvad_Plumber__c='Yes';
        acc.Years_of_experience__c='0-3 years';
        acc.Type_of_Phone__c='Smart Phone';
        acc.Number_of_Plumbers_under_me__c=9;
        acc.Dealer__c=DelearAccount.Id;
        acc.PIN_Code__c='123456';
        acc.Pin_Code1__c='123456';
        accInsertList.add(acc);
      
        
         Account acc2 = new Account();
        acc.RecordTypeId = plumberClubId;
        acc2.Plumber_club__c=pc.Id;
        acc2.Name='test';
        acc2.Contact_Number_Mobile__c='8652135478';
        acc2.ID_proof_submitted__c='Voter ID';
        acc2.Local_Work_Address__c='test';
        acc2.Birth_Date__c=system.today();
        acc2.City1__c='test';
        acc2.Blood_Group__c='c+';
        acc2.Ashirvad_Plumber__c='Yes';
        acc2.Years_of_experience__c='0-3 years';
        acc2.Type_of_Phone__c='Smart Phone';
        acc2.Number_of_Plumbers_under_me__c=9;
        acc2.Dealer__c=DelearAccount.Id;
        acc2.PIN_Code__c='123456';
        acc2.Pin_Code1__c='123456';
       	accInsertList2.add(acc2);
        accInsertList.add(acc2);
        
        insert accInsertList;
        //insert accInsertList2;
        
       
        
        
        
    }
    
}