@isTest
public class CustomLookupForProjectTest {
    static testMethod void customLookupMethod() {
        Target__c tc = new Target__c();
        tc.Approval_Comments__c = 'Approve';
        Insert tc;
        ApexPages.StandardController sc = new ApexPages.standardController(tc);
        CustomLookupForProject accPdf = new CustomLookupForProject(sc);
        
        
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
        
        AP_Taluk_Master__c taluk = new AP_Taluk_Master__c();
        taluk.Name = 'Bangalore';
        taluk.Cluster__c = 'Blr Zone';
        taluk.District__c = 'bangalore';
        taluk.State__c = 'Karnataka';
        Insert taluk;
        
        opportunity opp=new  opportunity();
        opp.name='test';
        //opp.owner.firstname='testuser';
        //opp.owner.Lastname='testuser2';
        opp.Average_Discount__c=2;
        opp.Project_Number__c   ='1234'; 
        opp.stagename='Offer Submitted';  
        opp.closedate=system.today();
        //insert opp;
        
           
        User_Taluk_Master_Junction__c talukjn = new User_Taluk_Master_Junction__c();
        talukjn.Name = 'kvp';
        talukjn.User__c = UserInfo.getUserId();
        Insert talukjn;
        
        Promotion__c promo = new Promotion__c();
     //   promo.Name = 'test';
        promo.District__c = 'Sikar';
      //  Date dt = new Date(5/10/2018);
      //  Date d = Date.newInstance(5/10/2018);
       // promo.Date__c = today();
        promo.Type__c = 'test';
        promo.State__c = 'Rajasthan';
        Insert promo;
        
        Product2  prod = new Product2();
        prod.name='test';
        prod.ProductCode='1234';
        prod.description='test';
        insert prod;
        
        //   CustomLookupForProject cLookup = new CustomLookupForProject();
        
        accPdf.runOrderQuery();
        accPdf.runProjectQuery();
        accPdf.runOrderFilterQuery();
        accPdf.runOrderFilterQuery2();
        accPdf.runOrderFilterPostQuery();
        accPdf.SearchqueryforAccount();
        accPdf.Searchqueryfortaluk();
        accPdf.runUserQuery();
        accPdf.Searchqueryforuser();
        accPdf.SearchqueryforPromo();
        accPdf.searchQueryforProject();
        accpdf.runProjectByFilterQuery();
        accpdf.runInfluencerDetailQuery();
        accpdf.runApplOfferDistributor();
        accpdf.runApplSupplyDistributor();
        accpdf.runApplSupplyProductName();
        accPdf.searchQueryforTalukJunc();
        CustomLookupForProject.selectedPartyType('test');
        accpdf.searchQueryforDistributor();
        accpdf.searchQueryforDealer();
        accpdf.runOrderQueryinfluencer();
        accpdf.runApplSupplyDistributorproject();
        accpdf.runApplOfferDistributorproject();
        accpdf.searchQueryforDistri();
        accpdf.SearchqueryforNewtaluk();
        accpdf.searchQueryforDealerProm();
        accpdf.runOrderQueryfordist();
        
    }
}