/*******************XXX**********************************

Created By      :Mohd.Numaan Ahmed
Created Date    :26-Jan-2015
Modified Date   :
Version         :1.0
Description     :Test class for MassEditInfulencers 

********************XXX***********************************/
@isTest(seeAllData=false)
private class Test_MassEditInfulencers {

	static User testUser;
	static Product2 testProduct;
	static PricebookEntry testPriceEntry;
	static Account testAccount;
	static Opportunity testOpp;
	static Influencer__c testInflu;
	
	static void init() {

		testUser = Initial_Test_Data.createUser('First','Last','System Administrator');
		insert testUser;

		testProduct = Initial_Test_Data.createProduct('Test Product');
		insert testProduct;

		Id stdpb = Test.getStandardPricebookId();
		testPriceEntry = Initial_Test_Data.createPriceBookEntry(stdpb, testProduct.Id);
		insert testPriceEntry;
 
		testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
		testAccount.Contact_Number_Mobile__c = '9765477738';
		insert testAccount;

		testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
		insert testOpp;

		testInflu = Initial_Test_Data.createInfluencer(testOpp.Id);
		insert testInflu;

	}

	@isTest static void test_method_one() {
		init();
		system.runAs(testUser) {

			Test.startTest();
				
				PageReference pageRef = new PageReference('/apex/MassEditInfulencers');
	            Test.setCurrentPage(pageRef);
	            ApexPages.currentPage().getParameters().put('ProjectId',testOpp.Id);
	            MassEditInfulencers oppController = new MassEditInfulencers();
	            oppController.updateInfluencers();
	            oppController.cancel();
				oppController.runOrderQuery();
			Test.stopTest();
		}
	}
}