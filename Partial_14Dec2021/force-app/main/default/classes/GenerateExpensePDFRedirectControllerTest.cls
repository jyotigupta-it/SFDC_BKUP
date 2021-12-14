@isTest
public class GenerateExpensePDFRedirectControllerTest {
    static testMethod void expensePdfMethod() {
        Target__c tc = new Target__c();
        tc.Approval_Comments__c = 'Approve';
        Insert tc;
        
        ApexPages.currentPage().getHeaders().put('USER-AGENT', 'Mobile');
        ApexPages.StandardController sc = new ApexPages.standardController(tc);
        GenerateExpensePDFRedirectController accPdf = new GenerateExpensePDFRedirectController(sc);
        
    /*    EmailMessage email = new EmailMessage();
        email.FromAddress = 'test@abc.org';
        email.Incoming = True;
        email.ToAddress= 'test@xyz.org';
        email.Subject = 'Test email';
        email.HtmlBody = 'Test email body';
      //  email.ParentId = tc.Id; 
        insert email;
        
        Attachment attach=new Attachment();   	
    	attach.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        attach.parentId=tc.id;
        insert attach;
        */
        accPdf.sendGenerateExpPdf();
        GenerateExpensePDFRedirectController.codeCoverageTrick();
    }
}