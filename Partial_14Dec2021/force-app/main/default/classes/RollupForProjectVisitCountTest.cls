/***************************************************
* Name:SuryaPriya.S
* Description: Test class for RollupForProjectVisitCount
* Trigger:AdoptedPlumberAndDealer 
* created date :18/12/2019***********************/

@isTest
public class RollupForProjectVisitCountTest {
    static testMethod void rollupCount() {
        Test.startTest();
        Account testAccountDis1 = new Account(); 
        testAccountDis1 = Initial_Test_Data.createAccount('test Account1','Distributor');
        testAccountDis1.Contact_Number_Mobile__c ='7259582222'; 
        testAccountDis1.Party_Type__c='Distributor';
        testAccountDis1.District__c='Bangalore';
        testAccountDis1.State__c='Karnataka';
        testAccountDis1.Business_Line__c='Plumbing';
        testAccountDis1.Status__c='Existing';
        testAccountDis1.Ramco_ID__c='12345';
        testAccountDis1.SAP_id_DP__c='1222';
        testAccountDis1.VAT_CST_Number__c='101010000000000';
        testAccountDis1.Accountant__c='Yes';
        testAccountDis1.Total_Annual_Turnover__c=150;
        testAccountDis1.Accounting_software_installed__c='Yes';
        testAccountDis1.Avg_Credit_days_offered_in_market__c=10;
        testAccountDis1.Dedicated_office_space__c='Yes';
        testAccountDis1.Distribution_as_a_part_of_total_business__c=15;
        testAccountDis1.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        testAccountDis1.Total_working_capital_investment__c=133;
        testAccountDis1.Borrowed_capital__c=133;
        testAccountDis1.Name_of_software__c='hbkj';
        testAccountDis1.Expected_AA_contribution_in_total_busi__c=10;
        insert testAccountDis1; 
        
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
        Account testAccount2=new Account();
        testAccount2 = Initial_Test_Data.createAccount('Tecount2', 'Key Accounts');
        testAccount2.Contact_Number_Mobile__c = '7259992222';
        testAccount2.Name_of_software__c='hbkj';
        testAccount2.Total_working_capital_investment__c=133;
        testAccount2.Dedicated_office_space__c='Yes';
        testAccount2.Borrowed_capital__c=133;
        testAccount2.Party_Type__c='Plumber';
        testAccount2.Expected_AA_contribution_in_total_busi__c=10;
        testAccount2.District__c='Bangalore';
        testAccount2.State__c='Karnataka';
        testAccount2.Business_Line__c='Plumbing';
        testAccount2.Status__c='Existing';
        testAccount2.Discount__c=10;
        testAccount2.Total_Annual_Turnover__c=150;
        testAccount2.VAT_CST_Number__c='101010000000000';
        testAccount2.Accountant__c='Yes';
        testAccount2.Distribution_as_a_part_of_total_business__c=15;
        testAccount2.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        
        testAccount2.Accounting_software_installed__c='Yes';
        testAccount2.Avg_Credit_days_offered_in_market__c=10;
        insert testAccount2;
        
        
        
        Account testAccountDis2 = new Account(); 
        testAccountDis2 = Initial_Test_Data.createAccount('test Account1','Distributor');
        testAccountDis2.Contact_Number_Mobile__c ='7259582222'; 
        testAccountDis2.Party_Type__c='Distributor';
        testAccountDis2.District__c='Bangalore';
        testAccountDis2.State__c='Karnataka';
        testAccountDis2.Business_Line__c='Plumbing';
        testAccountDis2.Status__c='Existing';
        testAccountDis2.Ramco_ID__c='12345';
        testAccountDis2.SAP_id_DP__c='1222';
        testAccountDis2.VAT_CST_Number__c='101010000000000';
        testAccountDis2.Accountant__c='Yes';
        testAccountDis2.Total_Annual_Turnover__c=150;
        testAccountDis2.Accounting_software_installed__c='Yes';
        testAccountDis2.Avg_Credit_days_offered_in_market__c=10;
        testAccountDis2.Dedicated_office_space__c='Yes';
        testAccountDis2.Distribution_as_a_part_of_total_business__c=15;
        testAccountDis2.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        testAccountDis2.Total_working_capital_investment__c=133;
        testAccountDis2.Borrowed_capital__c=133;
        testAccountDis2.Name_of_software__c='hbkj';
        testAccountDis2.Expected_AA_contribution_in_total_busi__c=10;
        insert testAccountDis2; 
        
        Account testAccount3 = new Account();
        testAccount3 = Initial_Test_Data.createAccount('Testount1', 'Dealer');
        testAccount3.Name = 'Kvp';
        testAccount3.Name_of_software__c='hbkj';
        testAccount3.Total_working_capital_investment__c=133;
        testAccount3.Borrowed_capital__c=133;
        testAccount3.Total_Annual_Turnover__c=150;
        testAccount3.Primary_Contact_Person_Name__c = 'KvpTest';
        testAccount3.Party_Type__c = 'Dealer';
        testAccount3.Contact_Number_Mobile__c = '9859000000';
        testAccount3.State__c = 'Rajasthan';
        testAccount3.District__c = 'Jaipur';
        testAccount3.Expected_AA_contribution_in_total_busi__c=10;
        testAccount3.City__c = 'Jaipur';
        testAccount3.Status__c = 'Prospective';
        testAccount3.Street_Address__c = 'HSR';
        testAccount3.Ramco_ID__c = '54';
        testAccount3.Distribution_as_a_part_of_total_business__c=15;
        testAccount3.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        testAccount3.Avg_Credit_days_offered_in_market__c=10;
        testAccount3.Year_Since_in_Business__c='2019';
        testAccount3.If_Yes_Products__c='test';
        testAccount3.If_others__c='test';
        testAccount3.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount3.VAT_CST_Number__c='101010000000000';
        testAccount3.Conversion_Probability__c='High';
        // testAccount1 .Parent.id=acc.id;
        testAccount3.PIN_Code__c='562106';
        testAccount3.UPVC_Discount__c=0;
        testAccount3.Column_Discount_Amount__c=0;
        testAccount3.Discount__c=0;
        testAccount3.SWR_Discount__c=0;
        testAccount3.Accountant__c='Yes';
        testAccount3.Accounting_software_installed__c='Yes';
        testAccount3.Dedicated_office_space__c='Yes';
        insert testAccount3;
        Account testAccount4=new Account();
        testAccount4 = Initial_Test_Data.createAccount('Tecount2', 'Key Accounts');
        testAccount4.Contact_Number_Mobile__c = '7259992222';
        testAccount4.Name_of_software__c='hbkj';
        testAccount4.Total_working_capital_investment__c=133;
        testAccount4.Dedicated_office_space__c='Yes';
        testAccount4.Borrowed_capital__c=133;
        testAccount4.Party_Type__c='Plumber';
        testAccount4.Expected_AA_contribution_in_total_busi__c=10;
        testAccount4.District__c='Bangalore';
        testAccount4.State__c='Karnataka';
        testAccount4.Business_Line__c='Plumbing';
        testAccount4.Status__c='Existing';
        testAccount4.Discount__c=10;
        testAccount4.Total_Annual_Turnover__c=150;
        testAccount4.VAT_CST_Number__c='101010000000000';
        testAccount4.Accountant__c='Yes';
        testAccount4.Distribution_as_a_part_of_total_business__c=15;
        testAccount4.Size_of_Dedicated_godown_for_Ashirvad__c=15;
        
        testAccount4.Accounting_software_installed__c='Yes';
        testAccount4.Avg_Credit_days_offered_in_market__c=10;
        insert testAccount4;    
        
        
        
        
        
        
        
        
        
        
        
        
        Target__c tgt = new Target__c(State__c='Assam',Vertical__c='Plumbing',Influencer_projectVisit_Actual__c=5);
        insert tgt;
        system.debug('------------------tgt------->>'+tgt);
        AP_Tour_Plan__c aptp = new AP_Tour_Plan__c(Target__c=tgt.ID,Account__c=testAccount1.ID);
        insert aptp;
        system.debug('------------------Tour plan------->>'+aptp);
        list<AP_Site_Visit__c> applist1=new list<AP_Site_Visit__c>();
        Id VisitRcdType = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Project Visit').getRecordTypeId();
        Id VisitRcdType1 = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('brandingVist').getRecordTypeId();
        Id VisitRcdType2 = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Other Activities').getRecordTypeId();
        Id VisitRcdType3 = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
        AP_Site_Visit__c apsv = new AP_Site_Visit__c();
        apsv.Target__c=tgt.id;
        apsv.AP_Tour_Plan__c=aptp.id;
        apsv.party_name__C=testAccount1.ID; 
        apsv.RecordTypeId=VisitRcdType;
        apsv.Date__c=system.today();
        
        AP_Site_Visit__c apsv1 = new AP_Site_Visit__c();
        apsv1.Target__c=tgt.id;
        apsv1.AP_Tour_Plan__c=aptp.id;
        apsv1.party_name__C=testAccountDis1.ID; 
        apsv1.RecordTypeId=VisitRcdType1;
        apsv1.Date__c=system.today();
        
        AP_Site_Visit__c apsv2 = new AP_Site_Visit__c();
        apsv2.Target__c=tgt.id;
        apsv2.AP_Tour_Plan__c=aptp.id;
        apsv2.party_name__C=testAccount2.ID; 
        apsv2.RecordTypeId=VisitRcdType1;
        apsv2.Date__c=system.today();
        
        AP_Site_Visit__c apsv3 = new AP_Site_Visit__c();
        apsv3.Target__c=tgt.id;
        apsv3.AP_Tour_Plan__c=aptp.id;
        apsv3.party_name__C=testAccountDis2.ID; 
        apsv3.RecordTypeId=VisitRcdType2;
        apsv3.Date__c=system.today();
        
        AP_Site_Visit__c apsv4 = new AP_Site_Visit__c();
        apsv4.Target__c=tgt.id;
        apsv4.AP_Tour_Plan__c=aptp.id;
        apsv4.party_name__C=testAccount4.ID; 
        apsv4.RecordTypeId=VisitRcdType3;
        apsv4.Date__c=system.today();
        
        applist1.add(apsv);
        applist1.add(apsv1);
        applist1.add(apsv2);
        applist1.add(apsv3);
        applist1.add(apsv4);
        insert applist1;
        system.debug('AppList after Insert : '+applist1);
        list<AP_Site_Visit__c> applist2=new list<AP_Site_Visit__c>();
        
        
        system.debug('apsv==>'+apsv);
        for(AP_Site_Visit__c aps1:[select id ,name from AP_Site_Visit__c where id =:apsv.id limit 1]){
            //  apsv1.name='testing';
            database.update(aps1);
        }
        
        //list<AP_Site_Visit__c> applist= [select id ,name from AP_Site_Visit__c where id =:apsv.id];
        //delete applist;
        //delete applist1;
        delete apsv;
        Test.stopTest();
        
        
    }   
    
}