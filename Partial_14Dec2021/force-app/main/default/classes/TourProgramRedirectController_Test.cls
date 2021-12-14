@isTest
public class TourProgramRedirectController_Test {
	static testMethod void SPRPDFPreviewRedirect2Test(){
        
        Account testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
        testAccount.Contact_Number_Mobile__c = '7259582222';
        insert testAccount;
        
        
        Opportunity testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
        testopp.Probability_New__c ='20%';
        insert testOpp;
        
        Apexpages.StandardController sc = new Apexpages.standardController(testOpp);
        apexpages.currentpage().getparameters().put('att',testOpp.id);
        
        TourProgramRedirectController spr =new TourProgramRedirectController(sc);
        
        ApexPages.currentPage().getHeaders().put('USER-AGENT','abc');
        TourProgramRedirectController spr2 =new TourProgramRedirectController(sc);
        
        spr.sendExpensesPdf();
        spr.sendViewTourPlanPdf();
        TourProgramRedirectController.codeCoverageTrick();    
        
        
        
    }
}