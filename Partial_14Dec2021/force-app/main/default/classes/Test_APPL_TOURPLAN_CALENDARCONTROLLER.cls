@isTest
private class Test_APPL_TOURPLAN_CALENDARCONTROLLER {   
    //Varibles
    public static Target__c target;
    public static AP_Tour_Plan__c tourplan;
    public static User userdata;
    public static User userManeger;
    public static Task t;
    // initializing test data
    private static void init() {   
        userManeger = Test_Intial_Data_Phase2.PlumbingRH('Maneger','LastName','System Administrator');
        insert userManeger ;
        
        userdata = Test_Intial_Data_Phase2.PlumbingRH('First','Last','System Administrator');
        userdata.ManagerId = userManeger.Id;
        userdata.Allocated_State__c = 'Goa;Pune';
        insert userdata ;
                
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        target.Start_Date__c = Date.today();
                
        tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Approval_Status__c = 'Pending';
        tourplan.Visit_Type__c = 'Ex-Station';
        tourplan.Date__c = Date.today();
                
      
    }
    
    private static testMethod void tourPlanUnitTest() {
        init(); 
         List<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
        
    
        
        //Start Test
        Test.startTest();
        
        System.runAs(userdata) {
            //Insert Target
            insert target;
            tourplan.Target__c = target.ID;
            //Insert TourPlan
            insert tourplan;
            
            pagereference pr=new pagereference('/apex/APPL_TOURPLAN_CALENDAR?scontrolCaching=1&id='+target.id);
            Test.setCurrentPageReference(pr);
            Apexpages.StandardController sc = new Apexpages.standardController(target);
            APPL_TOURPLAN_CALENDARCONTROLLER controllerInstance = new APPL_TOURPLAN_CALENDARCONTROLLER(sc);
            
            APPL_TOURPLAN_CALENDARCONTROLLER.retreiveTourRelatedTarget(target.id);
            APPL_TOURPLAN_CALENDARCONTROLLER.saveTargetonApproval(target.id,'Approved','Approved');
            APPL_TOURPLAN_CALENDARCONTROLLER.retreiveStateValues(target.id);
            controllerInstance.distTest();
            APPL_TOURPLAN_CALENDARCONTROLLER.marketvalue('Test');
            //AP_TOURPLAN_CALENDARCONTROLLER.retreiveNumberOfTourPlan(target.id);
            //Insert TourPlan
            APPL_TOURPLAN_CALENDARCONTROLLER.saveTourPlan(tourplan.Id, target.id, '05/05/2015','Mega Plumber Meets', 'ex-station', 'Karnataka', 'SOUTH CANARA', false, false,false,'','','','');
         APPL_TOURPLAN_CALENDARCONTROLLER.saveTourPlan('123456',target.id, '05/05/2015','Mega Plumber Meets', '[Ex-Station]', 'Karnataka', 'SOUTH CANARA', false, false,false,'','','','');
            APPL_TOURPLAN_CALENDARCONTROLLER.saveTourPlan('',target.id, '05/06/2015','Mega Plumber Meets', '[Ex-Station]', 'Karnataka', 'SOUTH CANARA', true, false, false, '','','','');
            APPL_TOURPLAN_CALENDARCONTROLLER.saveTargetonRejection(target.Id, 'Rejected', 'Rejected');
           APPL_TOURPLAN_CALENDARCONTROLLER.saveTourPlan('',target.id, '05/07/2015','[Builders Meet]', '[Ex-Station]', 'Karnataka', 'SOUTH CANARA', false, true,false,'','','','');
           // APPL_TOURPLAN_CALENDARCONTROLLER.saveTourPlan('',target.id, '05/08/2015','Builders Meet', 'ex-station', 'Karnataka', 'SOUTH CANARA', 'btm', false, false, true, 'test comments','','');
            
        }
        Test.stoptest();
        
    }
    
    private static testMethod void tourPlanUnitTest2() {
        init();
        //Start Test
        Test.startTest();
        target__c target1 = new Target__c();
        Apexpages.StandardController sc = new Apexpages.standardController(target1);
        APPL_TOURPLAN_CALENDARCONTROLLER controllerInstance = new APPL_TOURPLAN_CALENDARCONTROLLER(sc);
        Test.stopTest();
    }
}