@isTest()
Public Class TestTaskCreatepromotionmemberClass{
    Static TestMethod Void Emailpromotion(){
    
        Profile p = [SELECT Id FROM Profile WHERE Name='BD'];
        
        User usr = new User();
        usr.FirstName = 'TestFirst';
        usr.LastName = 'Testlast';
        usr.Email = 'testusr3@abc.com';
        usr.Username = 'test3435@mail.in';
        usr.Alias = 'gd34';
        usr.ProfileId = p.Id;
        usr.TimeZoneSidKey = 'America/Los_Angeles';
        usr.languagelocalekey='en_US';
        usr.emailencodingkey='UTF-8';
        usr.localesidkey='en_US';
        insert usr;
        
        User usr1 = new User();
        usr1.FirstName = 'TestFirst';
        usr1.LastName = 'Testlast';
        usr1.Email = 'testusr@abc.com';
        usr1.Username = 'test3fs435@mail.com';
        usr1.ManagerId = usr.Id;
        usr1.Alias = 'gd54';
        usr1.ProfileId = p.Id;
        usr1.TimeZoneSidKey = 'America/Los_Angeles';
        usr1.languagelocalekey='en_US';
        usr1.emailencodingkey='UTF-8';
        usr1.localesidkey='en_US';
        insert usr1;
        
        System.runas(usr1){
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
            sv.Verification_Type__c='Complaint';
            sv.Verified__c=true;
             sv.Date__c = Date.today();
            insert sv;
            
            Promotion__c prm=new Promotion__c();            
            prm.Date__c=System.today();
            prm.Type__c='Dealers Meet';
            prm.Site_Visit__c=sv.id;
            insert prm;
            
            Promotion_Member__c pm=new Promotion_Member__c();
            pm.Promotions2__c=prm.id;
            pm.Call_Center_Remarks__c='Remarks';
            pm.Call_Status__c='Completed';
            pm.Verified__c=true;
            insert pm;
            
            Test.StartTest();
            pm.Verification_Status__c = 'complaint';
            update pm;
            Test.StopTest();
        }      
    }
}