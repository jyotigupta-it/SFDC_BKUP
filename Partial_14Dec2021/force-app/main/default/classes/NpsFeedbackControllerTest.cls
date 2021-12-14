@isTest
public class NpsFeedbackControllerTest {
    @isTest static void npsFeedbackTestMethod() {
        try {
            List<ChildObjectWrapper> childObjectWrapperList = new List<ChildObjectWrapper>();
            List<FirstQuestion> firstQuesList = new List<FirstQuestion>();
            List<LookupValueWithLabelWrp> lookupValueWithLabelWrpList = new List<LookupValueWithLabelWrp>();
            
            Account acc1=new Account();
            acc1.Name='tstacc';
            acc1.Contact_Email__c='tst@loa.com';
            acc1.Primary_Contact_Person_Name__c  ='Salesforce';
            acc1.PIN_Code__c='560045';
            acc1.Street_Address__c='Trinity Road';
            acc1.Party_Type__c='Plumber';
            acc1.Contact_Number_Mobile__c = '9859000000';
            acc1.State__c = 'Rajasthan';
            acc1.District__c = 'Jaipur';
            acc1.City__c = 'Jaipur';
            acc1.Status__c = 'Prospective';
            acc1.Street_Address__c = 'HSR';
            acc1.Ramco_ID__c = '54';
            acc1.Year_Since_in_Business__c='2019';
            acc1.If_Yes_Products__c='test';
            acc1.If_others__c='test';
            acc1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
            acc1.VAT_CST_Number__c='101010000000000';
            acc1.Conversion_Probability__c='High';
            acc1.PIN_Code__c='562106';
            acc1.UPVC_Discount__c=0;
            acc1.Column_Discount_Amount__c=0;
            acc1.Discount__c=0;
            acc1.SWR_Discount__c=0;
            acc1.System_Flag__c = true;
            acc1.Premium_plumber__c = 'No';
            Insert acc1;
            
            Master_Questions__c masterQues = new Master_Questions__c();
            masterQues.Mandatory__c = true;
            masterQues.Name = 'What is your Name?';
            masterQues.Options__c = '001';
            masterQues.Question_Name__c = 'First Question';
            masterQues.Question_Order__c = 1;
            masterQues.Status__c = true;
            masterQues.Type__c = 'Text'; 
            Insert masterQues;
            
            NPS__c nps = new NPS__c();
            nps.Top_Brand_Name__c = 'Ashirvad';
            nps.Top_Brand_Rating__c = 8;
            nps.Rating_Capture_Date__c = System.now();
            nps.Status__c = 'Open';
            nps.Account__c = acc1.Id;
            Test.startTest();
            Insert nps;
            Test.stopTest();
            
            System.debug('nps +++ ' + nps);
            
            NpsFeedbackController.fetchQuestions(acc1.Id);
            
            List<Survey_Details__c> surveyDetailList = new List<Survey_Details__c>();
            Survey_Details__c surveyDetail = new Survey_Details__c();
            surveyDetail.Account__c = acc1.Id;
            surveyDetail.Master_Questions__c = masterQues.Id;
            surveyDetail.Response__c = 'Ashirvad';
            surveyDetailList.add(surveyDetail);
            //    Insert surveyDetailList;
            
            FirstQuestion fq = new FirstQuestion();
            fq.Id = '001g0000026Y5yiAAC';
            fq.Name = 'Ranvir Electronics';
            firstQuesList.add(fq);
            //    String firstQuesListJSON = JSON.serialize(firstQuesList);
            
            LookupValueWithLabelWrp lookUpValue = new LookupValueWithLabelWrp();
            lookUpValue.label = 'IBM';
            lookUpValue.value = 6;
            lookupValueWithLabelWrpList.add(lookUpValue);
            
            childObjectWrapperList.add(new ChildObjectWrapper(masterQues.Id, '001', 'Custom', firstQuesList));
            System.debug('childObjectWrapperList ' + childObjectWrapperList);
            
            NpsFeedbackController.saveSurveyDetailsMethod(surveyDetailList, JSON.serialize(childObjectWrapperList).replaceAll('_temp','__c'), 'Ashirvad', 
                                                          5, acc1.Id, 
                                                          'Open', JSON.serialize(lookupValueWithLabelWrpList));
        } catch(Exception ex) {
            System.debug('Exception in npsFeedbackTestMethod test ' + ex);
        }
        
        
    }
    
    @isTest static void npsFeedbackTestMethod2() {
        try {
            List<ChildObjectWrapper> childObjectWrapperList = new List<ChildObjectWrapper>();
            List<FirstQuestion> firstQuesList = new List<FirstQuestion>();
            List<LookupValueWithLabelWrp> lookupValueWithLabelWrpList = new List<LookupValueWithLabelWrp>();
            
            Account acc1=new Account();
            acc1.Name='tstacc';
            acc1.Contact_Email__c='tst@loa.com';
            acc1.Primary_Contact_Person_Name__c  ='Salesforce';
            acc1.PIN_Code__c='560045';
            acc1.Street_Address__c='Trinity Road';
            acc1.Party_Type__c='Plumber';
            acc1.Contact_Number_Mobile__c = '9859000000';
            acc1.State__c = 'Rajasthan';
            acc1.District__c = 'Jaipur';
            acc1.City__c = 'Jaipur';
            acc1.Status__c = 'Prospective';
            acc1.Street_Address__c = 'HSR';
            acc1.Ramco_ID__c = '54';
            acc1.Year_Since_in_Business__c='2019';
            acc1.If_Yes_Products__c='test';
            acc1.If_others__c='test';
            acc1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
            acc1.VAT_CST_Number__c='101010000000000';
            acc1.Conversion_Probability__c='High';
            acc1.PIN_Code__c='562106';
            acc1.UPVC_Discount__c=0;
            acc1.Column_Discount_Amount__c=0;
            acc1.Discount__c=0;
            acc1.SWR_Discount__c=0;
            acc1.System_Flag__c = true;
            acc1.Premium_plumber__c = 'No';
            Insert acc1;
            
            Master_Questions__c masterQues = new Master_Questions__c();
            masterQues.Mandatory__c = true;
            masterQues.Name = 'What is your Name?';
            masterQues.Options__c = '001';
            masterQues.Question_Name__c = 'First Question';
            masterQues.Question_Order__c = 1;
            masterQues.Status__c = true;
            masterQues.Type__c = 'Text'; 
            Insert masterQues;
            
            List<Survey_Details__c> surveyDetailList = new List<Survey_Details__c>();
            Survey_Details__c surveyDetail = new Survey_Details__c();
            surveyDetail.Account__c = acc1.Id;
            surveyDetail.Master_Questions__c = masterQues.Id;
            surveyDetail.Response__c = 'Ashirvad';
            surveyDetailList.add(surveyDetail);
            
            FirstQuestion fq = new FirstQuestion();
            fq.Id = '001g0000026Y5yiAAC';
            fq.Name = 'Ranvir Electronics';
            firstQuesList.add(fq);
            
            LookupValueWithLabelWrp lookUpValue = new LookupValueWithLabelWrp();
            lookUpValue.label = 'IBM';
            lookUpValue.value = 6;
            lookupValueWithLabelWrpList.add(lookUpValue);
            
            childObjectWrapperList.add(new ChildObjectWrapper(masterQues.Id, '002', 'Custom', firstQuesList));
            System.debug('childObjectWrapperList ' + childObjectWrapperList);
            
            NpsFeedbackController.saveSurveyDetailsMethod(surveyDetailList, JSON.serialize(childObjectWrapperList).replaceAll('_temp','__c'), 'Ashirvad', 
                                                          5, acc1.Id, 
                                                          'Open', JSON.serialize(lookupValueWithLabelWrpList));
        } catch(Exception ex) {
            System.debug('Exception in npsFeedbackTestMethod2 test ' + ex);
        }
        
    }
    @isTest static void npsFeedbackTestMethod3() {
        try {
            List<ChildObjectWrapper> childObjectWrapperList = new List<ChildObjectWrapper>();
            List<FirstQuestion> firstQuesList = new List<FirstQuestion>();
            List<LookupValueWithLabelWrp> lookupValueWithLabelWrpList = new List<LookupValueWithLabelWrp>();
            
            Account acc1=new Account();
            acc1.Name='tstacc';
            acc1.Contact_Email__c='tst@loa.com';
            acc1.Primary_Contact_Person_Name__c  ='Salesforce';
            acc1.PIN_Code__c='560045';
            acc1.Street_Address__c='Trinity Road';
            acc1.Party_Type__c='Plumber';
            acc1.Contact_Number_Mobile__c = '9859000000';
            acc1.State__c = 'Rajasthan';
            acc1.District__c = 'Jaipur';
            acc1.City__c = 'Jaipur';
            acc1.Status__c = 'Prospective';
            acc1.Street_Address__c = 'HSR';
            acc1.Ramco_ID__c = '54';
            acc1.Year_Since_in_Business__c='2019';
            acc1.If_Yes_Products__c='test';
            acc1.If_others__c='test';
            acc1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
            acc1.VAT_CST_Number__c='101010000000000';
            acc1.Conversion_Probability__c='High';
            acc1.PIN_Code__c='562106';
            acc1.UPVC_Discount__c=0;
            acc1.Column_Discount_Amount__c=0;
            acc1.Discount__c=0;
            acc1.SWR_Discount__c=0;
            acc1.System_Flag__c = true;
            acc1.Premium_plumber__c = 'No';
            Insert acc1;
            
            Master_Questions__c masterQues = new Master_Questions__c();
            masterQues.Mandatory__c = true;
            masterQues.Name = 'What is your Name?';
            masterQues.Options__c = '001';
            masterQues.Question_Name__c = 'First Question';
            masterQues.Question_Order__c = 1;
            masterQues.Status__c = true;
            masterQues.Type__c = 'Text'; 
            Insert masterQues;
            
            List<Survey_Details__c> surveyDetailList = new List<Survey_Details__c>();
            Survey_Details__c surveyDetail = new Survey_Details__c();
            surveyDetail.Account__c = acc1.Id;
            surveyDetail.Master_Questions__c = masterQues.Id;
            surveyDetail.Response__c = 'Ashirvad';
            surveyDetailList.add(surveyDetail);
            
            FirstQuestion fq = new FirstQuestion();
            fq.Id = '001g0000026Y5yiAAC';
            fq.Name = 'Ranvir Electronics';
            firstQuesList.add(fq);
            
            LookupValueWithLabelWrp lookUpValue = new LookupValueWithLabelWrp();
            lookUpValue.label = 'IBM';
            lookUpValue.value = 6;
            lookupValueWithLabelWrpList.add(lookUpValue);
            
            childObjectWrapperList.add(new ChildObjectWrapper(masterQues.Id, '003', 'Custom', firstQuesList));
            System.debug('childObjectWrapperList ' + childObjectWrapperList);
            
            NpsFeedbackController.saveSurveyDetailsMethod(surveyDetailList, JSON.serialize(childObjectWrapperList).replaceAll('_temp','__c'), 'Ashirvad', 
                                                          5, acc1.Id, 
                                                          'Open', JSON.serialize(lookupValueWithLabelWrpList));
        } catch(Exception ex) {
            System.debug('Exception in npsFeedbackTestMethod3 test ' + ex);
        }
        
    }
    @isTest static void npsFeedbackTestMethod4() {
        try {
            List<ChildObjectWrapper> childObjectWrapperList = new List<ChildObjectWrapper>();
            List<FirstQuestion> firstQuesList = new List<FirstQuestion>();
            List<LookupValueWithLabelWrp> lookupValueWithLabelWrpList = new List<LookupValueWithLabelWrp>();
            
            Account acc1=new Account();
            acc1.Name='tstacc';
            acc1.Contact_Email__c='tst@loa.com';
            acc1.Primary_Contact_Person_Name__c  ='Salesforce';
            acc1.PIN_Code__c='560045';
            acc1.Street_Address__c='Trinity Road';
            acc1.Party_Type__c='Plumber';
            acc1.Contact_Number_Mobile__c = '9859000000';
            acc1.State__c = 'Rajasthan';
            acc1.District__c = 'Jaipur';
            acc1.City__c = 'Jaipur';
            acc1.Status__c = 'Prospective';
            acc1.Street_Address__c = 'HSR';
            acc1.Ramco_ID__c = '54';
            acc1.Year_Since_in_Business__c='2019';
            acc1.If_Yes_Products__c='test';
            acc1.If_others__c='test';
            acc1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
            acc1.VAT_CST_Number__c='101010000000000';
            acc1.Conversion_Probability__c='High';
            acc1.PIN_Code__c='562106';
            acc1.UPVC_Discount__c=0;
            acc1.Column_Discount_Amount__c=0;
            acc1.Discount__c=0;
            acc1.SWR_Discount__c=0;
            acc1.System_Flag__c = true;
            acc1.Premium_plumber__c = 'No';
            Insert acc1;
            
            Master_Questions__c masterQues = new Master_Questions__c();
            masterQues.Mandatory__c = true;
            masterQues.Name = 'What is your Name?';
            masterQues.Options__c = '001';
            masterQues.Question_Name__c = 'First Question';
            masterQues.Question_Order__c = 1;
            masterQues.Status__c = true;
            masterQues.Type__c = 'Text'; 
            Insert masterQues;
            
            List<Survey_Details__c> surveyDetailList = new List<Survey_Details__c>();
            Survey_Details__c surveyDetail = new Survey_Details__c();
            surveyDetail.Account__c = acc1.Id;
            surveyDetail.Master_Questions__c = masterQues.Id;
            surveyDetail.Response__c = 'Ashirvad';
            surveyDetailList.add(surveyDetail);
            
            FirstQuestion fq = new FirstQuestion();
            fq.Id = '001g0000026Y5yiAAC';
            fq.Name = 'Ranvir Electronics';
            firstQuesList.add(fq);
            
            LookupValueWithLabelWrp lookUpValue = new LookupValueWithLabelWrp();
            lookUpValue.label = 'IBM';
            lookUpValue.value = 6;
            lookupValueWithLabelWrpList.add(lookUpValue);
            
            childObjectWrapperList.add(new ChildObjectWrapper(masterQues.Id, '004', 'Custom', firstQuesList));
            System.debug('childObjectWrapperList ' + childObjectWrapperList);
            
            NpsFeedbackController.saveSurveyDetailsMethod(surveyDetailList, JSON.serialize(childObjectWrapperList).replaceAll('_temp','__c'), 'Ashirvad', 
                                                          5, acc1.Id, 
                                                          'Open', JSON.serialize(lookupValueWithLabelWrpList)); 
        } catch(Exception ex) {
            System.debug('Exception in npsFeedbackTestMethod4 test ' + ex);
        }
        
    }
    public class ChildObjectWrapper {
        public String Master_Questions_temp;
        // public FirstQuestion Response_temp;
        public String Options;
        public String Type;
        public List<FirstQuestion> Response_temp = new List<FirstQuestion>();
        public ChildObjectWrapper(String masQues, String option, String QuesType, List<FirstQuestion> wrpList) {
            this.Master_Questions_temp = masQues;
            this.Options = option;
            this.Type = QuesType;
            this.Response_temp = wrpList;
        }
        public ChildObjectWrapper() {
            
        }
    }
    
    public class FirstQuestion {
        public String Id;
        public String Name;
    }
    
    public class LookupValueWithLabelWrp {
        public Decimal value;
        public String label;
    }
}