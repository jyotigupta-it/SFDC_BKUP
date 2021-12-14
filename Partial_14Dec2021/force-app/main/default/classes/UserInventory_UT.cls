@isTest
public class UserInventory_UT{
   static testMethod void CountUserInventory(){
   
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    List<inventory__c> invlist= new List<inventory__c>();
    inventory__c inv1= new Inventory__c();
    inv1.opening_stock__c =200;
    inv1.Closing_Stocks__c=200;
    inv1.Dispatch_Size__c=50;
    inv1.Owner_Account__c = user.id;
    inv1.Received_Stock__c = 0;
    inv1.Threshold__c=50;
    inv1.Used_Stock__c=0;
    inv1.product__C='XYZ';
    inv1.type__c='PRODUCT COLLATERALS';
    invlist.add(inv1);
    
    inventory__c inv2= new Inventory__c();
    inv2.opening_stock__c =100;
    inv2.Closing_Stocks__c=100;
    inv2.Dispatch_Size__c=50;
    inv2.Owner_Account__c = user.id;
    inv2.Received_Stock__c = 0;
    inv2.Threshold__c=50;
    inv2.Used_Stock__c=0;
    inv2.product__C='XYZ';
    inv2.type__c='GIFT ITEMS';
    invlist.add(inv2);
    
    
    inventory__c inv3= new Inventory__c();
    inv3.opening_stock__c =150;
    inv3.Closing_Stocks__c=150;
    inv3.Dispatch_Size__c=50;
    inv3.Owner_Account__c = user.id;
    inv3.Received_Stock__c = 0;
    inv3.Threshold__c=50;
    inv3.Used_Stock__c=0;
    inv3.product__C='XYZ';
    inv3.type__c='SAMPLES';
    invlist.add(inv3);
    
    
    inventory__c inv4= new Inventory__c();
    inv4.opening_stock__c =210;
    inv4.Closing_Stocks__c=210;
    inv4.Dispatch_Size__c=50;
    inv4.Owner_Account__c = user.id;
    inv4.Received_Stock__c = 0;
    inv4.Threshold__c=50;
    inv4.Used_Stock__c=0;
    inv4.product__C='XYZ';
    inv4.type__c='PACKING MATERIALS';
    invlist.add(inv4);
    
    insert invlist;
    
    test.startTest();
    System.runAs(user)
    { 
    UserInventory UI= new UserInventory(new ApexPages.StandardSetController(invlist));
    for(inventory__c userInventory : invlist){
    UI.searchData=userInventory;
    }
    
    UI.getCollaterals();
    UI.search();
    
    List<inventory__c> invlist1= new List<inventory__c>();
    for(integer i=0;i<=30;i++){
    inventory__c inv5= new Inventory__c();
    inv5.opening_stock__c =210;
    inv5.Closing_Stocks__c=210;
    inv5.Dispatch_Size__c=50;
    inv5.Owner_Account__c = user.id;
    inv5.Received_Stock__c = 0;
    inv5.Threshold__c=50;
    inv5.Used_Stock__c=0;
    inv5.product__C='XYZ';
    inv5.type__c='PACKING MATERIALS';
    invlist1.add(inv5);
    
    }
    
    insert invlist1;
    
    for(inventory__c userInventory : invlist1){
    UI.searchData=userInventory;
    }
    UI.searchText='XYZ';
    UI.searchData.owner_account__c=null;
    UI.search();
    UI.getCollaterals();
    UI.searchInventory();
    UI.countCombined=invlist1.size();
    UI.RenderNext();
    UI.RenderPrevious(); 
    }    
    test.stopTest();  
    
   }
}