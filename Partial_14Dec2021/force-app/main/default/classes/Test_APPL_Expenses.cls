@isTest
public  class Test_APPL_Expenses {
    public static AP_Expenses__c expense;
    public static Target__c target;
    public static AP_Tour_Plan__c tourplan;
    public static User userdata;
    
    public static void init() {
        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
        insert userdata ;
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        insert target;
        Test.setCurrentPageReference(new PageReference('Page.AP_Expenses_Sheet')); 
        System.currentPageReference().getParameters().put('id', target.ID);
        tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Target__c = target.ID;
        insert tourplan;
        expense = Test_Intial_Data_Phase2.CreateExpense(tourplan.Id);
        expense.TourPlan__c = tourplan.ID;
        insert expense ; 
        
    }
    
    public static testmethod void testone() {
        
        init();
        test.startTest();
        ApexPages.StandardController Controller = new ApexPages.StandardController(target);
        APPL_EXPENSE_SHEET_CTRL exp = new APPL_EXPENSE_SHEET_CTRL(Controller);
        test.stopTest();
    }
}