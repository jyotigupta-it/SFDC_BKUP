@isTest
public class AdoptedPlumberAndDealer_Test {
    Public static testMethod void AdoptedPlumberDealerTestMethod(){
        list<AP_Site_Visit__c> tourlist =  new list<AP_Site_Visit__c>();
        AP_Taluk_Master__c aptm = new AP_Taluk_Master__c(Name='TestTaluk',Region__c='West',
                                                         State__c='Gujarat',Cluster__c='Ahmedabad',District__c='Ahmedabad');
        insert aptm;
        system.debug('------------------taluk master------->>'+aptm);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c(Name='TestUTMJ',Record_Vertical__c='Plumbing',AP_Taluk_Master__c=aptm.ID);
        insert utmj;
        system.debug('------------------utmj------->>'+utmj);
        Id DlrRcdType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        system.debug('----------------record type dealer-------->'+DlrRcdType);
        Account acc1 = new Account(Name='testName',Primary_Contact_Person_Name__c='testContactPerson',
                                   Status__c='Existing',Classification__c='Adopted',Purchase_Cycle__c='Weekly',
                                   Contact_Number_Mobile__c='9999999999',Type_of_Dealer__c='Sanitary',
                                   Display_of_our_product__c='Prominent',Media__c='In Shop',Sub_Media__c='Sunboard',
                                   APPL_Taluk__c=utmj.ID,Discount__c=40,recordtypeid=DlrRcdType);
        system.debug('------------------acc1------->>'+acc1);
        try{
            insert acc1;
        }catch(exception e){
            system.debug('------------------exception-------->'+e);
        }
        Target__c tgt = new Target__c(State__c='Assam',Vertical__c='Plumbing');
        insert tgt;
        system.debug('------------------tgt------->>'+tgt);
        AP_Tour_Plan__c aptp = new AP_Tour_Plan__c(Target__c=tgt.ID,Account__c=acc1.ID);
        insert aptp;
        system.debug('------------------Tour plan------->>'+aptp);
        Id VisitRcdType = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        AP_Site_Visit__c apsv = new AP_Site_Visit__c(Othet_Activities__c = 'Meeting',recordtypeid=VisitRcdType,AP_Tour_Plan__c=aptp.ID,Target__c=tgt.ID,Party_Type__c='Dealer',Party_Name__c=acc1.ID);
        insert apsv;
        AdoptedPlumberAndDealer ap = new AdoptedPlumberAndDealer();
        tourlist.add(apsv);
        AdoptedPlumberAndDealer.AdoptedDealerAndPlumberMethod(tourlist);  
        DELETE apsv;
        No_of_days_worked_Visits.testMethod_1();
    }
}