@isTest
public class CtrlInventoryDetailPage_UT{
   static testMethod void InventoryDetailPagetest(){
       
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= CaseRecordTypeInfo.get('Branding Request').getRecordTypeId(); 
     
    Case c1=new Case();
    c1.recordtypeId =i;
    c1.Shipping_Address__c='Elec,Bangalore';
    c1.Billing_Address__c='BTM,Bangalore';
    c1.Is_In_Approval_Process__c=false;
    c1.status='New';
    c1.depo__c=user.id;
    c1.head_office__c=user.id;
    c1.team_lead__c=user.id;
    c1.Request_Raised_By__c=user.id;
    c1.collateral_flows__c ='Requestor';
    insert c1;
    
    List<inventory__c> invlist= new List<inventory__c>();
    inventory__c inv1=new inventory__c();
    inv1.opening_stock__c =150;
    inv1.Closing_Stocks__c=150;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    inv1.type__c='PRODUCT COLLATERALS';
    inv1.product__c='XYZ';
    inv1.Color_Language_Size__c='zzzzz';
    inv1.product_description__c='Good';
    inv1.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert inv1;
    // List<inventory__c> invlist= new List<inventory__c>();
    inventory__c invSam=new inventory__c();
    invSam.opening_stock__c =150;
    invSam.Closing_Stocks__c=150;
    invSam.Dispatch_Size__c=50;
    invSam.Owner_Account__c = user.id;
    invSam.Received_Stock__c = 0;
    invSam.Threshold__c=50;
    invSam.Used_Stock__c=0;
    invSam.type__c='SAMPLES';
    invSam.product__c='XYZ';
    invSam.Color_Language_Size__c='zzzzz';
    invSam.product_description__c='Good';
    invSam.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert invSam;
    
     inventory__c invPac=new inventory__c();
    invPac.opening_stock__c =150;
    invPac.Closing_Stocks__c=150;
    invPac.Dispatch_Size__c=50;
    invPac.Owner_Account__c = user.id;
    invPac.Received_Stock__c = 0;
    invPac.Threshold__c=50;
    invPac.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invPac.product__c='XYZ';
    invPac.Color_Language_Size__c='zzzzz';
    invPac.product_description__c='Good';
    invPac.Item_Code__c='8888';
    invPac.type__c='PACKING MATERIALS';
    
    insert invPac;
   
    inventory__c inv2=new inventory__c();
    inv2.opening_stock__c =150;
    inv2.Closing_Stocks__c=150;
    inv2.Dispatch_Size__c=50;
    inv2.Owner_Account__c = user.id;
    inv2.Received_Stock__c = 0;
    inv2.Threshold__c=50;
    inv2.Used_Stock__c=0;
    inv2.type__c='PRODUCT COLLATERALS';
    inv2.product__c='XYZ';
    inv2.Color_Language_Size__c='zzzzz';
    inv2.product_description__c='Good';
    inv2.Item_Code__c='8888';
    //inv2.type__c='SAMPLES';
    
    insert inv2;
    
     inventory__c inv4=new inventory__c();
    inv4.opening_stock__c =150;
    inv4.Closing_Stocks__c=150;
    inv4.Dispatch_Size__c=50;
    inv4.Owner_Account__c = user.id;
    inv4.Received_Stock__c = 0;
    inv4.Threshold__c=50;
    inv4.Used_Stock__c=0;
    inv4.type__c='PRODUCT COLLATERALS';
    inv4.product__c='XYZ';
    inv4.Color_Language_Size__c='zzzzz';
    inv4.product_description__c='Good';
    inv4.Item_Code__c='8888';
    //inv4.type__c='GIFT ITEMS';
     inv4.type_of_meet__c='Mega Meet';
    
    insert inv4;
    
      inventory__c inv3=new inventory__c();
     inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    //inv3.type__c='ABC';
    inv3.product__c='XYZ';
    inv3.Color_Language_Size__c='zzzzz';
    inv3.product_description__c='Good';
    inv3.Item_Code__c='8888';
    inv3.type__c='PRODUCT COLLATERALS';
    
    insert inv3;
    
    
    
    Inventory_Request__c invreq1=new Inventory_Request__c();
    invreq1.Type_of_Item__c=inv1.id;
    invreq1.inventory_Sample__c=invSam.id;
    invreq1.inventory_Product__c=inv1.id;
    invreq1.inventory_PackMaterials__c=invPac.id;
    invreq1.Inventory_Request_Number__c=c1.id;
    invreq1.Request_Rasied_by__c=user.id;
    invreq1.Required_Quantity__c  =100;
    
    insert invreq1;
    
   Inventory_Request__c invreq2=new Inventory_Request__c();
    invreq2.Type_of_Item__c=inv2.id;
    invreq2.inventory_Sample__c=invSam.id;
    invreq2.inventory_Product__c=inv2.id;
    invreq2.inventory_PackMaterials__c=invPac.id;
    invreq2.Inventory_Request_Number__c=c1.id;
    invreq2.Request_Rasied_by__c=user.id;
        invreq2.Required_Quantity__c  =100;
    
    insert invreq2;
    
    Inventory_Request__c invreq4=new Inventory_Request__c();
    invreq4.Type_of_Item__c=inv4.id;
    invreq4.inventory_Sample__c=invSam.id;
    invreq4.inventory_Product__c=inv4.id;
    invreq4.inventory_PackMaterials__c=invPac.id;
    invreq4.Inventory_Request_Number__c=c1.id;
    invreq4.Request_Rasied_by__c=user.id;
        invreq4.Required_Quantity__c  =100;
   
    insert invreq4;
    
    Inventory_Request__c invreq3=new Inventory_Request__c();
    invreq3.Type_of_Item__c=inv3.id;
    invreq3.inventory_Sample__c=invSam.id;
    invreq3.inventory_Product__c=inv3.id;
    invreq3.inventory_PackMaterials__c=invPac.id;
    invreq3.Inventory_Request_Number__c=c1.id;
    invreq3.Request_Rasied_by__c=user.id;
    invreq3.Required_Quantity__c  =100;
    insert invreq3;
    
    test.startTest();
    System.runAs(user)
    { 
       ApexPages.currentPage().getParameters().put('id', c1.id);    
       ApexPages.StandardController sc = new ApexPages.StandardController(c1);
       CtrlInventoryDetailPage ctrl= new CtrlInventoryDetailPage(sc);
             
       PageReference ref=ctrl.editDetails( );
       PageReference ref1=ctrl.Cancel();
        PageReference ref2=ctrl.getinventoryDetails();
       
       PageReference ref4=ctrl.saveDetails( );
      
    }
    test.stopTest();
   }
   
   static testMethod void InventoryDetailPagetest1(){
  
     Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= CaseRecordTypeInfo.get('Branding Request').getRecordTypeId(); 
     
    Case c1=new Case();
    c1.recordtypeId =i;
    c1.Shipping_Address__c='Elec,Bangalore';
    c1.Billing_Address__c='BTM,Bangalore';
    c1.Is_In_Approval_Process__c=false;
    c1.status='New';
    c1.depo__c=user.id;
    c1.head_office__c=user.id;
    c1.team_lead__c=user.id;
    c1.Request_Raised_By__c=user.id;
    c1.collateral_flows__c ='Requestor';
    insert c1;
    
    List<inventory__c> invlist= new List<inventory__c>();
    inventory__c inv1=new inventory__c();
    inv1.opening_stock__c =150;
    inv1.Closing_Stocks__c=150;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    inv1.type__c='PRODUCT COLLATERALS';
    inv1.product__c='XYZ';
    inv1.Color_Language_Size__c='zzzzz';
    inv1.product_description__c='Good';
    inv1.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert inv1;
    
    inventory__c invSam=new inventory__c();
    invSam.opening_stock__c =150;
    invSam.Closing_Stocks__c=150;
    invSam.Dispatch_Size__c=50;
    invSam.Owner_Account__c = user.id;
    invSam.Received_Stock__c = 0;
    invSam.Threshold__c=50;
    invSam.Used_Stock__c=0;
    invSam.type__c='SAMPLES';
    invSam.product__c='XYZ';
    invSam.Color_Language_Size__c='zzzzz';
    invSam.product_description__c='Good';
    invSam.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert invSam;
    
     inventory__c invPac=new inventory__c();
    invPac.opening_stock__c =150;
    invPac.Closing_Stocks__c=150;
    invPac.Dispatch_Size__c=50;
    invPac.Owner_Account__c = user.id;
    invPac.Received_Stock__c = 0;
    invPac.Threshold__c=50;
    invPac.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invPac.product__c='XYZ';
    invPac.Color_Language_Size__c='zzzzz';
    invPac.product_description__c='Good';
    invPac.Item_Code__c='8888';
    invPac.type__c='PACKING MATERIALS';
    
    insert invPac;
    
    
   
    
    
   inventory__c inv2=new inventory__c();
    inv2.opening_stock__c =150;
    inv2.Closing_Stocks__c=150;
    inv2.Dispatch_Size__c=50;
    inv2.Owner_Account__c = user.id;
    inv2.Received_Stock__c = 0;
    inv2.Threshold__c=50;
    inv2.Used_Stock__c=0;
    inv2.type__c='PRODUCT COLLATERALS';
    inv2.product__c='XYZ';
    inv2.Color_Language_Size__c='zzzzz';
    inv2.product_description__c='Good';
    inv2.Item_Code__c='8888';
    //inv2.type__c='GIFT ITEMS';
     inv2.type_of_meet__c='Mini Meet';
    
    insert inv2;
    
     inventory__c inv4=new inventory__c();
    inv4.opening_stock__c =150;
    inv4.Closing_Stocks__c=150;
    inv4.Dispatch_Size__c=50;
    inv4.Owner_Account__c = user.id;
    inv4.Received_Stock__c = 0;
    inv4.Threshold__c=50;
    inv4.Used_Stock__c=0;
    inv4.type__c='PRODUCT COLLATERALS';
    inv4.product__c='XYZ';
    inv4.Color_Language_Size__c='zzzzz';
    inv4.product_description__c='Good';
    inv4.Item_Code__c='8888';
   // inv4.type__c='GIFT ITEMS';
     //inv4.type_of_meet__c='Mega Meet';
    
    insert inv4;
      inventory__c inv3=new inventory__c();
     inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    //inv3.type__c='ABC';
    inv3.product__c='XYZ';
    inv3.Color_Language_Size__c='zzzzz';
    inv3.product_description__c='Good';
    inv3.Item_Code__c='8888';
    inv3.type__c='PRODUCT COLLATERALS';
    
    insert inv3;
    
    
    
    Inventory_Request__c invreq1=new Inventory_Request__c();
    invreq1.Type_of_Item__c=inv1.id;
    invreq1.inventory_Sample__c=invSam.id;
    invreq1.inventory_Product__c=inv1.id;
    invreq1.inventory_PackMaterials__c=invPac.id;
    invreq1.Inventory_Request_Number__c=c1.id;
    invreq1.Request_Rasied_by__c=user.id;
    invreq1.Required_Quantity__c  =100;
    
    insert invreq1;
    
   Inventory_Request__c invreq2=new Inventory_Request__c();
    invreq2.Type_of_Item__c=inv2.id;
    invreq2.inventory_Sample__c=invSam.id;
    invreq2.inventory_Product__c=inv2.id;
    invreq2.inventory_PackMaterials__c=invPac.id;
    invreq2.Inventory_Request_Number__c=c1.id;
    invreq2.Request_Rasied_by__c=user.id;
        invreq2.Required_Quantity__c  =100;
    
    insert invreq2;
    
    Inventory_Request__c invreq4=new Inventory_Request__c();
    invreq4.Type_of_Item__c=inv4.id;
    invreq4.inventory_Sample__c=invSam.id;
    invreq4.inventory_Product__c=inv4.id;
    invreq4.inventory_PackMaterials__c=invPac.id;
    invreq4.Inventory_Request_Number__c=c1.id;
    invreq4.Request_Rasied_by__c=user.id;
        invreq4.Required_Quantity__c  =100;
   
    insert invreq4;
    
    Inventory_Request__c invreq3=new Inventory_Request__c();
    invreq3.Type_of_Item__c=inv3.id;
    invreq3.inventory_Sample__c=invSam.id;
    invreq3.inventory_Product__c=inv3.id;
    invreq3.inventory_PackMaterials__c=invPac.id;
    invreq3.Inventory_Request_Number__c=c1.id;
    invreq3.Request_Rasied_by__c=user.id;
   // invreq3.Required_Quantity__c  =100;
    insert invreq3;
    
     Inventory_gift_Request__c ingif1=new Inventory_gift_Request__c();
     
     ingif1.case__c=c1.id;
    ingif1.Request_Raised_by__c=user.id;
     ingif1.Required_Quantity__c  =100;
     ingif1.type_of_meet__c = 'Mini Meet';
     insert ingif1;
     
      Inventory_gift_Request__c ingif2=new Inventory_gift_Request__c();
     ingif2.case__c=c1.id;
    ingif2.Request_Raised_by__c=user.id;
     ingif2.Required_Quantity__c  =100;
     ingif2.type_of_meet__c = 'Mega Meet';
     insert ingif2;
     
    test.startTest();
    System.runAs(user)
    {  
    ApexPages.currentPage().getParameters().put('id', c1.id);    
       ApexPages.StandardController sc = new ApexPages.StandardController(c1);
       CtrlInventoryDetailPage ctrl= new CtrlInventoryDetailPage(sc);
             
       PageReference ref=ctrl.editDetails( );
       PageReference ref1=ctrl.Cancel();
        PageReference ref2=ctrl.getinventoryDetails();
       
       PageReference ref4=ctrl.saveDetails( );
       
       
    }
    test.stopTest();
 }
 
 static testMethod void InventoryDetailPagetest2(){
  
     Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= CaseRecordTypeInfo.get('Branding Request').getRecordTypeId(); 
     
    Case c1=new Case();
    c1.recordtypeId =i;
    c1.Shipping_Address__c='Elec,Bangalore';
    c1.Billing_Address__c='BTM,Bangalore';
    c1.Is_In_Approval_Process__c=true;
    c1.status='Auto Approved';
   // c1.depo__c=user.id;
    c1.head_office__c=user.id;
   // c1.team_lead__c=user.id;
    //c1.Request_Raised_By__c=user.id;
    c1.collateral_flows__c ='Depot';
    c1.origin ='User';
    insert c1;
    
    List<inventory__c> invlist= new List<inventory__c>();
    inventory__c inv1=new inventory__c();
    inv1.opening_stock__c =150;
    inv1.Closing_Stocks__c=150;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    //inv1.type__c='ABC';
    inv1.product__c='XYZ';
    inv1.Color_Language_Size__c='zzzzz';
    inv1.product_description__c='Good';
    inv1.Item_Code__c='8888';
    inv1.type__c='PRODUCT COLLATERALS';
    
    insert inv1;
    
   
      inventory__c invSam=new inventory__c();
    invSam.opening_stock__c =150;
    invSam.Closing_Stocks__c=150;
    invSam.Dispatch_Size__c=50;
    invSam.Owner_Account__c = user.id;
    invSam.Received_Stock__c = 0;
    invSam.Threshold__c=50;
    invSam.Used_Stock__c=0;
    invSam.type__c='SAMPLES';
    invSam.product__c='XYZ';
    invSam.Color_Language_Size__c='zzzzz';
    invSam.product_description__c='Good';
    invSam.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert invSam;
    
    inventory__c invPac=new inventory__c();
    invPac.opening_stock__c =150;
    invPac.Closing_Stocks__c=150;
    invPac.Dispatch_Size__c=50;
    invPac.Owner_Account__c = user.id;
    invPac.Received_Stock__c = 0;
    invPac.Threshold__c=50;
    invPac.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invPac.product__c='XYZ';
    invPac.Color_Language_Size__c='zzzzz';
    invPac.product_description__c='Good';
    invPac.Item_Code__c='8888';
    invPac.type__c='PACKING MATERIALS';
    
    insert invPac;
    
    
   
    
    
   inventory__c inv2=new inventory__c();
    inv2.opening_stock__c =150;
    inv2.Closing_Stocks__c=150;
    inv2.Dispatch_Size__c=50;
    inv2.Owner_Account__c = user.id;
    inv2.Received_Stock__c = 0;
    inv2.Threshold__c=50;
    inv2.Used_Stock__c=0;
    inv2.type__c='PRODUCT COLLATERALS';
    inv2.product__c='XYZ';
    inv2.Color_Language_Size__c='zzzzz';
    inv2.product_description__c='Good';
    inv2.Item_Code__c='8888';
    //inv2.type__c='GIFT ITEMS';
     inv2.type_of_meet__c='Mini Meet';
    
    insert inv2;
    
 
      inventory__c inv3=new inventory__c();
     inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    //inv3.type__c='ABC';
    inv3.product__c='XYZ';
    inv3.Color_Language_Size__c='zzzzz';
    inv3.product_description__c='Good';
    inv3.Item_Code__c='8888';
    inv3.type__c='PRODUCT COLLATERALS';
    
    insert inv3;
    
    
    
    Inventory_Request__c invreq1=new Inventory_Request__c();
    invreq1.Type_of_Item__c=inv1.id;
    invreq1.inventory_Sample__c=invSam.id;
    invreq1.inventory_Product__c=inv1.id;
    invreq1.inventory_PackMaterials__c=invPac.id;
    invreq1.Inventory_Request_Number__c=c1.id;
    invreq1.Request_Rasied_by__c=user.id;
    invreq1.Required_Quantity__c  =100;
    
    insert invreq1;
    
   Inventory_Request__c invreq2=new Inventory_Request__c();
    invreq2.Type_of_Item__c=inv2.id;
    invreq2.inventory_Sample__c=invSam.id;
    invreq2.inventory_Product__c=inv2.id;
    invreq2.inventory_PackMaterials__c=invPac.id;
    invreq2.Inventory_Request_Number__c=c1.id;
    invreq2.Request_Rasied_by__c=user.id;
        invreq2.Required_Quantity__c  =100;
    
    insert invreq2;
    
    Inventory_Request__c invreq4=new Inventory_Request__c();
    invreq4.Type_of_Item__c=inv3.id;
    invreq4.inventory_Sample__c=invSam.id;
    invreq4.inventory_Product__c=inv3.id;
    invreq4.inventory_PackMaterials__c=invPac.id;
    invreq4.Inventory_Request_Number__c=c1.id;
    invreq4.Request_Rasied_by__c=user.id;
        invreq4.Required_Quantity__c  =100;
   
    insert invreq4;
    
    /*Inventory_Request__c invreq3=new Inventory_Request__c();
    invreq3.Type_of_Item__c=inv1.id;
    invreq3.inventory_Sample__c=inv1.id;
    invreq3.inventory_Product__c=inv1.id;
    invreq3.inventory_PackMaterials__c=inv1.id;
    invreq3.Inventory_Request_Number__c=c1.id;
    invreq3.Request_Rasied_by__c=user.id;
    invreq3.Required_Quantity__c  =100;
    insert invreq3;
    */
     Inventory_gift_Request__c ingif1=new Inventory_gift_Request__c();
     
     ingif1.case__c=c1.id;
    ingif1.Request_Raised_by__c=user.id;
     ingif1.Required_Quantity__c  =100;
     ingif1.type_of_meet__c = 'Mini Meet';
     insert ingif1;
     
     /* Inventory_gift_Request__c ingif2=new Inventory_gift_Request__c();
     ingif2.case__c=c1.id;
    ingif2.Request_Raised_by__c=user.id;
     ingif2.Required_Quantity__c  =100;
     ingif2.type_of_meet__c = 'Mega Meet';
     insert ingif2;*/
     
    test.startTest();
    System.runAs(user)
    {  
    ApexPages.currentPage().getParameters().put('id', c1.id);    
       ApexPages.StandardController sc = new ApexPages.StandardController(c1);
       CtrlInventoryDetailPage ctrl= new CtrlInventoryDetailPage(sc);
             
       PageReference ref=ctrl.editDetails( );
       PageReference ref1=ctrl.Cancel();
        PageReference ref2=ctrl.getinventoryDetails();
       
       PageReference ref4=ctrl.saveDetails( );
       
       
    }
    test.stopTest();
 }
 
static testMethod void InventoryDetailPagetest3(){
  
     Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= CaseRecordTypeInfo.get('Branding Request').getRecordTypeId(); 
     
    Case c1=new Case();
    c1.recordtypeId =i;
    c1.Shipping_Address__c='Elec,Bangalore';
    c1.Billing_Address__c='BTM,Bangalore';
    c1.Is_In_Approval_Process__c=false;
    c1.status='New';
    c1.depo__c=user.id;
    c1.head_office__c=user.id;
    c1.team_lead__c=user.id;
    c1.Request_Raised_By__c=user.id;
    c1.collateral_flows__c ='Requestor';
    insert c1;
    
    List<inventory__c> invlist= new List<inventory__c>();
    inventory__c inv1=new inventory__c();
    inv1.opening_stock__c =150;
    inv1.Closing_Stocks__c=150;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    inv1.type__c='PRODUCT COLLATERALS';
    inv1.product__c='XYZ';
    inv1.Color_Language_Size__c='zzzzz';
    inv1.product_description__c='Good';
    inv1.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert inv1;
    
   
    inventory__c invSam=new inventory__c();
    invSam.opening_stock__c =150;
    invSam.Closing_Stocks__c=150;
    invSam.Dispatch_Size__c=50;
    invSam.Owner_Account__c = user.id;
    invSam.Received_Stock__c = 0;
    invSam.Threshold__c=50;
    invSam.Used_Stock__c=0;
    invSam.type__c='SAMPLES';
    invSam.product__c='XYZ';
    invSam.Color_Language_Size__c='zzzzz';
    invSam.product_description__c='Good';
    invSam.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert invSam;
    
   inventory__c invPac=new inventory__c();
    invPac.opening_stock__c =150;
    invPac.Closing_Stocks__c=150;
    invPac.Dispatch_Size__c=50;
    invPac.Owner_Account__c = user.id;
    invPac.Received_Stock__c = 0;
    invPac.Threshold__c=50;
    invPac.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invPac.product__c='XYZ';
    invPac.Color_Language_Size__c='zzzzz';
    invPac.product_description__c='Good';
    invPac.Item_Code__c='8888';
    invPac.type__c='PACKING MATERIALS';
    
    insert invPac;
    
    
    
   inventory__c inv2=new inventory__c();
    inv2.opening_stock__c =150;
    inv2.Closing_Stocks__c=150;
    inv2.Dispatch_Size__c=50;
    inv2.Owner_Account__c = user.id;
    inv2.Received_Stock__c = 0;
    inv2.Threshold__c=50;
    inv2.Used_Stock__c=0;
    //inv2.type__c='ABC';
    inv2.product__c='XYZ';
    inv2.Color_Language_Size__c='zzzzz';
    inv2.product_description__c='Good';
    inv2.Item_Code__c='8888';
    inv2.type__c='PRODUCT COLLATERALS';
     inv2.type_of_meet__c='Mini Meet';
    
    insert inv2;
    
 
      inventory__c inv3=new inventory__c();
     inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    //inv3.type__c='ABC';
    inv3.product__c='XYZ';
    inv3.Color_Language_Size__c='zzzzz';
    inv3.product_description__c='Good';
    inv3.Item_Code__c='8888';
    inv3.type__c='PRODUCT COLLATERALS';
    
    insert inv3;
    
    
    
    Inventory_Request__c invreq1=new Inventory_Request__c();
    invreq1.Type_of_Item__c=inv1.id;
    invreq1.inventory_Sample__c=invSam.id;
    invreq1.inventory_Product__c=inv1.id;
    invreq1.inventory_PackMaterials__c=invPac.id;
    invreq1.Inventory_Request_Number__c=c1.id;
    invreq1.Request_Rasied_by__c=user.id;
    invreq1.Required_Quantity__c  =100;
    
    insert invreq1;
    
   Inventory_Request__c invreq2=new Inventory_Request__c();
    invreq2.Type_of_Item__c=inv2.id;
    invreq2.inventory_Sample__c=invSam.id;
    invreq2.inventory_Product__c=inv2.id;
    invreq2.inventory_PackMaterials__c=invPac.id;
    invreq2.Inventory_Request_Number__c=c1.id;
    invreq2.Request_Rasied_by__c=user.id;
        invreq2.Required_Quantity__c  =100;
    
    insert invreq2;
    
    Inventory_Request__c invreq4=new Inventory_Request__c();
    invreq4.Type_of_Item__c=inv3.id;
    invreq4.inventory_Sample__c=invSam.id;
    invreq4.inventory_Product__c=inv3.id;
    invreq4.inventory_PackMaterials__c=invPac.id;
    invreq4.Inventory_Request_Number__c=c1.id;
    invreq4.Request_Rasied_by__c=user.id;
        invreq4.Required_Quantity__c  =100;
   
    insert invreq4;
    
  
     Inventory_gift_Request__c ingif1=new Inventory_gift_Request__c();
     
     ingif1.case__c=c1.id;
    ingif1.Request_Raised_by__c=user.id;
     ingif1.Required_Quantity__c  =100;
     ingif1.type_of_meet__c = 'Mega Meet';
     insert ingif1;
     
    
     
    test.startTest();
    System.runAs(user)
    {  
    ApexPages.currentPage().getParameters().put('id', c1.id);    
       ApexPages.StandardController sc = new ApexPages.StandardController(c1);
       CtrlInventoryDetailPage ctrl= new CtrlInventoryDetailPage(sc);
             
       PageReference ref=ctrl.editDetails( );
       PageReference ref1=ctrl.Cancel();
        PageReference ref2=ctrl.getinventoryDetails();
       
       PageReference ref4=ctrl.saveDetails( );
       
       
    }
    test.stopTest();
 }
 
 
 static testMethod void InventoryDetailPagetest4(){
  
     Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    Id i= CaseRecordTypeInfo.get('Branding Request').getRecordTypeId(); 
     
    Case c1=new Case();
    c1.recordtypeId =i;
    c1.Shipping_Address__c='Elec,Bangalore';
    c1.Billing_Address__c='BTM,Bangalore';
    c1.Is_In_Approval_Process__c=false;
    c1.status='New';
    c1.depo__c=user.id;
    c1.head_office__c=user.id;
    c1.team_lead__c=user.id;
    c1.Request_Raised_By__c=user.id;
    c1.collateral_flows__c ='Requestor';
    insert c1;
    
    List<inventory__c> invlist= new List<inventory__c>();
    inventory__c inv1=new inventory__c();
    inv1.opening_stock__c =150;
    inv1.Closing_Stocks__c=150;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    inv1.product__c='XYZ';
    inv1.Color_Language_Size__c='zzzzz';
    inv1.product_description__c='Good';
    inv1.Item_Code__c='8888';
    inv1.type__c='PRODUCT COLLATERALS';
    
    insert inv1;
    
    inventory__c invSam=new inventory__c();
    invSam.opening_stock__c =150;
    invSam.Closing_Stocks__c=150;
    invSam.Dispatch_Size__c=50;
    invSam.Owner_Account__c = user.id;
    invSam.Received_Stock__c = 0;
    invSam.Threshold__c=50;
    invSam.Used_Stock__c=0;
    invSam.type__c='SAMPLES';
    invSam.product__c='XYZ';
    invSam.Color_Language_Size__c='zzzzz';
    invSam.product_description__c='Good';
    invSam.Item_Code__c='8888';
    //inv1.type__c='PACKING MATERIALS';
    
    insert invSam;
    
    inventory__c invPac=new inventory__c();
    invPac.opening_stock__c =150;
    invPac.Closing_Stocks__c=150;
    invPac.Dispatch_Size__c=50;
    invPac.Owner_Account__c = user.id;
    invPac.Received_Stock__c = 0;
    invPac.Threshold__c=50;
    invPac.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invPac.product__c='XYZ';
    invPac.Color_Language_Size__c='zzzzz';
    invPac.product_description__c='Good';
    invPac.Item_Code__c='8888';
    invPac.type__c='PACKING MATERIALS';
    
    insert invPac;
    
    inventory__c invmega=new inventory__c();
    invmega.opening_stock__c =150;
    invmega.Closing_Stocks__c=150;
    invmega.Dispatch_Size__c=50;
    invmega.Owner_Account__c = user.id;
    invmega.Received_Stock__c = 0;
    invmega.Threshold__c=50;
    invmega.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invmega.product__c='XYZ';
    invmega.Color_Language_Size__c='zzzzz';
    invmega.product_description__c='Good';
    invmega.Item_Code__c='8888';
    invmega.type__c='GIFT ITEMS';
    invmega.type_of_meet__c='Mega Meet';
    insert invmega;
   
    inventory__c invmini=new inventory__c();
    invmini.opening_stock__c =150;
    invmini.Closing_Stocks__c=150;
    invmini.Dispatch_Size__c=50;
    invmini.Owner_Account__c = user.id;
    invmini.Received_Stock__c = 0;
    invmini.Threshold__c=50;
    invmini.Used_Stock__c=0;
   // invSam.type__c='SAMPLES';
    invmini.product__c='XYZ';
    invmini.Color_Language_Size__c='zzzzz';
    invmini.product_description__c='Good';
    invmini.Item_Code__c='8888';
    invmini.type__c='GIFT ITEMS';
    invmini.type_of_meet__c='Mini Meet';
    insert invmini;
    
    
   inventory__c inv2=new inventory__c();
    inv2.opening_stock__c =150;
    inv2.Closing_Stocks__c=150;
    inv2.Dispatch_Size__c=50;
    inv2.Owner_Account__c = user.id;
    inv2.Received_Stock__c = 0;
    inv2.Threshold__c=50;
    inv2.Used_Stock__c=0;
    inv2.product__c='XYZ';
    inv2.Color_Language_Size__c='zzzzz';
    inv2.product_description__c='Good';
    inv2.Item_Code__c='8888';
    inv2.type__c='PRODUCT COLLATERALS';
     inv2.type_of_meet__c='Mini Meet';
    
    insert inv2;
    
    inventory__c inv21=new inventory__c();
    inv21.opening_stock__c =150;
    inv21.Closing_Stocks__c=150;
    inv21.Dispatch_Size__c=50;
    inv21.Owner_Account__c = user.id;
    inv21.Received_Stock__c = 0;
    inv21.Threshold__c=50;
    inv21.Used_Stock__c=0;
    inv21.product__c='XYZ';
    inv21.Color_Language_Size__c='zzzzz';
    inv21.product_description__c='Good';
    inv21.Item_Code__c='8888';
    inv21.type__c='PRODUCT COLLATERALS';
     inv21.type_of_meet__c='Mini Meet';
    
    insert inv21;
 
   inventory__c inv211=new inventory__c();
    inv211.opening_stock__c =150;
    inv211.Closing_Stocks__c=150;
    inv211.Dispatch_Size__c=50;
    inv211.Owner_Account__c = user.id;
    inv211.Received_Stock__c = 0;
    inv211.Threshold__c=50;
    inv211.Used_Stock__c=0;
    inv211.product__c='XYZ';
    inv211.Color_Language_Size__c='zzzzz';
    inv211.product_description__c='Good';
    inv211.Item_Code__c='8888';
    inv211.type__c='PRODUCT COLLATERALS';
     inv211.type_of_meet__c='Mega Meet';
    
    insert inv211;
 
 inventory__c inv2112=new inventory__c();
    inv2112.opening_stock__c =150;
    inv2112.Closing_Stocks__c=150;
    inv2112.Dispatch_Size__c=50;
    inv2112.Owner_Account__c = user.id;
    inv2112.Received_Stock__c = 0;
    inv2112.Threshold__c=50;
    inv2112.Used_Stock__c=0;
    inv2112.product__c='XYZ';
    inv2112.Color_Language_Size__c='zzzzz';
    inv2112.product_description__c='Good';
    inv2112.Item_Code__c='8888';
    inv2112.type__c='PRODUCT COLLATERALS';
     inv2112.type_of_meet__c='Mega Meet';
    
    insert inv2112;
    
      inventory__c inv3=new inventory__c();
     inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    //inv3.type__c='ABC';
    inv3.product__c='XYZ';
    inv3.Color_Language_Size__c='zzzzz';
    inv3.product_description__c='Good';
    inv3.Item_Code__c='8888';
    inv3.type__c='PRODUCT COLLATERALS';
    
    insert inv3;
    
    
    
    Inventory_Request__c invreq1=new Inventory_Request__c();
    invreq1.Type_of_Item__c=inv1.id;
    invreq1.inventory_Sample__c=invSam.id;
    invreq1.inventory_Product__c=inv1.id;
    invreq1.inventory_PackMaterials__c=invPac.id;
    invreq1.Inventory_Request_Number__c=c1.id;
    invreq1.Request_Rasied_by__c=user.id;
    invreq1.Required_Quantity__c  =100;
    
    insert invreq1;
    
   Inventory_Request__c invreq2=new Inventory_Request__c();
    invreq2.Type_of_Item__c=inv2.id;
    invreq2.inventory_Sample__c=invSam.id;
    invreq2.inventory_Product__c=inv2.id;
    invreq2.inventory_PackMaterials__c=invPac.id;
    invreq2.Inventory_Request_Number__c=c1.id;
    invreq2.Request_Rasied_by__c=user.id;
        invreq2.Required_Quantity__c  =100;
    
    insert invreq2;
    
    Inventory_Request__c invreq4=new Inventory_Request__c();
    invreq4.Type_of_Item__c=inv3.id;
    invreq4.inventory_mini__c=invmini.id;
     invreq4.inventory_mega__c=invmega.id;
    invreq4.inventory_Sample__c=invSam.id;
    invreq4.inventory_Product__c=inv3.id;
    invreq4.inventory_PackMaterials__c=invPac.id;
    invreq4.Inventory_Request_Number__c=c1.id;
    invreq4.Request_Rasied_by__c=user.id;
        invreq4.Required_Quantity__c  =100;
   
    insert invreq4;
    
    Inventory_Request__c invreq3=new Inventory_Request__c();
    invreq3.Type_of_Item__c=inv2112.id;
     invreq3.inventory_mini__c=invmini.id;
     invreq3.inventory_mega__c=invmega.id;
    invreq3.inventory_Sample__c=invSam.id;
    invreq3.inventory_Product__c=inv2112.id;
    invreq3.inventory_PackMaterials__c=invPac.id;
    invreq3.Inventory_Request_Number__c=c1.id;
    invreq3.Request_Rasied_by__c=user.id;
    invreq3.Required_Quantity__c  =100;
    insert invreq3;
    
    Inventory_Request__c invreq33=new Inventory_Request__c();
    invreq33.Type_of_Item__c=inv211.id;
     invreq33.inventory_mini__c=invmini.id;
     invreq33.inventory_mega__c=invmega.id;
    invreq33.inventory_Sample__c=invSam.id;
    invreq33.inventory_Product__c=inv211.id;
    invreq33.inventory_PackMaterials__c=invPac.id;
    invreq33.Inventory_Request_Number__c=c1.id;
    invreq33.Request_Rasied_by__c=user.id;
    invreq33.Required_Quantity__c  =100;
    insert invreq33;
    
     Inventory_Request__c invreq34=new Inventory_Request__c();
    invreq34.Type_of_Item__c=inv21.id;
    invreq34.inventory_Sample__c=invSam.id;
    invreq34.inventory_Product__c=inv21.id;
     invreq34.inventory_mini__c=invmini.id;
     invreq34.inventory_mega__c=invmega.id;
    invreq34.inventory_PackMaterials__c=invPac.id;
    invreq34.Inventory_Request_Number__c=c1.id;
    invreq34.Request_Rasied_by__c=user.id;
    invreq34.Required_Quantity__c  =100;
    insert invreq34;
    
    
    
    
     Inventory_gift_Request__c ingif1=new Inventory_gift_Request__c();
     
     ingif1.case__c=c1.id;
    ingif1.Request_Raised_by__c=user.id;
     ingif1.Required_Quantity__c  =100;
     ingif1.type_of_meet__c = 'Mega Meet';
     insert ingif1;
     
     /* Inventory_gift_Request__c ingif2=new Inventory_gift_Request__c();
     ingif2.case__c=c1.id;
    ingif2.Request_Raised_by__c=user.id;
     ingif2.Required_Quantity__c  =100;
     ingif2.type_of_meet__c = 'Mega Meet';
     insert ingif2;*/
     
    test.startTest();
    System.runAs(user)
    {  
    ApexPages.currentPage().getParameters().put('id', c1.id);    
       ApexPages.StandardController sc = new ApexPages.StandardController(c1);
       CtrlInventoryDetailPage ctrl= new CtrlInventoryDetailPage(sc);
             
       PageReference ref=ctrl.editDetails( );
       PageReference ref1=ctrl.Cancel();
        PageReference ref2=ctrl.getinventoryDetails();
       
       PageReference ref4=ctrl.saveDetails( );
       
       
    }
    test.stopTest();
 }
}