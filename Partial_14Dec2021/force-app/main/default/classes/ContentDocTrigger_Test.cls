/* ***************************************************************************************
Created By    : Srilakshmi, KVP Business Solutions
Description   : Test class for ContentDocTrigger
******************************************************************************************** */
@isTest

public class ContentDocTrigger_Test{
    private static Account dis1;
    
    
    static testmethod void method_1(){
        try {
            dis1 = Initial_Test_Data.createAccount('test Account1','Individual Contacts');
            dis1.Contact_Number_Mobile__c ='7259582222'; 
            dis1.Party_Type__c = 'Distributor';
            dis1.Status__c = 'Existing';
            dis1.Ramco_ID__c = 'abc123';
            insert dis1;
            
            Promotion__c prm = new Promotion__c();            
            prm.Date__c=System.today();
            prm.Type__c='Dealers Meet';
            prm.Total_Expenses__c = 1000;
            prm.Total_no_of_attendees__c = 0;
            prm.State__c = 'Karnataka';
            prm.Location__c = 'BTM';
            prm.Distributor__c=dis1.id;
            insert prm; 
            
            system.assert(prm.id != null);
            
            ContentVersion cver = new ContentVersion();
            cver.ContentLocation = 'S';
            cver.VersionData = Blob.valueOf('Unit Test Attachment Body');
            cver.PathOnClient = 'Retailer.png';
            cver.Title = 'Retailer Image';
            insert cver;     
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;
            
            ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cver.Id];
            ContentVersion testContent1 = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :contentVersion.Id];
            
            Promotion__c promo = [select id from Promotion__c where id=:prm.id];
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = prm.Id;  // a0a2F000002whylQAA
            cdl.ContentDocumentId = testcontent.ContentDocumentId;
            cdl.shareType = 'V';
            insert cdl; 
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cd2 = New ContentDocumentLink();
            cd2.LinkedEntityId = prm.Id;  // a0a2F000002whylQAA
            cd2.ContentDocumentId = testcontent1.ContentDocumentId;
            cd2.shareType = 'V';
            insert cd2; 
            
            List<ContentDocument> cdoc = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument where id=:testcontent.ContentDocumentId];
            
            delete cdoc;
            
        } catch(Exception ex) {
            System.debug('Exception Test ' + ex);
            System.debug('Exception Test1 ' + ex.getMessage());
        }       
    }
     static testmethod void method_2(){
        try {
            Account  dis2 = new Account();
         
            dis2.Name='testee';
            //dis2.recordtype.name='Individual Contacts';
           dis2.RecordTypeId='01230000001DIm0AAG';
            dis2.Contact_Number_Mobile__c ='7259582223'; 
            dis2.Party_Type__c = 'Plumber';
            dis2.Status__c = 'Existing';
            dis2.Ramco_ID__c = 'abc123';
            dis2.Count_Attachment__c=2;
            insert dis2;
            
            system.assert(dis2.id != null);
            
            ContentVersion cver = new ContentVersion();
            cver.ContentLocation = 'S';
            cver.VersionData = Blob.valueOf('Unit Test Attachment Body');
            cver.PathOnClient = 'Retailer.png';
            cver.Title = 'Retailer Image';
            insert cver;     
            
            ContentVersion contentVersion = new ContentVersion(
                Title = 'Penguins',
                PathOnClient = 'Penguins.jpg',
                VersionData = Blob.valueOf('Test Content'),
                IsMajorVersion = true
            );
            insert contentVersion;
            
            ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cver.Id];
            ContentVersion testContent1 = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :contentVersion.Id];
            
           // Promotion__c promo = [select id from Promotion__c where id=:prm.id];
       
            Account acc=[select id from Account where ID =:dis2.id];
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cdl = New ContentDocumentLink();
            cdl.LinkedEntityId = dis2.Id;  // a0a2F000002whylQAA
            cdl.ContentDocumentId = testcontent.ContentDocumentId;
            cdl.shareType = 'V';
            insert cdl; 
            
            //create ContentDocumentLink  record 
            ContentDocumentLink cd2 = New ContentDocumentLink();
            cd2.LinkedEntityId = dis2.Id;  // a0a2F000002whylQAA
            cd2.ContentDocumentId = testcontent1.ContentDocumentId;
            cd2.shareType = 'V';
            insert cd2; 
            
            List<ContentDocument> cdoc = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument where id=:testcontent.ContentDocumentId];
            
            delete cdoc;
            
        } catch(Exception ex) {
            System.debug('Exception Test ' + ex);
            System.debug('Exception Test1 ' + ex.getMessage());
        }       
    }
    
}