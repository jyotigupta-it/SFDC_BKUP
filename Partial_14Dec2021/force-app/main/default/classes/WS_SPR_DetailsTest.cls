@isTest
public with sharing class WS_SPR_DetailsTest {
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
        acc.Party_Type__c = 'Project Owner/Developer';
        insert acc;
        
        Opportunity opp = new Opportunity();
        List<String> prodNameList = new List<String>();
        Product2 prodobj = new Product2();
        Unique_SPR__c uqSPR = new Unique_SPR__c();
        New_Special_Pricing_Request__c newSPRObj = new New_Special_Pricing_Request__c();
        
        // Inserting a new Project 
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
        opp.Project_Number__c= 'PJ-00362799';
        opp.Standard_ORC__c=4;
        opp.BlazeMaster__c = 'No';
        opp.Project_Location__c = 'dgwu';
        opp.Street_Address__c = 'yfhfyjtdj';
        insert opp;
        
        System.debug(opp.Id);
        uqSPR.Unique_Name__c ='PJ-00362799_SPR_1_2021-02-21';
        uqSPR.Project__c =opp.Id;
        uqSPR.Approval_Status__c = 'Approved';
        uqSPR.Approval_date__c = date.today();
        insert uqSPR;
        
        prodobj.Name = 'Water Tanks';
        prodobj.ProductCode ='000';
        prodobj.Family ='Water Tanks';
        prodobj.Product_Group_Code__c ='SWR GRP CODE';
        prodobj.Product_Category_Code_Discount_Group__c ='000';
        prodobj.Product_Category_Description_Discount__c='AQUA-PIPE';
        insert prodobj;
        
        newSPRObj.APPL__c = 5;
        newSPRObj.Extra_Discount__c = 5;
        newSPRObj.ORC_MARGIN_TO_DLR_DIST__c = 6;
        newSPRObj.Validity_for_the_Price__c = date.TODAY()+15;
        newSPRObj.Unique_SPR__c = uqSPR.Id;
        newSPRObj.Product_name__c = prodobj.Name;
        insert newSPRObj;
        prodNameList.add(newSPRObj.Product_name__c);
    }
    @isTest
    public static void getSprDetails() {
        Test.startTest();
        WS_SPR_Details.getSprDetails();
        WS_SPR_Prod_Details.getSprDetails();
        Test.stopTest();
    }
}