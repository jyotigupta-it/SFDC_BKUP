@istest
Private Class TestRollupPromotionsToTourProgram
{
    Static TestMethod Void TestRollupSiteVisits()
    {
    Test.StartTest();
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
                                  UserName= 'FName+LName+@TestUser1.com'
                                  );
           
           system.runAs(userData) {
    	
       Tour_Program__c tr=new Tour_Program__c();
        tr.From_Date__c=date.newinstance(2014, 3, 1);
        tr.To_Date__c=date.newinstance(2014, 3, 15);
     	tr.Tour_Program_Approved__c = true;
       insert tr;
       List<Tour_Plan1__c > TourPlan=new List<Tour_Plan1__c >();
       Tour_Plan1__c tp=new Tour_Plan1__c();
       tp.Name='Tour Palan';
       tp.Tour_Program__c=tr.id;
       tp.Date__c = Date.today();
       insert tp;
       
     
       Site_Visit__c sv=new Site_Visit__c();
       sv.Tour_Plan1__c=tp.id;
       sv.Architects_Meet_Actuals__c=1;
       sv.Boarers_Meet_Actuals__c=2;
       sv.Builders_Meet_Actuals__c=3;
       sv.Date__c = Date.today();
       insert sv;
       Update sv;
          
     
    Promotion__c pr=new Promotion__c();
       pr.Type__c='Architects Meet';
       pr.Site_Visit__c=sv.id;     
       insert pr;
       Update pr;
        Delete pr;
           }
       Test.StopTest(); 
    }
}