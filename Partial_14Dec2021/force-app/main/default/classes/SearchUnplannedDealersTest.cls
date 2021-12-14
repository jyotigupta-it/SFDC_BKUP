@isTest public class SearchUnplannedDealersTest {
    @isTest public static void  test(){
        
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
        insert testAccount1;
        SearchUnplannedDealers s = new SearchUnplannedDealers();
        s.fetchAccounts(testAccount1.Name, testAccount1.Name, new Set<Id>{testAccount1.Id});
            
            
            }
    
}