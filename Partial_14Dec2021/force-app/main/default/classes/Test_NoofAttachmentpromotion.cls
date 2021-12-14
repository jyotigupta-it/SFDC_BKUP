@isTest(SeeAllData=false)
public class Test_NoofAttachmentpromotion {
    	static testmethod void testattach(){ 
    
        promotion__c pro = new promotion__c(); 
        Test.startTest(); 
        insert pro; 
        Test.stopTest(); 
        System.debug('promotion created: ' + pro.Id); 
        
        Attachment attach=new Attachment(); 
        attach.Name='Unit Test Attachment'; 
        Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body'); 
        attach.body=bodyBlob; 
        attach.parentId=pro.Id; 
        attach.ContentType = 'application/msword'; 
        attach.IsPrivate = false; 
        attach.Description = 'Test'; 
        insert attach; 
            
        Attachment attach2=new Attachment(); 
        attach2.Name='Unit Test Attachment'; 
        Blob bodyBlob2=Blob.valueOf('Unit Test Attachment Body'); 
        attach2.body=bodyBlob2; 
        attach2.parentId=pro.Id; 
        attach2.ContentType = 'application/msword'; 
        attach2.IsPrivate = false; 
        attach2.Description = 'Test'; 
        insert attach2; 
        System.debug('Inserted: '+ attach2.Id);  
        attachment deleteattach=[select id from attachment where id=:attach2.id];
         System.debug('Deleted: '+ deleteattach.Id);   
        delete deleteattach;
        attachment deleteattach2=[select id from attachment where id=:attach.id];
        System.debug('Inserted: '+ attach.Id); 
        delete deleteattach2;
      
    } 
    }