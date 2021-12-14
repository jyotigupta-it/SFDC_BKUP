/*  
    Author: Satyanarayana
    Description : SMART KRA Controller : Generate SMART KRA Report for particular Month based on the User Test class.
    Date : 06/07/2015    */
@istest
public class Test_AP_Site_Visit_Trigger {
	
	public static Target__c target;
	public static Target__c target1;
    public static AP_Tour_Plan__c tourplan;
    public static User userdata;
    public static AP_Site_Visit__c sitevisit;
    public static AP_Site_Visit__c sitevisit1;
    public static AP_Site_Visit__c sitevisit2;
    public static AP_Site_Visit__c sitevisit3;
    public static void init() {
    	
	        Account objAcct = Test_Utilclass.ObjAcct();
	        objAcct.Contact_Number_Mobile__c = '9603612607';
	        objAcct.recordtypeid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Individual Contacts').getRecordTypeId();
	        insert  objAcct;
	        
	        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
	        insert userdata ;
	        
	        target1 = Test_Intial_Data_Phase2.CreateTarget(userdata);
	        insert target1;
	        
	        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
	        insert target;
	        tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
	        tourplan.Target__c = target.ID;
	        insert tourplan;
	        
	        sitevisit = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
	        sitevisit.Target__c = target.ID;
	        sitevisit.AP_Tour_Plan__c = tourplan.Id;
	        sitevisit.Date__c = date.today();
	        sitevisit.Party_Name__c = objAcct.id;
	        insert sitevisit;
	        
	        sitevisit1 = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
	        sitevisit1.Target__c = target.ID;
	        sitevisit1.AP_Tour_Plan__c = tourplan.Id;
	        //sitevisit1.Party_Name__c = objAcct.id;
	        sitevisit1.Date__c = date.today();
	        insert sitevisit1;
        
            sitevisit3 = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
	        sitevisit3.Target__c = target.ID;
	        sitevisit3.AP_Tour_Plan__c = tourplan.Id;
	        //sitevisit1.Party_Name__c = objAcct.id;
	        sitevisit3.Date__c = date.today()+1;
	        insert sitevisit3;
	        
	        sitevisit2 = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
	        sitevisit2.Target__c = target.ID;
	        sitevisit2.AP_Tour_Plan__c = tourplan.Id;
	        sitevisit2.Date__c = date.today();
	        //sitevisit2.Party_Name__c = objAcct.id;
	        sitevisit2.Retailing_Day__c = true;
	        insert sitevisit2;
	  
    }
     public static testmethod void testone() {
        
         init();
        test.startTest();
      		AP_Site_Visit__c sitevisit12 = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
	        sitevisit12.Target__c = target.ID;
	        sitevisit12.AP_Tour_Plan__c = tourplan.Id;
	        sitevisit12.Date__c = date.today();
	        //sitevisit12.Party_Name__c = objAcct.id;
	        insert sitevisit12;
        test.stopTest();
    }
    
   
    
    
}