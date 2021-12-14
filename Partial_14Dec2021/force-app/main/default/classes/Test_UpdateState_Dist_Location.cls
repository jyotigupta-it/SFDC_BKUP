@isTest
Public Class Test_UpdateState_Dist_Location  {
    
    Static TestMethod Void UpdateState_Dist_Location() {
    	
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
                                  UserName= 'FName+LName+@TestUs232.com'
                                  );
                                  
           system.runAs(userData) {
           	
           
        Tour_Program__c tp1 = new Tour_Program__c();
            tp1.From_Date__c=Date.newInstance(2016 , 09 ,01);
            tp1.To_Date__c=Date.newInstance(2016 , 09 ,15);
            tp1.Tour_Program_Approved__c = true;
        insert tp1;
        
        Tour_Plan1__c top=new Tour_Plan1__c(Name='test12',
                                            Tour_Program__c=tp1.id,
                                            Date__c=Date.Today(),
                                            State__c='TamilNadu',
                                            District__c='Tirunelveli',
                                            Location__c='local',
                                            Actual_State__c='Assam',
                                            Actual_District__c='Nellore',
                                            Actual_Location__c='aaaa');
        insert top;
        
        Site_Visit__c sv = new Site_Visit__c();
            sv.Tour_Plan1__c = top.id;
            sv.State__c='Andhra Pradesh';
            sv.District__c='Nellore';
            sv.Location__c='jayanagar';
            sv.Date__c = Date.today();
        insert sv;    
    }
    Test.StopTest();
    }
}