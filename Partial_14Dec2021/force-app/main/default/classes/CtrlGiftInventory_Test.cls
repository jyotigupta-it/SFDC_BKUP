/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class CtrlGiftInventory_Test{

 static testMethod void validateCtrlGiftInventory(){
    
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
    
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    inventory__c testinv = new Inventory__c();
    testinv.Type__c='Gifts';
    testinv.Type_Of_Meet__c='Mini Meet';
    testinv.Item_Code__c='12345';
    testinv.Product__c='CORPORATE';
    testinv.Product_Description__c='TORCHE_EVEREADY';
    testinv.Color_Language_Size__c='YELLOW';
    testinv.opening_stock__c =100;
    testinv.Closing_Stocks__c=100;
    testinv.Dispatch_Size__c=50;
    testinv.Owner_Account__c = user.id;
    testinv.Received_Stock__c = 0;
    testinv.Threshold__c=50;
    testinv.Used_Stock__c=0;
    
    insert testinv;
    
    inventory__c testinv1 = new Inventory__c();
    testinv1.Type__c='Gifts';
    testinv1.Type_Of_Meet__c='Mega Meet';
    testinv1.Item_Code__c='12345';
    testinv1.Product__c='CORPORATE';
    testinv1.Product_Description__c='TORCHE_EVEREADY';
    testinv1.Color_Language_Size__c='YELLOW';
    testinv1.opening_stock__c =100;
    testinv1.Closing_Stocks__c=100;
    testinv1.Dispatch_Size__c=50;
    testinv1.Owner_Account__c = user.id;
    testinv1.Received_Stock__c = 0;
    testinv1.Threshold__c=50;
    testinv1.Used_Stock__c=0;
    
    insert testinv1;
    
    inventory__c testinv2 = new Inventory__c();
    testinv2.Type__c='Package Materials';
    testinv2.Item_Code__c='12345';
    testinv2.Product__c='AQUALIFE';
    testinv2.Product_Description__c='FLEX BOARD 8 x 4';
    testinv2.Color_Language_Size__c='TAMIL';
    testinv2.IsCSO_User__c=true;
    testinv2.opening_stock__c =100;
    testinv2.Closing_Stocks__c=100;
    testinv2.Dispatch_Size__c=50;
    testinv2.Owner_Account__c = user.id;
    testinv2.Received_Stock__c = 0;
    testinv2.Threshold__c=50;
    testinv2.Used_Stock__c=0;
    
    insert testinv2;
    
    Case case1= new Case(recordtypeId = Rt.id, Metro_Non_Metro__c=System.Label.Branding_Request_Non_Metro, Request_Raised_By__c = user.id,
            status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false, Head_Office__c=user.id);
            
    insert case1;
    
    Inventory_request__c inv1 = new Inventory_request__c();
    inv1.Inventory_Request_Number__c = case1.id;
    inv1.Request_Rasied_by__c =user.id;
    inv1.Type_of_Item__c = testinv2.id;
    inv1.Required_Quantity__c=50;
    inv1.Comments_Remarks__c='Testing';
    
    Insert inv1;
    
    Inventory_request__c inv2 = new Inventory_request__c();
    inv2.Inventory_Request_Number__c = case1.id;
    inv2.Request_Rasied_by__c =user.id;
    inv2.Type_of_Item__c = testinv1.id;
    inv2.Required_Quantity__c=50;
    inv2.Comments_Remarks__c='Testing';
    
    Insert inv2;
    
    Inventory_Gift_Request__c inv = new Inventory_Gift_Request__c();
    inv.Case__c = case1.id;
    inv.Request_Raised_by__c =user.id;
    inv.Type_Of_Meet__c = 'Mini Meet';
    inv.Required_Quantity__c=50;
    inv.Comments__c='Testing';
    
    Insert inv;
        
    test.startTest();
    System.runAs(user)
    { 
    
    ApexPages.StandardController sc = new ApexPages.StandardController(case1);
    PageReference pageRef = Page.GiftInventory;
    pageRef.getParameters().put('id', String.valueOf(case1.id));
    
    test.setCurrentPage(pageRef);
    CtrlGiftInventory pdd = new CtrlGiftInventory(sc);
    pdd.currentCase=case1;
    pdd.getCollaterals(user.id);
    pdd.flagVar=false;
    
    delete inv;
    delete inv1;
    delete inv2;
    
    test.setCurrentPage(pageRef);
    pdd = new CtrlGiftInventory(sc);
    pdd.currentCase=case1;
    }    
    test.stopTest();  
  }
}