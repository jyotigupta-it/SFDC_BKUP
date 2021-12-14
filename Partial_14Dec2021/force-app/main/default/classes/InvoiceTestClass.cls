@isTest
private class InvoiceTestClass {
     public static testMethod void testCase(){
        OperatingHours oh = new OperatingHours();
        oh.Name = 'TestOH';
        oh.TimeZone='America/Los_Angeles';
        insert oh;
        
        
      ServiceTerritory s1=new ServiceTerritory();
        s1.Name='Bangalore';
        s1.IsActive=true;
        s1.OperatingHoursId=oh.id;
        insert s1;

        Town_Master__c tm=new Town_Master__c();
        tm.Name='Bangalore';
        tm.State__c='Karnataka';
        tm.District__c='Bangalore';
        tm.Service_Territory__c=s1.id;
        insert tm;
        
        Account acc1=new Account();
        acc1.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail-Customer').getRecordTypeId();
        acc1.Name='Customer';
        acc1.Contact_Number_Mobile__c='12345678901';
        acc1.Can_you_please_give_address_retail__c='asdfghj';
        acc1.City_lookup__c=s1.id;
        acc1.State__c='Karnataka';
        acc1.Country_fsl__c='India';
        acc1.PinCode__c='123456';
        acc1.Town_Code__c='5670';
         acc1.Business_Line__c='Column';
        acc1.Products__c='CPVC';
        
        acc1.Town_Name__c=tm.id;
        insert acc1;
         Invoice__c inv=new Invoice__c();
         inv.Account__c=acc1.id;
         inv.Invoice_Amount__c=320.0;
         inv.Invoice_Date__c=Date.newInstance(2020,11,20);
         inv.Status__c='Generated';
         insert inv;
         
         //Create Document
ContentVersion cv = new ContentVersion();
cv.Title = 'Test Document';
cv.PathOnClient = 'TestDocument.pdf';
cv.VersionData = Blob.valueOf('Test Content');
cv.IsMajorVersion = true;
Insert cv;
 
//Get Content Documents
Id conDocId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;
 
//Create ContentDocumentLink 
ContentDocumentLink cdl = New ContentDocumentLink();
cdl.LinkedEntityId = inv.Id;
cdl.ContentDocumentId = conDocId;
cdl.shareType = 'V';
Insert cdl;
         
         Invoice__c inv1=new Invoice__c();
         inv1.id=inv.id;
         inv1.Status__c='Raised';
         update inv1;
     }

}