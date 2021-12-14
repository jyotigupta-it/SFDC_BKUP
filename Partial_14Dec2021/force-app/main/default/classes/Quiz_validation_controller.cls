public with sharing class Quiz_validation_controller{

    //declaration and initialisation of variables used
    private final User candidate;
    List<User> listCand=new list<User>();
    public Integer MonthDay {get; set;}  
    
    //constructor
    public Quiz_validation_controller(ApexPages.StandardController controller){
        this.candidate=(User)controller.getRecord();
        MonthDay = Date.Today().Day();
    }
    
     //method to send a security token to the test taker
        
    //method to navigate to the next page and modify the candidate object to have the final time taken calculated
    public PageReference navigate(){
        
        try{
        system.debug('MonthDay:::'+ MonthDay  );
        if(MonthDay  == 04 || MonthDay == 05 || MonthDay  == 06 ){ 
        
        User loggedUserDetail = [Select Quiz_catagory__c from User where id =: UserInfo.getUserId()];
        if(loggedUserDetail.Quiz_catagory__c =='' || loggedUserDetail.Quiz_catagory__c == null){
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,
        'Your user profile does not fall into any of the quiz catagory. Please contact your administator'));
        return null;
        }
           autoRequestBatchHelper autoRequest = new autoRequestBatchHelper();
                
                String thisMonth = autoRequest.getCurrentMonth();
               // List<Quiz_Attendee__c> atendeeToUpsert = new List<Quiz_Attendee__c>();
                List<Quiz_Attendee__c> atendees = [select Quiz_Attendee__c, Quiz_Catagory__c, Quiz_status__c, Quiz_Month__c
                 from Quiz_Attendee__c where Quiz_Attendee__c =: UserInfo.getUserId() and Quiz_Month__c=: thisMonth]; 
                
                if(atendees.size() == 0){
                Quiz_Attendee__c atendeeDetail = new Quiz_Attendee__c();
                atendeeDetail.Quiz_Attendee__c=UserInfo.getUserId();
                atendeeDetail.Quiz_Month__c = thisMonth;
                atendeeDetail.Quiz_status__c='Started';
                atendeeDetail.Quiz_Catagory__c =loggedUserDetail.Quiz_catagory__c;
                //atendeeToUpsert.add(atendeeDetail);
                upsert atendeeDetail;
                }
                else{
                for(Quiz_Attendee__c atend : atendees){
                if(atend.Quiz_status__c=='Completed'){
              
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,
        'You have already attempted the quiz for this month. Hence you will not be able to take the Quiz again'));
        return null;
        
                }
               
                }
                }
                
                
        
             PageReference firstPage = new PageReference ('/apex/QuizQuestionPage');
                firstPage.getParameters().put('ID', userInfo.getUserId());
                firstPage.setRedirect(false);
                return firstPage;           
             }
             else{
              PageReference secondPage = new PageReference ('/apex/QuizErrorPage');
             return secondPage; 
             }
                    }
       
         catch(exception e){system.debug(e.getMessage()); return null;} 
        }
    }