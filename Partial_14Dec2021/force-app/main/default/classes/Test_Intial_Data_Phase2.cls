@istest
public  class Test_Intial_Data_Phase2 {
    //User Creation
    
    public static user ColumnRH(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData1 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '12345'
                                  
                                 );
        return userData1; 
    }
    public static user ColumnRSM(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData2 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '12346'
                                 );
        return userData2; 
    }
    
    public static user ColumnASM(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData3 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '12347'
                                 );
        return userData3; 
    }
    
    public static user PlumbingRH(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData4 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '12348'
                                 );
        return userData4; 
    }
    
    public static user PlumbingRSM(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData5 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '12349'
                                 );
        return userData5; 
    }
    public static user PlumbingASM(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData6 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '12340'
                                 );
        return userData6; 
    }
    
    public static user ProjectsRH(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData7 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '13345'
                                 );
        return userData7; 
    }
    
    public static user ProjectsRSM(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData8 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName=LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '14345'
                                 );
        return userData8; 
    }
    
    public static user ProjectsASM(string LName, string FName,string ProfileName) {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name =: profileName]; 
        User userData9 = new User(Alias = 'standt1', 
                                  Email= FName+LName+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = FName,
                                  LastName = LName, 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName= LName+FName+'@ashirvadpipes.com',
                                  EmployeeNumber = '15345'
                                 );
        return userData9; 
    }
    
    //--------------Target Creation--------------
    public static Target__c CreateTarget(User testUser) {
        
        Target__c target = new Target__c(
            Is_Active__c = true,
            Architects_Meet__c = 2,
            Boarers_Meet__c = 3,
            Builders_Meet__c = 4,
            Column_Dealer_Meet__c = 5,
            Target_User__c = testUser.Id,
            OwnerId = testUser.Id,
            Approval_Status__c = 'Not Submitted',
            Vertical__c        = 'Plumbing'
        );
        return target;
    }
    //-----------TourPlan Creation----------------
    public static AP_Tour_Plan__c CreateTourPlan(Id targetID) {
        
        AP_Tour_Plan__c tourplan = new AP_Tour_Plan__c(
            Market_Type__c = 'New',
            Promotional_Type__c = 'Boarers Meet',
            Target__c = targetID
            
        );
        return tourplan;
    } 
    //-----------------Expenses Creation-----------------
    public static AP_Expenses__c CreateExpense(Id tourplanID) {
        
        AP_Expenses__c expense = new AP_Expenses__c(
            Local_Conveyance__c=100,
            Lodge__c=200,
            Miscellaneous__c=300,
            Not_Involving_Overnight_Stay_DA__c =400,
            Remarks__c='yes',
            TourPlan__C = tourplanID,
            Expens_Visit_Type__c = 'Headquarter',
            Expense_Date__c = date.today().addDays(-15)
        );
        return expense;
    } 
    
    //---------------Promotion-----
    public static Promotion__c CreatePromotion(String proType) {
        
        Promotion__c promotion = new Promotion__c();
        promotion.Type__c = proType;
        promotion.Date__c = Date.today();
        promotion.State__c = 'Karnataka';
        promotion.District__c = 'Bangalore Urban';
        promotion.Location__c = 'BTM';
        promotion.No_of_Members_attended__c = 2;
        promotion.Total_no_of_attendees__c = 2;
        promotion.Total_Expenses__c = 10000;
        
        return promotion;
        
    }
    //---------------Promotion Member(Promotion.Id and Account.Id )-----
    public static Promotion_Member__c CreatePromotionMember(Id promotionId,Id accId) {
        
        Promotion_Member__c promoMember = new Promotion_Member__c();
        promoMember.Promotions2__c = promotionId;
        promoMember.Account__c     = accId;
        
        return promoMember;
    }
    
    //-------------Account Creation---------------------
    public static Account createAccount(String name,String recordTypeName) {
        Id recordTId  = [select id from RecordType where SobjectType = 'Account' AND Name =:recordTypeName].id;
        Account newAccount = new Account(
            Name  = name,
            BillingState = 'Gujarat',
            BillingStreet = 'Abc Street',
            BillingCity = 'Abc City',
            BillingCountry = 'India',
            Contact_Number_Mobile__c = '1234567898',
            RecordTypeId = recordTId
        );
        
        return newAccount;
    }
    
    //-------------AP Site Visit( Rty = Visit)
    public static AP_Site_Visit__c createSiteVisit(Id tourId,String recordTypeName){
        
        Id visitRecordTId  = [select id from RecordType where SobjectType = 'AP_Site_Visit__c' AND Name =: recordTypeName].id;
        
        AP_Site_Visit__c apVisit = new AP_Site_Visit__c();
        
        apVisit.AP_Tour_Plan__c = tourId;
        apVisit.RecordTypeId    = visitRecordTId;
        apVisit.Date__c         = Date.today();
        
        return apVisit;
    }
    
    //-----------Task Creation------
    public static Task CreateTask() {
        Task task = new Task();
        
        return task;
    }
    
}