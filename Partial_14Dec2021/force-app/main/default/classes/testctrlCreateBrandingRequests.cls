/*  
 * Author     : Renjay Surendran
 */ 
@isTest
private class testctrlCreateBrandingRequests{
   static testMethod void testctrlCreatebrs(){
   
    Profile profileID = [select id from profile where Name='System Administrator' limit 1];
    
    User u1 = new User(LastName='xyz1',ProfileId=profileID.Id,Alias='test1',EmailEncodingKey='UTF-8',
    Email='others1@infosys.com',UserName='uppers1@infosys.com', User_State__c ='Karnataka', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',LanguageLocaleKey='en_US',vendor_code__c ='4000');
    
    insert u1;
    
    User u2 = new User(LastName='XYZ2',ProfileId=profileID.Id,Alias='test2',EmailEncodingKey='UTF-8',
    Email='others2@infosys.com',UserName='uppers2@infosys.com', User_State__c ='Karnataka', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='4002');
    
    insert u2;
    
    User u3 = new User(LastName='XYZ3',ProfileId=profileID.Id,Alias='test3',EmailEncodingKey='UTF-8',
    Email='others3@infosys.com',UserName='uppers3@infosys.com', User_State__c ='Karnataka', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='4003');
    
    insert u3;
    
    User u4 = new User(LastName='XYZ4',ProfileId=profileID.Id,Alias='test4',EmailEncodingKey='UTF-8',
    Email='others4@infosys.com',UserName='uppers4@infosys.com', User_State__c ='Karnataka', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',LanguageLocaleKey='en_US', vendor_code__c ='4004');
    
    insert u4;
    
    User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='testing',EmailEncodingKey='UTF-8',
    Email='othering@infosys.com', Branding_Manager__c = u1.id, Branding_Team_Member__c = u2.id, Team_Lead__c = u3.id, Vendor__c = u4.id,
    UserName='others@infosys.com', User_State__c ='Karnataka', TimeZoneSidKey='America/New_York', LocaleSidKey='en_US',LanguageLocaleKey='en_US',vendor_code__c ='5001');
    
    insert user1;
    
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();
    
    Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
    Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();
    
    Account acc1=new Account(recordtypeId=ii,name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
    classification__c='C',district__c='Mysore',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
    state__c='Goa',ownerid = user1.id,Street_Address__c='xyzx',
    Contact_Number_Mobile__c='7156784489',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
    );
    
    insert acc1;
    
    Vendor_Details__c ven = new Vendor_Details__c();
    ven.name ='XYZ';
    ven.vendor_code__c ='5001';
    ven.Vendor__c=u1.id;
    ven.vendor_cluster__c='abc';
    ven.Primary_Vendor__c=true;
    insert ven;
    
    Case c= new Case(recordtypeId = i, status ='Approved by Team Leader', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
    Metro_Non_Metro__c = 'Metro',city__c='Bangalore');
    
    insert c;
    
    RecordType rt=[SELECT Id FROM RecordType WHERE SObjectType='Branding_Request__c' AND Name='Branding Request' LIMIT 1];
    
    Branding_Request__c brand1= NEW Branding_Request__c();
    brand1.Branding_Products__c='Plumbing';
    brand1.Shop_Name__c=acc1.id;
    brand1.Branding_Request__c=c.Id;
    brand1.Shop_Type__c='Fresh Shop';
    brand1.Branding_Sub_Products__c='SWR';
    brand1.Branding_Sub_Type__c='Vinyl on Sunboard';
    brand1.Branding_Type__c='In Shop';
    brand1.Language__c='English';
    brand1.Comments__c='QQQQ';
    brand1.Shop_Description__c='zzzz';
    brand1.RecordType=rt;
    
    Insert brand1;
    
   
    
    Branding_Request__c brand2= NEW Branding_Request__c(); 
    brand2.Branding_Products__c='All Products';
    brand2.Shop_Name__c=acc1.id;
    brand2.Shop_Type__c='Fresh Shop';
    brand2.Branding_Request__c=c.Id;
    brand2.Branding_Sub_Products__c='SWR';
    brand2.Comments__c='QQQQ';
    brand2.Branding_Sub_Type__c='Vinyl on Sunboard';
    brand2.Branding_Type__c='In Shop';
    brand2.Language__c='English';
    brand2.Shop_Description__c='zzzz';
    brand2.RecordType=rt;
    
    insert brand2;
    
    AP_Taluk_Master__c ap = new AP_Taluk_Master__c();
    ap.name='Bangalore';
    ap.Cluster__c='abc';
    ap.District__c='aaa';
    ap.State__c='aaa';
    
    insert ap;
    
  /*  Branding_Request_Sub_Products__c brandprod=New Branding_Request_Sub_Products__c();
    brandprod.Name='Vinyl on Sunboard';
    brandprod.Branding_Request_Product__c='Plumbing';
    insert brandprod;*/
    
    System.runAs(user1){    
      Test.startTest();
            
        ApexPages.StandardController sc = new ApexPages.StandardController(c);
        PageReference pageRef = Page.CreateBrandingRequests;
        pageRef.getParameters().put('id', String.valueOf(c.id));
        pageRef.getParameters().put('RecordType', String.valueOf(i));
        brand1= [select Shop_Name__c, Branding_Request__c, Comments__c, Shop_Name__r.name, Shop_Name__r.Metro_Non_Metro__c, Shop_Name__r.RecordType.name, Shop_Name__r.recordtypeid,  Shop_Description__c, Language__c, Branding_Products__c, Branding_Type__c, Branding_Sub_Type__c, Shop_Type__c from Branding_Request__c where id=:brand1.id]; 
       system.debug('brand1:::'+brand1.id);
        Test.setCurrentPage(pageRef);
        ctrlCreateBrandingRequests  ccbr= new ctrlCreateBrandingRequests (sc);
        
        ccbr.currentcase=[select id,CaseNumber,recordtypeId,status,origin,Priority,Is_In_Approval_Process__c,Metro_Non_Metro__c ,city__c from case where id=:c.id];
        ccbr.currentcase.Vendor__c=ven.Vendor__c;
        ccbr.currentCase.Vendor_Details__c=ven.id;
        ccbr.wrapperView[0].brRequest=brand1;
        ccbr.wrapperView[0].selectedSubProds.add(new selectOption('SWR','SWR'));
        ccbr.wrapperView[0].selectedSubProds.add(new selectOption('SWR','SWR'));
        for(integer ia=1;ia<10;ia++)
            ccbr.wrapperView[ia].brRequest.Shop_Name__c=null;
      
        ccbr.disabled =false;
        ccbr.currentcase=new Case(recordtypeId = i, status ='Approved by TL', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
    Metro_Non_Metro__c = 'Metro',city__c='Bangalore');
        //ccbr.wrapperView[0].brRequest=new Branding_Request__c(Branding_Products__c='Plumbing', Shop_Name__c=acc1.id, Branding_Request__c=c.Id, Shop_Type__c='Fresh Shop', Branding_Sub_Products__c='SWR', Branding_Sub_Type__c='Vinyl on Sunboard', Branding_Type__c='In Shop', Language__c='English', Comments__c='QQQQ', Shop_Description__c='zzzz', RecordType=rt);
        ccbr.shoppToRemove=acc1.id;
        ccbr.shoppId=acc1.id;
        ccbr.selectedId='abc';
        ccbr.RefreshAccountDetails();
       
        ccbr.saveDetails();
        ccbr.showCityText();
        ccbr.wrapperView[1].brRequest=brand2;
        ccbr.getAccountDetails();
        
        ccbr.getIsCity();
        ccbr.currentCase.City__c='Others';
        ccbr.currentCase.taluk__c=ap.id;
        ccbr.getIsCity();
        ccbr.saveNew();
        ccbr.getTalukDetails();
        ccbr.Cancel();
        ccbr.queryAccount(acc1.id);
         ccbr.DeleteShop();
         ccbr.AsignVendor();
        Test.stopTest();
    }
   }     
}