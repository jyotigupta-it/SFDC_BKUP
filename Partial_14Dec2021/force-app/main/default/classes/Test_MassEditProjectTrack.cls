/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :26-Jan-2015
Modified Date   :
Version         :1.0
Description     :Test class for MassEditProjectTracker 

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_MassEditProjectTrack {

	static User testUser;
	static Product2 testProduct;
	static PricebookEntry testPriceEntry;
	static Account testAccount;
	static Opportunity testOpp;
	static Project_Tracker__c testPT;
	
	static void init() {

		testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
		insert testUser;

		testProduct = Initial_Test_Data.createProduct('Test Product');
		insert testProduct;

		Id stdpb = Test.getStandardPricebookId();
		testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
		insert testPriceEntry;
 
		testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
		testAccount.Contact_Number_Mobile__c = '9766631218';
		insert testAccount;

		testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
		insert testOpp;

		testPT = Initial_Test_Data.createPTracker(testOpp.Id);
		insert testPT;

	}


	@isTest static void test_method_one() {
		init();
		system.runAs(testUser) {

			Test.startTest();
				//ApexPages.StandardController sc = new ApexPages.StandardController(testUser);
				PageReference pageRef = new PageReference('/apex/MassEditProjectTracker');
	            Test.setCurrentPage(pageRef);
	            ApexPages.currentPage().getParameters().put('ProjectId',testOpp.Id);
	            //ApexPages.currentPage().getParameters().put('applType','probType');
	            
	            MassEditProjectTracker oppController = new MassEditProjectTracker();
	            oppController.updateProjectTracker();
	            oppController.cancel();

			Test.stopTest();
			
		}
	}
	
	
}