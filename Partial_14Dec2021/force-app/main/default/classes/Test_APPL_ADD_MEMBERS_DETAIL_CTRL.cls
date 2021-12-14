@isTest
public class Test_APPL_ADD_MEMBERS_DETAIL_CTRL{

 static testMethod void testMethod1() 
    {
        List<Account> lstAccount= new List<Account>();
        User u=new User();
        u.Id=UserInfo.getUserId();
       
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
            //create a record Type
            RecordType rt=new RecordType();
            rt=[SELECT DeveloperName,Id,Name FROM RecordType WHERE SobjectType = 'Account' limit 1];
           
            // records for promotions
            Promotion__c promo =new Promotion__c();
            promo.Total_no_of_attendees__c=5;
            promo.Date__c=System.Today();
            
              
                insert promo;
                
                     if(rt.DeveloperName=='Dealer'){
                       upsert testAccount1;
                     }
             
            Promotion_Member__c pm= new Promotion_Member__c();
            pm.Account__c=testAccount1.id;
            pm.Promotions2__c =promo.id;
            insert pm;
        
        string str=string.valueof(testAccount1.Contact_Number_Mobile__c);
            List<Account> Paccount=new List<Account>();   
            Paccount.add(new Account());         
            test.startTest();
            
             ApexPages.StandardController sc = new ApexPages.StandardController(promo);
             PageReference pageRef = Page.APPL_ADD_MEMBERS_DETAIL_PAGE;
               pageRef.getParameters().put('addrowsvalue','5');
        pageRef.getParameters().put('cusMobile','9308622241');
         pageRef.getParameters().put('rowIndex','1');
        
       
               pageRef.getParameters().put('id',promo.id);
               Test.setCurrentPage(pageRef);
                APPL_ADD_MEMBERS_DETAIL_CTRL obj=new APPL_ADD_MEMBERS_DETAIL_CTRL(sc);
                //System.debug(APPL_ADD_MEMBERS_DETAIL_CTRL.getCustomer('9308622241'));
                obj.ShowMembers();
                obj.more();
                obj.addMember();
                obj.getAccoutRow();
                obj.SavePromotionMembers();
                obj.accToRemove='1';
                obj.RefreshEntry();
                obj.closeWindow();
                obj.DeleteEntry();
                obj.SaveBtnHide();
               String mob='7259992222';
               String Prom='Shop Anniversary Dinner';
              APPL_ADD_MEMBERS_DETAIL_CTRL.getCustomer(mob,Prom);
               
                
            test.stopTest();
            
             }
}