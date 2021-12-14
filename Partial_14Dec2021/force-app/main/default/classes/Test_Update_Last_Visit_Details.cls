@isTest

Public class Test_Update_Last_Visit_Details 
{
    Static TestMethod Void Update_Last_Visit_Details()
    {
    
    Profile p = [SELECT Id, Name FROM Profile WHERE Name =: 'BD']; 
        User userData = new User(Alias = 'standt1', 
                                  Email= 'FName'+'LName'+'@TestUser99.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName',
                                  LastName = 'LName', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_AU', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Australia/Sydney', 
                                  UserName= 'FName+LName+@TestUse23.com'
                                  );
                                  
           system.runAs(userData) {
    
    RecordType rt = [SELECT id,Name FROM RecordType WHERE Name='Individual Contacts' AND sObjectType='Account'];
        Account testacc=new Account();
            testacc.Name='tstacc123';
            testacc.Contact_Email__c='tst345@aol.com';
            testacc.Primary_Contact_Person_Name__c  ='SFDC33';
            //testacc.Location__c='Bangalore';
            testacc.PIN_Code__c='560037';
            testacc.Street_Address__c='MG Road';
            testacc.Party_Type__c='Architect';
            testacc.Products__c ='COLUMN';
            testacc.Contact_Number_Mobile__c = '9874289632';
            testacc.RecordTypeId=rt.id;
            testacc.Have_we_met_all_the_decision_makers_and__c='No';
            testacc.Are_we_the_only_major_player__c='No';
            testacc.Have_we_met_important_decision_influence__c='No';
            testacc.Are_we_approved__c='No';
            testacc.Does_our_top_management_have_access_to__c='No';
            testacc.Is_our_proposal_technically_Commerical__c='No';
            testacc.Do_we_know_the_important_criteria_s_on__c='No';
            testacc.Can_we_meet_the_delivery_requirement_str__c='No';
            testacc.Does_our_top_management_have_access_to__c='No';
            testacc.Firm_Name__c='ssssssss';
       insert testacc;
       
       Tour_Program__c t=new Tour_Program__c();            
             t.From_Date__c=date.newinstance(2014, 3, 1);
             t.To_Date__c=date.newinstance(2014, 3, 15);
             t.Tour_Program_Approved__c = true;
        insert t; 
       
       Tour_Plan1__c tp=new  Tour_Plan1__c();
            tp.Name='tour plan0123'; 
            tp.Tour_Program__c=t.id;
            tp.Date__c=System.Today();
            tp.State__c='Assam';
       insert tp;
       
       Site_Visit__c v=new Site_Visit__c();
             v.Date__c=date.newinstance(2014, 2, 1);
             v.Tour_Plan1__c=tp.id;
             v.Type__c='Non Visit';
             v.Architects_Meet_Actuals__c=1;
             v.Boarers_Meet_Actuals__c=2;
             v.Builders_Meet_Actuals__c=3;
             v.Party_Name__c=testacc.id;
             v.Party_Type__c='Architect';
             v.Date__c = Date.today();
     insert v; 
     Update v;
     Delete v;
    }
    }
}