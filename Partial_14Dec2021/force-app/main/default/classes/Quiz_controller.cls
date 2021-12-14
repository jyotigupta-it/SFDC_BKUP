public class Quiz_controller{

    public Boolean flag{get;set;}

    public String Candidate_ID{get; set;}

    Integer counter=0;
    public Integer selectedPage{get;set;}
    public Quiz_controller(){
        Candidate_ID = UserInfo.getUserId();
        selectedPage=1;
        //previous();

    }

    public Id Agrisenior=[Select id from RecordType where Name ='Agriculture Senior'].id;
    public Id AgriJun=[Select id from RecordType where Name ='Agriculture Junior'].id;
    public Id plumsenior=[Select id from RecordType where Name ='Plumbing Senior'].id;
    public Id plumJun=[Select id from RecordType where Name ='Plumbing Junior'].id;

    autoRequestBatchHelper autoRequest = new autoRequestBatchHelper();

    String thisMonth = autoRequest.getCurrentMonth();

    List<Question_Response__c> answeredQuestions = [select Question__c, Question__r.Currect_Answer__c, User_Answer__c from Question_Response__c where User__c =: UserInfo.getUserId() and Quiz_Month__c=: thisMonth ];
    public Integer noOfRecords{get; set;}    
    public Integer size{get;set;}
    public string currentQuesId{get;set;} 

    public string answerRadio{get;set;}
    public integer percentage=0;
    public Map<Id, String> correctAnswersMap = new Map<Id, String>();
    public Map<Id, String> ResponseMap= new Map<Id, String>();        
    public List<SelectOption> options= new List<SelectOption>();
    public Integer CountCorrectAns=0;
    public List<Quiz_Question__c> MasterList= new List<Quiz_Question__c>();
    public List<Quiz_Question__c> SelectedQuestions= new List<Quiz_Question__c>();        
    public String show{get; set;}
    public String responselist='';
    public Integer Count = 10;

    //setter and getter methods for various variables used
    public void setCountCorrectAns(Integer CountCorrectAns ){
        this.CountCorrectAns =CountCorrectAns ;
    }        

    public Integer getCountCorrectAns(){
        return CountCorrectAns;
    }

    public void setPercentage(Integer percentage){
        this.percentage=percentage;
    }        

    public Integer getPercentage(){
        return percentage;
    }   

    // controller method     
    public ApexPages.StandardSetController setCon {
        get{

            if(setCon == null){   

                size = 1;

                /*Getting the details of the logged in User */

              User loggedUserDetail = [Select Quiz_catagory__c from User where id =: UserInfo.getUserId()];

                String appendQuery; 
                String appendQueryCount;

                if( loggedUserDetail.Quiz_catagory__c == 'Agriculture Senior'){
                    appendQuery =' And RecordTypeId =: Agrisenior ';
                    appendQueryCount = ' Where RecordTypeId =: Agrisenior ';

                }
                if( loggedUserDetail.Quiz_catagory__c == 'Agriculture Junior'){
                    appendQuery =' And RecordTypeId =: AgriJun';
                    appendQueryCount = ' Where RecordTypeId =: AgriJun';

                }
                if( loggedUserDetail.Quiz_catagory__c == 'Plumbing Senior'){
                    appendQuery =' And RecordTypeId =: plumsenior';
                    appendQueryCount = ' Where RecordTypeId =: plumsenior';

                }
                if( loggedUserDetail.Quiz_catagory__c == 'Plumbing Junior'){
                    appendQuery =' And RecordTypeId =: plumJun';
                    appendQueryCount = ' Where RecordTypeId =: plumJun';

                }

                Quiz_Attendee__c atendees = [select Quiz_Attendee__c, Quiz_Catagory__c, Quiz_status__c, Quiz_Month__c
                                             from Quiz_Attendee__c where Quiz_Attendee__c =: UserInfo.getUserId() and Quiz_Month__c=: thisMonth limit 1]; 
                Set<Id> selectRandom = new Set<Id>();
                Set<Id> qIds = new Set<Id>();
                if(atendees.Quiz_status__c == 'Pending'){
              
                    for(Question_Response__c answered : answeredQuestions){
                        qIds.add(answered.Question__c);
                        selectRandom.add(answered.Question__c);
                        responseMap.put(answered.Question__c, answered.User_Answer__c);
                    }

                }

                String Query1 = 'SELECT Id FROM Quiz_Question__c' + appendQueryCount +' and isActive__c = true and id not in :qIds';
                List<Quiz_Question__c> qRandom =Database.query(Query1);
                
             
                
                
                set<Integer> random = new set<Integer>();
                while(random.size()!=(10 - qIds.size())){
                    
                    Integer rand = Math.floor(Math.random() * qRandom.size()).intValue();
                    
                    random.add(rand);
                }
               
                for(Integer i :random){             
                    selectRandom.add(qRandom[i].id);
                }
              
                String Query2 = 'select id,Question_Description__c,Option_1__c,Option_2__c,Option_3__c,Option_4__c,Option_5__c, Currect_Answer__c, Quiz_Month__c from Quiz_Question__c where id in: selectRandom and isActive__c = true ' + appendQuery ;//LIMIT 10 OFFSET :selectRandom

                SelectedQuestions=Database.query(Query2 );

                for(Quiz_Question__c s : SelectedQuestions)
                {
                    correctAnswersMap.put(s.id,s.currect_answer__c);
                }                    
                system.debug('SelectedQuestions:::' + SelectedQuestions);
                setCon = new ApexPages.StandardSetController(SelectedQuestions);                
                setCon.setPageSize(size);                
                noOfRecords = setCon.getResultSize();            
                system.debug('noOfRecords:: '+ noOfRecords );
            }            
            return setCon;        
        }
        set;    
    }         

    //method to render the questions on VF page
    public Map<Id, Map<Quiz_Question__c, List<SelectOption>>> getQuestion(){
    Boolean flag = false;
        Map<Quiz_Question__c, List<SelectOption>> quest = new Map<Quiz_Question__c, List<SelectOption>>();    
        Map<ID, Map<Quiz_Question__c, List<SelectOption>>> questlist= new Map<ID, Map<Quiz_Question__c, List<SelectOption>>> ();
        for(Quiz_Question__c a : (List<Quiz_Question__c>)setCon.getRecords()){ 
        system.debug('a::::::::'+ a);
        //flag = true;           
           //for(Question_Response__c answered : answeredQuestions){
              //if(a.id == answered.question__c){
             
             //  }
              //  }
             //if(flag){   
            List<SelectOption> options=new list<SelectOption>();
            options.add(new SelectOption('Option 1',a.option_1__c));
            options.add(new SelectOption('Option 2',a.option_2__c));
            if(a.option_3__c != null) options.add(new SelectOption('Option 3',a.option_3__c));
            if(a.option_4__c != null) options.add(new SelectOption('Option 4',a.option_4__c));
            if(a.option_5__c != null) options.add(new SelectOption('Option 5',a.option_5__c));
            quest.put(a,options);    
            questList.put(a.id, quest);//}
            
        } 
        
        system.debug('questList:::::::::'+ questList);
        return questList;    
    }

    public PageReference test(){
        integer i=0;
        system.debug('coming:::'+answerRadio);  
        if(answerRadio!=null || answerRadio!=''){
            responseMap.put(currentQuesId, answerRadio);

        }
        return null;
    }            

    //methods for pagination
    public Boolean hasNext{        
        get{ 
            if (pagenumber==noofrecords) return false;
            else return true;
        }set;    
    }    

    public Boolean hasPrevious {        
        get{ 
            if(pagenumber==1) return false;
            else return true;
        }set;    
    }      

    public Integer pageNumber {        
        get{return setCon.getPageNumber();        
        }set;    
    }      


    public void previous() {

        show='';
        answerRadio='';
     setCon.previous();   
        Quiz_Question__c CurrQues= SelectedQuestions[pageNumber-1];
        if(responseMap.get(CurrQues.id)!=null){
            show=responseMap.get(CurrQues.id);
            answerRadio= responseMap.get(CurrQues.id);

        }

    }

    public void next() { 

        answerRadio='';
        show='';
     setCon.next();    
        Quiz_Question__c CurrQues= SelectedQuestions.get(pagenumber-1);
        if(responseMap.get(CurrQues.id)!=null){
            show=responseMap.get(CurrQues.id);
            answerRadio= responseMap.get(CurrQues.id);

        }
    } 

    public PageReference submit(){
        Map<String,Integer> AggResult=check(responseMap);
        system.debug('responseMap' + responseMap);
        if(responseMap.size() != count){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,'All Questions are compulsory, Please answer all the questions and click on submit'));
            return null;
        }
        for(Id i: responseMap.keyset()){
            if(responselist== null || responselist==''){
                responselist = i + ';' + responseMap.get(i);
            }
            else {
                responselist = responselist +';' + i + ';' + responseMap.get(i);
            } system.debug('list of :' + responselist);      
        }




        List<Quiz_Attendee__c> atendeeToUpsert = new List<Quiz_Attendee__c>();
        Quiz_Attendee__c atend= [select Quiz_Attendee__c, Quiz_Catagory__c, Quiz_status__c, Quiz_Month__c
                                           from Quiz_Attendee__c where Quiz_Attendee__c =: UserInfo.getUserId() and Quiz_Month__c=: thisMonth limit 1]; 
       // for(Quiz_Attendee__c atend : atendees){
            atend.Quiz_status__c='Completed';
            atend.Time_of_submission__c=system.now();
            atend.Percentage__c=AggResult.get('Total Percentage');
            atend.Correct_answers__c=AggResult.get('Correct Answers');
             atend.CorrectAnswerCollect__c=responselist;
            //atendeeToUpsert.add(atend);
       // }

        upsert atend;//atendeeToUpsert;

        responseMap.clear();
        PageReference submission= new PageReference ('/apex/QuizResults');
        submission.getParameters().put('Result_ID', atend.id);
        submission.getParameters().put('Candidate_ID',UserInfo.getUserId());



        submission.setRedirect(true);    
        return submission;             


    }

    public Map<String,Integer> check(Map<Id, String> response){
        Map<String,Integer> AggResult=new Map<String,Integer>();
        CountCorrectAns=0;
        List<Question_Response__c> qRespList=new List<Question_Response__c>();
        boolean checkFlag =false;
        system.debug('answeredQuestions:::' + answeredQuestions.size());
        Map<Id, Question_Response__c> ansmap = new Map<Id, Question_Response__c>();
        for(Question_Response__c resp :answeredQuestions ){
            ansmap.put(resp.question__c, resp);
        }
        
        system.debug('response:::' + response.size());
        for(Id s:response.keyset()){
         checkFlag =false;
         //  for(Question_Response__c resp :answeredQuestions ){
           
         //  if(s==resp.question__c){
           Question_Response__c resp = ansmap.get(s);
            if(resp!=null){
           resp.User_Answer__c = response.get(s);
           qRespList.add(resp);
                checkFlag = true;}
          // break;
          // }
           //}
           if(!checkFlag){
            Question_Response__c qResp = new Question_Response__c();
            qResp.Question__c = s;
            qResp.User__c = UserInfo.getUserId();
            qResp.User_Answer__c = response.get(s);
            qResp.Quiz_Month__c = thisMonth;
            qRespList.add(qResp);
            }
            if(response.get(s)== correctAnswersMap.get(s)){
                CountCorrectAns++;
            }

        }
        system.debug('qRespList:::' + qRespList);
        upsert qRespList;

        percentage=(countCorrectAns*100)/noOfRecords; 
        aggResult.put('Correct Answers',countCorrectAns);
        aggresult.put('Total Percentage',percentage);
        return aggresult;                                             
    }

    public Component.Apex.outputPanel getPreviousNext() {
        Set<string> theSet = new Set<string>();
        theSet.add('myButtons');        
        theSet.add('pb');

        Component.Apex.outputPanel pbButtons= new Component.Apex.outputPanel();        
        pbButtons.id='op';

        Component.Apex.commandButton b1 = new Component.Apex.commandButton();
        b1.expressions.action = '{!Previous}';
        b1.title = 'Previous';
        b1.value = 'Previous';
        b1.expressions.disabled = '{!!hasPrevious}';   
        b1.reRender = theSet;
        b1.style='width:100px;color:black;height:25px;font-size:100%;';
        pbButtons.childComponents.add(b1);        

        Component.Apex.commandButton b2 = new Component.Apex.commandButton();
        b2.expressions.action = '{!Next}';
        b2.title = 'Next';
        b2.value = 'Next';
        b2.expressions.disabled = '{!!hasNext}';
        b2.reRender = theSet;
        b2.style='width:100px;color:black;height:25px;font-size:100%;';
        pbButtons.childComponents.add(b2);


        return pbButtons;
    }

    public PageReference saveClose(){
       
        Map<String,Integer> AggResult=check(responseMap);
          
     
        Quiz_Attendee__c atendees = [select Quiz_Attendee__c, Quiz_Catagory__c, Quiz_status__c, Quiz_Month__c
                                             from Quiz_Attendee__c where Quiz_Attendee__c =: UserInfo.getUserId() and Quiz_Month__c=: thisMonth limit 1]; 
        atendees.Quiz_status__c = 'Pending';
        
        update atendees ;
        
        
        pagereference submission=new pagereference('/home/home.jsp');

        submission.setredirect(true);
  
        return submission;             

       
    }

}