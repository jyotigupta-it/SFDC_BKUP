@isTest
public class vendorController_UT{
   static testMethod void vendorControllerSearch(){
    
    Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( role__c='abc',FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
    
    User user2= new User( role__c='abc',FirstName='Test', LastName='User2', alias='abcd', email='testuser@abc.com', username='tes2tuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user2;
     test.starttest();
     System.runAs(user)
    {
    Vendor_Details__c ven = new Vendor_Details__c();
    ven.name ='XYZ';
    ven.vendor_code__c ='111de';
    ven.Vendor__c=user2.id;
    insert ven;
   
     ApexPages.currentPage().getParameters().put('id',user.id);    
     ApexPages.StandardController sc = new ApexPages.StandardController(new User());
    vendorController UI= new vendorController((sc));
    UI.caseRecord.Vendor_Details__c = ven.id;
     UI.getVendorDetails();
      PageReference ref1=UI.saveVendorDetails();
     
    }    
    test.stoptest();
    
   }
}