@isTest
public class ctrlBrandingRequest_UT{

static testmethod void ctrlBrandingRequestTest(){
 Profile profileID = [select id from profile where Name='System Administrator' limit 1];
 
 User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
       Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN441@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US');
     
 insert user1;

 Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
 Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
 
Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();

  Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
  status ='New');
  
 insert caset;
 
 Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();

Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();

 
 Account acc=new Account(recordtypeid =ii,name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
      classification__c='C', Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
      state__c='Goa', Street_Address__c='xyzx', Products__c='SWR', 
      Contact_Number_Mobile__c='7125552009',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent');

insert acc;

 
 ApexPages.currentPage().getParameters().put('Id', acc.id);
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc); 
  ctrlBrandingRequest accobj= new ctrlBrandingRequest(stdController );
  
  accobj.showBrandingRequestCases();
  accobj.newRequest();

  
  
  
  
  }
  
  static testmethod void ctrlBrandingRequestExceptionTest(){
 Profile profileID = [select id from profile where Name='System Administrator' limit 1];
 
 User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
       Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN442@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US');
     
 insert user1;

 Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
 Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
 
Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();

  Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
  status ='New');
  
 insert caset;
 
 Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();

Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();

 
 Account acc1=new Account(recordtypeid =ii,name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
      classification__c='C', Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
      state__c='Goa',  Street_Address__c='xyzx', Products__c='SWR', 
      Contact_Number_Mobile__c='7125552009',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent');

insert acc1;

 
 //ApexPages.currentPage().getParameters().put('Id', acc.id);
  Apexpages.StandardController stdController = new Apexpages.StandardController(acc1); 
  ctrlBrandingRequest accobj= new ctrlBrandingRequest(stdController );
  
  accobj.showBrandingRequestCases();
  accobj.newRequest();

  
  
  
  
  }
  
  
  
}