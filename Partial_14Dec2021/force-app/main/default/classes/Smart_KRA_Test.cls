@isTest(seealldata=true)
public with sharing class Smart_KRA_Test{
    
    public static User userdata1;
     public static User userdata2;
    public static Target__c target;
    
    public static void init() {
        Profile p = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator']; 
        userData1 = new User(Alias = 'standt1', EmployeeNumber = '12345', 
                                  Email= 'FName'+'LName'+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName',
                                  LastName = 'LName', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName='LName'+'FName'+'@ashirvadpipes.com'                                 
                                 );
        insert userdata1 ;
       
        target = new Target__c(
            Is_Active__c = true,
            Architects_Meet__c = 2,
            Boarers_Meet__c = 3,
            Builders_Meet__c = 4,
            Column_Dealer_Meet__c = 5,
            Target_User__c = userData1.Id,
            OwnerId = userData1.Id,
            Approval_Status__c = 'Not Submitted',
            Vertical__c        = 'Plumbing'
        );
        target.Vertical__c = 'Plumbing';
        target.Start_Date__c = Date.Today().toStartOfMonth();
        Integer month = Date.Today().month();
        Integer year   = Date.Today().year();
        target.End_Date__c   = target.Start_Date__c.addDays(Date.daysInMonth(year, month)-1);
        insert target;
    Profile p1 = [SELECT Id, Name FROM Profile WHERE Name = 'BD']; 
    userData2 = new User(Alias = 'standt1', EmployeeNumber = '23456', 
                                  Email= 'FName1'+'LName1'+'@ashirvad.com', 
                                  EmailEncodingKey='UTF-8', 
                                  FirstName = 'FName1',
                                  LastName = 'LName1', 
                                  LanguageLocaleKey='en_US', 
                                  LocaleSidKey='en_US', 
                                  ProfileId = p1.Id, 
                                  TimeZoneSidKey='Asia/Kolkata', 
                                  UserName='LName1'+'FName1'+'@ashirvadpipes.com'                                 
                                 );
    insert userData2;
    List<target__c> targetRecord=[select id ,Retailing_days_Target_field_work__c,Retailing_days_field_work_ACHVD__c,Retailing_days_field_work__c,Retailing_days_field_work_Weightage__c,Retailing_days_Score_field_work__c,No_of_visits_Target_total_visits__c,No_of_visits_total_visits__c,No_of_visits_total_visits_ACHVD__c,No_of_visits_Weightage_total_visits__c,No_of_visits_Score_field_work__c,Contacts_visit_Target_Plumbers__c,
                                            Contacts_visit_Plumbers_etc__c,Contacts_visit_Plumbers_ACHVD__c,Contacts_visit_Weightage_Plumbers__c,Contacts_visit_Score_Plumbers__c,Key_influencers_Target_Arch_consultant__c,
                                            Key_influencers_contact_Arch_consultant__c ,Key_influencers_Arch_consultant_ACHVD__c,Key_influencers_Weighta_Arch_consultant__c,Key_influencers_Score_Arch_consultant__c,
                                             Mega_Meets_Plumbing__c,Mega_Meets_Plumbing_Actual__c,Mega_Meets_ACHVD__c,Mega_Meets_Weightage__c,Mega_Meets_Score__c,
                                             ISP_Meets_Plumbing__c,Inshop_Plumber_Meets_Actual__c,Inshop_Plumber_Meet_ACHVD__c,Inshop_Plumber_Meet_Weightage__c,Inshop_Plumber_Meet_Score__c,PRIMARY_SALES_CPVC__c,Primary_Sales_CPVC_Actuals__c,Primary_Sales_CPVC_ACHVD__c,
                                              Primary_Sales_CPVC_Weightage__c,Primary_Sales_CPVC_Score__c,PRIMARY_SALES_UPVC__c,Primary_Sales_Aqua_Actuals__c,Primary_Sales_Aqua_ACHVD__c,Primary_Sales_Aqua_Weightage__c,Primary_Sales_Aqua_Score__c,
                                              PRIMARY_SALES_SWR__c,Primary_Sales_SWR_Actuals__c,Primary_Sales_SWR_ACHVD__c,Primary_Sales_SWR_Weightage__c,Primary_Sales_SWR_Score__c,   Secondary_Sales_Target__c,Secondary_Sales_Actual_In_Lacs__c,Secondary_Sales_ACHVD__c,
                                              Secondary_Sales_Weightage__c,Secondary_Sales_Score__c,Plumbing_DSM_Meet_Training_ACHVD__c,Plumbing_DSM_Meet_Training_Weightage__c  from Target__c limit 2 ];//new target__c();
      
        List<Target__c> tgtListnew=new List<Target__c>();
        for(target__c tgt: targetRecord){
            tgt.Contacts_visit_Target_Plumbers__c=10;
            tgt.OwnerId=userInfo.getUserId();
            tgt.End_Date__c   = Date.today();
            tgt.Start_Date__c   = Date.today();
            tgtListnew.add(tgt);        
        }
        update tgtListnew;
        system.debug('+++++++++++++++%$(^%*&%&(^%&' +targetRecord.size());
    }
    public static testmethod void testone() {
        
        init();
        
        test.startTest();
        KRAv1 kraModified=new KRAv1();
        kraModified.target = target;
        kraModified.selectedMonth = string.valueOf(Date.today().month());
        kraModified.selectedYear  = string.valueOf(Date.today().year());        
        List<target__c> TLIST=new List<target__c>();
        kraModified.selectSubordinates=true;
        target.Vertical__c = 'Plumbing';
        update target;
        kraModified.callKRA();
        target.Vertical__c = 'Column';
        TLIST.add(target);
        update target;
        kraModified.callKRA();
        target.Vertical__c = 'Projects';
         target.Plumbing_DSM_Meet_Training_Weightage__c=0;
        kraModified.projectflag=true;
        TLIST.add(target);
        update target;
        kraModified.callKRA();
        TLIST.add(target);
        test.stopTest();
    }
}