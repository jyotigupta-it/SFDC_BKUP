@isTest
private class GeoLocationController_Test{
  @testSetup
  static void setupTestData(){
    test.startTest();
    User user_Obj = new User(Username = 'TestUser3090520180827004346@codecoverage.com', LocaleSidKey = 'sq',EmailEncodingKey = 'UTF-8', LanguageLocaleKey = 'en_US', Alias = 'Alias833', TimeZoneSidKey = 'Pacific/Kiritimati', LastName = 'LastName760', Email = 'Email22@test.com', IsActive = true, ProfileId = '00e30000001IxrqAAC', EmployeeNumber = 'Emplo383', Vertical_Type__c = 'Column');
    Insert user_Obj; 
    Account account_Obj = new Account(Name = 'Name303', Contact_Number_Mobile__c = '9999999987', Type = 'Analyst', RecordTypeId = '01230000001DIllAAG',BillingStreet = 'PratapNagar', BillingCity = 'Jaipur', BillingState = 'Raj', BillingPostalCode = '302022', BillingCountry = 'India', Party_Type__c = 'Architect',  Inactive_Mobile_No__c = false, System_Flag__c = false, Account_Status_Flag__c = false, Bandhan_Cutsomer__c = false, Geolocation__Latitude__s = 0, Geolocation__Longitude__s = 0, Products__c = 'Column Pipes');
    Insert account_Obj; 
    Target__c targets_Obj = new Target__c();
    Insert targets_Obj;
    Promotion__c promotions_Obj = new Promotion__c(Type__c = 'Architects Meet');
    Insert promotions_Obj; 
    AP_Tour_Plan__c ap_tour_plan_Obj = new AP_Tour_Plan__c(Account__c = account_Obj.id, Target__c = targets_Obj.id);
    Insert ap_tour_plan_Obj;
    AP_Site_Visit__c ap_site_visit_Obj = new AP_Site_Visit__c(RecordTypeId = '01230000001DPwDAAW',AP_Tour_Plan__c = ap_tour_plan_Obj.id, Action_Date__c = Date.today(), Date__c = Date.today(), Generate_Order__c = false, Party_Type__c = 'Architect', RecordEdit__c = false, Task_Tab__c = false, Target__c = targets_Obj.id, Verified__c = false, Retailing_Day__c = false, Geo_Location__Latitude__s = 0, Geo_Location__Longitude__s = 0, Adopted_Plumber__c = false, Adopted_Dealer__c = false);
    Insert ap_site_visit_Obj; 
    test.stopTest();
  }
  static testMethod void test_AccountType_UseCase1(){
    Id DlrRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Dealer').RecordTypeId;
    List<User> user_Obj  =  [SELECT Id,Username,LastName,Email,IsActive,ProfileId,EmployeeNumber,Vertical_Type__c from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Account> account_Obj  =  [SELECT Id,Name,Type,RecordTypeId,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Party_Type__c,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Bandhan_Cutsomer__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    List<Promotion__c> promotions_Obj  =  [SELECT Id,Name,Type__c from Promotion__c];
    System.assertEquals(true,promotions_Obj.size()>0);
    List<AP_Site_Visit__c> ap_site_visit_Obj  =  [SELECT Id,Name,RecordTypeId,AP_Tour_Plan__c,Action_Date__c,Date__c,Generate_Order__c,Party_Type__c,RecordEdit__c,Target__c,Verified__c,Retailing_Day__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Location__c,Adopted_Plumber__c,Adopted_Dealer__c from AP_Site_Visit__c];
    System.assertEquals(true,ap_site_visit_Obj.size()>0);
    GeoLocationController obj01 = new GeoLocationController();
    obj01.a = account_Obj[0];
    obj01.objectList = new list<SelectOption>();
    obj01.selectedObject = 'Accounts';
    obj01.accountType = new list<selectoption>();
    obj01.selectedAccountType = 'DlrRecTypid';
    obj01.accountList = account_Obj;
    //obj01.promotionList = new list<Promotion__c>();
    obj01.promotionList = promotions_Obj;
    obj01.visitList = ap_site_visit_Obj;
    obj01.fromDate = Date.today();
    obj01.toDate = Date.today();
    obj01.AccountType();
  }
  static testMethod void test_showRecords_UseCase1(){
    //Id DlrRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Dealer').RecordTypeId;
    List<RecordType> DlrRec = [SELECT ID FROM RecordType WHERE Name = 'Dealer'];
    List<User> user_Obj  =  [SELECT Id,Username,LastName,Email,IsActive,ProfileId,EmployeeNumber,Vertical_Type__c from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Account> account_Obj  =  [SELECT Id,Name,OwnerID,Type,RecordTypeId,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Party_Type__c,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Bandhan_Cutsomer__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    List<Promotion__c> promotions_Obj  =  [SELECT Id,Name,Type__c from Promotion__c];
    System.assertEquals(true,promotions_Obj.size()>0);
    List<AP_Site_Visit__c> ap_site_visit_Obj  =  [SELECT Id,Name,RecordTypeId,AP_Tour_Plan__c,Action_Date__c,Date__c,Generate_Order__c,Party_Type__c,RecordEdit__c,Target__c,Verified__c,Retailing_Day__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Location__c,Adopted_Plumber__c,Adopted_Dealer__c from AP_Site_Visit__c];
    System.assertEquals(true,ap_site_visit_Obj.size()>0);
    GeoLocationController obj01 = new GeoLocationController();
    String type = 'Dealer';
    obj01.a = account_Obj[0];
    obj01.objectList = new list<SelectOption>();
    obj01.selectedObject = 'Accounts';
    obj01.accountType = new list<selectoption>();
    obj01.selectedAccountType = '01230000001DIllAAG';
    obj01.accountList = account_Obj;
    obj01.promotionList = promotions_Obj;
    obj01.visitList = ap_site_visit_Obj;
    obj01.fromDate = Date.today();
    obj01.toDate = Date.today();
    obj01.showRecords();
  }
  static testMethod void test_showRecords_UseCase2(){
    List<User> user_Obj  =  [SELECT Id,Username,LastName,Email,IsActive,ProfileId,EmployeeNumber,Vertical_Type__c from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Account> account_Obj  =  [SELECT Id,Name,Type,OwnerID,RecordTypeId,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Party_Type__c,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Bandhan_Cutsomer__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    List<Promotion__c> promotions_Obj  =  [SELECT Id,Name,Owner.ID,Type__c from Promotion__c];
    System.assertEquals(true,promotions_Obj.size()>0);
    List<AP_Site_Visit__c> ap_site_visit_Obj  =  [SELECT Id,Name,RecordTypeId,AP_Tour_Plan__c,Action_Date__c,Date__c,Generate_Order__c,Party_Type__c,RecordEdit__c,Target__c,Verified__c,Retailing_Day__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Location__c,Adopted_Plumber__c,Adopted_Dealer__c from AP_Site_Visit__c];
    System.assertEquals(true,ap_site_visit_Obj.size()>0);
    GeoLocationController obj01 = new GeoLocationController();
    obj01.objectList = new list<SelectOption>();
    obj01.selectedObject = 'Promotions';
    obj01.promotionList = promotions_Obj;
    obj01.fromDate = Date.today();
    obj01.toDate = Date.today();
    obj01.showRecords();
  }
   static testMethod void test_showRecords_UseCase3(){ 
    List<User> user_Obj  =  [SELECT Id,Username,LastName,Email,IsActive,ProfileId,EmployeeNumber,Vertical_Type__c from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Account> account_Obj  =  [SELECT Id,Name,Type,OwnerID,RecordTypeId,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Party_Type__c,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Bandhan_Cutsomer__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    List<Promotion__c> promotions_Obj  =  [SELECT Id,Name,Type__c from Promotion__c];
    System.assertEquals(true,promotions_Obj.size()>0);
    List<AP_Site_Visit__c> ap_site_visit_Obj  =  [SELECT Id,Name,Vendor__c,RecordTypeId,AP_Tour_Plan__c,Action_Date__c,Date__c,Generate_Order__c,Party_Type__c,RecordEdit__c,Target__c,Verified__c,Retailing_Day__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Location__c,Adopted_Plumber__c,Adopted_Dealer__c from AP_Site_Visit__c];
    System.assertEquals(true,ap_site_visit_Obj.size()>0);
    GeoLocationController obj01 = new GeoLocationController();
    obj01.objectList = new list<SelectOption>();
    obj01.selectedObject = 'Visits';
    obj01.accountType = new list<selectoption>();
    obj01.selectedAccountType = 'All';
    obj01.visitList = ap_site_visit_Obj;
    obj01.fromDate = Date.today();
    obj01.toDate = Date.today();
    obj01.showRecords();
  }
  static testMethod void test_showRecords_UseCase4(){
    List<User> user_Obj  =  [SELECT Id,Username,LastName,Email,IsActive,ProfileId,EmployeeNumber,Vertical_Type__c from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Account> account_Obj  =  [SELECT Id,Name,Type,OwnerId,RecordTypeId,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Party_Type__c,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Bandhan_Cutsomer__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    List<Promotion__c> promotions_Obj  =  [SELECT Id,Name,Type__c from Promotion__c];
    System.assertEquals(true,promotions_Obj.size()>0);
    List<AP_Site_Visit__c> ap_site_visit_Obj  =  [SELECT Id,Name,RecordTypeId,AP_Tour_Plan__c,Action_Date__c,Date__c,Generate_Order__c,Party_Type__c,RecordEdit__c,Target__c,Verified__c,Retailing_Day__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Location__c,Adopted_Plumber__c,Adopted_Dealer__c from AP_Site_Visit__c];
    System.assertEquals(true,ap_site_visit_Obj.size()>0);
    GeoLocationController obj01 = new GeoLocationController();
    obj01.a = account_Obj[0];
    obj01.objectList = new list<SelectOption>();
    obj01.selectedObject = 'Accounts';
    obj01.accountType = new list<selectoption>();
    obj01.selectedAccountType = 'All';
    obj01.accountList = account_Obj;
    obj01.showRecords();
  }
    static testMethod void test_showRecords_UseCase5(){ 
    //Id DlrRecTypid= Schema.SObjectType.Account.RecordTypeInfosByName.get('Dealer').RecordTypeId;
    List<RecordType> DlrRec = [SELECT ID FROM RecordType WHERE Name = 'Dealer'];
    List<User> user_Obj  =  [SELECT Id,Username,LastName,Email,IsActive,ProfileId,EmployeeNumber,Vertical_Type__c from User];
    System.assertEquals(true,user_Obj.size()>0);
    List<Account> account_Obj  =  [SELECT Id,OwnerID,Name,Type,RecordTypeId,ParentId,BillingStreet,BillingCity,BillingState,BillingPostalCode,BillingCountry,Party_Type__c,Inactive_Mobile_No__c,System_Flag__c,Account_Status_Flag__c,Bandhan_Cutsomer__c,Geolocation__Latitude__s,Geolocation__Longitude__s,Geolocation__c from Account];
    System.assertEquals(true,account_Obj.size()>0);
    List<Promotion__c> promotions_Obj  =  [SELECT Id,Name,Type__c from Promotion__c];
    System.assertEquals(true,promotions_Obj.size()>0);
    List<AP_Site_Visit__c> ap_site_visit_Obj  =  [SELECT Id,Name,Vendor__c,RecordTypeId,AP_Tour_Plan__c,Action_Date__c,Date__c,Generate_Order__c,Party_Type__c,RecordEdit__c,Target__c,Verified__c,Retailing_Day__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Location__c,Adopted_Plumber__c,Adopted_Dealer__c from AP_Site_Visit__c];
    System.assertEquals(true,ap_site_visit_Obj.size()>0);
    GeoLocationController obj01 = new GeoLocationController();
    String type = 'Dealer';
    obj01.objectList = new list<SelectOption>();
    obj01.selectedObject = 'Visits';
    obj01.accountType = new list<selectoption>();
    obj01.selectedAccountType = '01230000001DIllAAG';
    obj01.visitList = ap_site_visit_Obj;
    obj01.fromDate = Date.today();
    obj01.toDate = Date.today();
    obj01.showRecords();
  }
 
}