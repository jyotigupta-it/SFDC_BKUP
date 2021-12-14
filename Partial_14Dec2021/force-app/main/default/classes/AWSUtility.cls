public class AWSUtility {
    @AuraEnabled
    public static String fetchBillImage(String recordId){
        sales_accrual__c sa = [select Id, Bill_Image__c from sales_accrual__c where Id =: recordId];
        String billImage = sa.Bill_Image__c;
        System.debug('Bill Image: '+ billImage);
        return billImage;
    }
    
    @AuraEnabled
    public static string getSignedURL(string file) {
        String filename = EncodingUtil.urlEncode(file, 'UTF-8');
       
        AWS_S3__c a = [select BucketName__c,AccessKey__c,SecretKey__c, Prefix__c from AWS_S3__c limit 1];
        String BucketName=a.BucketName__c;
        String AccessKey= a.AccessKey__c;
        String SecretKey= a.SecretKey__c;
        String Prefix = a.Prefix__c;
        Datetime now = DateTime.now();
        Datetime expireson = now.AddSeconds(60); // Lifespan of the link
        Long Lexpires = expireson.getTime()/1000;
        
        String stringtosign = 'GET\n\n\n'+Lexpires+'\n/'+BucketName+'/'+Prefix+'/'+BucketName+'/'+filename;
        System.debug('redirectToS3Key stringstosign: ' + stringtosign);
        
        String signingKey = EncodingUtil.base64Encode(Blob.valueOf(SecretKey));
        Blob mac = Crypto.generateMac('HMacSHA1', blob.valueof(stringtosign),blob.valueof(SecretKey)); 
        String signed= EncodingUtil.base64Encode(mac);     
        String codedsigned = EncodingUtil.urlEncode(signed,'UTF-8');
        String url = 'https://'+BucketName+'.s3.amazonaws.com/'+Prefix+'/'+BucketName+'/'+filename+'?AWSAccessKeyId='+AccessKey+
            '&Expires='+Lexpires+'&Signature='+signed;

        return url;
        
    }
}

/*
To run in anonymous window use following lines.

String file='/cloud-cube-jp/media/abc_HfeRUmG.png';
String url = AWSUtility.getSignedURL(file);
System.debug('Presigned URL: '+url);
* */