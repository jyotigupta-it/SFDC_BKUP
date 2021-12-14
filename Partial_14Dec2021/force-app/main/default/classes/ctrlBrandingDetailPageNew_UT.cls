/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class ctrlBrandingDetailPageNew_UT{
   static testmethod void testMethod1(){
   
   Profile profileID = [select id from profile where Name='System Administrator' limit 1];
   User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='others@infosys.com',UserName='others@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='5001');//
   
   insert user1;
   User user2 = new User(LastName='XYZtxcv',ProfileId=profileID.Id,Alias='testt',EmailEncodingKey='UTF-8',
                Email='othersxc@infosys.com',UserName='otherssxc@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='5002');//
   
   insert user2;
   User user3 = new User(LastName='XYZtt',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='others@infosys.com',UserName='otherssss@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='5003');
   
   insert user3;
   User user4 = new User(LastName='XYZd',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='others@infosys.com',UserName='othersd@infosys.com',
                User_State__c ='Karnataka',
                TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='5004');
   
   insert user4;
   
   Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
   Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
   Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();
     
   Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
   Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
   Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();

   Account acc1=new Account(recordtypeId=ii,name ='testAccounttestyyy', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
        classification__c='C',district__c='Mysore',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
        state__c='Goa', ownerid = user1.id,Street_Address__c='xyzx',
        Contact_Number_Mobile__c='7156784489', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
         );
                                  
   insert acc1;
   
   /*Account acc2=new Account(recordtypeId=ii,name ='testAccounttestzz', Primary_Contact_Person_Name__c='Testzz',market__c='Prospect',
        classification__c='C',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
        state__c='Goa', location__c='Bangalore',ownerid = user1.id,Street_Address__c='xyzx', Products__c='SWR', Shop_Description__c='Normal Dealer',
        Contact_Number_Mobile__c='7153784489',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent',
        Language__c = 'Hindi', Branding_Products__c = 'Plumbing', Branding_Sub_Products__c = '', Sub_Media__c = 'One-way-Vision' );
                                  
   insert acc2;*/

   Case caseRec1= new Case(recordtypeId = i, status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
   Metro_Non_Metro__c = 'Metro',city__c='Bangalore',Branding_Manager__c=user1.id,Branding_Team_Member__c=user2.id,Team_Lead__c=user3.id
   ,Vendor__c=user4.id);
   
   insert caseRec1;
   
   
   RecordType rt=[SELECT Id FROM RecordType WHERE SObjectType='Branding_Request__c' AND Name='Branding Request' LIMIT 1];

   Branding_Request__c brand1= NEW Branding_Request__c();
   brand1.Branding_Products__c='Plumbing';
   brand1.Shop_Name__c=acc1.id;
   brand1.Branding_Request__c=caseRec1.Id;
   brand1.Shop_Type__c='Fresh Shop';
   brand1.Branding_Sub_Products__c='SWR;column';
   brand1.Branding_Type__c='In Shop';
   brand1.Language__c='English';
   brand1.Shop_Description__c='zzzz';
   brand1.RecordType=rt;
   brand1.Branding_Request__c=caseRec1.id;
     
   Insert brand1;
   
   brand1= [select Shop_Name__c, Branding_Request__c, Shop_Name__r.name, Shop_Name__r.Metro_Non_Metro__c, Shop_Name__r.RecordType.name, Shop_Name__r.recordtypeid,  Shop_Description__c, Language__c, Branding_Products__c, Branding_Type__c, Branding_Sub_Type__c, Shop_Type__c from Branding_Request__c where id=:brand1.id];

   Branding_Request__c brand2= NEW Branding_Request__c(); 
   brand2.Branding_Products__c='All Products';
   brand2.Shop_Name__c=acc1.id;
   brand2.Branding_Request__c=caseRec1.Id;
   brand2.Shop_Type__c='Repair/Rework Dealer';
   brand2.comments__c='';
   brand2.Branding_Sub_Products__c='SWR;column';
  // brand2.Branding_Type__c='In Shop';
   brand2.Language__c='English';
   brand2.Shop_Description__c='zzzz';
   brand2.RecordType=rt;
   insert brand2;
   
   Branding_Request__c brand3= NEW Branding_Request__c(); 
   brand3.Branding_Products__c='All Products';
   brand3.Shop_Name__c=acc1.id;
   brand3.comments__c='';
   brand3.Branding_Request__c=caseRec1.Id;
   brand3.Shop_Type__c='Repair/Rework Dealer';
   brand3.Branding_Sub_Products__c='SWR;column';
   //brand3.Branding_Type__c='In Shop';
   brand3.Language__c='English';
   brand3.Shop_Description__c='zzzz';
   brand3.RecordType=rt;
   
         
   Branding_Request_Sub_Products__c brandprod=New Branding_Request_Sub_Products__c();
   brandprod.Name='Vinyl on Sunboard';
   brandprod.Branding_Request_Product__c='Plumbing';
   insert brandprod;
   
   Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
   req1.setComments('Submitting request for approval.');
   req1.setObjectId(caseRec1.id);
   Approval.ProcessResult result = Approval.process(req1);
       
       
   System.runAs(user4){
   test.starttest();    
    
    ApexPages.StandardController sc = new ApexPages.StandardController(caseRec1);
    PageReference pageRef = Page.BrandingDetailPageNew;
    pageRef.getParameters().put('id', String.valueOf(caseRec1.id));
    Test.setCurrentPage(pageRef);
    ctrlBrandingDetailPageNew  b1= new ctrlBrandingDetailPageNew (sc);
    
    //b1.currentcase=[select id,CaseNumber,recordtypeId,status,origin,Priority,Is_In_Approval_Process__c,Metro_Non_Metro__c ,city__c,Shop_1__c, Vendor__c
     //,Branding_Manager__c,Branding_Team_Member__c,Team_Lead__c
     //from case where id=:caseRec1.id];

     Boolean duplicateShop=false;
     b1.wrapperView[0].brRequest=brand1;
     b1.wrapperView[0].selectedSubProds.add(new selectOption('SWR','SWR'));
     b1.wrapperView[0].selectedSubProds.add(new selectOption('SWR','SWR'));
     for(integer ia=1;ia<10;ia++)
      b1.wrapperView[ia].brRequest.Shop_Name__c=null;
     
     b1.queryAccount(acc1.Id);
     insert brand3;  
     PageReference ref22=b1.saveDetails();    
     b1.wrapperView[1].brRequest=brand2;
     b1.wrapperView[2].brRequest=brand3;
     PageReference ref2=b1.saveDetails();
     b1.wrapperView[2].brRequest.Shop_Name__c=null;
     b1.wrapperView[2].brRequest.Shop_Name__r=acc1;
     PageReference ref21=b1.saveDetails();
     //PageReference ref3=b1.newReceeRecord();
     PageReference ref1=b1.editDetails();
     b1.subProdSelect();  
     PageReference ref=b1.getAccountDetails(); 
     PageReference ref4=b1.Cancel();
     delete acc1;
     b1.queryAccount(acc1.id);
     b1.shoppToRemove=acc1.id;
     b1.shoppId=acc1.id;
     PageReference refa=b1.RefreshAccountDetails();
     PageReference refb=b1.DeleteShop();
     test.stoptest();
     } 
 }
 
 
}