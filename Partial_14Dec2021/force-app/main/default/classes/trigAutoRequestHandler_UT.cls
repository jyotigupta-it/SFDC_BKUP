/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class trigAutoRequestHandler_UT{

static testmethod void checkAutoTest(){
    
    list<inventory__c> uplist=new list<inventory__c>();
    
    Profile profileID = [select id from profile where Name='System Administrator' limit 1];
    
    RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
    
    User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
    Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN115@infosys.com',
    User_State__c ='Karnataka',
    TimeZoneSidKey='America/New_York',
    LocaleSidKey='en_US',LanguageLocaleKey='en_US');
    
    insert user1;
    
    inventory__c testinv1 = new Inventory__c();
    testinv1.Type__c='Gifts';
    testinv1.Type_Of_Meet__c='Mini Meet';
    testinv1.Item_Code__c='12345';
    testinv1.Product__c='CORPORATE';
    testinv1.Product_Description__c='TORCHE_EVEREADY';
    testinv1.Color_Language_Size__c='YELLOW';
    testinv1.opening_stock__c =100;
    testinv1.Closing_Stocks__c=100;
    testinv1.Dispatch_Size__c=50;
    testinv1.Owner_Account__c = user1.id;
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
    testinv2.Owner_Account__c = user1.id;
    testinv2.Received_Stock__c = 0;
    testinv2.Threshold__c=50;
    testinv2.Used_Stock__c=0;
    
    insert testinv2;
    
    Case case1= new Case(recordtypeId = Rt.id, Metro_Non_Metro__c=System.Label.Branding_Request_Non_Metro, Request_Raised_By__c = user1.id,
            status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false, Head_Office__c=user1.id);
            
    insert case1;
    
    Inventory_request__c inv = new Inventory_request__c();
    inv.Inventory_Request_Number__c = case1.id;
    inv.Request_Rasied_by__c =user1.id;
    inv.Type_of_Item__c = testinv2.id;
    inv.Required_Quantity__c=50;
    inv.Comments_Remarks__c='Testing';
    Insert inv;
    
    system.runas(user1){
    test.starttest();
    
    testinv1.Closing_Stocks__c=49;
    uplist.add(testinv1);
    
    testinv2.Closing_Stocks__c=49;
    uplist.add(testinv2);
    
    update uplist;
    
    test.stoptest();
    }
    
    
    
 }

}