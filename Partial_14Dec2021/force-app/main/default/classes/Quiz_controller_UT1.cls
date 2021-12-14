@isTest
public class Quiz_controller_UT1{

 static testMethod void Quizcontrollertest(){
 autoRequestBatchHelper helper = new autoRequestBatchHelper();
Profile profile= [Select Id from Profile where name='System Administrator' limit 1];
    User user= new User( Quiz_catagory__c='Agriculture Senior', FirstName='Test1', LastName='User1', alias='abcd', email='testuser@abc.com', username='test123user123@abc.com', profileId=profile.Id, TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='UTF-8', LanguageLocaleKey='en_US');
    insert user;
     test.startTest();
     Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Quiz_Question__c; 
    Map<String,Schema.RecordTypeInfo> CaseRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
   Id i= CaseRecordTypeInfo.get('Agriculture Junior').getRecordTypeId(); 
   Quiz_Attendee__c atendeeDetail = new Quiz_Attendee__c();
    atendeeDetail.Quiz_Attendee__c=user.id;
    atendeeDetail.Quiz_Month__c = helper.getCurrentMonth();
    atendeeDetail.Quiz_status__c='Pending';
    atendeeDetail.Quiz_Catagory__c ='Agriculture Junior';
    
    insert atendeeDetail;
    
    Quiz_Question__c quest1 = new Quiz_Question__c();
    quest1.Question_Description__c ='abcdefgh';
    quest1.Currect_Answer__c ='Option 1';
    quest1.Option_1__c = 'a';
    quest1.Option_2__c ='b';
    quest1.Option_3__c ='c';
    quest1.Option_4__c ='d';
    quest1.recordtypeId =i;   
    insert quest1;
    
    Quiz_Question__c quest2 = new Quiz_Question__c();
    quest2.Question_Description__c ='abcdefgh';
    quest2.Currect_Answer__c ='Option 1';
    quest2.Option_1__c = 'a';
    quest2.Option_2__c ='b';
    quest2.Option_3__c ='c';
    quest2.Option_4__c ='d';
    quest2.recordtypeId =i;   
    insert quest2;
    
    Quiz_Question__c quest3 = new Quiz_Question__c();
    quest3.Question_Description__c ='abcdefgh';
    quest3.Currect_Answer__c ='Option 1';
    quest3.Option_1__c = 'a';
    quest3.Option_2__c ='b';
    quest3.Option_3__c ='c';
    quest3.Option_4__c ='d';  
    quest3.recordtypeId =i; 
    insert quest3;
    
    Quiz_Question__c quest4 = new Quiz_Question__c();
    quest4.Question_Description__c ='abcdefgh';
    quest4.Currect_Answer__c ='Option 1';
    quest4.Option_1__c = 'a';
    quest4.Option_2__c ='b';
    quest4.Option_3__c ='c';
    quest4.Option_4__c ='d';  
    quest4.recordtypeId =i; 
    insert quest4;
    
    Quiz_Question__c quest5 = new Quiz_Question__c();
    quest5.Question_Description__c ='abcdefgh';
    quest5.Currect_Answer__c ='Option 1';
    quest5.Option_1__c = 'a';
    quest5.Option_2__c ='b';
    quest5.Option_3__c ='c';
    quest5.Option_4__c ='d'; 
    quest5.recordtypeId =i;  
    insert quest5;
    
    Quiz_Question__c quest6 = new Quiz_Question__c();
    quest6.Question_Description__c ='abcdefgh';
    quest6.Currect_Answer__c ='Option 1';
    quest6.Option_1__c = 'a';
    quest6.Option_2__c ='b';
    quest6.Option_3__c ='c';
    quest6.Option_4__c ='d';
    quest6.recordtypeId =i;   
    insert quest6;
    
    Quiz_Question__c quest7 = new Quiz_Question__c();
    quest7.Question_Description__c ='abcdefgh';
    quest7.Currect_Answer__c ='Option 1';
    quest7.Option_1__c = 'a';
    quest7.Option_2__c ='b';
    quest7.Option_3__c ='c';
    quest7.Option_4__c ='d'; 
    quest7.recordtypeId =i;  
    insert quest7;
    
    Quiz_Question__c quest8 = new Quiz_Question__c();
    quest8.Question_Description__c ='abcdefgh';
    quest8.Currect_Answer__c ='Option 1';
    quest8.Option_1__c = 'a';
    quest8.Option_2__c ='b';
    quest8.Option_3__c ='c';
    quest8.Option_4__c ='d';
    quest8.recordtypeId =i;   
    insert quest8;
    
    Quiz_Question__c quest9 = new Quiz_Question__c();
    quest9.Question_Description__c ='abcdefgh';
    quest9.Currect_Answer__c ='Option 1';
    quest9.Option_1__c = 'a';
    quest9.Option_2__c ='b';
    quest9.Option_3__c ='c';
    quest9.Option_4__c ='d';  
    quest9.recordtypeId =i; 
    insert quest9;
    
    Quiz_Question__c quest10 = new Quiz_Question__c();
    quest10.Question_Description__c ='abcdefgh';
    quest10.Currect_Answer__c ='Option 1';
    quest10.Option_1__c = 'a';
    quest10.Option_2__c ='b';
    quest10.Option_3__c ='c';
    quest10.Option_4__c ='d';
    quest10.recordtypeId =i;   
    insert quest10;
    
    Question_Response__c resp = new Question_Response__c();
    resp.Question__c=quest1.id;
    resp.Quiz_Month__c=helper.getCurrentMonth();
    resp.User__c = user.id;
    resp.User_Answer__c='Option 3';
    insert resp;
    
    
    Question_Response__c resp1 = new Question_Response__c();
    resp1.Question__c=quest10.id;
    resp1.Quiz_Month__c=helper.getCurrentMonth();
    resp1.User__c = user.id;
    resp1.User_Answer__c='Option 3';
    insert resp1;
    
            
    System.runAs(user)
    { 
   
    ApexPages.currentPage().getParameters().put('id', user.id); 
    Quiz_controller pdd = new Quiz_controller();
    List<Quiz_Question__c> lec= new List<Quiz_Question__c>();
    lec.add(quest7);
    lec.add(quest8);
    pdd.SelectedQuestions.add(quest1);
    pdd.SelectedQuestions.add(quest2);
    pdd.SelectedQuestions.add(quest3);
    pdd.SelectedQuestions.add(quest4);
    pdd.SelectedQuestions.add(quest5);
    pdd.SelectedQuestions.add(quest6);
    pdd.SelectedQuestions.add(quest7);
    pdd.SelectedQuestions.add(quest8);
    pdd.SelectedQuestions.add(quest9);
    pdd.SelectedQuestions.add(quest10);

    Component.Apex.outputPanel a=pdd.getPreviousNext();
    pdd.flag=true;
    pdd.noOfRecords=10;
    pdd.size=100;
    pdd.currentQuesId=quest7.id;
    pdd.show='asd';
    pdd.answerRadio='asd';
    pdd.setCountCorrectAns(1);
    pdd.responseMap.put(quest1.id,'a');
    pdd.responseMap.put(quest2.id,'b');
    pdd.responseMap.put(quest3.id,'a');
    pdd.responseMap.put(quest4.id,'b');
    pdd.responseMap.put(quest5.id,'a');
    pdd.responseMap.put(quest6.id,'b');
    pdd.responseMap.put(quest7.id,'a');
    pdd.responseMap.put(quest8.id,'b');
    pdd.responseMap.put(quest9.id,'a');
    pdd.responseMap.put(quest10.id,'b');
    
    Integer ia=pdd.getCountCorrectAns();
    pdd.setPercentage(2);
    ia=pdd.getPercentage();  
    pdd.Candidate_ID=user.id;
    pdd.setCon=new ApexPages.StandardSetController(lec);
    boolean b;
    b =pdd.hasnext;
    b =pdd.hasPrevious;
    pdd.pagenumber=1;
    b =pdd.hasPrevious;
    pdd.getQuestion();
    PageReference ref;
    //pdd.setCon=null;
    ref=pdd.submit();
    ref=pdd.saveClose();
    ref=pdd.test();
    pdd.next();
    pdd.previous();   
      }
    test.stopTest();
}


}