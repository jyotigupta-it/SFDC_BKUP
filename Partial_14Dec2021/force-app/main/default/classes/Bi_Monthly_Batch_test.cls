/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public Class Bi_Monthly_Batch_test{ 
        static testmethod void StartTest(){
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        Bi_Monthly_Batch prog = new Bi_Monthly_Batch();
        List<Bi_Monthly_Batch__c> batchList = new List<Bi_Monthly_Batch__c>();
        List<inventory__c> invList = new List<inventory__c>();
        List<user> userList = new List<user>();
        Profile profile1= [Select Id from Profile where name='System Administrator' limit 1];
        Profile profile2= [Select Id from Profile where name='BD' limit 1];
        User user= new User( FirstName='Test',Street='asd',city='aas',state='Karnataka',PostalCode='560100',country='India', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile1.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
      //  User user2= new User( FirstName='Test',Street='asd',city='aas',state='Karnataka',PostalCode='560100',country='India', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile1.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        insert user;
        
        
        User admin = new User(LastName='XYZ1u23',ProfileId=profile2.Id,Alias='test',EmailEncodingKey='UTF-8',
            Email='vasanthi_KN@infosys.com',UserName='vasanthi45671@infosys.com',
            User_State__c ='Karnataka',Head_office__c=user.id,team_lead__c=user.id,Depo__c=user.id,TimeZoneSidKey='America/New_York',
            LocaleSidKey='en_US',LanguageLocaleKey='en_US');
         userList.add(admin);
 insert userList ;
        System.runAs(admin){ 
        inventory__c inv=new inventory__c();
        inv.Name='Renj';
        inv.Closing_Stocks__c=100;
        inv.opening_stock__c=1000;
        inv.Dispatch_Size__c=75; 
        inv.Threshold__c=200;
        inv.Used_Stock__c=900;
        inv.Type__c='SAMPLES';
        inv.Product__c='a';
        inv.Product_Description__c='a';
        inv.Owner_Account__c=admin.id;
        inv.Color_Language_Size__c='a';
        inv.Item_Code__c='100';
        invList.add(inv);
        
        insert invList; 
        
        Bi_Monthly_Batch__c bi=new Bi_Monthly_Batch__c();
        bi.Name='Renj'; 
        bi.Category__c ='a';
        bi.Product__c='SAMPLES';
        bi.Product_Discription__c='a';
        bi.Color_Language_Size__c='a';
        bi.Item_Code__c='100';
        batchList.add(bi);
        
        insert batchList;
        
        test.startTest();  
        QL = prog.start(BC); 
        prog.execute(BC, userList);
        prog.finish(BC); 
        test.stopTest();
      }
}
}