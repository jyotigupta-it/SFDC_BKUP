@isTest
Private class ProductRequestTestClass {
public static testMethod void testproduct(){
    Product2 p1=new Product2();
    p1.Name='Concealed valve';
    insert p1;
         OperatingHours oh = new OperatingHours();
        oh.Name = 'TestOH';
        oh.TimeZone='America/Los_Angeles';
        insert oh;
   
      ServiceTerritory s1=new ServiceTerritory();
        s1.Name='Bangalore';
        s1.IsActive=true;
        s1.OperatingHoursId=oh.id;
        insert s1;
      Town_Master__c tm=new Town_Master__c();
        tm.Name='Bangalore';
        tm.State__c='Karnataka';
        tm.District__c='Bangalore';
        tm.Service_Territory__c=s1.id;
        insert tm;
        
        Account acc1=new Account();
        acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail-Customer').getRecordTypeId();
        acc1.Name='Customer';
        acc1.Contact_Number_Mobile__c='12345678901';
        acc1.Can_you_please_give_address_retail__c='asdfghj';
        acc1.City_lookup__c=s1.id;
        acc1.State__c='Karnataka';
        acc1.Country_fsl__c='India';
        acc1.PinCode__c='123456';
        acc1.Town_Code__c='5670';
         acc1.Business_Line__c='Column';
        acc1.Products__c='CPVC';
        
        acc1.Town_Name__c=tm.id;
        insert acc1;
         
        Entitlement ent=new Entitlement();
         ent.name='Work Order Process';
         ent.AccountId=acc1.id;
         insert ent;
        
        Entitlement ent1=new Entitlement();
         ent1.name='Case Process';
         ent1.AccountId=acc1.id;
         insert ent1;
        
       
        
        ServiceTerritory s5=new ServiceTerritory();
        s5.Name='Pune';
        s5.IsActive=true;
        s5.OperatingHoursId=oh.id;
        insert s5;
        
        Product2 prod=new Product2();
        prod.Name='Concealed Valve';
        prod.IsActive=true;
        prod.Family='Concealed Valve';
        insert prod;
       
        Product2 prod1=new Product2();
        prod1.Name='Concealed Diverter';
        prod1.IsActive=true;
        prod1.Family='Diverter';
        insert prod1;
        
        WorkType work=new WorkType();
        work.Name='Concealed';
        work.DurationType='Hours';
        work.EstimatedDuration=5;
        insert work;
        
        Problem__c prob =new Problem__c();
        prob.Name='Concealed valve leakage';
        prob.Product__c=prod.Id;
        
        prob.Work_Type__c=work.id;
        insert prob;
        
         Problem__c prob1 =new Problem__c();
        prob1.Name='Concealed Diverter leakage';
        prob1.Product__c=prod1.Id;
        
        prob1.Work_Type__c=work.id;
        insert prob1;

       Contact con = new Contact(LastName ='testCon',Salutation='Mr',AccountId = acc1.Id);
       insert con;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Ashirvad Contractor Partner Community'];
        User u1=new User();
        u1.Alias='user1';
        u1.Email='test@gmail.com';
        u1.Username='test675433@gmail.com.123';
        u1.FirstName='test';
        u1.LastName='user';
        u1.ProfileId=p.id;
        u1.EmailEncodingKey='UTF-8';
        u1.LanguageLocaleKey='en_US';
        u1.LocaleSidKey='en_US';
        u1.IsActive=true;
        u1.ContactId=con.id;
        u1.TimeZoneSidKey='America/Los_Angeles';
        insert u1;
 
         ServiceResource sr=new ServiceResource();
        sr.Name='TestResource';
       // sr.ResourceType='Technician';
        sr.RelatedRecordId=u1.Id;
        sr.IsActive=true;
        insert sr;
        
          
        Territory_Contractors__c tc =new Territory_Contractors__c();
        tc.Name='Test';
        tc.Service_Territory__c=s1.Id;
        tc.Contractor__c= u1.id;
        tc.SAP_Code_ship__c='qwer';
        tc.SAP_Code_sold__c='sdf';
        insert tc;
    
    Schema.Location loc1=new Schema.Location();
    loc1.LocationType='Warehouse';
    loc1.Name='Test Warehouse';
    loc1.IsInventoryLocation=true;
    insert loc1;
    
    ProductItem pi=new ProductItem();
    pi.LocationId=loc1.id;
    pi.Product2Id=p1.id;
    pi.QuantityOnHand=20;
   insert pi;
    
    
    ProductRequest pr=new ProductRequest();
    pr.OwnerId=u1.id;
    pr.DestinationLocationId=loc1.id;
    pr.Status='Draft';
    insert pr;
    
    ProductRequestLineItem lineitem=new ProductRequestLineItem();
    lineitem.ParentId=pr.id;
    lineitem.DestinationLocationId=loc1.id;
    lineitem.Product2Id=p1.id;
    lineitem.QuantityRequested=10;
    lineitem.Status='Draft';
    insert lineitem;
    
     ProductRequest pro=new ProductRequest();
    pro.id=pr.id;
    pro.DestinationLocationId=loc1.id;
    pro.Status='Submitted';
    update pro;
    
     ProductRequest prodr=new ProductRequest();
    prodr.id=pr.id;
    prodr.DestinationLocationId=loc1.id;
    prodr.Status='Received';
    update prodr;
    
    
     ProductRequestLineItem lineitemz=new ProductRequestLineItem();
    lineitemz.ParentId=pr.id;
    lineitemz.DestinationLocationId=loc1.id;
    lineitemz.Product2Id=p1.id;
    lineitemz.QuantityRequested=10;
    lineitemz.Status='Draft';
    insert lineitemz;
    
    
    
    ProductRequest pr11=new ProductRequest();
     pr11.DestinationLocationId=loc1.id;
    pr11.Status='Draft';
    insert pr11;
    
      ProductRequest pr12=new ProductRequest();
    pr12.id=pr11.id;
         pr12.Status ='Submitted';
    update pr12;
    
     ProductRequest pr13=new ProductRequest();
    pr13.id=pr11.id;
    pr11.Status='Received';
    update pr13;
     ProductRequestLineItem lineitem1=new ProductRequestLineItem();
    lineitem1.id=lineitem.id;
   // lineitem1.ParentId=pr11.id;
    lineitem1.DestinationLocationId=loc1.id;
    lineitem1.Product2Id=p1.id;
    lineitem1.QuantityRequested=10;
    lineitem1.Quantity_Received__c=5;
    lineitem1.Status='Received';
    update lineitem1;
    
     ProductRequestLineItem lineitem11=new ProductRequestLineItem();
    lineitem11.id=lineitemz.id;
   // lineitem1.ParentId=pr11.id;
    lineitem11.DestinationLocationId=loc1.id;
    lineitem11.Product2Id=p1.id;
    lineitem11.QuantityRequested=10;
    lineitem11.Quantity_Received__c=10;
    lineitem11.Status='Received';
    update lineitem11;
    
    ProductRequest prre=new ProductRequest();
    prre.DestinationLocationId=loc1.id;
    prre.Status='Received';
    insert prre;
    
     
    ProductRequestLineItem line=new ProductRequestLineItem();
    line.ParentId=prre.id;
    line.DestinationLocationId=loc1.id;
    line.Product2Id=p1.id;
    line.QuantityRequested=10;
    line.Status='Draft';
    insert line;
    
}
}