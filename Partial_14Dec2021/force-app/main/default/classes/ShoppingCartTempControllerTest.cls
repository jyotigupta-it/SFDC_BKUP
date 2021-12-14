@isTest 
public class ShoppingCartTempControllerTest {
    private static Account testAccount1;
    
    @isTest public static void testCoverage1(){
        AP_Taluk_Master__c aptm = new AP_Taluk_Master__c(Name='TestTaluk',Region__c='West',
                                                         State__c='Gujarat',Cluster__c='Ahmedabad',District__c='Ahmedabad');
        insert aptm;
        system.debug('------------------taluk master------->>'+aptm);
        
        User_Taluk_Master_Junction__c utmj = new User_Taluk_Master_Junction__c(Name='TestUTMJ',Record_Vertical__c='Plumbing',AP_Taluk_Master__c=aptm.ID);
        insert utmj;
        Product2 pr = new Product2();
        pr.Name= 'Test';
        pr.Available_Fot_cart__c=true;
        insert pr;
        testAccount1 = Initial_Test_Data.createAccount('Test Account1', 'Dealer');
        testAccount1.Contact_Number_Mobile__c ='7259582222';
        testAccount1.Party_Type__c='Dealer';
        testAccount1.Year_Since_in_Business__c='2019';
        testAccount1.If_Yes_Products__c='test';
        testAccount1.If_others__c='test';
        testAccount1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount1.VAT_CST_Number__c='101010000000000';
        testAccount1.Conversion_Probability__c='High';
        // testAccount1.Parent.id=acc.id;
        testAccount1.PIN_Code__c='562106';
        testAccount1.UPVC_Discount__c=0;
        testAccount1.Column_Discount_Amount__c=0;
        testAccount1.Discount__c=0;
        testAccount1.SWR_Discount__c=0;
        testAccount1.Accountant__c='YES';
        testAccount1.Products__c='Air Admittance Valve';
        testAccount1.Business_Line__c='Plumbing';
        testAccount1.PIN_Code__c='464001';
        testAccount1.APPL_Taluk__c=utmj.Id;
        
        
        insert testAccount1;
        
        Order_portal_session_Id__c cs = new Order_portal_session_Id__c();
        cs.name = testAccount1.id;
        cs.session_id__c = null;
        insert cs;
        
        
        
        System.currentPageReference().getParameters().put('dealer', testAccount1.Id);
        System.currentPageReference().getParameters().put('sessionId', '100');
        ShoppingCartPageTempController sc = new ShoppingCartPageTempController();
        sc.dealer = testAccount1.Id;
        String dealer=testAccount1.Id;
        Test.setCurrentPageReference(new PageReference('Page.ShoppinCartPageTemp'));
                String dealerId= ShoppingCartPageTempController.encryptData(dealer);

        System.currentPageReference().getParameters().put('dealer', dealerId);
        Test.setCurrentPageReference(new PageReference('Page.ShoppingCartPDF'));
        Id OrderRecID = Schema.SObjectType.Order.getRecordTypeInfosByName().get('Portal').getRecordTypeId();
        Order order = new Order();
        order.AccountId = testAccount1.Id;
        order.RecordTypeId = OrderRecID;
        order.Status='Submitted';
        order.EffectiveDate=System.today();
        insert order;
        String orId= ShoppingCartPageTempController.encryptData(order.Id);
        System.currentPageReference().getParameters().put('orderId', orId);
        Product2 pro = new Product2();
        pro.Family='Test';
        pro.Name='Test';
        insert pro;
        Dealer_Order_line_item__c oli = new Dealer_Order_line_item__c();
        oli.Order__c = order.id;
        insert oli;
        sc.jsonString = '[{"productToPlace":"'+pro.Id+'","quantityOfProduct":"2"}]';
        sc.placeOrder();
        sc.fetchProductLine(); 
       sc.backToOrder();
        system.debug('testtt2==>'+testAccount1.Id);
        sc.dealer = testAccount1.Id;
        sc.logOutCon();
        new ShoppingCartPageTempController().onLoad();
        
    }
}