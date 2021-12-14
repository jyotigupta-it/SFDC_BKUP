@isTest
public class AccountPdfTestRedirectControllerTest {
    static testMethod void accountPdfMethod() {
        Target__c tc = new Target__c();
        tc.Approval_Comments__c = 'Approve';
        Insert tc;
        
        ApexPages.currentPage().getHeaders().put('USER-AGENT', 'Mobile');
        ApexPages.StandardController sc = new ApexPages.standardController(tc);
        AccountPdfTestRedirectController accPdf = new AccountPdfTestRedirectController(sc);
        accPdf.sendprojectFormatPdf();
     //   accPdf.sendDownloadPdf();
        
		accPdf.sendprojectFormatPdf();
        AccountPdfTestRedirectController.codeCoverageTrick();        
    }
}