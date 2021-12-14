@isTest(SeeAllData=true)
public class Test_GetApproval {
    static Product2 testProduct;
    static Pricebook2 testPricebook;
    static PricebookEntry testPriceEntry;
    static PricebookEntry testPriceEntry2;
    static Account testAccount;
    static Opportunity testOpp;
    static OpportunityLineItem testOppLI;
     public static testMethod void insertOpp(){ 
          testProduct = Initial_Test_Data.createProduct('Test Product');
            insert testProduct;

            Id stdpb = Test.getStandardPricebookId();
            testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
            insert testPriceEntry;
            
            testPricebook = Initial_Test_Data.createPriceBook('Project');
            insert testPricebook;

            testPriceEntry2 = Initial_Test_Data.createPriceBookEntry(testPricebook.Id, testProduct.Id);
            insert testPriceEntry2;
         
          Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD'];
   
            User userDataManager = new User(Alias = 'stan', 
                                  Email= 'FName1'+'LName1'+'@TestUser98.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  EmployeeNumber='12345',
                                  Intial_Project_Approver__c=userinfo.getUserId(),
                                  Project_Approver__c=userinfo.getUserId(),
                                  UserName= 'FName1+LName2+@TestUs232.com'
                                  );
    
    insert userDataManager;

     List<Opportunity> opList=new List<Opportunity>();
    
        User userData = new User(Alias = 'standt1', 
                                  Email= 'FName'+'LName'+'@TestUser99.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName',
                                  LastName = 'LName', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName+LName+@TestUs232.com',
                                  Intial_Project_Approver__c=userinfo.getUserId(),
                                  Project_Approver__c=userinfo.getUserId(),
                                  EmployeeNumber='123433',
                                  ManagerId=userDataManager.id
                                  );
    
    insert userData;
    List<Id> listUser=new List<Id>();
        
     User userDataNextApprover = new User(Alias = 'standt1', 
                                  Email= 'FName6'+'LName9'+'@TestU.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName6',
                                  LastName = 'LName9', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName6+LName9+@TesUs232.com',
                                  EmployeeNumber='1234',
                                 Intial_Project_Approver__c=userinfo.getUserId(),
                                  Project_Approver__c=userinfo.getUserId(),
                                  ManagerId=userDataManager.id
                                  );
    
    insert userDataNextApprover; 
          listUser.add(userDataNextApprover.Id);
    Opportunity op= new Opportunity();
    op.ownerId=userData.Id;
    op.name='Test';
    op.ownerId=userData.Id;
    op.StageName='Designing';
    op.Project_Type__c='Mixed';
    op.Probability_New__c='80%';
    op.Average_Discount__c=5;
   // op.Taluk__c=getId.id;
   op.CloseDate=system.today();
    op.No_of_Bathrooms__c=7;
    op.Special_Pricing_Request_Approval__c='Not Submitted';
    opList.add(op);
insert opList;
//
 PageReference pageRef = Page.ProjectDetails_PDF;
        pageRef.getParameters().put('opporId',op.Id);// String.valueOf()
        Test.setCurrentPage(pageRef);
    //     system.runAs(userData) {        
       approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();     
       req1.setComments('Submitting record for approval.');
       req1.setNextApproverIds(listUser);
       req1.setObjectId(op.id);
       req1.setSubmitterId(op.ownerId);
       approval.ProcessResult result = Approval.process(req1);
         System.assert(result.isSuccess());

         
// workitem
 List<Id> newWorkItemIds = result.getNewWorkitemIds();
    Approval.ProcessWorkitemRequest req2 = 
        new Approval.ProcessWorkitemRequest();
    req2.setComments('Approving request.');
    req2.setAction('Approve');
    req2.setNextApproverIds(listUser);
    req2.setWorkitemId(newWorkItemIds.get(0));
    Approval.ProcessResult result2 =  Approval.process(req2);
    //     }       
     //opportunity Products
     //
      testOppLI = Initial_Test_Data.createOppLineItem(op.Id,'APPL Probability',testPriceEntry2.Id);
            testOppLI.Probability_Check__c = true;
            testOppLI.Offer_Check__c = true;
            testOppLI.Offer_MRP__c = 1000;
            testOppLI.APPL_STD_Discount__c = 55.0;
            testOppLI.Addl_Discount_Required__c = 60.0;
            testOppLI.ORC_Margin_to_Dlr_Dist__c = 3.0;
            testOppLI.Quantity = 1;
            
            // testOppLI.Probability_New__c=10;
          //  testOppLI.Order_Placement__c = 'Distributor';
            insert testOppLI;

     test.startTest();
         
         //ApexPages.StandardController sc = new ApexPages.standardController(op);
         Addl_Disc_Component_Controller ob=new Addl_Disc_Component_Controller();
         GetApproval obj=new GetApproval(ob);
         GetApproval.wrapProcessInstance wrapOBJ=new GetApproval.wrapProcessInstance();
            
       
     
        test.stopTest();
         
     }  

}