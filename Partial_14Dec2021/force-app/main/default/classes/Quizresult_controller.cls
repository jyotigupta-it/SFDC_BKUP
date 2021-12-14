public class Quizresult_controller {

    public String Result_ID { get; set; }
    public String Candidate_ID{ get; set;} 
    public Integer correctAnswer{get; set;}
    public Integer Percentage{get; set;}
    public Integer marked{get; set;}
    public Integer numberOfQuestions{get; set;}    
    public String result{get; set;}     
    public Boolean flag{get; set;}
    public Boolean check{get; set;}    
   public List<Quiz_Question__c> questionslist{get; set;} 
        
    public String CorrectAnswerCollect{get; set;}
      
    Map<id,string> correctAnswersMap=new Map<id,string>();
    Map<id,string> responseMap=new Map<id,string>(); 
    Map<Quiz_Question__c, List<String>> descriptionoption = new Map<Quiz_Question__c, List<String>>();     
       
      public Quizresult_controller(ApexPages.StandardController controller) {
       
        Result_ID = Apexpages.currentPage().getParameters().get('Result_ID');
        Candidate_ID = Apexpages.currentPage().getParameters().get('Candidate_ID');
            
         autoRequestBatchHelper autoRequest = new autoRequestBatchHelper();

    String thisMonth = autoRequest.getCurrentMonth();
        
        List<Question_Response__c> res = [select Question__c from Question_Response__c where User__c =: UserInfo.getUserId() and
        Quiz_Month__c =: thisMonth ];
        system.debug('response list' + res);
        List<Id> quesId = new List<Id>();
        for(Question_Response__c resp : res){
       quesId.add(resp.Question__c);
       
        }
        questionslist=[Select id,currect_answer__c,Question_Description__c, Option_1__c, Option_2__c, Option_3__c, Option_4__c, Option_5__c from Quiz_Question__c 
        where id in: quesId];
       
        for(Quiz_Question__c q: questionslist){
             correctAnswersMap.put(q.id,q.currect_answer__c);
         } 
        numberOfQuestions= questionslist.size();
          
      
        Quiz_Attendee__c showResult=[Select Correct_Answers__c,Percentage__c,CorrectAnswerCollect__c from Quiz_Attendee__c where id=:Result_ID ];
           correctAnswer=showResult.Correct_Answers__c.intvalue();
        percentage=showresult.Percentage__c.intvalue();
     CorrectAnswerCollect= showResult.CorrectAnswerCollect__c;

        system.debug('CorrectAnswerCollect:::'+CorrectAnswerCollect);
        if(percentage<50) result='Fail';
        else{
            result='Pass';
            flag=true;                    
        }        
     
       getdescriptionoption();
      
        
    }

    public Map<Quiz_Question__c, List<String>> getdescriptionoption(){
        String descr= '';
        String corr='';
        DateTime d = datetime.now();
        String monthName= d.format('MMMMM');
        String year= d.format('Y');

        list<String> CollectResponse= new list<String>();
        if (correctAnswerCollect!='' && correctAnswerCollect!=null) {
       
       CollectResponse=CorrectAnswerCollect.split(';');
         system.debug(' list of response '+CorrectAnswerCollect.split(';'));
         system.debug('List is  ' +CollectResponse);       
        }
       for(integer i=0; i<CollectResponse.size(); i=i+2)
       {
        responseMap.put(CollectResponse.get(i), CollectResponse.get(i+1));
       }        
       
        marked=responseMap.size();
      
        for(Quiz_Question__c ques: questionslist)
        {
        List<String> options=new list<String>();
        descr= ques.Question_Description__c;
     
        descriptionoption.put(ques,options);
        system.debug('Result_ID:'+result_id);
        system.debug('CorrectAnswerCollect:'+CorrectAnswerCollect);       
            
        if(correctAnswersMap.get(ques.id)== 'Option 1' && ResponseMap.get(ques.id)!='Option 1')
        {
          corr =  ques.Option_1__c + '  (Correct answer) ';
          options.add(corr);
          check= true;
        }        
        if(ResponseMap.get(ques.id)=='Option 1' && correctAnswersMap.get(ques.id)!= 'Option 1')
        {
         corr = ques.Option_1__c + '  (Your choice) ';
         options.add(corr);
         
        }
        if(correctAnswersMap.get(ques.id)!= 'Option 1' && ResponseMap.get(ques.id)!='Option 1')
        {
         options.add(ques.Option_1__c);
        } 
        if(ResponseMap.get(ques.id)=='Option 1' && correctAnswersMap.get(ques.id)== 'Option 1')
        {
         corr = ques.Option_1__c +'  (Correct answer) '+' (Your choice) ';
         options.add(corr);
         check=true;
        }
 
          
        
         if(correctAnswersMap.get(ques.id)== 'Option 2' && ResponseMap.get(ques.id)!='Option 2')
        {
          corr =  ques.Option_2__c + '  (Correct answer) ';
          options.add(corr);
          check=true;
        }        
        if(ResponseMap.get(ques.id)=='Option 2' && correctAnswersMap.get(ques.id)!= 'Option 2')
        {
         corr = ques.Option_2__c + '  (Your choice) ';
         options.add(corr);
         
        }
        if(correctAnswersMap.get(ques.id)!= 'Option 2' && ResponseMap.get(ques.id)!='Option 2')
        {
         options.add(ques.Option_2__c);
        } 
        if(ResponseMap.get(ques.id)=='Option 2' && correctAnswersMap.get(ques.id)== 'Option 2')
        {
         corr = ques.Option_2__c +'  (Correct answer) '+' (Your choice) ';
         options.add(corr);
         check=true;
        }
        
        
        
        if(ques.Option_3__c!=null||ques.Option_3__c==''){
        if(correctAnswersMap.get(ques.id)== 'Option 3' && ResponseMap.get(ques.id)!='Option 3' )
        {
          corr =  ques.Option_3__c + '  (Correct answer) ';
          options.add(corr);
          check=true;
        }        
        if(ResponseMap.get(ques.id)=='Option 3'  && correctAnswersMap.get(ques.id)!= 'Option 3')
        {
         corr = ques.Option_3__c + '  (Your choice) ';
         options.add(corr);
         
        }
        if(correctAnswersMap.get(ques.id)!= 'Option 3'  && ResponseMap.get(ques.id)!='COption 3' )
        {
         options.add(ques.Option_3__c);
        } 
        if(ResponseMap.get(ques.id)=='Option 3'  && correctAnswersMap.get(ques.id)== 'Option 3' )
        {
         corr = ques.Option_3__c +'  (Correct answer) '+' (Your choice) ';
         options.add(corr);
         check=true;
        }
        }

        
        if(ques.Option_4__c!=null||ques.Option_4__c==''){
        if(correctAnswersMap.get(ques.id)== 'Option 4' && ResponseMap.get(ques.id)!='Option 4')
        {
          corr =  ques.Option_4__c + '  (Correct answer) ';
           options.add(corr);
          check=true;
        }        
        if(ResponseMap.get(ques.id)=='Option 4' && correctAnswersMap.get(ques.id)!= 'Option 4')
        {
         corr = ques.Option_4__c + '  (Your choice) ';
          options.add(corr);
        }
        if(correctAnswersMap.get(ques.id)!= 'Option 4' && ResponseMap.get(ques.id)!='Option 4')
        {
         options.add(ques.Option_4__c);
        } 
        if(ResponseMap.get(ques.id)=='Option 4' && correctAnswersMap.get(ques.id)== 'Option 4')
        {
         corr = ques.Option_4__c +'  (Correct answer) '+' (Your choice) ';
          options.add(corr);
         check=true;
        }
        }
        
        if(ques.Option_5__c!=null||ques.Option_5__c==''){
        if(correctAnswersMap.get(ques.id)== 'Option 5' && ResponseMap.get(ques.id)!='Option 5')
        {
          corr =  ques.Option_5__c + '  (Correct answer) ';
           options.add(corr);
          check=true;
        }        
        if(ResponseMap.get(ques.id)=='Option 5' && correctAnswersMap.get(ques.id)!= 'Option 5')
        {
         corr = ques.Option_5__c + '  (Your choice) ';
          options.add(corr);
        }
        if(correctAnswersMap.get(ques.id)!= 'Option 5' && ResponseMap.get(ques.id)!='Option 5')
        {
         options.add(ques.Option_5__c);
        } 
        if(ResponseMap.get(ques.id)=='Option 5' && correctAnswersMap.get(ques.id)== 'Option 5')
        {
         corr = ques.Option_5__c +'  (Correct answer) '+' (Your choice) ';
          options.add(corr);
         check=true;
        }
        }

      }
        //sendPdf();     
       return descriptionoption;
      
  }
  
  public PageReference sendPdf() {

    PageReference pdf = Page.QuizPFDAttachment;
    pdf.getParameters().put('Candidate_ID', Candidate_ID);
    pdf.getParameters().put('Result_ID', Result_ID);
    // the contents of the attachment from the pdf
    Blob body;
    // returns the output of the page as a PDF
    body = Test.isRunningTest() ? Blob.valueOf('UNIT.TEST') : pdf.getContent();
    
   // body = pdf.getContent();
  
    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
    attach.setContentType('application/pdf');
    attach.setFileName('QuizResult.pdf');
    attach.setInline(false);
    attach.Body = body;
    
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setUseSignature(false);
    mail.setToAddresses(new String[]{UserInfo.getUserEmail()});
    mail.setSubject('Monthly Quiz Results');
    mail.setHtmlBody('Please find attached the PDF with the Results of the Quiz taken for this month');
    mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 

    // Send the email
    Messaging.sendemailresult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
  
    ApexPages.addmessage(new ApexPages.message(ApexPages.Severity.confirm,
       'The Email has been sent to email address '+ UserInfo.getUserEmail()));
    return null;

  }
 public PageReference close() {
  pagereference submission=new pagereference('/home/home.jsp');

        submission.setredirect(true);
  
        return submission;}  
 }