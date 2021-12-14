@isTest
public class ctrlUploadBrandinImages_UT{
 static testmethod void test(){
 
    Profile profileID = [select id from profile where Name='System Administrator' limit 1];
    User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='others@infosys.com',UserName='others@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US',vendor_code__c ='5001');
   
   insert user1;
   
   System.runAs(user1) {
         // The following code runs as user 'user1'
         System.debug('Current User: ' + UserInfo.getUserName());
         System.debug('Current Profile: ' + UserInfo.getProfileId());
         System.debug('Current User: ' + UserInfo.getUserId());
      }
 
    Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
    Id ii= AccountRecordTypeInfoa.get('Dealer').getRecordTypeId();
    
   Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
   Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
   Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();
   
    
    Account acc1=new Account(recordtypeid =ii,name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
        classification__c='C',Metro_Non__c='Metro',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
        state__c='Goa', ownerid = user1.id,Street_Address__c='xyzx',
        Contact_Number_Mobile__c='7156784489', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
         );
                                  
   insert acc1;
   
   Case c= new Case(recordtypeId = i, status ='Approved by TL', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
   Metro_Non_Metro__c = 'Metro',city__c='Bangalore');
   insert c;
   
   Branding_Request__c b2= NEW Branding_Request__c();
    b2.Branding_Request__c=c.id;
    b2.Shop_Name__c=acc1.id;
    
    b2.Branding_Installation__c='Installed';
    insert b2;
    
    System.runAs(user1){
    
    test.starttest();
    ApexPages.currentPage().getParameters().put('id', c.id);    
    ApexPages.StandardController sc = new ApexPages.StandardController(c);
    
    ctrlUploadBrandinImages b1= new ctrlUploadBrandinImages(sc);   
    Blob bodyBlob1=Blob.valueOf('Unit Test Attachment Body'); 
    b1.wrapperView[0].csvAsString='test';
    b1.wrapperView[0].csvFileBody=bodyBlob1;  
    PageReference ref=b1.uploadAttachment( );
    
    delete b2;
    ctrlUploadBrandinImages b1New= new ctrlUploadBrandinImages(sc);
     //b1New.wrapperView[0].csvFileBody=Blob.valueOf('');  
    PageReference ref1=b1.uploadAttachment( );
    test.stoptest();
   } 
    
 }
}