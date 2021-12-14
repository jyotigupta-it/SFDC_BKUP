@isTest
public  class Test_UploadExpenseAttachments {
    public static AP_Expenses__c expense;
    public static Target__c target;
    public static AP_Tour_Plan__c tourplan;
    public static User userdata;

   static testMethod void init() {
        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
        insert userdata ;
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        insert target;
        tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Target__c = target.ID;
        insert tourplan;
        expense = Test_Intial_Data_Phase2.CreateExpense(tourplan.Id);
        expense.TourPlan__c = tourplan.ID;
        insert expense ; 
        Test.setCurrentPageReference(new PageReference('Page.AP_Expenses_Sheet')); 
        System.currentPageReference().getParameters().put('expId', expense.id);

        Blob b = Blob.valueOf('Test Data');
        Attachment attachment1 = new Attachment();
        attachment1.ParentId = expense.ID;
        attachment1.Name = 'Test Attachment for Parent';
        attachment1.Body = b;
        List<Attachment> att=new List<Attachment>();
        att.add(attachment1);
        test.starttest();
        UploadExpenseAttachments_Ctrl uploadexp = new UploadExpenseAttachments_Ctrl();
        uploadexp.allFileList=att;
        uploadexp.FileCount = '1';
        
        uploadexp.SaveAttachments();
        //uploadexp.ChangeCount();
        test.stoptest();   
    }
    public static  testmethod void init2(){
      
   

   
        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
        insert userdata ;
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        insert target;
        tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Target__c = target.ID;
        insert tourplan;
        expense = Test_Intial_Data_Phase2.CreateExpense(tourplan.Id);
        expense.TourPlan__c = tourplan.ID;
        insert expense ; 
        Test.setCurrentPageReference(new PageReference('Page.AP_Expenses_Sheet')); 
        System.currentPageReference().getParameters().put('expId', expense.id);

        Blob b = Blob.valueOf('Test Data');
        Attachment attachment1 = new Attachment();
        attachment1.ParentId = expense.ID;
        attachment1.Name = 'Test Attachment for Parent';
        attachment1.Body = b;
        List<Attachment> att=new List<Attachment>();
        att.add(attachment1);
        test.starttest();
        UploadExpenseAttachments_Ctrl uploadexp = new UploadExpenseAttachments_Ctrl();
        uploadexp.allFileList=att;
        uploadexp.FileCount = '1';
         uploadexp.ChangeCount();
        uploadexp.SaveAttachments();
       
        test.stoptest();   
  
    }
}