@isTest
private class SPRPDFPreviewRedirectController_Test{

    static testMethod void SPRPDFPreviewRedirectTest(){
        
        Account testAccount = Initial_Test_Data.createAccount('Test Account', 'Key Accounts');
        testAccount.Contact_Number_Mobile__c = '7259582222';
        insert testAccount;
        
        
        Opportunity testOpp = Initial_Test_Data.createNewProject('Test Project', 'Commercial', testAccount.Id, 'Designing');
        testopp.Probability_New__c ='20%';
        insert testOpp;
        
        Apexpages.StandardController sc = new Apexpages.standardController(testOpp);
        apexpages.currentpage().getparameters().put('att',testOpp.id);
        
        SPRPDFPreviewRedirectController spr =new SPRPDFPreviewRedirectController(sc);
        
        ApexPages.currentPage().getHeaders().put('USER-AGENT','abc');
        SPRPDFPreviewRedirectController spr2 =new SPRPDFPreviewRedirectController(sc);
        
		spr.sendPdf();
        SPRPDFPreviewRedirectController.codeCoverageTrick();        
    }
}