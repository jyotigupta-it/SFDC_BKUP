@isTest
public class Quiz_results_UT{
 static testMethod void Quizcontrollertest(){
Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( Quiz_catagory__c='Agriculture Senior', FirstName='Test', LastName='User', alias='abcd', email='testuser@abc.com', username='testuser123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
     test.startTest();
     Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Quiz_Question__c; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
   Id i= CaseRecordTypeInfo.get('Agriculture Junior').getRecordTypeId(); 
  
    
    Quiz_Question__c quest = new Quiz_Question__c();
    quest.Question_Description__c ='abcdefgh';
    quest.Currect_Answer__c ='Option 1';
    quest.Option_1__c = 'a';
    quest.Option_2__c ='b';
    quest.Option_3__c ='c';
    quest.Option_4__c ='d';
    quest.Option_5__c ='d';
     quest.recordtypeId =i;  
    insert quest;
    
    Quiz_Question__c quest1 = new Quiz_Question__c();
    quest1.Question_Description__c ='abcdefgh';
    quest1.Currect_Answer__c ='Option 2';
    quest1.Option_1__c = 'a';
    quest1.Option_2__c ='b';
    quest1.Option_3__c ='c';
    quest1.Option_4__c ='d';
     quest1.Option_5__c ='d';
    quest1.recordtypeId =i;   
    insert quest1;
    
    Quiz_Question__c quest2 = new Quiz_Question__c();
    quest2.Question_Description__c ='abcdefgh';
    quest2.Currect_Answer__c ='Option 4';
    quest2.Option_1__c = 'a';
    quest2.Option_2__c ='b';
    quest2.Option_3__c ='c';
    quest2.Option_4__c ='d';
     quest2.Option_5__c ='d';
    quest2.recordtypeId =i;   
    insert quest2;
    
    Quiz_Question__c quest3 = new Quiz_Question__c();
    quest3.Question_Description__c ='abcdefgh';
    quest3.Currect_Answer__c ='Option 4';
    quest3.Option_1__c = 'a';
    quest3.Option_2__c ='b';
    quest3.Option_3__c ='c';
    quest3.Option_4__c ='d';  
     quest3.Option_5__c ='d';
    quest3.recordtypeId =i; 
    insert quest3;
    
    Quiz_Question__c quest4 = new Quiz_Question__c();
    quest4.Question_Description__c ='abcdefgh';
    quest4.Currect_Answer__c ='Option 5';
    quest4.Option_1__c = 'a';
    quest4.Option_2__c ='b';
    quest4.Option_3__c ='c';
    quest4.Option_4__c ='d'; 
     quest4.Option_5__c ='d'; 
    quest4.recordtypeId =i; 
    insert quest4;
    
    Quiz_Question__c quest5 = new Quiz_Question__c();
    quest5.Question_Description__c ='abcdefgh';
    quest5.Currect_Answer__c ='Option 5';
    quest5.Option_1__c = 'a';
    quest5.Option_2__c ='b';
    quest5.Option_3__c ='c';
    quest5.Option_4__c ='d'; 
    quest5.recordtypeId =i;  
    insert quest5;
    
    Quiz_Question__c quest6 = new Quiz_Question__c();
    quest6.Question_Description__c ='abcdefgh';
    quest6.Currect_Answer__c ='Option 3';
    quest6.Option_1__c = 'a';
    quest6.Option_2__c ='b';
    quest6.Option_3__c ='c';
    quest6.Option_4__c ='d';
    quest6.recordtypeId =i;   
    insert quest6;
    
    Quiz_Question__c quest7 = new Quiz_Question__c();
    quest7.Question_Description__c ='abcdefgh';
    quest7.Currect_Answer__c ='Option 3';
    quest7.Option_1__c = 'a';
    quest7.Option_2__c ='b';
    quest7.Option_3__c ='c';
    quest7.Option_4__c ='d'; 
    quest7.recordtypeId =i;  
    insert quest7;
    
    Quiz_Question__c quest8 = new Quiz_Question__c();
    quest8.Question_Description__c ='abcdefgh';
    quest8.Currect_Answer__c ='Option 2';
    quest8.Option_1__c = 'a';
    quest8.Option_2__c ='b';
    quest8.Option_3__c ='c';
    quest8.Option_4__c ='d';
    quest8.recordtypeId =i;   
    insert quest8;
    
    Quiz_Question__c quest89 = new Quiz_Question__c();
    quest89.Question_Description__c ='abcdefgh';
    quest89.Currect_Answer__c ='Option 2';
    quest89.Option_1__c = 'a';
    quest89.Option_2__c ='b';
    quest89.Option_3__c ='c';
    quest89.Option_4__c ='d';
    quest89.Option_5__c ='d';
    quest89.recordtypeId =i;   
    insert quest89;
    
    Question_Response__c resp = new Question_Response__c();
    resp.Question__c=quest.id;
    resp.Quiz_Month__c='September - 2015';
    resp.User__c = user.id;
    resp.User_Answer__c='Option 2';
    insert resp;
    
    
    Question_Response__c resp1 = new Question_Response__c();
    resp1.Question__c=quest1.id;
    resp1.Quiz_Month__c='September - 2015';
    resp1.User__c = user.id;
    resp1.User_Answer__c='Option 2';
    insert resp1;
    
     Question_Response__c resp11 = new Question_Response__c();
    resp11.Question__c=quest6.id;
    resp11.Quiz_Month__c='September - 2015';
    resp11.User__c = user.id;
    resp11.User_Answer__c='Option 1';
    insert resp11;
    
     Question_Response__c resp12 = new Question_Response__c();
    resp12.Question__c=quest3.id;
    resp12.Quiz_Month__c='September - 2015';
    resp12.User__c = user.id;
    resp12.User_Answer__c='Option 4';
    insert resp12;
    
    Question_Response__c resp13 = new Question_Response__c();
    resp13.Question__c=quest4.id;
    resp13.Quiz_Month__c='September - 2015';
    resp13.User__c = user.id;
    resp13.User_Answer__c='Option 3';
    insert resp13;
    
    Question_Response__c resp14 = new Question_Response__c();
    resp14.Question__c=quest5.id;
    resp14.Quiz_Month__c='September - 2015';
    resp14.User__c = user.id;
    resp14.User_Answer__c='Option 5';
    insert resp14;
    
    Question_Response__c resp141 = new Question_Response__c();
    resp141.Question__c=quest7.id;
    resp141.Quiz_Month__c='September - 2015';
    resp141.User__c = user.id;
    resp141.User_Answer__c='Option 5';
    insert resp141;
    
    Question_Response__c resp148 = new Question_Response__c();
    resp148.Question__c=quest8.id;
    resp148.Quiz_Month__c='September - 2015';
    resp148.User__c = user.id;
    resp148.User_Answer__c='Option 5';
    insert resp148;
    
     Quiz_Attendee__c atendeeDetail = new Quiz_Attendee__c();
    atendeeDetail.Quiz_Attendee__c=user.id;
    atendeeDetail.Quiz_Month__c = 'September - 2015';
    atendeeDetail.Quiz_status__c='Completed';
    atendeeDetail.Quiz_Catagory__c ='Agriculture Junior';
    atendeeDetail.percentage__c =100;
    atendeeDetail.Correct_Answers__c =10;
    atendeeDetail.CorrectAnswerCollect__c=quest.id+';'+ 'Option 1'+';'+
    quest1.id+';'+ 'Option 2'+';' + quest6.id+';'+ 'Option 3'+';' + quest2.id+';'+ 'Option 4'+';' + quest3.id+';'+ 'Option 4'+';' +quest4.id+';'+ 'Option 5'+';' + quest5.id+';'+ 'Option 2'+';' +
        quest8.id+';'+ 'Option 1'+';' + quest1.id+';'+ 'Option 4'+';' + quest89.id+';'+ 'Option 5'+';';     
    insert atendeeDetail;
           
    System.runAs(user)
    { 
   
    ApexPages.currentPage().getParameters().put('Candidate_ID', user.id);
    ApexPages.currentPage().getParameters().put('Result_ID', atendeeDetail.id); 
    
    ApexPages.StandardController sc = new ApexPages.StandardController(new User());     
    Quizresult_controller cont = new Quizresult_controller(sc);
       //cont.Candidate_ID=user.id;
     PageReference ref=cont.sendPdf();
 
      }
    test.stopTest();
}


}