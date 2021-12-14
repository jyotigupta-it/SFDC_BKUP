@isTest
public with sharing class WS_Project_DetailsTest {
    @TestSetup
    static void makeData() {
        String strRecordTypeId = [Select Id From RecordType Where SobjectType = 'Account' and Name = 'Key Accounts'].Id;
        Account acc = new Account();
        acc.Name='testAcc';
        acc.Contact_Number_Mobile__c = '9765433318';
        acc.recordTypeId = strRecordTypeId;
        acc.Firm_Name__c = 'et';
        acc.Products__c='Air Admittance Valve';
        acc.Business_Line__c='column';
        acc.Year_Since_in_Business__c='2015';
        insert acc;
        
        // Inserting a new Project    
        Opportunity opp = new Opportunity();
        
        opp.Project_Number__c= 'PJ-00362799';
        opp.Name='TestClass';
        opp.StageName = 'Designing';
        opp.CloseDate = date.TODAY()+10;
        opp.Project_Type__c='Commercial';
        opp.Mixed_Type__c='Malls';
        opp.No_of_Bathrooms__c = 12;
        opp.No_of_Floors__c=5;
        opp.Number_of_kitchens__c=6;
        opp.Number_of_towers__c=1;
        opp.Material_of_Stack__c='SWR';
        opp.Internal_Plumbing_Mix__c='CPVC';
        opp.Dimension_of_the_stack__c='110';
        opp.Project_Area__c=2563;
        opp.Standard_ORC__c=4;
        opp.Project_By__c = acc.Id;
        opp.Distributor__c = acc.Id;
        opp.SWR_system_to_be_deployed__c='Conventional';
        //opp.GSTN__c = '29AADCB2230M1ZP';
        opp.BlazeMaster__c = 'No';
        insert opp;
        
        Unique_SPR__c uqSPR = new Unique_SPR__c(); 
        uqSPR.Unique_Name__c ='PJ-00362799_SPR_1_2021-02-21';
        opp.Project_Number__c= 'PJ-00362799';
        opp.Standard_ORC__c=4;
        uqSPR.Project__c = opp.Id;
        insert uqSPR;
    }
    @isTest
    public static void getProjDetails() {
        
        // Forming the request
        /*RestRequest req = new RestRequest(); 
          RestResponse res = new RestResponse(); 
          req.requestUri = '/services/apexrest/getProjectDetails';
          req.httpMethod = 'GET';
          RestContext.request = req;
          RestContext.response = res;*/
          Test.startTest();
          WS_Project_Details.getProjDetails();
          Test.stopTest();
    }
}