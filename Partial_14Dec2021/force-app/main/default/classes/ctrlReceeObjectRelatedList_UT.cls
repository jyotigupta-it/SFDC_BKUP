@isTest
public class ctrlReceeObjectRelatedList_UT{
static testmethod void ctrlReceeObjectRelatedListTest(){
 Profile profileID = [select id from profile where Name='System Administrator' limit 1];
 
 User user1 = new User(LastName='XYZ',ProfileId=profileID.Id,Alias='test',EmailEncodingKey='UTF-8',
       Email='vasanthi_KN@infosys.com',UserName='vasanthi_KN112@infosys.com',
        User_State__c ='Karnataka',
        TimeZoneSidKey='America/New_York',
        LocaleSidKey='en_US',LanguageLocaleKey='en_US');
     
 insert user1;

 Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
 Map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
 
Id i= AccountRecordTypeInfo.get('Branding Request').getRecordTypeId();

Recce_Cost_Setting__c recCost = new Recce_Cost_Setting__c();
recCost.Cost_sqft__c=10;
recCost.name='GUW100903-Vinyl';
recCost.vendor_code__c='GUW100903';
insert recCost;

 Vendor_Details__c ven = new Vendor_Details__c();
            ven.name ='XYZ';
            ven.vendor_code__c ='GUW100903';
            ven.Vendor__c=user1.id;
            insert ven;

  Case caset= new Case(recordtypeId = i, Request_Raised_By__c = user1.id,
  status ='New',vendor__c=user1.id, Vendor_Details__c=ven.id);
  
 insert caset;
 
 Recce_Detail__c rec= new Recce_Detail__c(Branding_Request__c=caset.id,Branding_Type__c='In Shop',Height_in_Inches__c=10.00,Job_Type__c= 'Vinyl');
 insert rec;
 
 Recce_Detail__c rec1= new Recce_Detail__c(Branding_Request__c=caset.id, Branding_Type__c='In Shop',Height_in_Inches__c=20.00,Job_Type__c= 'Vinyl');
 insert rec1;
 
 Recce_Detail__c rec3= new Recce_Detail__c(Branding_Request__c=caset.id, Branding_Type__c='In Shop',Height_in_Inches__c=30.00,Job_Type__c= 'Vinyl');
 insert rec3;
 
 Recce_Detail__c rec4= new Recce_Detail__c(Branding_Request__c=caset.id, Branding_Type__c='In Shop',Height_in_Inches__c=40.00,Job_Type__c= 'Vinyl');
 insert rec4;
 
  ApexPages.currentPage().getParameters().put('Id', rec.id);
  Apexpages.StandardController stdController = new Apexpages.StandardController(rec); 
  ctrlReceeObjectRelatedList recobj= new ctrlReceeObjectRelatedList(stdController );
  recobj.fetchRecords();
  //recobj.newRequest();
  recobj.Beginning();
 // recobj.Previous();
  recobj.Next();
  recobj.End();
  recobj.getDisablePrevious();
  recobj.getDisableNext();
  recobj.getTotal_size();
 }
 }