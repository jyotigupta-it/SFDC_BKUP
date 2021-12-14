//Test class for APPL_NEW_PROMOTION_CTRL.
@isTest
private class Test_APPL_NEW_PROMOTION_CTRL
{   
    //Account - Distributor
    //Account - 3
    //Promotion
    //Promotion Members
    static User testUser;
    private static Account testAccountDis1;
    private static Account testAccount1;
    private static Account testAccount2;
    private static Account accDistributor;

    static Account testAccount;
    static Opportunity testOpp;

    private static Promotion__c newPromotion;
    private static Promotion_Member__c proMember1;
    private static Promotion_Member__c proMember2;
    private static Promotion_Member__c proMember3;


    // initializing test data
    private static void init()
    {
        

    }

    private static testMethod void promotionUnitTest() {
        
        testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
        insert testUser;
        
       
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

        //Start Test
         System.Test.startTest();
        //Call the VF Page
        pagereference pr=new pagereference('/apex/createPromotion_v2?promoDate=04/05/2015');
        System.Test.setCurrentPageReference(pr);
        //Creating Instance of the Controller
       // APPL_NEW_PROMOTION_CTRL  promotionInstance = new APPL_NEW_PROMOTION_CTRL();
        APPL_NEW_PROMOTION_CTRL_Modified promotionInstance= new APPL_NEW_PROMOTION_CTRL_Modified();

        newPromotion = Test_Intial_Data_Phase2.CreatePromotion('Architects Meet');
        insert newPromotion;
        
            
         promotionInstance.newpromotion.Date__c= date.today();
         promotionInstance.newpromotion.Type__c = 'Dealer';
         promotionInstance.newpromotion.Total_Expenses__c = 1000;
         promotionInstance.newpromotion.Total_no_of_attendees__c = 10;
         promotionInstance.newpromotion.State__c = 'Karnataka';
         promotionInstance.newpromotion.Location__c = 'BTM';
         promotionInstance.newpromotion.Distributor__c=testAccountDis1.id;
       //  promotionInstance.newpromotion.Total_no_of_attendees__c = 1;
       
       insert promotionInstance.newPromotion;
        System.debug('promotionInstance '+promotionInstance.newPromotion);
         // for expense table child object new modification
         list<Promotion__c> nw=[Select Name from Promotion__c where id =:newpromotion.id];
        List<PromotionExpenseTable__c> newpromotionExpenseList= new List<PromotionExpenseTable__c>();
       List<PromotionExpenseTable__c> expTableList=new List<PromotionExpenseTable__c>();
        for(integer i=0;i<5;i++){
        PromotionExpenseTable__c expTable=new PromotionExpenseTable__c();
        expTable.Promotion__c=promotionInstance.newPromotion.id;
        expTable.Dealer_share__c=5;
        expTable.Nature_of_Expenditure__c='Gift Expenses';
        expTable.Remarks__c='test record';
        expTable.Total_Expenses__c=100;
        expTable.RecordEdit__c=true;
        expTableList.add(expTable);
       }
        
        insert expTableList;
         
       // for expense table child object new modification test data ends here 
        
         promotionInstance.CreatePromotion();
         promotionInstance.addMember();
         //promotionInstance.addMember();
        

        list<account> acc = new list<account>();
       // acc = APPL_NEW_PROMOTION_CTRL.getCustomer('725');
        acc =APPL_NEW_PROMOTION_CTRL_Modified.getCustomer('725','Shop Anniversary Dinner');
        promotionInstance.proAccounts[0] = testAccount1;
        //promotionInstance.proAccounts[0].name = 'test';
        apexpages.currentpage().getparameters().put('rowIndex' , '1');
        apexpages.currentpage().getparameters().put('cusMobile','7259582222');
        promotionInstance.getAccoutRow();
        promotionInstance.CancelToPromo();
        promotionInstance.showAddMemberPanel=true;
        proMember1 = Test_Intial_Data_Phase2.CreatePromotionMember(newPromotion.Id, testAccount1.Id);
        insert proMember1;
        System.debug(proMember1+'=proMember1');
        
        proMember2 = Test_Intial_Data_Phase2.CreatePromotionMember(newPromotion.Id, testAccount2.Id);
        insert proMember2;
        System.debug(proMember2+'=proMember2');
        promotionInstance.SavePromotionMembers();
        promotionInstance.CancelToPromo();
        promotionInstance.CanelPromotion();
        apexpages.currentpage().getparameters().put('cusMobile','8959582222');
        
        promotionInstance.accToRefresh= testAccountDis1.id;
        promotionInstance.accToRemove= '1';
        promotionInstance.getAccoutRow();
        promotionInstance.RefreshEntry();
        promotionInstance.DeleteEntry();
        promotionInstance.newpromotionExpense();
         pageReference pager = page.APPL_NEW_PROMOTION_Modified;
         System.Test.setCurrentPage(pager);
         apexPages.Currentpage().getParameters().put('expListCount','1');
         try{
          promotionInstance.ShowMembers();
          promotionInstance.CancelPL();
          promotionInstance.EditPL();
          promotionInstance.SavePL();
          expTableList.add(new PromotionExpenseTable__c());
          pageReference pager2 = page.APPL_NEW_PROMOTION_Modified;
          System.Test.setCurrentPage(pager2);
          apexPages.Currentpage().getParameters().put('expListCount','4');
          promotionInstance.RemovePL();
       
         //System.Test.stopTest();
}
        catch(exception e){
            system.debug('error message'+e.getMessage()+' at line nO:'+e.getLineNumber());
        }
        //APPL_NEW_PROMOTION_CTRL.getCustomer('725');
        //
        
        try{ 
            promotionInstance.newpromotion.Date__c= date.today();
            promotionInstance.newpromotion.Type__c = 'Dealer';
            promotionInstance.newpromotion.Total_Expenses__c = 1000;
            promotionInstance.newpromotion.Total_no_of_attendees__c = 10;
            promotionInstance.newpromotion.State__c = 'Karnataka';
            promotionInstance.newpromotion.Location__c = 'BTM';
            promotionInstance.newpromotion.Distributor__c=testAccountDis1.id;
       //  promotionInstance.newpromotion.Total_no_of_attendees__c = 1;
       
            insert promotionInstance.newPromotion;
            System.debug('promotionInstance '+promotionInstance.newPromotion);
            PageReference pager3 = page.new_Promotion_PDF;
            System.Test.setCurrentPage(pager3);
            string a=apexPages.Currentpage().getParameters().put('id',promotionInstance.newPromotion.id);
            system.debug(a);
            NewPromotionPDFController nRerd=new NewPromotionPDFController();
            nRerd.promoId=string.valueOf(promotionInstance.newPromotion.id);
            nRerd.promoRecord=newPromotion;
            nRerd.promoRecord.id=promotionInstance.newPromotion.id;
            
            insert nRerd.promoRecord;
            List<PromotionExpenseTable__c> tableOBJ=new List<PromotionExpenseTable__c>();
            nRerd.promoExpenseTableRecords=expTableList;
            for(PromotionExpenseTable__c tes:nRerd.promoExpenseTableRecords){
            tes.Promotion__c=nRerd.promoRecord.id;
              tableOBJ.add(tes);  
            }
            insert tableOBJ;
            APPL_NEW_PROMOTION_CTRL_Modified appll=new APPL_NEW_PROMOTION_CTRL_Modified();
            newpromotionExpenseList = new List<PromotionExpenseTable__c>();
        Promotion__c newpromotion2 = new Promotion__c();
        newpromotion2  = newpromotion;
        
        newpromotion = new Promotion__c();   
        newpromotion.Vertical__c = newpromotion2.Vertical__c;
        newpromotion.Type__c = '';
       Boolean showPromotion = true;
       Boolean showAddMember = false;
       Boolean showPromotionSaveBtn = false;
        Boolean showsavepromoButton = false;
        Boolean showsaveAndAddButton = false;
        //system.debug('the raja is:'+showPromotion);
            appll.resetVariables();
        }
        catch(exception e){
          system.debug('exception .....'+e);   
        }
       System.Test.stopTest();
        //End of Test Method       
    }   
}