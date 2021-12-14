/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class autoRequestBatchHelper_Test{

 static testMethod void validateAutoRequestBatchHelper(){
    
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    RecordType Rt = [select Id from RecordType where Name ='Collateral Request' and SobjectType = 'case'];
    
    User user1 = new User(LastName='XYZ',ProfileId=profile.Id,Alias='test',EmailEncodingKey='UTF-8',
    Email='vasanthi@abc.com',UserName='vasanthi_KN1234@infosys.com',
    User_State__c ='Karnataka',
    TimeZoneSidKey='America/New_York',
    LocaleSidKey='en_US',LanguageLocaleKey='en_US');
    insert user1;
    
    User user= new User( Gifts_Required_For_Meet__c= true, FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US',Mega_Meet_Threshold__c=1,Mini_Meet_Threshold__c=1,
    head_office__c=user1.id);
    insert user;
    
    inventory__c testinv = new Inventory__c();
    testinv.Type__c='GIFT ITEMS';
    testinv.Type_Of_Meet__c='Mini Meet';
    testinv.Item_Code__c='12345';
    testinv.Product__c='CORPORATE';
    testinv.Product_Description__c='TORCHE_EVEREADY';
    testinv.Color_Language_Size__c='YELLOW';
    testinv.opening_stock__c =100;
    testinv.Closing_Stocks__c=0;
    testinv.Dispatch_Size__c=50;
    testinv.Owner_Account__c = user.id;
    testinv.Received_Stock__c = 0;
    testinv.Threshold__c=0;
    testinv.Used_Stock__c=0;
    
    
    
    inventory__c testinv1 = new Inventory__c();
    testinv1.Type__c='GIFT ITEMS';
    testinv1.Type_Of_Meet__c='Mega Meet';
    testinv1.Item_Code__c='12345';
    testinv1.Product__c='CORPORATE';
    testinv1.Product_Description__c='TORCHE_EVEREADY';
    testinv1.Color_Language_Size__c='YELLOW';
    testinv1.opening_stock__c =100;
    testinv1.Closing_Stocks__c=0;
    testinv1.Dispatch_Size__c=50;
    testinv1.Owner_Account__c = user.id;
    testinv1.Received_Stock__c = 0;
    testinv1.Threshold__c=50;
    testinv1.Used_Stock__c=0;
    
    
    
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
    
    
    
    Case case1= new Case(recordtypeId = Rt.id, Metro_Non_Metro__c=System.Label.Branding_Request_Non_Metro, Request_Raised_By__c = user.id,
            status ='New', origin='Self', Priority='Medium', Is_In_Approval_Process__c =false, Head_Office__c=user.id);
            
    
    
    Inventory_request__c inv1 = new Inventory_request__c();
    
    inv1.Request_Rasied_by__c =user.id;
    inv1.Type_of_Item__c = testinv2.id;
    inv1.Required_Quantity__c=50;
    inv1.Comments_Remarks__c='Testing';
    
    
    
    Inventory_request__c inv2 = new Inventory_request__c();
    
    inv2.Request_Rasied_by__c =user.id;
    inv2.Type_of_Item__c = testinv1.id;
    inv2.Required_Quantity__c=50;
    inv2.Comments_Remarks__c='Testing';
    
    
    
    Inventory_Gift_Request__c inv = new Inventory_Gift_Request__c();
    
    inv.Request_Raised_by__c =user.id;
    inv.Type_Of_Meet__c = 'Mini Meet';
    inv.Required_Quantity__c=50;
    inv.Comments__c='Testing';
    
    
        
    test.startTest();
    System.runAs(user)
    { 
        insert testinv;
        insert testinv1;
        insert testinv2;
        
        insert case1;
        inv1.Inventory_Request_Number__c = case1.id;
        inv2.Inventory_Request_Number__c = case1.id;
        inv.Case__c = case1.id;
        insert inv1;
        insert inv2;
        insert inv;
        
        autoRequestBatchHelper help=new autoRequestBatchHelper();
        help.getCurrentMonth();
        Target__c tgt = new Target__c(ownerid =user.id, Is_Active__c = true,
        InShop_Mechanic_Meet__c = 5, Inshop_Boarers_Meet__c=2, Mega_Mechanic_Meet__c= 1, Mega_Farmers_Meet__c = 2,
        Column_Distributors_Dealers_Mechanic_Fac__c = 1, Mega_Plumbers_Meet__c =1, Architects_Engineers_Consultants_Factory__c =1, Plumber_Factory_Visit__c =1,Plumbing_Dealers_Factory_Visit__c =1, Plumbing_Dealer_Distributor_Meets__c=1,
         Architects_Meet__c =1, Builders_Meet__c =1, Engineers_Meet__c =1, Projects_DSM_Meet_Training__c = 1,InSHOP_Plumber_meet__c =1, Naaka_Meet__c =1, Onsite_Plumber_Meet__c =1, Actuval_Exhibition_Construction_Fairs__c =1
        );
        insert tgt;
         List<Target__c> tg =[select Mega_Meets_Column__c,Mega_Meets_Plumbing__c,Mega_Meets_Project__c, Mini_Meets_Column__c, Mini_Meets_Plumbing__c, Mini_Meets_Project__c,Approval_Status__c, ownerid, Month__c, Vertical__c from Target__c where id =: tgt.id];
       // List<Target__c> tg=new List<Target__c>();
        //tg.add(tgt);
        help.executeAutoRequestForMeet(tg);
    }    
    test.stopTest();  
  }
}