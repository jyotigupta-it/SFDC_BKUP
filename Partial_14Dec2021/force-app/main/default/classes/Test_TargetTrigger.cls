@isTest
public  class Test_TargetTrigger {

    public static List<target__c> targetList = new List<target__c>();
    public static List<target__c> targetList1 = new List<target__c>();
    public static List<AP_Tour_Plan__c> tourplanlist = new List<AP_Tour_Plan__c>();
    public static List<target__c> updatetargetList = new List<target__c>();
    public static List<target__c> updatetargetList1 = new List<target__c>();
    //public static AP_Tour_Plan__c tourplan();
    public static Task task;
    
    public static void initPending() {
        
        User userdata = Test_Intial_Data_Phase2.ColumnRH('First1','Last1','System Administrator');
         // Creating the manager user for assigning to current user(For task creation)
        User userdata1 = Test_Intial_Data_Phase2.ColumnRH('FirstM1','LastM1','System Administrator');
        insert userdata1;
        userdata.ManagerId = userdata1.Id;
        insert userdata ;
        system.runAs(userdata) {
        for(Integer i=0; i<5; i++) {
            target__c obj;
        If(i==0){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId = Schema.SObjectType.target__c.RecordTypeInfosByName.get('Column').RecordTypeId;
        }else If(i==1){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId = Schema.SObjectType.target__c.RecordTypeInfosByName.get('Plumbing').RecordTypeId;
        }else if(i==2){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId =Schema.SObjectType.target__c.RecordTypeInfosByName.get('Projects').RecordTypeId;
        }
            else{
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId =Schema.SObjectType.target__c.RecordTypeInfosByName.get('Industrial').RecordTypeId;
        }
        targetList.add(obj);
        }
        insert targetList;
        for(target__c t : targetList){
            t.Approval_Status__c = 'Pending';
            
            updatetargetList.add(t);
        }
        update updatetargetList;
        }
        //tourplan = Test_Intial_Data_Phase2.CreateTourPlan(Id targetId);

    } 
    public static void initApproved() {

        User userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
         // Creating the manager user for assigning to current user(For task creation)
        User userdata1 = Test_Intial_Data_Phase2.ColumnRH('FirstM','LastM','System Administrator');
        insert userdata1;
        
        userdata.ManagerId = userdata1.Id;
        insert userdata ;

        for(Integer i=0;i<5;i++){
            target__c obj;
       If(i==0){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId = Schema.SObjectType.target__c.RecordTypeInfosByName.get('Column').RecordTypeId;
        }else If(i==1){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId = Schema.SObjectType.target__c.RecordTypeInfosByName.get('Plumbing').RecordTypeId;
        }else{
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId =Schema.SObjectType.target__c.RecordTypeInfosByName.get('Projects').RecordTypeId;
        }
        targetList1.add(obj);
        }
        insert targetList1;

        for(target__c t1 :targetList1 ) {
            t1.Approval_Status__c = 'Approved';
            
            updatetargetList1.add(t1);

        }
        update updatetargetList1;
   }
    
    public static void initRejected() {

        User userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
         // Creating the manager user for assigning to current user(For task creation)
        User userdata1 = Test_Intial_Data_Phase2.ColumnRH('FirstM','LastM','System Administrator');
        insert userdata1;
        
        userdata.ManagerId = userdata1.Id;
        insert userdata ;

        for(Integer i=0;i<5;i++){
            target__c obj;
       If(i==0){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId = Schema.SObjectType.target__c.RecordTypeInfosByName.get('Column').RecordTypeId;
        }else If(i==1){
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId = Schema.SObjectType.target__c.RecordTypeInfosByName.get('Plumbing').RecordTypeId;
        }else{
             obj = Test_Intial_Data_Phase2.CreateTarget(userdata);
            obj.RecordTypeId =Schema.SObjectType.target__c.RecordTypeInfosByName.get('Projects').RecordTypeId;
        }
        targetList1.add(obj);
        }
        insert targetList1;

        for(target__c t1 :targetList1 ) {
            t1.Approval_Status__c = 'Rejected';
            
            updatetargetList1.add(t1);

        }
        update updatetargetList1;
   }
    
    static testMethod void positiveTest() {

        Test.startTest();
        list<target__c> targetList12 = new list<Target__c>();
        initPending();
        for(target__c t : targetList){
            t.Approval_Status__c = 'Approved';
            
            targetList12.add(t);
        }
        update targetList12;
        TargetTriggerHandler.positive();
        Test.stopTest();
    }

    static testMethod void positiveTest1() {
       
       Test.startTest();
        list<target__c> targetList12 = new list<Target__c>();
        initPending();
        for(target__c t : targetList){
            t.Approval_Status__c = 'Rejected';
            
            targetList12.add(t);
        }
        update targetList12;
        Test.stopTest();
    }
    
   static testMethod void positiveTest2() {
       
        Test.startTest();
        initPending();
        initRejected();
        Test.stopTest();
    }  
}