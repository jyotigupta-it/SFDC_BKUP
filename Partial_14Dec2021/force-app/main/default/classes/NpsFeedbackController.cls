public with sharing class NpsFeedbackController {
    
    @AuraEnabled(cacheable=true)
    public static List<QuestionWrapper> fetchQuestions(String accountId) {
        System.debug('accountId **** ' + accountId);
        Account accountList;
        Id npsRecordId;
        List<NPS__c> npsRecordList = new List<NPS__c>();
        if(accountId != null) {
            accountList = [SELECT Id, Party_Type__c FROM Account WHERE Id =: accountId LIMIT 1];
            npsRecordList = [SELECT Id FROM NPS__c WHERE Account__c =: accountId AND Account__c != null Order By CreatedDate Desc LIMIT 1];
            if (npsRecordList.size() > 0) {
                npsRecordId = npsRecordList[0].Id;
            }
        }
        
        List<QuestionWrapper> wrapQuestionList = new List<QuestionWrapper>();
        List<Master_Questions__c> masterQuestionList = new List<Master_Questions__c>([SELECT Id, Question_Name__c, Type__c, Options__c,
                                                                                        Status__c, Mandatory__c, Question_Order__c
                                                                                        FROM Master_Questions__c WHERE Status__c = true 
                                                                                        ORDER BY Question_Order__c ASC]);

        System.debug('masterQuestionList ' + masterQuestionList);
        for(Master_Questions__c mQues : masterQuestionList) {
            if(accountList != null && 
                (accountList.Party_Type__c == Label.Dealer_Label || accountList.Party_Type__c == Label.Plumber_Label)
                && npsRecordId != null) {
                String quesName = mQues.Question_Name__c;
                quesName = quesName.replace(Label.Question_Modify, accountList.Party_Type__c); // replace @@@@ in the question with PArty type of Account.
                wrapQuestionList.add(new QuestionWrapper(mQues.Id, 
                                                            quesName, 
                                                            mQues.Status__c, 
                                                            mQues.Options__c, 
                                                            mQues.Type__c, '',
                                                            mQues.Question_Order__c, 
                                                            mQues.Mandatory__c,
                                                            npsRecordId));
            }
        }
        System.debug('wrapQuestionList **** ' + wrapQuestionList);
        return wrapQuestionList;
    }

    @AuraEnabled
    public static void saveSurveyDetailsMethod(List<Survey_Details__c> surveyDetailList, String surveyDetailChildList,
                                                String selectedTopBrandName, Decimal selectedTopBrandRating, 
                                                String accountId, String selectedFeedbackStatus, String lookupValueWithLabel) {
        try {
            System.debug('lookupValueWithLabel ' + lookupValueWithLabel);
            System.debug('selectedTopBrandName ' + selectedTopBrandName + ' --- ' + selectedTopBrandRating + ' ---- ' + accountId);
            List<Answer_Option__c> answerOptionListToInsert = new List<Answer_Option__c>();
            Map<Id, Id> serveyDetailMap = new Map<Id, Id>();
            if(surveyDetailList.size() > 0) {

                if (surveyDetailList.size() > 0) {
                    System.debug('surveyDetailList before insert ' + surveyDetailList);
                    Insert surveyDetailList; // Insert Survey details which has response of master questions
                }
                System.debug('surveyDetailList after insert ' + surveyDetailList);
                for (Survey_Details__c serDetail : surveyDetailList) {
                    serveyDetailMap.put(serDetail.Master_Questions__c, serDetail.Id); // storing Survey details Id on each question id to insert child record(Answer option)
                }

                List<Object> lookupValueWithLabelList = (List<Object>) JSON.deserializeUntyped(lookupValueWithLabel);
                Map<String, String> lookupMap = new Map<String, String>();
                for (Object iterateObjList : lookupValueWithLabelList) {
                    if(iterateObjList != null) {
                        Map<String, Object> surveyDetailMap = (Map<String, Object>) iterateObjList;
                        List<String> keyValue = new List<String>(surveyDetailMap.keySet());
                        lookupMap.put(keyValue[0], JSON.serialize(surveyDetailMap.get(keyValue[0]))); // Map to hold rating as key and brand name as value 
                    }
                }
                System.debug('qwewwe final lookupMap ' + lookupMap);
                
                
                List<Object> surveyDetailObj = (List<Object>) JSON.deserializeUntyped(surveyDetailChildList);
                for (Object iterateObjList : surveyDetailObj) {
                    if(iterateObjList != null) {
                        Map<String, Object> surveyDetailMap = (Map<String, Object>) iterateObjList;
                        
                        System.debug('fdsfdsf' + surveyDetailMap.get('Response__c'));
                        if ((String) surveyDetailMap.get('Type') == 'Custom' && (String) surveyDetailMap.get('Options') == '001' && surveyDetailMap.get('Response__c') != null) {
                            List<Object> responseList = (List<object>) surveyDetailMap.get('Response__c');

                            for (Object obj : responseList) {
                                ResponseWrapper wrpInstace = (ResponseWrapper)JSON.deserializeStrict(JSON.serialize(obj), ResponseWrapper.class); // map response list values with wrapper class attributes
                                Answer_Option__c ansOption = new Answer_Option__c();
                                ansOption.Survey_Details__c = serveyDetailMap.get((String)surveyDetailMap.get('Master_Questions__c'));
                                ansOption.Custom_Question__c = '';
                                ansOption.Custom_Value__c = wrpInstace.Name;
                                ansOption.Other_Top_Brand__c = '';
                                answerOptionListToInsert.add(ansOption);
                            }
                            
                        }

                        if ((String) surveyDetailMap.get('Type') == 'Custom' && (String) surveyDetailMap.get('Options') == '002' && surveyDetailMap.get('Response__c') != null) {
                            List<Object> responseList = (List<object>) surveyDetailMap.get('Response__c');

                            for (Object obj : responseList) {
                                ResponseWrapper wrpInstace = (ResponseWrapper)JSON.deserializeStrict(JSON.serialize(obj), ResponseWrapper.class);
                                Answer_Option__c ansOption = new Answer_Option__c();
                                ansOption.Survey_Details__c = serveyDetailMap.get((String)surveyDetailMap.get('Master_Questions__c'));
                                ansOption.Custom_Question__c = lookupMap.get(wrpInstace.value).remove('\"'); // removing double quote from selected brand name
                                ansOption.Custom_Value__c = wrpInstace.value;
                                ansOption.Other_Top_Brand__c = '';
                                answerOptionListToInsert.add(ansOption);
                            }
                            
                        }

                        if ((String) surveyDetailMap.get('Type') == 'Custom' && (String) surveyDetailMap.get('Options') == '003' && surveyDetailMap.get('Response__c') != null) {
                            List<Object> responseList = (List<object>) surveyDetailMap.get('Response__c');

                            for (Object obj : responseList) {
                                ResponseWrapper wrpInstace = (ResponseWrapper)JSON.deserializeStrict(JSON.serialize(obj), ResponseWrapper.class);
                                Answer_Option__c ansOption = new Answer_Option__c();
                                ansOption.Survey_Details__c = serveyDetailMap.get((String)surveyDetailMap.get('Master_Questions__c'));
                                ansOption.Custom_Question__c = wrpInstace.label;
                                ansOption.Custom_Value__c = wrpInstace.subQuesRating;
                                ansOption.Other_Top_Brand__c = wrpInstace.subQuesTopBrandRating;
                                answerOptionListToInsert.add(ansOption);
                            }

                        }

                        if ((String) surveyDetailMap.get('Type') == 'Custom' && (String) surveyDetailMap.get('Options') == '004' && surveyDetailMap.get('Response__c') != null) {
                            List<Object> responseList = (List<object>) surveyDetailMap.get('Response__c');

                            for (Object obj : responseList) {
                                ResponseWrapper wrpInstace = (ResponseWrapper)JSON.deserializeStrict(JSON.serialize(obj), ResponseWrapper.class);
                                Answer_Option__c ansOption = new Answer_Option__c();
                                ansOption.Survey_Details__c = serveyDetailMap.get((String)surveyDetailMap.get('Master_Questions__c'));
                                ansOption.Custom_Question__c = '';
                                ansOption.Custom_Value__c = wrpInstace.value;
                                ansOption.Other_Top_Brand__c = '';
                                answerOptionListToInsert.add(ansOption);
                            }
                            
                        }
                    }
                }
                System.debug('1111 ' + answerOptionListToInsert);
                
                if (answerOptionListToInsert.size() > 0) {
                    Insert answerOptionListToInsert;
                }
                /* Logic to insert NPS record and update account record */
                if (selectedTopBrandName != null && selectedTopBrandRating != null &&
                         accountId != null && selectedFeedbackStatus != null) {
                    
                    Account acc = new Account();
                    acc.Id = accountId;
                    acc.Rating_Capture_Date__c = System.now();

                    if (acc != null) {
                        Update acc;
                    }

                    List<NPS__c> npsListToUpdate = new List<NPS__c>();
                    for (NPS__c nps : [SELECT Id, Top_Brand_Name__c, Top_Brand_Rating__c, Rating_Capture_Date__c, Status__c FROM NPS__c 
                            WHERE Account__c =: accountId Order By CreatedDate Desc LIMIT 1]) {
                        NPS__c npsIns = new NPS__c();
                        npsIns.Id = nps.Id;
                        npsIns.Top_Brand_Name__c = selectedTopBrandName;
                        npsIns.Top_Brand_Rating__c = selectedTopBrandRating;
                        npsIns.Rating_Capture_Date__c = System.now();
                        npsIns.Status__c = selectedFeedbackStatus;
                        if(selectedTopBrandRating >= 1 && selectedTopBrandRating <= 6) {
                            npsIns.NPSType__c = Label.Demotors;
                        } else if(selectedTopBrandRating >= 7 && selectedTopBrandRating <= 8) {
                            npsIns.NPSType__c = Label.Passive;
                        } else if(selectedTopBrandRating >= 9 && selectedTopBrandRating <= 10){
                            npsIns.NPSType__c = Label.Promotors;
                        } else {
                            npsIns.NPSType__c = '';
                        }
                        Integer i = 0;
                        for (String str : lookupMap.keySet()) {
                            if (i == 0) {
                                npsIns.First_Brand__c = lookupMap.get(str).remove('\"');
                                npsIns.First_Brand_Rating__c = Decimal.valueOf(str);
                            }
                            if (i == 1) {
                                npsIns.Second_Brand__c = lookupMap.get(str).remove('\"');
                                npsIns.Second_Brand_Rating__c = Decimal.valueOf(str);
                            }
                            if (i == 2) {
                                npsIns.Third_Brand__c = lookupMap.get(str).remove('\"');
                                npsIns.Third_Brand_Rating__c = Decimal.valueOf(str);
                            }
                            i++;
                        }
                        npsListToUpdate.add(npsIns);
                    }
                    System.debug('npsListToUpdate ' + npsListToUpdate);
                    if (npsListToUpdate.size() > 0) {
                        Update npsListToUpdate;
                    }
                    
                }
            }
            
        } catch(Exception ex) {
            System.debug('wrapQuestionList **** ' + ex);
            throw new AuraHandledException(ex.getMessage());
        }
        
    }

    public class QuestionWrapper {
        
        
        @AuraEnabled
        public Id recordId;

        @AuraEnabled
        public Id npsId;

        @AuraEnabled
        public String QuestionName;

        @AuraEnabled
        public Boolean Status;

        @AuraEnabled
        public String Options;

        @AuraEnabled
        public String Type;

        @AuraEnabled
        public object Response;

        @AuraEnabled
        public Decimal questionOrder;

        @AuraEnabled
        public Boolean mandatory;

        public QuestionWrapper() {

        }
        public QuestionWrapper(Id recordId,
                                String QuestionName, 
                                Boolean Status, 
                                String Options, 
                                String Type, 
                                object Response, 
                                Decimal questionOrder,
                                Boolean mandatory,
                                Id npsId) {
            this.recordId = recordId;
            this.QuestionName = QuestionName;
            this.Status = Status;
            this.Options = Options;
            this.Type = Type;
            this.Response = Response;
            this.questionOrder = questionOrder;
            this.mandatory = mandatory;
            this.npsId = npsId;
        }
    }
    public class ResponseWrapper {
        public String Id;
        public String Name;
        public String value;
        public String label;
        public String subQuesRating;
        public String subQuesTopBrandRating;
    }
}