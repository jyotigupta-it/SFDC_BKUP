@isTest 
public class testbatchclasstodeleteattachements {
    static testMethod void testdltattach(){
       Profile profileID = [select id from profile where Name='System Administrator' limit 1];
       User u = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN114@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
       insert u;
       Id i=[select id from RecordType where SobjectType = 'Case' AND Name ='Branding Request' Limit 1].id;      
       Case c= new Case(recordtypeId = i, Request_Raised_By__c = u.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
                    Team_Lead__c =u.id, depo__c=u.id,City__c='Metro');
      insert c;
      Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
        Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
        Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();
        Account acc1=new Account(recordtypeid =ii,name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
        classification__c='C',Metro_Non__c='Metro',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
        state__c='Goa', ownerid = u.id,Street_Address__c='xyzx',
        Contact_Number_Phone__c='9114508449', Contact_Number_Mobile__c='9114508449',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
         );
        insert acc1;
        Branding_Request__c b2= NEW Branding_Request__c();
        b2.Branding_Request__c=c.id;
        b2.Shop_Name__c=acc1.id;
        insert b2;
        Attachment attach=new Attachment(); 
        String s=c.CaseNumber+'-'+acc1.Name+'-';    
        attach.Name='s';
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
        attach.body=bodyBlob;
        attach.parentId=acc1.id;
        insert attach;
        List<case> clist= [Select Id from case where Id =:c.id];
       Database.QueryLocator QL;
       Database.BatchableContext BC;
       Test.startTest();
       batchclasstodeleteattachements b = new batchclasstodeleteattachements();
       //Database.executeBatch(b);
       QL = b.start(BC); 
       b.execute(BC, clist);
       b.finish(BC); 
       Test.stopTest();

    }
}