/***************************************************
 * Name:SudhaMurthy
 * Description: class to create count  and sum of visits on target
 * Trigger:AdoptedPlumberAndDealer 
 * created date :22/22/2018***********************/
@isTest
public class Test_ProductivevisitOrders {
    @isTest static void Testforproductivevisits(){
    AP_Tour_Plan__c a1 = new AP_Tour_Plan__c();
    insert a1;
    AP_Tour_Plan__c a2 = new AP_Tour_Plan__c();
    insert a2;
       Target__C t1= new target__C();
        insert t1;
        target__C t2= new target__C();
        insert t2;
        Test.startTest();
        AP_Site_Visit__c visit1= new AP_Site_Visit__c(AP_Tour_Plan__c=a1.id,target__c=t1.id);
        insert visit1;
        AP_Site_Visit__c visit2= new AP_Site_Visit__c(AP_Tour_Plan__c=a2.id,target__c=t1.id);
        insert visit2;
        //System.assertEquals(1, [Select visit_with_new_order_booking__c   From target__c Where Id =: t1.Id].visit_with_new_order_booking__c  );
        
        update visit1;
       // System.assertEquals(2, [Select visit_with_new_order_booking__c   From target__c Where Id =: t1.Id].visit_with_new_order_booking__c  );
          
        update visit2;
        delete visit1;
        // System.assertEquals(0, [Select visit_with_new_order_booking__c  From target__c Where Id =: t1.Id].visit_with_new_order_booking__c  );
        undelete visit1;
         Test.stopTest();   
        
    }

}