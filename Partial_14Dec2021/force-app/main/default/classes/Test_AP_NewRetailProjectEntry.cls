@isTest(seeAllData=false)
private class Test_AP_NewRetailProjectEntry {
    
    static User testUser;    
    static Account testAccount;
    static Account testAccountIndividual;
    static Opportunity testOpp;
    static OpportunityLineItem testOppLI;
    static Influencer__c testInflu;
    static Project_Tracker__c testPT;
    static Influencer_types__c infCustom;
    static Project_Tracker_Questions__c projectCustom;

    static void init() {

        testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
        insert testUser;
        testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
        testAccount.Contact_Number_Mobile__c = '9765412238';
        insert testAccount;
        testAccountIndividual = Initial_Test_Data.createAccount('Test Account', 'Individual Contacts');
        testAccountIndividual.Contact_Number_Mobile__c = '9679412238';
        insert testAccountIndividual;

        testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
        //insert testOpp;
        testInflu = Initial_Test_Data.createInfluencer(testOpp.Id);
        testInflu.Update_of_Last_Visit__c = 'Test';
        //insert testInflu;

        infCustom = new Influencer_types__c();
        infCustom.Type__c='Site Engineer';
        infCustom.Name='Type 1';
        //infCustom.
        insert infCustom;

        projectCustom = new Project_Tracker_Questions__c();
        projectCustom.Question__c='All Product range approved';
        projectCustom.Name='Question 1';
        insert projectCustom;


    }

    @isTest static void test_method_one() {
        init();
        system.runAs(testUser) {

            Test.startTest();
                ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
                PageReference pageRef = new PageReference('/apex/AP_NewRetailProjectPage');
                Test.setCurrentPage(pageRef);                                
                AP_NewRetailProjectEntry oppController = new AP_NewRetailProjectEntry(sc);                
                oppController.opportunityRecord = testOpp;
                oppController.saveProject();
                oppController.calRender();
               AP_NewRetailProjectEntry.getAccountInfo(testAccountIndividual.Name);
                oppController.cancel();  
                oppController.projectCategoryVal();              
            Test.stopTest();
            
        }
    }    
}