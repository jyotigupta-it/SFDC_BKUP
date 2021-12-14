/* Test class for AWSUtility */
@isTest
public class AWSUtilityTest {
    
    public static testMethod void fetchBillImageTest(){
        Transaction__c t = new Transaction__c(Status__c='PENDING');
        insert t;
        sales_accrual__c sa = new sales_accrual__c(Transaction__c=t.Id);
        insert sa;
        
        String file = AWSUtility.fetchBillImage(sa.Id);
    }
    
    public static testMethod void getSignedURLTest(){
        String BucketName='abc.com';
        String AccessKey= '12345';
        String SecretKey= '6789';
        AWS_S3__c aws = new AWS_S3__c(BucketName__c=BucketName, AccessKey__c=AccessKey,SecretKey__c=SecretKey);
        insert aws;
        
        String url = AWSUtility.getSignedURL('abc.png');
    }
}