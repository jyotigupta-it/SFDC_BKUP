@isTest(seealldata=false)
public class BatchAttendanceTest{
    @testSetup
    public static void setupData(){      
        
        
        
    }
    
    
    public static testmethod void testm1(){
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username1';
        User1.Email='username1@av.com';
        User1.Username='username1@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true;
        User1.EmployeeNumber = 'Test1';
        insert User1;
        
        
        User User2=new User();
        User2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User2.FirstName='UserM';
        User2.LastName='Username2';
        User2.Email='Username2@av.com';
        User2.Username='Username2@av.com'+ System.currentTimeMillis();
        User2.CompanyName='Test';
        User2.TimeZoneSidKey='Asia/Kolkata';
        User2.Title='title';
        User2.Alias='Use2';
        User2.EmailEncodingKey='UTF-8';
        User2.LanguageLocaleKey='en_US';
        User2.LocaleSidKey='en_IN';
        User2.IsActive=true;
        User2.Create_Attendance__c=true;
        User2.EmployeeNumber = 'Test2';
        insert User2;
        
        
        User User3=new User();
        User3.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User3.LastName='UserAA';
        User3.Email='Username3@av.com';
        User3.Username='Username3@av.com'+ System.currentTimeMillis();
        User3.Employeenumber='12345';
        User3.CompanyName='Test';
        User3.TimeZoneSidKey='Asia/Kolkata';
        User3.Title='title';
        User3.Alias='Use3';
        User3.EmailEncodingKey='UTF-8';
        User3.LanguageLocaleKey='en_US';
        User3.LocaleSidKey='en_IN';               
        User3.Vertical_Type__c='Column';
        User3.IsActive=true;
        User3.Create_Attendance__c=true;
        User3.EmployeeNumber = 'Test3';
        insert User3;
        
        Attendance__c attlst1 = new Attendance__c();
        attlst1.Employee__c =User1.Id;
        attlst1.In_Time__c=Label.In_Time;
        attlst1.Out_Time__c=Label.Out_Time;
        attlst1.Status__c='Present';
        attlst1.TourPlanDate__c=system.today()-1;
        insert attlst1;
        
        Attendance__c attlst2 = new Attendance__c();
        attlst2.Employee__c =User1.Id;
        
        attlst2.In_Time__c=Label.In_Time;
        attlst2.Out_Time__c=Label.Out_Time;
        attlst2.Status__c='Absent';
        attlst2.TourPlanDate__c=system.today()-1;
        insert attlst2;
        
        Attendance__c attlst3 = new Attendance__c();
        attlst3.Employee__c =User1.Id;
        
        attlst3.In_Time__c=Label.In_Time;
        attlst3.Out_Time__c=Label.Out_Time;
        attlst3.Status__c='Present';
        attlst3.TourPlanDate__c=system.today()-1;
        insert attlst3;
        attlst3.Status__c='Absent';
        update attlst3;
        
        Attendance__c attlst4 = new Attendance__c();
        attlst4.Employee__c =User1.Id;
        
        attlst4.In_Time__c=Label.In_Time;
        attlst4.Out_Time__c=Label.Out_Time;
        attlst4 .Status__c='Absent';
        attlst4.TourPlanDate__c=system.today();
        insert attlst4;
        attlst4.Status__c='Present';
        update attlst4;
        
        
        Target__c tt1 = new Target__c();
        tt1.Target_User__c=User1.id;
        tt1.Approval_Status__c='Approved';
        insert tt1;
        
        AP_Tour_Plan__c aptour1 = new AP_Tour_Plan__c();  
        aptour1.Date__c=system.Today();
        aptour1.Target__c=tt1.ID;
        insert aptour1;
        
        AP_Site_Visit__c vv1 = new AP_Site_Visit__c();
        vv1.AP_Tour_Plan__c=aptour1.ID;
        VV1.TARGET__c=TT1.ID;
        insert vv1;
        
        AP_Tour_Plan__c aptour2 = new AP_Tour_Plan__c();  
        aptour2.Date__c=system.Today()-2;
        aptour2.Target__c=tt1.ID;
        insert aptour2;
        
        
        AP_Tour_Plan__c aptour3 = new AP_Tour_Plan__c();  
        aptour3.Date__c=system.Today()-2;
        aptour3.Target__c=tt1.ID;
        insert aptour3;
        AP_Site_Visit__c vv2 = new AP_Site_Visit__c();
        vv2.AP_Tour_Plan__c=aptour1.ID;
        vv2.TARGET__c=TT1.ID;
        insert vv2;
        
        AP_Tour_Plan__c aptour4 = new AP_Tour_Plan__c();  
        aptour4.Date__c=system.Today()-2;
        aptour4.Target__c=tt1.ID;
        insert aptour4;
        AP_Site_Visit__c vv4 = new AP_Site_Visit__c();
        vv4.RecordTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Other Activities').getRecordTypeId();
        vv4.AP_Tour_Plan__c=aptour4.Id;
        vv4.TARGET__c=TT1.ID;
        vv4.Othet_Activities__c = 'Meeting';
        insert vv4;
        
        AP_Tour_Plan__c aptour5 = new AP_Tour_Plan__c();
        aptour5.Date__c=system.Today()-2;
        
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        
        BatchCreateAttendanceRecords bb = new BatchCreateAttendanceRecords ();
        BatchAttendanceExpenseCreation bbec = new BatchAttendanceExpenseCreation();
        
        test.startTest();  
        Database.executeBatch(bb);
        Database.executeBatch(bbec);
        test.stopTest();
    }
    
    
    public static testmethod void testm3(){
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username1';
        User1.Email='username1@av.com';
        User1.Username='username1@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true;
        User1.EmployeeNumber = 'Test1';
        insert User1;
        
        
        User User2=new User();
        User2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User2.FirstName='UserM';
        User2.LastName='Username2';
        User2.Email='Username2@av.com';
        User2.Username='Username2@av.com'+ System.currentTimeMillis();
        User2.CompanyName='Test';
        User2.TimeZoneSidKey='Asia/Kolkata';
        User2.Title='title';
        User2.Alias='Use2';
        User2.EmailEncodingKey='UTF-8';
        User2.LanguageLocaleKey='en_US';
        User2.LocaleSidKey='en_IN';
        User2.IsActive=true;
        User2.Create_Attendance__c=true;
        User2.EmployeeNumber = 'Test2';
        insert User2;
        
        
        User User3=new User();
        User3.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User3.LastName='UserAA';
        User3.Email='Username3@av.com';
        User3.Username='Username3@av.com'+ System.currentTimeMillis();
        User3.Employeenumber='12345';
        User3.CompanyName='Test';
        User3.TimeZoneSidKey='Asia/Kolkata';
        User3.Title='title';
        User3.Alias='Use3';
        User3.EmailEncodingKey='UTF-8';
        User3.LanguageLocaleKey='en_US';
        User3.LocaleSidKey='en_IN';               
        User3.Vertical_Type__c='Column';
        User3.IsActive=true;
        User3.Create_Attendance__c=true;
        User3.EmployeeNumber = 'Test3';
        insert User3;
        
        Attendance__c attlst1 = new Attendance__c();
        attlst1.Employee__c =User1.Id;
        attlst1.In_Time__c=Label.In_Time;
        attlst1.Out_Time__c=Label.Out_Time;
        attlst1.Status__c='Absent';
        attlst1.TourPlanDate__c=system.today()-1;
        insert attlst1;
        
        Target__c tt1 = new Target__c();
        tt1.Target_User__c=User1.id;
        tt1.Approval_Status__c='Approved';
        insert tt1;
        
        
        AP_Tour_Plan__c aptour1 = new AP_Tour_Plan__c();  
        aptour1.Date__c=system.Today()-1;
        aptour1.Target__c=tt1.ID;
        insert aptour1;
        
        AP_Site_Visit__c vv1 = new AP_Site_Visit__c();
        vv1.AP_Tour_Plan__c=aptour1.ID;
        VV1.TARGET__c=TT1.ID;
        insert vv1;
        
        AP_Tour_Plan__c aptour2 = new AP_Tour_Plan__c();  
        aptour2.Date__c=system.Today()-2;
        aptour2.Target__c=tt1.ID;
        insert aptour2;
        
        
        AP_Tour_Plan__c aptour3 = new AP_Tour_Plan__c();  
        aptour3.Date__c=system.Today()-2;
        aptour3.Target__c=tt1.ID;
        insert aptour3;
        AP_Site_Visit__c vv2 = new AP_Site_Visit__c();
        vv2.AP_Tour_Plan__c=aptour1.ID;
        vv2.TARGET__c=TT1.ID;
        insert vv2;
        
        
        AP_Tour_Plan__c aptour4 = new AP_Tour_Plan__c();
        aptour4.Date__c=system.Today()-2;
        
        Database.QueryLocator QL;
        Database.BatchableContext BC;
        
        BatchCreateAttendanceRecords bb = new BatchCreateAttendanceRecords ();
        BatchAttendanceExpenseCreation bbec = new BatchAttendanceExpenseCreation();
        
        test.startTest();  
        Database.executeBatch(bb);
        Database.executeBatch(bbec);
        test.stopTest();
    }
    
    
    public static testmethod void testm2(){ 
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username1';
        User1.Email='username1@av.com';
        User1.Username='username1@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true;
        User1.EmployeeNumber = 'Test1';
        insert User1;
        
        
        User User2=new User();
        User2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User2.FirstName='UserM';
        User2.LastName='Username2';
        User2.Email='Username2@av.com';
        User2.Username='Username2@av.com'+ System.currentTimeMillis();
        User2.CompanyName='Test';
        User2.TimeZoneSidKey='Asia/Kolkata';
        User2.Title='title';
        User2.Alias='Use2';
        User2.EmailEncodingKey='UTF-8';
        User2.LanguageLocaleKey='en_US';
        User2.LocaleSidKey='en_IN';
        User2.IsActive=true;
        User2.Create_Attendance__c=true;
        User2.EmployeeNumber = 'Test2'; 
        insert User2;
        
        
        User User3=new User();
        User3.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User3.LastName='UserAA';
        User3.Email='Username3@av.com';
        User3.Username='Username3@av.com'+ System.currentTimeMillis();
        User3.Employeenumber='12345';
        User3.CompanyName='Test';
        User3.TimeZoneSidKey='Asia/Kolkata';
        User3.Title='title';
        User3.Alias='Use3';
        User3.EmailEncodingKey='UTF-8';
        User3.LanguageLocaleKey='en_US';
        User3.LocaleSidKey='en_IN';               
        User3.Vertical_Type__c='Column';
        User3.IsActive=true;
        User3.Create_Attendance__c=true;
        User3.EmployeeNumber = 'Test3'; 
        insert User3;
        
        Target__c tt1 = new Target__c();
        tt1.Target_User__c=User1.id;
        tt1.Approval_Status__c='Approved';
        insert tt1;
        
        AP_Tour_Plan__c aptour1 = new AP_Tour_Plan__c();  
        aptour1.Date__c=system.Today()-1;
        aptour1.Target__c=tt1.ID;
        insert aptour1;
        
        AP_Site_Visit__c vv1 = new AP_Site_Visit__c();
        vv1.AP_Tour_Plan__c=aptour1.ID;
        VV1.TARGET__c=TT1.ID;
        insert vv1;
        
        AP_Tour_Plan__c aptour2 = new AP_Tour_Plan__c();  
        aptour2.Date__c=system.Today()-2;
        aptour2.Target__c=tt1.ID;
        insert aptour2;
        
        
        AP_Tour_Plan__c aptour3 = new AP_Tour_Plan__c();  
        aptour3.Date__c=system.Today()-2;
        aptour3.Target__c=tt1.ID;
        insert aptour3;
        AP_Site_Visit__c vv2 = new AP_Site_Visit__c();
        vv2.AP_Tour_Plan__c=aptour1.ID;
        vv2.TARGET__c=TT1.ID;
        insert vv2;
        
        
        AP_Tour_Plan__c aptour4 = new AP_Tour_Plan__c();
        aptour4.Date__c=system.Today()-2;
        
        BatchCreateAttendanceRecords bb = new BatchCreateAttendanceRecords ();
        BatchAttendanceExpenseCreation bbec = new BatchAttendanceExpenseCreation();
        
        test.startTest();  
        Database.executeBatch(bb);
        Database.executeBatch(bbec);
        test.stopTest();
        
    }   
    
    public static testmethod void test2(){
        
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username1';
        User1.Email='username1@av.com';
        User1.Username='username1@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true; 
        User1.EmployeeNumber = 'Test1';
        insert User1;
        
        
        User User2=new User();
        User2.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User2.FirstName='UserM';
        User2.LastName='Username2';
        User2.Email='Username2@av.com';
        User2.Username='Username2@av.com'+ System.currentTimeMillis();
        User2.CompanyName='Test';
        User2.TimeZoneSidKey='Asia/Kolkata';
        User2.Title='title';
        User2.Alias='Use2';
        User2.EmailEncodingKey='UTF-8';
        User2.LanguageLocaleKey='en_US';
        User2.LocaleSidKey='en_IN';
        User2.IsActive=true;
        User2.Create_Attendance__c=true; 
        User2.EmployeeNumber = 'Test2';
        insert User2;
        
        
        User User3=new User();
        User3.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User3.LastName='UserAA';
        User3.Email='Username3@av.com';
        User3.Username='Username3@av.com'+ System.currentTimeMillis();
        User3.Employeenumber='12345';
        User3.CompanyName='Test';
        User3.TimeZoneSidKey='Asia/Kolkata';
        User3.Title='title';
        User3.Alias='Use3';
        User3.EmailEncodingKey='UTF-8';
        User3.LanguageLocaleKey='en_US';
        User3.LocaleSidKey='en_IN';               
        User3.Vertical_Type__c='Column';
        User3.IsActive=true;
        User3.Create_Attendance__c=true;
        User3.EmployeeNumber = 'Test3'; 
        insert User3;
        
        Target__c tt1 = new Target__c();
        tt1.Target_User__c=User1.id;
        tt1.Approval_Status__c='Approved';
        insert tt1;
        
        AP_Tour_Plan__c aptour1 = new AP_Tour_Plan__c();  
        aptour1.Date__c=system.Today()-1;
        aptour1.Target__c=tt1.ID;
        insert aptour1;
        
        AP_Site_Visit__c vv1 = new AP_Site_Visit__c();
        vv1.AP_Tour_Plan__c=aptour1.ID;
        VV1.TARGET__c=TT1.ID;
        insert vv1;
        
        AP_Tour_Plan__c aptour2 = new AP_Tour_Plan__c();  
        aptour2.Date__c=system.Today()-2;
        aptour2.Target__c=tt1.ID;
        insert aptour2;
        
        
        AP_Tour_Plan__c aptour3 = new AP_Tour_Plan__c();  
        aptour3.Date__c=system.Today()-2;
        aptour3.Target__c=tt1.ID;
        insert aptour3;
        AP_Site_Visit__c vv2 = new AP_Site_Visit__c();
        vv2.AP_Tour_Plan__c=aptour1.ID;
        vv2.TARGET__c=TT1.ID;
        insert vv2;
        
        
        AP_Tour_Plan__c aptour4 = new AP_Tour_Plan__c();
        aptour4.Date__c=system.Today()-2;
        
        Test.startTest();
        Datetime dt = Datetime.now().addMinutes(1);
        String CRON_EXP = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
        
        System.schedule('ScheduleApexClassTest1',CRON_EXP, new scheduledBatchableAttendance ());  
        System.schedule('ScheduleApexClassTest2',CRON_EXP, new scheduledBatchableAttendanceExpense()); 
        Test.stopTest();
        
        List<String> Month=new List<String>{'01','02','03','04','05','06','07','08','09','10','11','12'};
            system.debug(AttendanceReport.collectDetails(Month[system.today().month()-1],Month[system.today().month()-1]=='12'?'01':Month[system.today().month()],''+system.today().year()));
        
    }
    
    public static testmethod void test3(){
        List<String> Month=new List<String>{'01','02','03','04','05','06','07','08','09','10','11','12'};
            User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username1';
        User1.Email='username1@av.com';
        User1.Username='username1@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true;
        User1.EmployeeNumber = 'Test1'; 
        insert User1;
        
        Attendance__c attlst1 = new Attendance__c();
        //attlst1.Employee_Name__c=User1.LastName;
        //attlst1.Employee_Id__c='12345';
        attlst1.Employee__c =User1.Id;
        attlst1.In_Time__c=Label.In_Time;
        attlst1.Out_Time__c=Label.Out_Time;
        attlst1.Status__c='Present';
        attlst1.TourPlanDate__c=system.today()-1;
        insert attlst1;
        
        Attendance_Expense__c   ae= new Attendance_Expense__c ();
        
        ae.Date__c=system.today()-1;
        ae.UserName__c=User1.id;
        ae.Ex_Station__c=5;
        ae.External_Id__c=''+User1.id+Month[system.today().month()-1]+(Month[system.today().month()-1]=='12'?'01':Month[system.today().month()])+''+system.today().year(); 
        system.debug(ae.External_Id__c);
        ae.HeadQuarter__c=3;
        ae.Headquarter_Metro__c=5;    
        ae.Headquarter_State_Capital__c=8;
        ae.Outstation__c=4;
        insert ae;
        
        system.debug(AttendanceReport.collectDetails(Month[system.today().month()-1],Month[system.today().month()-1]=='12'?'01':Month[system.today().month()],''+system.today().year()));
        
    }
    
    public static testmethod void testm5(){
        User User1=new User();
        User1.ProfileId=[SELECT Id FROM Profile WHERE Name =: 'BD'].Id;
        User1.LastName='username1';
        User1.Email='username1@av.com';
        User1.Username='username1@av.com'+ System.currentTimeMillis();
        User1.CompanyName='Test';
        User1.TimeZoneSidKey='Asia/Kolkata';
        User1.Title='title';
        User1.Alias='use1';
        User1.EmailEncodingKey='UTF-8';
        User1.LanguageLocaleKey='en_US';
        User1.LocaleSidKey='en_IN';
        User1.IsActive=true;
        User1.Create_Attendance__c=true;
        User1.EmployeeNumber = 'Test1'; 
        insert User1;
        
        
        Attendance__c attlst1 = new Attendance__c();
        attlst1.Employee__c =User1.Id;
        attlst1.In_Time__c=Label.In_Time;
        attlst1.Out_Time__c=Label.Out_Time;
        attlst1.Status__c='Present';
        attlst1.TourPlanDate__c=system.today().addMonths(-3);
        insert attlst1;
        Integer mB=attlst1.TourPlanDate__c.month();
        Integer mA=attlst1.TourPlanDate__c.month()+1;
        Integer mY=attlst1.TourPlanDate__c.Year();
        string extID=''+User1.Id+mB+mA+mY;
        
        // delete attlst1;
        
        Attendance__c attlst2 = new Attendance__c();
        attlst2.Employee__c =User1.Id;
        
        attlst2.In_Time__c=Label.In_Time;
        attlst2.Out_Time__c=Label.Out_Time;
        attlst2.Status__c='Absent';
        attlst2.TourPlanDate__c=system.today()-1;
        insert attlst2;
        Datetime dt90before = Datetime.now().addDays(-91);
        Test.setCreatedDate(attlst2.Id, dt90before );
        
        
        // delete attlst2;
        
        Attendance__c attlst3 = new Attendance__c();
        attlst3.Employee__c =User1.Id;
        
        attlst3.In_Time__c=Label.In_Time;
        attlst3.Out_Time__c=Label.Out_Time;
        attlst3.Status__c='Present';
        attlst3.TourPlanDate__c=system.today();
        insert attlst3;
        attlst3.Status__c='Absent';
        update attlst3;
        
        Attendance__c attlst4 = new Attendance__c();
        attlst4.Employee__c =User1.Id;
        
        attlst4.In_Time__c=Label.In_Time;
        attlst4.Out_Time__c=Label.Out_Time;
        attlst4 .Status__c='Absent';
        attlst4.TourPlanDate__c=system.today();
        insert attlst4;
        attlst4.Status__c='Present';
        update attlst4;
        
        delete attlst4;
        
        
        Target__c tt1 = new Target__c();
        tt1.Target_User__c=User1.id;
        tt1.Approval_Status__c='Approved';
        insert tt1;
        
        
        AP_Tour_Plan__c aptour1 = new AP_Tour_Plan__c();  
        aptour1.Date__c=system.Today()-1;
        aptour1.Target__c=tt1.ID;
        insert aptour1;
        
        AP_Site_Visit__c vv1 = new AP_Site_Visit__c();
        vv1.AP_Tour_Plan__c=aptour1.ID;
        VV1.TARGET__c=TT1.ID;
        insert vv1;
        
        AP_Tour_Plan__c aptour2 = new AP_Tour_Plan__c();  
        aptour2.Date__c=system.Today()-2;
        aptour2.Target__c=tt1.ID;
        insert aptour2;
        
        
        AP_Tour_Plan__c aptour3 = new AP_Tour_Plan__c();  
        aptour3.Date__c=system.Today()-2;
        aptour3.Target__c=tt1.ID;
        insert aptour3;
        AP_Site_Visit__c vv2 = new AP_Site_Visit__c();
        vv2.AP_Tour_Plan__c=aptour1.ID;
        vv2.TARGET__c=TT1.ID;
        insert vv2;
        
        
        AP_Tour_Plan__c aptour4 = new AP_Tour_Plan__c();
        aptour4.Date__c=system.Today()-2;
        
        List<String> Month=new List<String>{'01','02','03','04','05','06','07','08','09','10','11','12'};
            Attendance_Expense__c   ae= new Attendance_Expense__c();
        
        ae.Date__c=system.today()-1;
        ae.UserName__c=User1.id;
        ae.Ex_Station__c=5;
        
        //ae.External_Id__c=''+User1.id+Month[system.today().month()-1]+(Month[system.today().month()-1]=='12'?'01':Month[system.today().month()])+''+system.today().year(); 
        
        // ae.External_Id__c=''+User1.id+Month[system.today().month()-1]+(Month[system.today().month()-1]=='12'?'01':Month[system.today().month()])+''+(Month[system.today().month()-1]=='12'?''+(system.today().year()+1):''+system.today().year()); 
        ae.External_Id__c=extID;
        system.debug(ae.External_Id__c);
        ae.HeadQuarter__c=3;
        ae.Headquarter_Metro__c=5;    
        ae.Headquarter_State_Capital__c=8;
        ae.Outstation__c=4;
        insert ae;
        System.debug('exp'+ae);
        Datetime dt90beforeAe = Datetime.now().addDays(-91);
        Test.setCreatedDate(ae.Id, dt90beforeAe );
        // delete ae;
        
        BatchAttendanceAndExpenseDelete bae = new BatchAttendanceAndExpenseDelete();
        
        test.startTest();  
        Database.executeBatch(bae);
        System.schedule('delete Attendance_Expense - Monday 5AM', '0 00 05 ? * 2', new scheduledBatchableAttExpDelete());
        test.stopTest();
    }
    
    
}