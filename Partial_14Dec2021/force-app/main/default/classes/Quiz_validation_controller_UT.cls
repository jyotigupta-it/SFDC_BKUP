@isTest
public class Quiz_validation_controller_UT{
    
    static testMethod void Quizvalidationcontrollertest(){
        
        Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
        User user= new User( Quiz_Catagory__c='Agriculture Junior',FirstName='Test', EmployeeNumber='1234',LastName='User', alias='abcd', email='testuser@abc.com', username='testuserXYZ@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        insert user;
        
        
        test.startTest();
        Date MyDate = Date.newInstance(2019, 1, 30);
        System.runAs(user)
        { 
            
            ApexPages.currentPage().getParameters().put('id', user.id); 
            ApexPages.StandardController sc = new ApexPages.StandardController(new user());     
            Quiz_validation_controller cont = new Quiz_validation_controller(sc);
            cont.MonthDay=2;
            PageReference ref=cont.navigate();
        }
        test.stopTest();
    }
    
    static testMethod void Quizvalidationcontrollertest1(){
        
        Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
        User user= new User( Quiz_Catagory__c='Agriculture Senior',FirstName='Test', LastName='User',EmployeeNumber='1234', alias='abcd', email='testuser@abc.com', username='testuserGHI@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        insert user;
        
        Quiz_Attendee__c atendeeDetail = new Quiz_Attendee__c();
        atendeeDetail.Quiz_Attendee__c=user.id;
        atendeeDetail.Quiz_Month__c = 'September - 2019';
        atendeeDetail.Quiz_status__c='Completed';
        atendeeDetail.Quiz_Catagory__c ='Agriculture Senior';
        insert atendeeDetail;
        test.startTest();
        System.runAs(user)
        { 
            ApexPages.currentPage().getParameters().put('id', user.id); 
            ApexPages.StandardController sc = new ApexPages.StandardController(new user());
            Quiz_validation_controller cont = new Quiz_validation_controller(sc);
            cont.MonthDay=3;
            PageReference ref=cont.navigate();
        }
        test.stopTest();
    }
    
    static testMethod void Quizvalidationcontrollertest2(){
        
        Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
        User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuserPQR@abc.com',EmployeeNumber='1234', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        insert user;
        Integer MonthDay = Date.Today().Day();
        
        test.startTest();
        System.runAs(user)
        { 
            ApexPages.currentPage().getParameters().put('id', user.id); 
            ApexPages.StandardController sc = new ApexPages.StandardController(new user());
            Quiz_validation_controller cont = new Quiz_validation_controller(sc);
            cont.MonthDay=1;
            PageReference ref=cont.navigate();
        }
        test.stopTest();
    }
    
    static testMethod void Quizvalidationcontrollertest3(){
        
        Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
        User user= new User( Quiz_Catagory__c='Agriculture Junior',FirstName='Test',EmployeeNumber='1234', LastName='User', alias='abcd', email='testuser@abc.com', username='testuserLMN@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        insert user;
        Integer MonthDay = 1;
        Quiz_Attendee__c atendeeDetail = new Quiz_Attendee__c();
        atendeeDetail.Quiz_Attendee__c=user.id;
        atendeeDetail.Quiz_Month__c = 'December - 2015';
        atendeeDetail.Quiz_status__c='Completed';
        atendeeDetail.Quiz_Catagory__c ='Agriculture Junior';
        
        insert atendeeDetail;
        test.startTest();
        System.runAs(user)
        { 
            ApexPages.currentPage().getParameters().put('id', user.id); 
            ApexPages.StandardController sc = new ApexPages.StandardController(new user());
            Quiz_validation_controller cont = new Quiz_validation_controller(sc);
            
            PageReference ref=cont.navigate();
        }
        test.stopTest();
    }
    
    static testMethod void Quizvalidationcontrollertest4(){
        
        Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
        User user= new User( FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com',EmployeeNumber='1234' ,username='testuserMBA@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
        insert user;
        Integer MonthDay = Date.Today().Day();
        autoRequestBatchHelper autoRequest = new autoRequestBatchHelper();
        
        String thisMonth = autoRequest.getCurrentMonth();
        Quiz_Attendee__c atendeeDetail = new Quiz_Attendee__c();
        atendeeDetail.Quiz_Attendee__c=user.id;
        atendeeDetail.Quiz_Month__c = thisMonth;
        atendeeDetail.Quiz_status__c='Started';
        atendeeDetail.Quiz_Catagory__c ='Agriculture Junior';
        
        insert atendeeDetail;
        test.startTest();
        System.runAs(user)
        { 
            ApexPages.currentPage().getParameters().put('id', user.id); 
            ApexPages.StandardController sc = new ApexPages.StandardController(new user());
            
            Quiz_validation_controller cont = new Quiz_validation_controller(sc);
            cont.MonthDay=1;
            PageReference ref=cont.navigate();
        }
        test.stopTest();
    }
}