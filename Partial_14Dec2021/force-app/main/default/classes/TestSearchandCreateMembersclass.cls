@isTest
Public Class TestSearchandCreateMembersclass
{
    Static TestMethod Void SearchandCreateMembers()
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
                                  UserName= 'FName+LName+@TestUs183.com'
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
            Promotion__c prm=new Promotion__c();            
            prm.Date__c=System.today();
            prm.Type__c='Dealers Meet';
            prm.Site_Visit__c=sv.id;
            insert prm;
            
             Account acc = new Account();
         acc.Name= 'Test Account';
         acc.Type1__c='Commercial';
         acc.No_of_Bathrooms__c=5;
         acc.Contact_Number_Mobile__c='9897969694';
         Account acc1 = new Account();
         acc1.Name= 'Test Account';
         acc1.Type1__c='Commercial';
         acc1.No_of_Bathrooms__c=5;
         acc1.Contact_Number_Mobile__c='9898969694';
         //acc.Order_Status__c='Order Loss';
         insert acc1;
         
           Promotion_Member__c tp1=new  Promotion_Member__c();
            tp1.Promotions2__c=prm.id; 
            tp1.Type1__c=prm.Type__c;
            tp1.Account__c=acc.id;
            insert tp1;
            Promotion_Member__c tp2=new  Promotion_Member__c();
            tp2.Promotions2__c=prm.id; 
            tp2.Type1__c=prm.Type__c;
            tp2.Account__c=acc1.id;
            insert tp2;
           upsert acc1;
           upsert acc;
         PageReference pageRef = Page.createMembers;
          Test.setCurrentPage(pageRef);
          pageRef.setredirect(true);
          pageRef.getParameters().put('id',prm.id);
          
                                
           SearchandCreateMembers npm = new SearchandCreateMembers(new ApexPages.StandardController(prm)); 
          //npm.SearchandCreateMembers();
          npm.add_rows();
          npm.getMobileNumbers();
          npm.getCombinedAccountList();
          npm.getExistingAccountList();
          npm.getNewAccountList();
          npm.searchMobileNumber();
          npm.saveMembers();
           }
        Test.StopTest();
    }
}