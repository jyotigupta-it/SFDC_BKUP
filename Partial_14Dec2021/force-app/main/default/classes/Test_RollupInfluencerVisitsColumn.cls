/***************************************************
* Name:SudhaMurthy
* Description: TEst class  for RollupInfluencerVisitsColumn
* Trigger:AdoptedPlumberAndDealer 
* created date :08/07/2019***********************/
@IsTest
public class Test_RollupInfluencerVisitsColumn{
    @isTest static void TestInfluencerVisitmethod(){
        List<AP_Tour_Plan__c> apList = new List<AP_Tour_Plan__c>();
        List<AP_Site_Visit__c> apVisit = new List<AP_Site_Visit__c>();
        
        AP_Tour_Plan__c a1 = new AP_Tour_Plan__c();
        apList.add(a1);
        AP_Tour_Plan__c a2 = new AP_Tour_Plan__c();
        apList.add(a2);
        
        insert apList;
        
        Target__C t1= new target__C(Influencer_visit_actual_column__c=2);
        insert t1;
        target__C t2= new target__C(Influencer_visit_actual_column__c=5);
        insert t2;
        
        Test.startTest();
        
        Id recordTypeIdVisits = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        
        AP_Site_Visit__c visit1= new AP_Site_Visit__c(AP_Tour_Plan__c=a1.id,target__c=t1.id,Party_type__C='farmer', recordTypeId =recordTypeIdVisits,Date__c = system.today() );
        apVisit.add(visit1);
        
        Id recordTypeIdForUserIncentiveActualsDaily = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Other Activities').getRecordTypeId();
        
        AP_Site_Visit__c visit3= new AP_Site_Visit__c(AP_Tour_Plan__c=a2.id,target__c=t1.id,recordTypeId = recordTypeIdForUserIncentiveActualsDaily, Date__c = system.today());
        apVisit.add(visit3);
        
        AP_Site_Visit__c visit5 = new AP_Site_Visit__c(AP_Tour_Plan__c=a2.id,target__c=t1.id,recordTypeId = recordTypeIdForUserIncentiveActualsDaily, Date__c = system.today());
        
        apVisit.add(visit5);
        insert apVisit;
        update visit1;
        update visit3;
        delete visit1;
        undelete visit1;
        
        Test.stopTest();   
    }
    @isTest static void TestLeavemethod(){
        AP_Tour_Plan__c a1 = new AP_Tour_Plan__c();
        insert a1;
        AP_Tour_Plan__c a2 = new AP_Tour_Plan__c();
        insert a2;
        Target__C t1= new target__C(Leave_Actual__c=2);
        insert t1;
        target__C t2= new target__C(Leave_Actual__c=5);
        insert t2;
        Test.startTest();
        AP_Site_Visit__c visit1= new AP_Site_Visit__c(AP_Tour_Plan__c=a1.id,target__c=t1.id,Othet_Activities__c='leave' );
        insert visit1;
        AP_Site_Visit__c visit2= new AP_Site_Visit__c(AP_Tour_Plan__c=a2.id,target__c=t1.id,Othet_Activities__c='leave' );
        insert visit2;
        
        
        update visit1;
        
        
        update visit2;
        delete visit1;
        
        undelete visit1;
        
        
        Test.stopTest();   
        
    }
}