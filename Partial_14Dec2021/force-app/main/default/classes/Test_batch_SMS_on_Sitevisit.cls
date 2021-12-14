/********************************************XXX**********************************************************

Developer       : Bhargav Surapaneni
Email           : bhargav.surapaneni@ashirvad.com
Created Date    : 22-Nov-2017
Description     : Batch test class for SMS on site visits 

**********************************************XXX*********************************************************/
@isTest(seeAllData=false)
global class Test_batch_SMS_on_Sitevisit {
    
    public static testmethod void testMethod2(){
       
        //User insertion
        Profile p = [SELECT Id, Name FROM Profile WHERE Name ='BD']; 
        User userData = new User(Alias = 'standt', Email='bhargav@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Tes', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='bhargav@testorg.com' );
        insert userData;
        
        //Target creation
        Target__c target = new Target__c(
            Is_Active__c = true,
            Architects_Meet__c = 2,
            Boarers_Meet__c = 3,
            Builders_Meet__c = 4,
            Column_Dealer_Meet__c = 5,
            Target_User__c = userdata.Id,
            OwnerId = userdata.Id,
            Approval_Status__c = 'Not Submitted',
            Vertical__c        = 'Plumbing'
        );
        insert target;
        
        //TourPlan Creation
         AP_Tour_Plan__c tourplan = new AP_Tour_Plan__c(
            Market_Type__c = 'New',
            Promotional_Type__c = 'Boarers Meet',
            Target__c = target.ID
            
        );
        insert tourplan;
        
        //Account Creation
        Account newAccount = new Account(
            Name  = 'name',
            BillingState = 'Gujarat',
            BillingStreet = 'Abc Street',
            BillingCity = 'Abc City',
            BillingCountry = 'India',
            Contact_Number_Mobile__c = '9493377376'
            
        );
        insert newAccount;
        
        //Site Visit Creation
        AP_Site_Visit__c apVisit = new AP_Site_Visit__c();        
        apVisit.AP_Tour_Plan__c = tourplan.Id;
        apVisit.Date__c         = System.today()-1;
        apVisit.Party_Name__c = newAccount.id;
        apVisit.Target__c=target.id;
        insert apVisit;    
        Test.setCreatedDate(apVisit.Id, DateTime.now()-1);
        
        //Test Method Start
        Test.startTest();
        Datetime dt = Datetime.now().addMinutes(1);
        String Schedule_time = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
        System.schedule('schedulevisitsms', schedule_time, new ScheduledSiteVisitSMS());
        Test.stopTest();
    }
}