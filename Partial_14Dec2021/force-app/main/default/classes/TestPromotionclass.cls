@isTest(SeeAllData=true)
Public Class TestPromotionclass
{
    Static TestMethod Void Promotion()
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
                                  UserName= 'FName+LName+@TestUser2.com'
                                  );
           
           system.runAs(userData) {
           	
        Tour_Program__c tr=new Tour_Program__c();
        tr.From_Date__c=date.newinstance(2014, 3, 1);
        tr.To_Date__c=date.newinstance(2014, 3, 15);
        tr.Tour_Program_Approved__c = true;
        insert tr;
       List<Tour_Plan1__c > TourPlan=new List<Tour_Plan1__c >();
       Tour_Plan1__c tp=new Tour_Plan1__c();
       tp.Name='Tour Palan1234';
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
            Promotion__c prm=new Promotion__c();            
            prm.Date__c=System.today();
            prm.Type__c='Dealers Meet';
            prm.Site_Visit__c=sv.id;
            Upsert prm;
           
          
           Test.StartTest();
           
         PageReference pageRef = Page.PageforPromotion;
          Test.setCurrentPage(pageRef);
          pageRef.setredirect(true);
          pageRef.getParameters().put('id',sv.id);
          
        promotionclass  controller = new promotionclass(); 
        controller.Save();
        controller.Cancel();
        controller.quicksave();
           }
        Test.StopTest();
    }
}