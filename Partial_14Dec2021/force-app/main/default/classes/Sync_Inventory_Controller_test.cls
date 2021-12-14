/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public Class Sync_Inventory_Controller_test{ 
    static testmethod void StartTest(){
       Database.QueryLocator QL;
       Database.BatchableContext BC;
       Sync_Inventory_Controller prog = new Sync_Inventory_Controller();
       List<inventory__c> invList = new List<inventory__c>();
       User admin = [SELECT id FROM User WHERE id =: UserInfo.getUserId() LIMIT 1]; 
       System.runAs(admin){ 
       inventory__c inv=new inventory__c();
       inv.Name='Renj'; 
       inv.Closing_Stocks__c=100;
       inv.opening_stock__c=1000;
       inv.Dispatch_Size__c=75;
       inv.Owner_Account__c=admin.id;
       inv.Threshold__c=200;
       inv.Used_Stock__c=900;
       invList.add(inv);
       
       insert invList; 
       
      test.startTest();  
      QL = prog.start(BC); 
      prog.execute(BC, invList);
      prog.finish(BC); 
      test.stopTest();
      }
}
}