@isTest public class BeatMasterAccountTriggerHandlerTest {
    @isTest static void testAddDealer(){
        
        AP_Taluk_Master__c ap= new AP_Taluk_Master__c ();
        ap.State__c='Andhra Pradesh';
        ap.District__c='Nellore';
        insert ap;
        
        User_Taluk_Master_Junction__c user = new User_Taluk_Master_Junction__c();
        user.AP_Taluk_Master__c=ap.Id;
            insert user;
        
        
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
        testAccount1.APPL_Taluk__c=user.Id;
        testAccount1.Business_Line__c='V4';
        testAccount1.Products__c='V4';
        
        
        
        insert testAccount1;
        
        Account testAccount2 = new Account();
        testAccount2 = Initial_Test_Data.createAccount('Testount1', 'Dealer');
        testAccount2 .Name = 'Kvp';
        testAccount2.Name_of_software__c='hbkj';
        testAccount2.Total_working_capital_investment__c=133;
        testAccount2.Borrowed_capital__c=133;
        testAccount2.Total_Annual_Turnover__c=150;
        testAccount2 .Primary_Contact_Person_Name__c = 'KvpTest';
        testAccount2 .Party_Type__c = 'Dealer';
        testAccount2 .Contact_Number_Mobile__c = '9859000000';
        testAccount2 .State__c = 'Rajasthan';
        testAccount1 .District__c = 'Jaipur';
        testAccount2.Expected_AA_contribution_in_total_busi__c=10;
        testAccount2 .City__c = 'Jaipur';
        testAccount2 .Status__c = 'Prospective';
        testAccount2 .Street_Address__c = 'HSR';
        testAccount2 .Ramco_ID__c = '54';
        testAccount2.Distribution_as_a_part_of_total_business__c=15;
        testAccount2.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        testAccount2.Avg_Credit_days_offered_in_market__c=10;
        testAccount2 .Year_Since_in_Business__c='2019';
        testAccount2 .If_Yes_Products__c='test';
        testAccount2 .If_others__c='test';
        testAccount2 .Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount2 .VAT_CST_Number__c='101010000000000';
        testAccount2 .Conversion_Probability__c='High';
        // testAccount1 .Parent.id=acc.id;
        testAccount2 .PIN_Code__c='562106';
        testAccount2 .UPVC_Discount__c=0;
        testAccount2 .Column_Discount_Amount__c=0;
        testAccount2 .Discount__c=0;
        testAccount2 .SWR_Discount__c=0;
        testAccount2.Accountant__c='Yes';
        testAccount2.Accounting_software_installed__c='Yes';
        testAccount2.Dedicated_office_space__c='Yes';
        testAccount2.APPL_Taluk__c=user.Id;
        testAccount2.Business_Line__c='V4';
        testAccount2.Products__c='V4';
        insert testAccount2;
        list<Beat_Master__c> bmList = new list<Beat_Master__c>();
        Beat_Master__c beat = new Beat_Master__c();
        beat.Name ='Test';
        bmList.add(beat);
       // insert beat;
        Beat_Master__c beat1 = new Beat_Master__c();
        beat1.Name ='Test';
        bmList.add(beat1);
        //insert beat1;
        insert bmList;
        Beat_Master_Account__c beatAcc = new Beat_Master_Account__c();
        beatAcc.Account__c =testAccount1.Id;
        beatAcc.Beat_Master__c =bmList[0].Id;
        insert beatAcc;
        Beat_Master_Account__c beatAcc1 = new Beat_Master_Account__c(Id=beatAcc.Id);
        beatAcc1.Account__c =testAccount2.Id;
       // beatAcc1.Beat_Master__c =bmList[1].Id;
        
        update beatAcc1;
        BeatrMasterTriggerHandler.updateAccountsOnDelete(bmList);
        //delete bmList;
        delete beatAcc;
        Beat_Master__c beathsr = new Beat_Master__c();
        
        beathsr.Name='HSR';
        insert beathsr;
        delete beathsr;
        //
        //BeatMasterAccountTriggerHandler.deleteTestObject(new Set<Id>{beatAcc.Id});
        
        
    }
    
    
    
    
    
}