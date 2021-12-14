/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public class CollateralPromotionTrigger_UT{
static testmethod void updateclosingStockTest(){
Profile profileID = [select id from profile where Name='System Administrator' limit 1];
 
 User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
       Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN454@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US');
     
 insert user1;

 inventory__c testinv = new Inventory__c();
 testinv.Type__c='GIFT ITEMS';
 testinv.Type_Of_Meet__c='Mini Meet';
 testinv.Item_Code__c='12345';
 testinv.Product__c='CORPORATE';
 testinv.Product_Description__c='TORCHE_EVEREADY';
 testinv.Color_Language_Size__c='YELLOW';
 testinv.opening_stock__c =100;
 testinv.Closing_Stocks__c=100;
 testinv.Dispatch_Size__c=50;
 testinv.Owner_Account__c = user1.id;
 testinv.Received_Stock__c = 0;
 testinv.Threshold__c=50;
 testinv.Used_Stock__c=0;
 
 insert testinv;
 
 inventory__c testinv1 = new Inventory__c();
 testinv1.Type__c='GIFT ITEMS';
 testinv1.Type_Of_Meet__c='Mega Meet';
 testinv1.Item_Code__c='12345';
 testinv1.Product__c='CORPORATE';
 testinv1.Product_Description__c='TORCHE_EVEREADY1';
 testinv1.Color_Language_Size__c='YELLOW';
 testinv1.opening_stock__c =100;
 testinv1.Closing_Stocks__c=100;
 testinv1.Dispatch_Size__c=50;
 testinv1.Owner_Account__c = user1.id;
 testinv1.Received_Stock__c = 0;
 testinv1.Threshold__c=50;
 testinv1.Used_Stock__c=0;
 
 insert testinv1;

 system.runas(user1){
      test.starttest();
     
 promotion__c prom = new promotion__c(Total_no_of_attendees__c = 5, Verified__c =false, Gift_Given_1__c=testinv1.id, Gift_Given_2__c=testinv.id,Gift_Given_22__c=testinv.id,Gift_Given_11__c=testinv1.id);
 insert prom;
 prom.Verified_Number_of_Attended_Members__c=10;
 prom.Verified__c =true;
 prom.Call_Center_Remarks__c ='asdfgh';
 prom.Verification_Status1__c='Others';
  update prom;
       test.stoptest();
      }
 


}

}