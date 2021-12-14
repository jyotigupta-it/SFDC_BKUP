/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class ctrlAutoDispatchRequest_Test{

 static testMethod void validateAutoDispatch(){
    
    Profile profile1= [Select Id from Profile where name='System Administrator' limit 1];
    Profile profile2= [Select Id from Profile where name='BD' limit 1];
    User user= new User( FirstName='Test',Street='asd',city='aas',state='Karnataka',PostalCode='560100',country='India', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile1.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    User user2 = new User(LastName='XYZ1u23x',ProfileId=profile2.Id,Alias='test',EmailEncodingKey='UTF-8',
                Email='vasanthi_KN@infosys.com',UserName='vasanthixxx@infosys.com',
                User_State__c ='Karnataka',Depo__c=user.id,TimeZoneSidKey='America/New_York',
                LocaleSidKey='en_US',LanguageLocaleKey='en_US');
    insert user2;
    
    Id auto=[select id from RecordType where Name ='Auto Dispatch'].id;
    Case casej= new Case(recordtypeId = auto, Request_Raised_By__c = user.id,
                    status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false, Request_User__c=user2.id); 
    
    Schema.DescribeSObjectResult cfrSchemaa = Schema.SObjectType.Account; 
    Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfoa = cfrSchemaa.getRecordTypeInfosByName();
    Id ii= AccountRecordTypeInfoa.get('Distributor').getRecordTypeId();                
    Account acc=new Account(recordtypeid =ii,BillingCity='asd',BillingCountry='India',BillingPostalCode='560100',BillingState='Karnataka',BillingStreet='123',name ='testAccount', Primary_Contact_Person_Name__c='Test',market__c='Prospect',
        classification__c='C',district__c='Mysore',Purchase_Cycle__c='Monthly', status__c='Cold Call', Conversion_Probability__c='Low', Description='abcd',
        state__c='Goa',ShippingCity='asd',ShippingCountry='India',ShippingPostalCode='560100',ShippingState='Karnataka',ShippingStreet='123',ownerid = user.id,Street_Address__c='xyzx', Products__c='SWR', 
        Contact_Number_Phone__c='9114508449', Contact_Number_Mobile__c='9114508449',Media__c='In Shop', No_of_Salesmen__c=1, No_of_Vehicles__c=2, Approx_Size_of_shop_in_Sq_ft__c=10, Display_of_our_product__c='Prominent'
         );  
    
    List<CollateralWrapper> wrapperL= new List<CollateralWrapper>();
    
    Case c1=new Case();
    c1.recordtypeId =auto;
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
    inv1.type__c='PACKING MATERIALS'; 
    insert inv1;
    
    
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
    inv2.type__c='SAMPLES';
    insert inv2;
    
    inventory__c inv3=new inventory__c();
    inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    inv3.product__c='XYZ';
    inv3.Color_Language_Size__c='zzzzz';
    inv3.product_description__c='Good';
    inv3.Item_Code__c='8888';
    inv3.type__c='PRODUCT COLLATERALS';
    insert inv3;
    
    inventory__c inv4=new inventory__c();
    inv4.opening_stock__c =150;
    inv4.Closing_Stocks__c=150;
    inv4.Dispatch_Size__c=50;
    inv4.Owner_Account__c = user.id;
    inv4.Received_Stock__c = 0;
    inv4.Threshold__c=50;
    inv4.Used_Stock__c=0;
    inv4.product__c='XYZ';
    inv4.Color_Language_Size__c='zzzzz';
    inv4.product_description__c='Good';
    inv4.Item_Code__c='8888';
    inv4.type__c='GIFT ITEMS';
    inv4.type_of_meet__c='Mega Meet'; 
    insert inv4;
    
    Inventory_Request__c invreq1=new Inventory_Request__c();
    invreq1.Type_of_Item__c=inv1.id;
    //invreq1.inventory_Sample__c=inv1.id;
    //invreq1.inventory_Product__c=inv1.id;
    invreq1.inventory_PackMaterials__c=inv1.id;
    invreq1.Inventory_Request_Number__c=c1.id;
    invreq1.Request_Rasied_by__c=user.id;
    invreq1.Required_Quantity__c  =100;
    insert invreq1;
    CollateralWrapper a1=new CollateralWrapper();
    a1.invRequest=invreq1;
    wrapperL.add(a1);
    
    Inventory_Request__c invreq2=new Inventory_Request__c();
    invreq2.Type_of_Item__c=inv2.id;
    invreq2.inventory_Sample__c=inv2.id;
    //invreq2.inventory_Product__c=inv2.id;
    //invreq2.inventory_PackMaterials__c=inv2.id;
    invreq2.Inventory_Request_Number__c=c1.id;
    invreq2.Request_Rasied_by__c=user.id;
    invreq2.Required_Quantity__c  =100;
    insert invreq2;
    CollateralWrapper a2=new CollateralWrapper();
    a2.invRequest=invreq2;
    wrapperL.add(a2);
    
    Inventory_Request__c invreq3=new Inventory_Request__c();
    invreq3.Type_of_Item__c=inv3.id;
    //invreq3.inventory_Sample__c=inv3.id;
    invreq3.inventory_Product__c=inv3.id;
    //invreq3.inventory_PackMaterials__c=inv3.id;
    invreq3.Inventory_Request_Number__c=c1.id;
    invreq3.Request_Rasied_by__c=user.id;
    invreq3.Required_Quantity__c  =100;
    insert invreq3;
    CollateralWrapper a3=new CollateralWrapper();
    a3.invRequest=invreq3;
    wrapperL.add(a3);
    
    Inventory_Request__c invreq4=new Inventory_Request__c();
    invreq4.Type_of_Item__c=inv4.id;
    //invreq4.inventory_Sample__c=inv4.id;
    invreq4.inventory_mega__c=inv4.id;
   // invreq4.inventory_Product__c=inv4.id;
    //invreq4.inventory_PackMaterials__c=inv4.id;
    invreq4.Inventory_Request_Number__c=c1.id;
    invreq4.Request_Rasied_by__c=user.id;
    invreq4.Required_Quantity__c  =100;
    insert invreq4;
    CollateralWrapper a4=new CollateralWrapper();
    a4.invRequest=invreq4;
    wrapperL.add(a4);
    
    Inventory_Request__c invreq5=new Inventory_Request__c();
    invreq5.Type_of_Item__c=inv4.id;
    invreq5.inventory_Sample__c=inv4.id;
    invreq5.inventory_mini__c=inv4.id;
    invreq5.inventory_Product__c=inv4.id;
    invreq5.inventory_PackMaterials__c=inv4.id;
    invreq5.Inventory_Request_Number__c=c1.id;
    invreq5.Request_Rasied_by__c=user.id;
    invreq5.Required_Quantity__c  =100;
   // insert invreq5;
    CollateralWrapper a5=new CollateralWrapper();
    a5.invRequest=invreq5;
    wrapperL.add(a5);
    
    inventory__c testinv = new Inventory__c();
    //testinv.name ='captest';
    testinv.opening_stock__c =100;
    testinv.Closing_Stocks__c=100;
    testinv.Dispatch_Size__c=50;
    testinv.Owner_Account__c = user.id;
    testinv.Received_Stock__c = 0;
    testinv.Threshold__c=50;
    testinv.Used_Stock__c=0;
    
    
    inventory__c testinv2 = new Inventory__c();
    //testinv2.name ='captest';
    testinv2.opening_stock__c =100;
    testinv2.Closing_Stocks__c=1000;
    testinv2.Dispatch_Size__c=50;
    testinv2.Owner_Account__c = user.id;
    testinv2.Received_Stock__c = 0;
    testinv2.Threshold__c=50;
    testinv2.Used_Stock__c=0;
        
    
    Inventory_request__c inv = new Inventory_request__c();
    
    inv.Request_Rasied_by__c = user.id;
    inv.Required_Quantity__c=50;
    inv.Quantity_Dispatched__c=50;
    inv.Comments_Remarks__c='Testing';
    system.debug('####'+inv);
    
    Inventory_request__c inv11 = new Inventory_request__c();
    
    
    inv11.Request_Rasied_by__c = user.id;
    inv11.Required_Quantity__c=50;
    inv11.Quantity_Dispatched__c=50;
    inv11.Comments_Remarks__c='Testing';
    
    test.startTest();
    System.runAs(user)
    { 
    insert casej;
    insert testinv;
    insert testinv2;
    insert acc;
    Case casek=new Case(); 
    ctrlAutoDispatchRequest pdd = new ctrlAutoDispatchRequest(new ApexPages.StandardController(casek));
    pdd.giftList=new List<CollateralWrapper>();
    pdd.gifReq=new List<inventory_Gift_request__c>();
    pdd.productCollList=wrapperL;
    pdd.giftListMega=wrapperL;
    pdd.giftListMini=wrapperL;
    pdd.sampleList=wrapperL;
    pdd.packMaterialList=wrapperL;
    PageReference page = pdd.Cancel();
    pdd.currentCase=casek;
    pdd.currentCase.Request_Raised_by__c=user.id;
    pdd.currentCase.Request_User__c=user2.id;
    inv.Inventory_Request_Number__c = casej.id;
    inv.Type_of_Item__c = testinv.id;
    //insert inv;
    inv11.Inventory_Request_Number__c = casej.id;
    inv11.Type_of_Item__c = testinv2.id;
    //insert inv1;
    pdd.invReqList.add(inv);
    pdd.invReqList.add(inv11);
    pdd.flag=true;
    page=pdd.saveDetails();
    page=pdd.getinventoryDetails();
    page=pdd.saveDetails();
    
    inventory__c test=pdd.queryInventory(testinv.id);
    pdd.disabled='Account';
    boolean a=pdd.getIsAccount();
    pdd.currentCase.Request_Account__c=acc.id;
    pdd.currentCase.Request_user__c=user2.id;
    pdd.getShipping();
    
    pdd.disabled='User';
    boolean b=pdd.getIsUser();
    pdd.getShipping();
    
    page=pdd.test();
    
   }    
    test.stopTest();  
    }


}