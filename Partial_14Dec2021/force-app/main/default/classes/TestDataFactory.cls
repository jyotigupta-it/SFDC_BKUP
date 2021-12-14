@IsTest
public class TestDataFactory {
    
    //Create Account Method
    public static Account createDealerAccount(Id parentId, Id recordTypeId){
        
        Account objAccount = new Account(
            Name = 'Test Account',
            BillingStreet = '130 Fenchurch Street',
            BillingState = 'Karnataka',
            BillingCity = 'Banglore',
            BillingCountry = 'IN',
            BillingPostalCode = '560011',
            //ParentId = parentId,
            recordTypeId = recordTypeId,
            Geolocation__Latitude__s = 12.95493,
            Geolocation__Longitude__s = 77.74161,
            Name_of_software__c = 'hbkj',
            Total_working_capital_investment__c = 133,
            Borrowed_capital__c = 133,
            Total_Annual_Turnover__c = 150,
            Primary_Contact_Person_Name__c = 'Test Name',
            Party_Type__c = 'Dealer',
            Contact_Number_Mobile__c = '1234567890',
            State__c = 'Karnataka',
            District__c = 'Banglore',
            Expected_AA_contribution_in_total_busi__c = 10,
            City__c = 'Banglore',
            Status__c = 'Prospective',
            Street_Address__c = 'HSR',
            Ramco_ID__c = '54',
            Distribution_as_a_part_of_total_business__c = 15,
            Size_of_Dedicated_godown_for_Ashirvad__c = 15,
            Avg_Credit_days_offered_in_market__c = 10,
            Year_Since_in_Business__c = '2019',
            If_Yes_Products__c = 'test',
            If_others__c = 'test',
            Reason_for_not_buying_Ashirvad__c = 'Poor DP relationship',
            VAT_CST_Number__c = '101010000000000',
            Conversion_Probability__c = 'High',
            PIN_Code__c = '560011',
            UPVC_Discount__c = 0,
            Column_Discount_Amount__c = 0,
            Discount__c = 0,
            SWR_Discount__c = 0,
            Accountant__c = 'Yes',
            Accounting_software_installed__c = 'Yes',
            Dedicated_office_space__c = 'Yes',
            Products__c = 'test',
            Business_Line__c = 'test'
        );
        return objAccount;
    }
    
    //Create Parent Account Method
    public static Account createParentAccount(){
        
        Account objParentAccount = new Account();
        objParentAccount.Name= 'Test Parent Account';
        objParentAccount.Type= 'Dealer / Distributor';
        objParentAccount.Contact_Number_Mobile__c = '1234567890';
        objParentAccount.Year_Since_in_Business__c = '2020';
        objParentAccount.Products__c = 'test';
        objParentAccount.Business_Line__c = 'test';
        return objParentAccount;
        
    }
    
    //Create Target__c Method
    public static Target__c createTarget(){
        Target__c objTarget = new Target__c();
        return objTarget;
    }
    
    //Create Promotion__c Method
    public static Promotion__c createPromotion(){
        Promotion__c objPromotion = new Promotion__c(Type__c = 'Architects Meet');
        return objPromotion;
    }
    
    //Create Promotion__c Method
    public static AP_Tour_Plan__c createAPTourPlan(Id objAccountId, Id objTargetId){
        AP_Tour_Plan__c objAPTourPlan = new AP_Tour_Plan__c(Account__c = objAccountId, Target__c = objTargetId);
        return objAPTourPlan;
    }
    
    //Create Promotion__c Method
    public static AP_Site_Visit__c createAPSiteVisit(Id objAPTourPlanId, Id objTargetId){
        AP_Site_Visit__c objAPSiteVisit = new AP_Site_Visit__c(
            RecordTypeId = '01230000001DPwDAAW',
            AP_Tour_Plan__c = objAPTourPlanId,
            Action_Date__c = Date.today(), 
            Date__c = Date.today(), 
            Generate_Order__c = false, 
            Party_Type__c = 'Architect', 
            RecordEdit__c = false, 
            Task_Tab__c = false, 
            Target__c = objTargetId, 
            Verified__c = false, 
            Retailing_Day__c = false, 
            Geo_Location__Latitude__s = 0,
            Geo_Location__Longitude__s = 0, 
            Adopted_Plumber__c = false, 
            Adopted_Dealer__c = false
        );
        return objAPSiteVisit;
    }

}