@isTest
public class distributorPdfControllerTest {
    
    @isTest
    public static void testMethod1()
    {
      AP_Taluk_Master__c aptm = new AP_Taluk_Master__c(Name='TestTaluk',Region__c='West',
                                                         State__c='Gujarat',Cluster__c='Ahmedabad',District__c='Ahmedabad');
        insert aptm;
        system.debug('------------------taluk master------->>'+aptm);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c(Name='TestUTMJ',Record_Vertical__c='Plumbing',AP_Taluk_Master__c=aptm.ID);
        insert utmj;
        system.debug('------------------utmj------->>'+utmj);
        Id DlrRcdType = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId();
        Id portalOrderId = Schema.SObjectType.Order.getRecordTypeInfosByName().get('Portal').getRecordTypeId();
        system.debug('----------------record type dealer-------->'+DlrRcdType);
        
         Account testAccountDis1 = new Account(); 
        testAccountDis1 = Initial_Test_Data.createAccount('test Account1','Distributor');
        testAccountDis1.Contact_Number_Mobile__c ='7829143143'; 
        testAccountDis1.Party_Type__c='Distributor';
        testAccountDis1.District__c='Bangalore';
        testAccountDis1.State__c='Karnataka';
        testAccountDis1.Business_Line__c='Plumbing';
        testAccountDis1.Status__c='Existing';
        testAccountDis1.Ramco_ID__c='12345';
        testAccountDis1.SAP_id_DP__c='1222';
        testAccountDis1.Year_Since_in_Business__c='2019';
        testAccountDis1.VAT_CST_Number__c='101010000000000';
         testAccountDis1.Accountant__c='Yes';
        testAccountDis1.Total_Annual_Turnover__c=150;
         testAccountDis1.Annual_Ashirvad_Turnover__c=7876555;
        testAccountDis1.Accounting_software_installed__c='Yes';
        testAccountDis1.Avg_Credit_days_offered_in_market__c=10;
        testAccountDis1.Dedicated_office_space__c='Yes';
       testAccountDis1.Distribution_as_a_part_of_total_business__c=15;
        testAccountDis1.Size_of_Dedicated_godown_for_Ashirvad__c=15;
       testAccountDis1.Total_working_capital_investment__c=133;
        testAccountDis1.Borrowed_capital__c=133;
        testAccountDis1.Name_of_software__c='hbkj';
       testAccountDis1.Expected_AA_contribution_in_total_busi__c=10;
                testAccountDis1.Products__c='Air Admittance Valve';

                        testAccountDis1.Business_Line__c='Plumbing';
                testAccountDis1.APPL_Taluk__c=utmj.Id;
                        testAccountDis1.PIN_Code__c='464001';

        insert testAccountDis1; 
        
        Account acc1 = new Account(Name='testName',Primary_Contact_Person_Name__c='testContactPerson',ParentId= testAccountDis1.Id,
                                                   Status__c='Existing',Classification__c='Adopted',Purchase_Cycle__c='Weekly',
                                                   Contact_Number_Mobile__c='7829140470',Type_of_Dealer__c='Sanitary',Annual_Ashirvad_Turnover__c=7876555,Year_Since_in_Business__c='2019',
                                                   Display_of_our_product__c='Prominent',Media__c='In Shop',Sub_Media__c='Sunboard',
                                                   APPL_Taluk__c=utmj.ID,Discount__c=40,recordtypeid=DlrRcdType,VAT_CST_Number__c='101010000000000',Products__c='Air Admittance Valve',Business_Line__c='Plumbing',PIN_Code__c='464001');
         
        system.debug('------------------acc1------->>'+acc1);
        try{
            insert acc1;
        }catch(exception e){
            system.debug('------------------exception-------->'+e);
        }
         
     
        
        Order newOrder = new Order(
                                Status  = 'Draft',
                                AccountId = acc1.Id, 
                                EffectiveDate = Date.today(),
            					RecordTypeId = portalOrderId
                                );
        
        
        try{
           insert newOrder; 
        }catch(exception e){
            system.debug('------------------exception-------->'+e);
        }
        
        
        Product2 newPro = new Product2( Name = 'prod1',IsActive=true,ProductCode ='70000000');
        insert newPro;

        Product2 newPro1 = new Product2( Name = 'prod2',IsActive=true,ProductCode ='70000001');
        insert newPro1;
        
        Dealer_Order_line_item__c item1= new Dealer_Order_line_item__c(Order__c = newOrder.id, Product__c=newPro.id,Quantity__c= 20 );
        insert item1;
        
        Dealer_Order_line_item__c item2= new Dealer_Order_line_item__c(Order__c = newOrder.id, Product__c=newPro1.id,Quantity__c= 40 );
        insert item2;
        
        Test.setCurrentPageReference(new PageReference('Page.DistributorPDF'));
        System.currentPageReference().getParameters().put('id', testAccountDis1.id);
        DistributorPdfController distPdf = new DistributorPdfController(new ApexPages.StandardController(testAccountDis1));
            
        
    }

}