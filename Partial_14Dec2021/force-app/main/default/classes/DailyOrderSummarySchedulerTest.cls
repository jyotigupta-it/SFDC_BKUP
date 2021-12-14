@isTest
public class DailyOrderSummarySchedulerTest {
    
    static testMethod void init(){
        id recId = ([SELECT Id, Name FROM RecordType where name = 'Distributor' limit 1]).id;
        id recId1 = ([SELECT Id, Name FROM RecordType where name = 'Portal' limit 1]).id;
        AP_Taluk_Master__c aptm = new AP_Taluk_Master__c(Name='TestTaluk',Region__c='West',
                                                         State__c='Gujarat',Cluster__c='Ahmedabad',District__c='Ahmedabad');
        insert aptm;
        system.debug('------------------taluk master------->>'+aptm);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c(Name='TestUTMJ',Record_Vertical__c='Plumbing',AP_Taluk_Master__c=aptm.ID);
                insert utmj;

        
        account acc =  new account();
        acc.name = 'testtt';
        acc.RecordTypeId = recId;
        acc.State__c = 'Karnataka';
        acc.Status__c = 'Existing';
        acc.Ramco_ID__c = 'abshddj';
        acc.Accountant__c = 'Yes';
        acc.Accounting_software_installed__c = 'Yes';
        acc.Avg_Credit_days_offered_in_market__c = 1;
        acc.Dedicated_office_space__c = 'Yes';
        acc.Distribution_as_a_part_of_total_business__c = 2;
        acc.VAT_CST_Number__c = 'PAS123456987123';
        acc.SAP_id_DP__c = '34686874432413';
        acc.Size_of_Dedicated_godown_for_Ashirvad__c = 1;
        acc.Total_working_capital_investment__c = 12;
        acc.Borrowed_capital__c = 1;
        acc.Expected_AA_contribution_in_total_busi__c = 2;
        acc.Name_of_software__c = 'aa';
        acc.Total_Annual_Turnover__c = 12;
        acc.District__c = 'Mysore';
        acc.Year_Since_in_Business__c = '2016';
        acc.Contact_Number_Mobile__c = '9797979797';
        acc.Contact_Email__c = 'abcd@gail.com';
        acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='Plumbing';
        acc.APPL_Taluk__c=utmj.Id;
                acc.PIN_Code__c='464001';

        insert acc;
        
        account acc1 =  new account();
        acc1.ParentId = acc.Id;
        acc1.name = 'testtt';
        acc1.State__c = 'Karnataka';
        acc1.District__c = 'Mysore';
        acc1.Year_Since_in_Business__c = '2016';
        acc1.Contact_Number_Mobile__c = '9797979797';
        acc1.Products__c='Air Admittance Valve';
                acc1.APPL_Taluk__c=utmj.Id;

                acc1.Business_Line__c='Plumbing';

                        acc1.PIN_Code__c='464001';

        insert acc1;
        
        Product2 t = new Product2();
        t.Name='Test';
        
        order o1 = new order();
        o1.AccountId = acc1.Id;
        o1.Status = 'Draft';
        o1.RecordTypeId = recId1;
        o1.EffectiveDate = date.today();
        insert o1;
        
        DailyOrderSummaryScheduler oo = new DailyOrderSummaryScheduler();
        oo.execute(null);
    }
}