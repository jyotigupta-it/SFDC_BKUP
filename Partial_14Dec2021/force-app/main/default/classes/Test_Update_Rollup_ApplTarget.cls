/**
* This class contains unit tests for validating the behavior of Apex classes : Update_Rollup_ApplTarget_Handler
* and trigger : Update_Rollup_ApplTarget.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
* 
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
@isTest
private class Test_Update_Rollup_ApplTarget {
    
    
    
    static testMethod void myUnitTest() {
        AP_Taluk_Master__c aptm = new AP_Taluk_Master__c(Name='TestTaluk',Region__c='West',
                                                         State__c='Gujarat',Cluster__c='Ahmedabad',District__c='Ahmedabad');
        insert aptm;
        system.debug('------------------taluk master------->>'+aptm);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c(Name='TestUTMJ',Record_Vertical__c='Plumbing',AP_Taluk_Master__c=aptm.ID);
        insert utmj;
        List<AP_Tour_Plan__c> aptourList=new List<AP_Tour_Plan__c>();
        List<AP_Tour_Plan__c> tourToUpdate = new List<AP_Tour_Plan__c>();
        Set<Id> beatIds = new Set<Id>();
        Map<Id,AP_Tour_Plan__c> oldMapp= new Map<Id,AP_Tour_Plan__c>();
        Target__c objTarget =  Test_Utilclass.objTarget();
        insert objTarget;
        Beat_Master__c bm=new Beat_Master__c();
        bm.Name='HSr 22';
        insert bm;
        
        AP_Tour_Plan__c objTourPlan = Test_Utilclass.objTourPlan();
        objTourPlan.Target__c = objTarget.id;
        objTourPlan.Beat__c=bm.id;
        aptourList.add(objTourPlan);
        insert objTourPlan;
        
        beatIds.add( objTourPlan.Beat__c);
        oldMapp.put(objTourPlan.Id, objTourPlan);
        AP_Expenses__c objExpensive = Test_Utilclass.objExpensive();
        objExpensive.TourPlan__c = objTourPlan.id;
        insert objExpensive;
        Account testAccount1 = new Account();
        testAccount1 = Initial_Test_Data.createAccount('Testount1', 'Dealer');
        testAccount1 .Name = 'Kvp';
        testAccount1.Name_of_software__c='hbkj';
        testAccount1.Total_working_capital_investment__c=133;
        testAccount1.Borrowed_capital__c=133;
        testAccount1.Total_Annual_Turnover__c=150;
        testAccount1 .Primary_Contact_Person_Name__c = 'KvpTest';
        testAccount1 .Party_Type__c = 'Dealer';
        testAccount1 .Contact_Number_Mobile__c = '9859000000';
        testAccount1 .State__c = 'Rajasthan';
        testAccount1 .District__c = 'Jaipur';
        testAccount1.Expected_AA_contribution_in_total_busi__c=10;
        testAccount1 .City__c = 'Jaipur';
        testAccount1 .Status__c = 'Prospective';
        testAccount1 .Street_Address__c = 'HSR';
        testAccount1 .Ramco_ID__c = '54';
        testAccount1.Distribution_as_a_part_of_total_business__c=15;
        testAccount1.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        testAccount1.Avg_Credit_days_offered_in_market__c=10;
        testAccount1 .Year_Since_in_Business__c='2019';
        testAccount1 .If_Yes_Products__c='test';
        testAccount1 .If_others__c='test';
        testAccount1 .Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount1 .VAT_CST_Number__c='101010000000000';
        testAccount1 .Conversion_Probability__c='High';
        // testAccount1 .Parent.id=acc.id;
        testAccount1 .PIN_Code__c='562106';
        testAccount1 .UPVC_Discount__c=0;
        testAccount1 .Column_Discount_Amount__c=0;
        testAccount1 .Discount__c=0;
        testAccount1 .SWR_Discount__c=0;
        testAccount1.Accountant__c='Yes';
        testAccount1.Accounting_software_installed__c='Yes';
        testAccount1.Dedicated_office_space__c='Yes';
        testAccount1.SWR_Discount__c=0;
        testAccount1.Accountant__c='YES';
        testAccount1.Products__c='Air Admittance Valve';
        testAccount1.Business_Line__c='Plumbing';
        testAccount1.PIN_Code__c='464001';
        testAccount1.APPL_Taluk__c=utmj.Id;
        insert testAccount1;
        
        Beat_Master__c beat = new Beat_Master__c();
        beat.Name='Test';
        insert beat;
        beatIds.add(beat.id);
        Beat_Master_Account__c b = new Beat_Master_Account__c();
        b.Account__c=testAccount1.Id;
        b.Beat_Master__c = beat.Id;
        insert b;
        Beat_Master__c beat2 = new Beat_Master__c();
        beat2.Name='testing surya';
        insert beat2;
        Beat_Master_Account__c bms = new Beat_Master_Account__c();
        bms.Account__c=testAccount1.Id;
        bms.Beat_Master__c = beat2.Id;   
        //insert bms;
        
        beatIds.add(beat2.id);
        Update_Rollup_ApplTarget_Handler upp=new Update_Rollup_ApplTarget_Handler();
        upp.updateBeatNameAfterApprove(aptourList,oldMapp);
        upp.updateBeatNameAfterApprove1(aptourList,oldMapp);
        upp.testMethod_1();
    }
}