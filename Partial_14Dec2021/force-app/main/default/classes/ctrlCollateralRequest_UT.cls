/*  
 * Modified By: Renjay Surendran
 */ 
@isTest
public class ctrlCollateralRequest_UT{

static testmethod void ctrlCollateralRequestTest(){
    List<inventory__c> inv=new List<inventory__c>();
    List<Inventory_request__c> invreq= new List<Inventory_request__c>();
    
    Profile profileID = [select id from profile where Name='System Administrator' limit 1];
    
    User user2 = new User(LastName='AXYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
       Email='vasanthi_KN@infosys.com',UserName='vasanthi555@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US'
        );
     
    insert user2;
    
    User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
       Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN555@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US',
        Team_lead__c=user2.id, depo__c=user2.id);
     
    insert user1;
 
system.runas(user1){
    
    test.starttest();
    Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
    Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
    
    Id i= AccountRecordTypeInfo.get('Auto Dispatch').getRecordTypeId();
    
    Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false,
    Team_Lead__c =user2.id, depo__c= user2.id );
    insert caset;
    
    inventory__c testinv1 = new Inventory__c();
    testinv1.name ='captest';
    testinv1.opening_stock__c =100;
    testinv1.Closing_Stocks__c=100;
    testinv1.Dispatch_Size__c=50;
    testinv1.Owner_Account__c = user1.id;
    testinv1.Received_Stock__c = 0;
    testinv1.Threshold__c=50;
    testinv1.Used_Stock__c=0;
    testinv1.type__c='PRODUCT COLLATERALS';
    inv.add(testinv1);
    
    inventory__c testinv2 = new Inventory__c();
    testinv2.name ='captest';
    testinv2.opening_stock__c =100;
    testinv2.Closing_Stocks__c=100;
    testinv2.Dispatch_Size__c=50;
    testinv2.Owner_Account__c = user1.id;
    testinv2.Received_Stock__c = 0;
    testinv2.Threshold__c=50;
    testinv2.Used_Stock__c=0;
    testinv2.type__c='GIFT ITEMS';
    testinv2.type_of_meet__c='Mega Meet';
    inv.add(testinv2);
    
    inventory__c testinv3 = new Inventory__c();
    testinv3.name ='captest';
    testinv3.opening_stock__c =100;
    testinv3.Closing_Stocks__c=100;
    testinv3.Dispatch_Size__c=50;
    testinv3.Owner_Account__c = user1.id;
    testinv3.Received_Stock__c = 0;
    testinv3.Threshold__c=50;
    testinv3.type__c='GIFT ITEMS';
    testinv3.type_of_meet__c='Mini Meet';
    inv.add(testinv3);
    
    inventory__c testinv4 = new Inventory__c();
    testinv4.name ='captest';
    testinv4.opening_stock__c =100;
    testinv4.Closing_Stocks__c=100;
    testinv4.Dispatch_Size__c=50;
    testinv4.Owner_Account__c = user1.id;
    testinv4.Received_Stock__c = 0;
    testinv4.Threshold__c=50;
    testinv4.Used_Stock__c=0;
    testinv4.type__c='PACKING MATERIALS';
    inv.add(testinv4);
    
    inventory__c testinv5 = new Inventory__c();
    testinv5.name ='captest';
    testinv5.opening_stock__c =100;
    testinv5.Closing_Stocks__c=100;
    testinv5.Dispatch_Size__c=50;
    testinv5.Owner_Account__c = user1.id;
    testinv5.Received_Stock__c = 0;
    testinv5.Threshold__c=50;
    testinv5.Used_Stock__c=0;
    testinv5.type__c='SAMPLES';
    inv.add(testinv5);
    
    insert inv;
    
    Inventory_request__c inv1 = new Inventory_request__c();
    inv1.Inventory_Request_Number__c = caset.id;
    inv1.Request_Rasied_by__c =user1.id;
    inv1.Type_of_Item__c = testinv1.id;
    inv1.Required_Quantity__c=50;
    inv1.Comments_Remarks__c='Testing';
    invreq.add(inv1);
    
    Inventory_request__c inv2 = new Inventory_request__c();
    inv2.Inventory_Request_Number__c = caset.id;
    inv2.Request_Rasied_by__c =user1.id;
    inv2.Type_of_Item__c = testinv2.id;
    inv2.Required_Quantity__c=50;
    inv2.Comments_Remarks__c='Testing';
    invreq.add(inv2);
    
    Inventory_request__c inv3 = new Inventory_request__c();
    inv3.Inventory_Request_Number__c = caset.id;
    inv3.Request_Rasied_by__c =user1.id;
    inv3.Type_of_Item__c = testinv3.id;
    inv3.Required_Quantity__c=50;
    inv3.Comments_Remarks__c='Testing';
    invreq.add(inv3);
    
    Inventory_request__c inv4 = new Inventory_request__c();
    inv4.Inventory_Request_Number__c = caset.id;
    inv4.Request_Rasied_by__c =user1.id;
    inv4.Type_of_Item__c = testinv4.id;
    inv4.Required_Quantity__c=50;
    inv4.Comments_Remarks__c='Testing';
    invreq.add(inv4);
    
    Inventory_request__c inv5 = new Inventory_request__c();
    inv5.Inventory_Request_Number__c = caset.id;
    inv5.Request_Rasied_by__c =user1.id;
    inv5.Type_of_Item__c = testinv5.id;
    inv5.Required_Quantity__c=50;
    inv5.Comments_Remarks__c='Testing';
    invreq.add(inv5);
    
    insert invreq;
    
    PageReference pRef = Page.CollateralRequestDetails;
    pRef.getParameters().put('id',caset.Id);
    Test.setCurrentPage(pRef);     
    ctrlCollateralRequest controller=new ctrlCollateralRequest(new ApexPages.StandardController(caset));
    controller.currentCase=caset;

    controller.existinginvReqList=invreq;    
    controller.flagVar=true;
    test.stoptest();
    }
    
  }
 }