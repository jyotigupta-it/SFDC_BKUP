/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :02-Mar-2015
Modified Date   :
Version         :1.0
Description     :Test class for Addl_Disc_Component_Controller

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_Addl_Disc_Component {
    
    static User testUser;
    static Product2 testProduct;
    static Pricebook2 testPricebook;
    static PricebookEntry testPriceEntry;
    static PricebookEntry testPriceEntry2;
    static Account testAccount;
    static Opportunity testOpp;
    static OpportunityLineItem testOppLI;
    static Influencer__c testInfo ;
    static User HBUser;
    static User RBMUser;
    static void init() {

            testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
            testUser.EmployeeNumber ='12364';
            insert testUser;

        

            testProduct = Initial_Test_Data.createProduct('Test Product');
            insert testProduct;

            Id stdpb = Test.getStandardPricebookId();
            testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
            insert testPriceEntry;
            
            testPricebook = Initial_Test_Data.createPriceBook('Project');
            insert testPricebook;

            testPriceEntry2 = Initial_Test_Data.createPriceBookEntry(testPricebook.Id, testProduct.Id);
            insert testPriceEntry2;

            testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
            testAccount.Contact_Number_Mobile__c = '9765341281';
            testAccount.Business_Line__c='Plumbing';
            testAccount.State__c='Karnataka';
            testAccount.District__c='Bangalore';
            insert testAccount;

            testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
            testOpp.Order_Placement__c = 'Distributor';
            testOpp.Probability_New__c='100%';
            testOpp.Special_Pricing_Request_Approval__c='Not Submitted';
            insert testOpp;

            testOppLI = Initial_Test_Data.createOppLineItem(testOpp.Id,'APPL Probability',testPriceEntry2.Id);
            testOppLI.Probability_Check__c = true;
            testOppLI.Offer_Check__c = true;
            testOppLI.Offer_MRP__c = 1000;
            testOppLI.APPL_STD_Discount__c = 55.0;
            testOppLI.Addl_Discount_Required__c = 60.0;
            testOppLI.ORC_Margin_to_Dlr_Dist__c = 3.0;
            testOppLI.Quantity = 1;
            //testOppLI.Probability_New__c=10;
          //  testOppLI.Order_Placement__c = 'Distributor';
            insert testOppLI;

    }
    
    

    
     @isTest static void test_method_two() {
        init();
        system.runAs(testUser) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD'];
        User userManager1 = new User(Alias = 'sUser1', 
                                  Email= 'FName1'+'LName1'+'@TestUser11.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName1+LName2+@Test1232.com',
                                  EmployeeNumber ='12354'
                                 );
               insert userManager1;

 User userDataManager = new User(Alias = 'stan', 
                                  Email= 'FName1'+'LName1'+'@TestUser98.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName1+LName2+@TestUs232.com',
                                  Intial_Project_Approver__c=userManager1.Id,
                                  EmployeeNumber ='12365'
                                  );
    
    insert userDataManager;
            Test.startTest();
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
                                  Intial_Project_Approver__c=userDataManager.id,
                                  EmployeeNumber ='12362'
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
                                  EmployeeNumber ='12264'
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
    op.Order_Placement__c='Distributor';
   // op.Taluk__c=getId.id;
   op.CloseDate=system.today();
    op.No_of_Bathrooms__c=7;
    op.Special_Pricing_Request_Approval__c='Approved';
    //op.checked_if_Approved__c=true;
    opList.add(op);
insert opList;
Influencer__c inf=new Influencer__c();
    inf.Account__c=testAccount.id;
    //inf.Contact__c='';
    inf.Influencer_Type__c='Project Manager';
    //inf.Inf_Order__c='';
    inf.Opportunity__c=opList[0].Id;
    insert inf;
 testOppLI = Initial_Test_Data.createOppLineItem(op.Id,'APPL Probability',testPriceEntry2.Id);
            testOppLI.Probability_Check__c = true;
            testOppLI.Offer_Check__c = true;
            testOppLI.Offer_MRP__c = 1000;
            testOppLI.APPL_STD_Discount__c = 55.0;
            testOppLI.Addl_Discount_Required__c = 60.0;
            testOppLI.ORC_Margin_to_Dlr_Dist__c = 3.0;
            testOppLI.Quantity = 1;
            // testOppLI.Probability_New__c=10;
          //testOppLI.Order_Placement__c = 'Distributor';
            insert testOppLI;
//
 //PageReference pageRef = Page.ProjectDetails_PDF;
   //     pageRef.getParameters().put('opporId',op.Id);// String.valueOf()
   //     Test.setCurrentPage(pageRef);
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

                Addl_Disc_Component_Controller oppController = new Addl_Disc_Component_Controller();
                oppController.oppId = op.id;
                oppController.getOppDetails();
                System.debug(oppController.getData());
            Test.stopTest();
            
        }
    }
    @isTest static void test_method_three() {
        init();
        system.runAs(testUser) {
Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD'];
User userManager1 = new User(Alias = 'sUser1', 
                                  Email= 'FName1'+'LName1'+'@Test12.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName1+LName2+@Test2.com',
                                  EmployeeNumber ='123642'
                                 );
               insert userManager1;

 User userDataManager = new User(Alias = 'stan', 
                                  Email= 'FName1'+'LName1'+'@TestUser98.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName1+LName2+@TestUs232.com',
                                  EmployeeNumber ='123643'
                                  );
    
    insert userDataManager;
            Test.startTest();
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
                                    Intial_Project_Approver__c=userDataManager.id,
                                    EmployeeNumber ='123644'
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
                                    Intial_Project_Approver__c=userManager1.id,                     //Added
                                    EmployeeNumber ='123646'
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
    op.Order_Placement__c='Contractor';
    op.Special_Pricing_Request_Approval__c='Approved';
    //op.checked_if_Approved__c=true;
    opList.add(op);
insert opList;
Influencer__c inf=new Influencer__c();
    inf.Account__c=testAccount.id;
    //inf.Contact__c='';
    inf.Influencer_Type__c='Contractor';
    //inf.Inf_Order__c='';
    inf.Opportunity__c=opList[0].Id;
    insert inf;
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
//
 //PageReference pageRef = Page.ProjectDetails_PDF;
   //     pageRef.getParameters().put('opporId',op.Id);// String.valueOf()
   //     Test.setCurrentPage(pageRef);
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

                Addl_Disc_Component_Controller oppController = new Addl_Disc_Component_Controller();
                oppController.oppId = op.id;
                oppController.getOppDetails();
                System.debug(oppController.getData());
            Test.stopTest();
            
        }
    }
    

    
    
    testmethod static void test_method_one() {
        init();
        system.runAs(testUser) {
Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD'];
User userManager1 = new User(Alias = 'sUser1', 
                                  Email= 'FName1'+'LName1'+'@Test22.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName1+LName2+@Test3.com',
                                  EmployeeNumber ='123649'
                                 );
               insert userManager1;

 User userDataManager = new User(Alias = 'stan', 
                                  Email= 'FName1'+'LName1'+'@TestUser98.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName2', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName1+LName2+@TestUs232.com',
                                    Intial_Project_Approver__c=userManager1.id,    //Added
                                    EmployeeNumber ='123648'
                                  );
    
    insert userDataManager;
            Test.startTest();
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
                                    Intial_Project_Approver__c=userDataManager.id,
                                    EmployeeNumber ='12364'
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
                                    Intial_Project_Approver__c=userManager1.id,    //Added
                                    EmployeeNumber ='123264'
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
    op.Order_Placement__c='Customer';
    op.Special_Pricing_Request_Approval__c='Approved';
    //op.checked_if_Approved__c=true;
    opList.add(op);
    
   
    
insert opList;
 Influencer__c inf=new Influencer__c();
    inf.Account__c=testAccount.id;
    //inf.Contact__c='';
    inf.Influencer_Type__c='Purchase Manager';
    //inf.Inf_Order__c='';
    inf.Opportunity__c=opList[0].Id;
    insert inf;
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
//
 //PageReference pageRef = Page.ProjectDetails_PDF;
   //     pageRef.getParameters().put('opporId',op.Id);// String.valueOf()
   //     Test.setCurrentPage(pageRef);
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

                Addl_Disc_Component_Controller oppController = new Addl_Disc_Component_Controller();
                oppController.oppId = op.id;
                oppController.getOppDetails();
                oppController.changeStatus=new List<Addl_Disc_Component_Controller.statusCorrection>{new Addl_Disc_Component_Controller.statusCorrection()};
                System.debug(oppController.getData());
            Test.stopTest();
            
        }
    }
    
}