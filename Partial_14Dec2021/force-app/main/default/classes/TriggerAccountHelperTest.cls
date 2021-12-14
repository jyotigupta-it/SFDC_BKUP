/* 
* Test class of TriggerAccountHelper
*/ 

@isTest
public class TriggerAccountHelperTest {
    
    public static testmethod void insertAccountIntoIEPInfluncerTest(){
        iep_influencer__c iep = new iep_influencer__c(Current_point__c=10);
        insert iep;
        Date dt = Date.valueOf('2020-08-25');    
        Account ac2 = new Account(Name='Test2',Contact_Number__c='9538509032', Contact_Number_Mobile__c='9538509031',ID_proof_submitted__c='Passport',Local_Work_Address__c='Pune', Birth_Date__c=dt, City1__c='Pune',Blood_Group__c='B+',State1__c='Bihar',Emergency_contact_number__c='1234',Type_of_Phone__c='Smart Phone', Ashirvad_Plumber__c='Yes',Years_of_experience__c='20 + years',Number_of_Plumbers_under_me__c=10,Profile_status__c='QC passed',is_active__c=true);
        insert ac2;
        List<Account> acList = new List<Account>();
        acList.add(ac2);

        TriggerAccountHelper.insertAccountIntoIEPInfluncer(acList); 
    }
}