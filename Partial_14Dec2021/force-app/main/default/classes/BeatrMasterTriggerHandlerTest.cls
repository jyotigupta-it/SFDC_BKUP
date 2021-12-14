@isTest
public class BeatrMasterTriggerHandlerTest {
    
    @isTest
    static void updateAccountsOnDeleteTest(){
        User userObj =[select id,Name from User Limit 1];
        List<Beat_Master__c> beatList = new List<Beat_Master__c>();
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
        Beat_Master__c beatObj = new Beat_Master__c(Name='TestBeat_1',Beat_Frequency__c='Monday Week1;Monday Week2',OwnerId=userObj.id);
        beatList.add(beatObj);
        //Beat_Master__c beatObj_1 = new Beat_Master__c(Name='TestBeat_2',Beat_Frequency__c='Monday Week1;Monday Week3',OwnerId=userObj.id);
        //beatList.add(beatObj_1);
        INSERT beatList;
        Beat_Master_Account__c beatMasterAcc = new Beat_Master_Account__c();
        beatMasterAcc.Account__c=testAccount1.Id;
        beatMasterAcc.Beat_Master__c = beatList[0].Id;
        INSERT beatMasterAcc;
        Target__c tergetObj = new Target__c(Start_Date__c=date.newInstance(2021,12,1),End_Date__c=date.newInstance(2021,12,31),Approval_Status__c='Pending',Vertical__c='Column',State__c='Karnataka',OwnerId=userObj.id);
        INSERT tergetObj;
        beatList[0].Beat_frequency_approval_status__c = 'Approved';
        UPDATE beatList;
        DELETE beatList;
    }
}