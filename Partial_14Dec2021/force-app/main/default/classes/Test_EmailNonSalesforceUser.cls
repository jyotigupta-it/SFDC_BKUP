@isTest
public class Test_EmailNonSalesforceUser{
    
   
    public static testMethod void testschedule() {
    Test.StartTest();
   
        EmailNonSalesforceUser sh1 = new EmailNonSalesforceUser();
        
        String sch = '0 00 01 * * ?'; 
        String jobId = system.schedule('EmailNonSalesforceUser', sch, sh1);
        System.assert(jobId != null);
        Test.stopTest(); 
         
        
    }
    
   
    static testMethod void myTestMethod1() {        
         test.starttest();
     EmailNonSalesforceUser.sendEmail();
     EmailNonSalesforceUser.method1();
      EmailNonSalesforceUser.method2();
       EmailNonSalesforceUser.method3();
       EmailNonSalesforceUser.method4();
       EmailNonSalesforceUser.method5();
        test.stopTest();
    }
}