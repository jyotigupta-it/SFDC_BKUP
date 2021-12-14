@istest
public class Test_APPL_Target_Creation {
    public static Target__c target;
    
    
    public static void init() {
        
        target = new Target__c();
        target.state__c='Karnataka';
        target.vertical__c = 'Column';
        insert target;
        
        //creating user with Column vetical and Regional Head Role
        
        User userdata1 = new User();
        list<User> userlist = new list<User>();
        userdata1 = Test_Intial_Data_Phase2.ColumnRH('test11', 'user1', 'BD');
        userdata1.Allocated_State__c= target.state__c;
        userdata1.Vertical_Type__c= 'Column';
        userdata1.Role__c = 'RH';
        userlist.add(userdata1);
        
        
        // creating user with column vertical and RSM role
        
        User userdata2 = new User();
        userdata2 = Test_Intial_Data_Phase2.ColumnRSM('test22', 'user2', 'System Administrator');
        userdata2.Allocated_State__c= target.state__c;
        userdata2.Vertical_Type__c= 'Column';
        userdata2.Role__c = 'RSM';
        userlist.add(userdata2);
        
        
        // creating user with column vertical and ASM role
        
        User userdata3 = new User();
        userdata3 = Test_Intial_Data_Phase2.ColumnASM('test33', 'user3', 'System Administrator');
        userdata3.Allocated_State__c= target.state__c;
        userdata3.Vertical_Type__c= 'Column';
        userdata3.Role__c = 'ASM';
        userlist.add(userdata3);
        
        
        // creating user with Plumbing vertical and Regional Head role
        
        User userdata4 = new User();
        userdata4 = Test_Intial_Data_Phase2.PlumbingRH('test44', 'user4', 'System Administrator');
        userdata4.Allocated_State__c= target.state__c;
        userdata4.Vertical_Type__c= 'Plumbing';
        userdata4.Role__c = 'ASM';
        userlist.add(userdata4);
        
        
        // creating user with Plumbing vertical and RSM role
        
        User userdata5 = new User();
        userdata5 = Test_Intial_Data_Phase2.PlumbingRSM('test55', 'user5', 'System Administrator');
        userdata5.Allocated_State__c= target.state__c;
        userdata5.Vertical_Type__c=target.Vertical__c;
        userlist.add(userdata5);
        
        
        // creating user with Plumbing vertical and ASM role
        
        User userdata6 = new User();
        userdata6 = Test_Intial_Data_Phase2.PlumbingASM('test66', 'user6', 'System Administrator');
        userdata6.Allocated_State__c= target.state__c;
        userdata6.Vertical_Type__c = target.Vertical__c;
        userlist.add(userdata6);
        
        
        // creating user with Projects vertical and Regional Head role
        
        User userdata7 = new User();
        userdata7 = Test_Intial_Data_Phase2.ProjectsRH('test77', 'user7', 'System Administrator');
        userdata7.Allocated_State__c= target.state__c;
        userdata7.Vertical_Type__c=target.Vertical__c;
        userlist.add(userdata7);
        
        
        // creating user with Projects vertical and RSM role
        
        User userdata8 = new User();
        userdata8 = Test_Intial_Data_Phase2.ProjectsRH('test88', 'user8', 'System Administrator');
        userdata8.Allocated_State__c= target.state__c;
        userdata8.Vertical_Type__c=target.Vertical__c;
        userlist.add(userdata8);
        
        
        // creating user with Projects vertical and ASM role
        
        User userdata9 = new User();
        userdata9 = Test_Intial_Data_Phase2.ProjectsRH('test99', 'user9', 'System Administrator');
        userdata9.Allocated_State__c= target.state__c;
        userdata9.Vertical_Type__c='Projects';
        userdata9.Role__c = 'RH';
        userlist.add(userdata9);
        insert userlist;
        
    }
    
    public static testmethod void testColumn() {
        
        init();
        list<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
        
        test.startTest();
        
        Apexpages.standardController controller = new Apexpages.standardController(target);
        APPL_Target_Create_Controller Atcc = new APPL_Target_Create_Controller(controller);
        Atcc.target.state__c='karnataka';
        Atcc.target.Vertical__c='Column';
        //List<SelectOption> monthsList = Atcc.populateMonths();
        Atcc.SelectedMonth = Atcc.months[2].getValue();
        //Atcc.queryRH();
        //Atcc.queryRSM();
        //Atcc.queryASM();
        Atcc.ToContinue();
        Atcc.clonebtn();
        Atcc.toSave();
        Atcc.toCancel();
        
        test.stopTest(); 
    }
    
    public static testmethod void testPlumbing() {
        
        init();
        list<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
        
        test.startTest();
        
        Apexpages.standardController controller = new Apexpages.standardController(target);
        APPL_Target_Create_Controller Atcc = new APPL_Target_Create_Controller(controller);
        Atcc.target.state__c='karnataka';
        Atcc.target.Vertical__c='Plumbing';
        //List<SelectOption> monthsList = Atcc.populateMonths();
        Atcc.SelectedMonth = Atcc.months[1].getValue();
        //Atcc.queryRH();
        //Atcc.queryRSM();
        //Atcc.queryASM();
        Atcc.ToContinue();
        Atcc.toSave();
        Atcc.toCancel();
        Atcc.clonebtn();
        test.stopTest(); 
    }
    
    public static testmethod void testProjects() {
        
        init();
        list<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
        
        test.startTest();
        
        Apexpages.standardController controller = new Apexpages.standardController(target);
        APPL_Target_Create_Controller Atcc = new APPL_Target_Create_Controller(controller);
        Atcc.target.state__c='karnataka';
        Atcc.target.Vertical__c='Projects';
        //List<SelectOption> monthsList = Atcc.populateMonths();
        Atcc.SelectedMonth = Atcc.months[1].getValue();
        //Atcc.queryRH();
        //Atcc.queryRSM();
        //Atcc.queryASM();
        Atcc.ToContinue();
        Atcc.toSave();
        Atcc.toCancel();
        Atcc.clonebtn();
        test.stopTest(); 
        
        
    }
    
    public static testmethod void testErrors() {
        
        init();
        list<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
        
        test.startTest();
        Apexpages.standardController controller = new Apexpages.standardController(target);
        APPL_Target_Create_Controller Atcc = new APPL_Target_Create_Controller(controller);
        Atcc.ToContinue();
        Atcc.target.Vertical__c='Plumbing';
        Atcc.ToContinue();
        Atcc.clonebtn();
        Atcc.target.Vertical__c='Plumbing';
        Atcc.selectedMonth ='march';
        Atcc.ToContinue();
        test.stopTest();
    }
}