/*  
 * Author     : Renjay Surendran
 */ 
@isTest
public Class RecceHWUpdation_test{ 
        static testmethod void StartTest(){

        List<case> caseList = new List<case>();
        Profile p = [select id from profile where Name='System Administrator' limit 1];
        User thisUser=new User(LastName='XYZ',ProfileId=p.Id,Alias='renj',EmailEncodingKey='UTF-8',TimeZoneSidKey='America/New_York',LocaleSidKey='en_US',LanguageLocaleKey='en_US',Email='renjay.surendran@gmail.com',UserName='abcd145@abcd.com');
        insert thisUser; 
        System.runAs(thisUser){ 
        User admin = [SELECT id FROM User WHERE id =: UserInfo.getUserId() LIMIT 1];
        
        Recce_Cost_Setting__c recCost = new Recce_Cost_Setting__c();
            recCost.Cost_sqft__c=10;
            recCost.name='GUW100903-Vinyl';
            recCost.vendor_code__c='GUW100903';
            insert recCost;

         Vendor_Details__c ven = new Vendor_Details__c();
            ven.name ='XYZ';
            ven.vendor_code__c ='GUW100903';
            ven.Vendor__c=thisUser.id;
            insert ven;
        
        Case cas=new Case();
        cas.Subject='Renjay';
        cas.Status=System.Label.Branding_Request_Recce_Approved_by_Branding_team;
        cas.Request_Raised_By__c=admin.id;
        cas.Vendor_Details__c=ven.id;
        insert cas;
        
        Recce_Detail__c rec=new Recce_Detail__c();
        rec.Branding_Request__c=cas.id;
        rec.Width_in_Inches__c=10;
        rec.Height_in_Inches__c=10;
        rec.Updated_Width_in_Inches__c=0;
        rec.Job_Type__c= 'Vinyl';
        insert rec;
        
        caseList.add([select ID, CaseNumber, Subject, Status, Request_Raised_By__c, Request_Raised_By__r.Email, Owner.Email from case where Id = :cas.Id]); 
 
        test.startTest();  
        update cas; 
        test.stopTest();
      }
}
}