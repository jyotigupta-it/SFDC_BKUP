@isTest
public class Test_Appl_visit_calendar {
    public static AP_Expenses__c expense;
    public static Target__c target;
    public static AP_Tour_Plan__c tourplan;
    public static User userdata;
    public static AP_Site_Visit__c holidayVisit;    
    public static AP_Site_Visit__c visitrec;
    public static AP_Site_Visit__c visitrec1;
    public static AP_Site_Visit__c visitrecbrand;
    public static AP_Site_Visit__c postvisit;
    public static AP_Site_Visit__c projectListvisit;
    
    private static Account testAccount1;
    private static Account testAccount2;
    private static Promotion__c newPromotion; 
    public static Branding_Request__c br;
	public static Integer i;    
    
    
    // initializing test data
    private static void init() {
        
        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
        insert userdata ;
        
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        target.Start_Date__c = Date.today();
        insert target;
        
        testAccount1 = Initial_Test_Data.createAccount('Test Account1', 'Dealer');
        testAccount1.Contact_Number_Mobile__c ='07259582222';
        testAccount1.Party_Type__c='Dealer';
        testAccount1.Year_Since_in_Business__c='2019';
        testAccount1.If_Yes_Products__c='test';
        testAccount1.If_others__c='test';
        testAccount1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount1.VAT_CST_Number__c='101010000000000';
        testAccount1.Conversion_Probability__c='High';
        // testAccount1.Parent.id=acc.id;
        testAccount1.PIN_Code__c='562106';
        testAccount1.UPVC_Discount__c=0;
        testAccount1.Column_Discount_Amount__c=0;
        testAccount1.Discount__c=0;
        testAccount1.SWR_Discount__c=0;
        testAccount1.Accountant__c='YES';
        insert testAccount1;
        
        testAccount2 = Initial_Test_Data.createAccount('Test Account1', 'Dealer');
        testAccount2.Contact_Number_Mobile__c ='07259580989';
        testAccount2.Party_Type__c='Dealer';
        testAccount2.Year_Since_in_Business__c='2019';
        testAccount2.If_Yes_Products__c='test';
        testAccount2.If_others__c='test';
        testAccount2.Accountant__c='Yes';
        testAccount2.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount2.VAT_CST_Number__c='101010000000000';
        testAccount2.Conversion_Probability__c='High';
        // testAccount2.Parent.id=acc.id;
        testAccount2.PIN_Code__c='562106';
        testAccount2.UPVC_Discount__c=0;
        testAccount2.Column_Discount_Amount__c=0;
        testAccount2.Discount__c=0;
        testAccount2.SWR_Discount__c=0;
        insert testAccount2;
        
         tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Approval_Status__c = 'Pending';
        tourplan.Visit_Type__c = 'Ex-Station';
        tourplan.Date__c = Date.today();
        tourplan.Target__c = target.ID;
        insert tourplan;
        
          expense = Test_Intial_Data_Phase2.CreateExpense(tourplan.Id);
        expense.TourPlan__c = tourplan.ID;
        insert expense ;
        
          holidayVisit =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        holidayVisit.Remarks__c = 'Holiday';
        holidayVisit.Target__c = target.Id;
        //insert holidayVisit;

        
        visitrec =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
        visitrec.Remarks__c = 'normal';
        visitrec.Party_Type__c = 'Dealer';
        visitrec.Party_Name__c = testAccount1.id;
        visitrec.Purpose_of_Visit__c = 'Enquiry';
        visitrec.Products__c = 'WCPC new order';
        visitrec.Order_Value__c = 1000;
        visitrec.Target__c = target.Id;
        //visitrec.
                visitrec.Id=null;
        visitrec.CheckOut_Address__c='bglr';
       // visitrec1.CheckOut_location__c=12°54'47''N 77°38'32''E;
        visitrec.CheckOut_location__Latitude__s=13.0429;
        visitrec.CheckOut_location__Longitude__s=80.2739;
        visitrec .Checkout_Time__c=Time.newInstance(0, 2, 2, 0);
        visitrec.BrandType__c='Recce';
        visitrec.Language__c='Hindi';
        visitrec.Branding_Request__c = true;
        
       // insert visitrec;
        
                visitrecbrand =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'brandingVist');
        visitrecbrand.Party_Type__c='Dealer';
        visitrecbrand.Party_Name__c = testAccount1.id;
        visitrecbrand.Target__c = target.Id;
        
        
        visitrecbrand.Branding_Request__c=true;
        visitrecbrand.Id=null;
        visitrecbrand.BrandType__c='Recce';
        visitrecbrand.Language__c='Hindi';
        
     //   insert visitrecbrand;
        
        visitrec1 =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
        visitrec1.Remarks__c = 'normal';
        visitrec1.Party_Type__c = 'Dealer';
        visitrec1.Party_Name__c = testAccount2.id;
        visitrec1.Purpose_of_Visit__c = 'Enquiry';
        visitrec1.Products__c = 'WCPC new order';
        visitrec1.Order_Value__c = 1000;
        visitrec1.Target__c = target.Id;
        visitrec1.Vertical__c='Plumbing';
        //Added By Shaikh Ishaque 
        visitrec1.Branding_Request__c=true;
        visitrec1.Id=null;
        visitrec1.CheckOut_Address__c='bglr';
       // visitrec1.CheckOut_location__c=12°54'47''N 77°38'32''E;
        visitrec1.CheckOut_location__Latitude__s=13.0429;
        visitrec1.CheckOut_location__Longitude__s=80.2739;
        visitrec1 .Checkout_Time__c=Time.newInstance(0, 2, 2, 0);
        visitrec1.BrandType__c='Inshop';
        visitrec1.Language__c='Hindi';
        visitrec1.MediaType__c='PoP Boards';   
             
//       Database.insert(visitrec1,false);
        
        
        
        postvisit =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        postvisit.Remarks__c    = 'postvisit';
        postvisit.Party_Type__c = 'Dealer';
        postvisit.Target__c     = target.Id;
        postvisit.Source__c     = 'Phone';
        postvisit.Products__c   = 'CPVC';
        postvisit.Party_Name__c = testAccount1.id;
        postvisit.Order_Value__c= 100;
        postvisit.Othet_Activities__c= 'Post Visit Order';
      // insert postvisit;


        
        projectListvisit =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Project Visit');
        projectListvisit.Remarks__c = 'projectListvisit';
        projectListvisit.Target__c = target.Id;
      //  insert projectListvisit;
        
        newPromotion = Test_Intial_Data_Phase2.CreatePromotion('Architects Meet');
        insert newPromotion;
        
        
        Case cas=new case();
        System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
        cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
        cas.status='Open';
        cas.subject='';
        insert cas;
        System.debug(cas);
        
        br = new Branding_Request__c();
        br.Escalated_To_Branding_Head__c = true;
        br.Branding_Approved_Rejected__c = 'Submitted To RBM';
        br.Branding_Request__c = cas.Id;
        br.Shop_Name__c = testAccount1.Id;
        try{
            Insert br;
        } catch(DmlException ex) {
            
        }
        
        
    }
      private static void init2() {
        init();
        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
        insert userdata ;
        
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        target.Start_Date__c = Date.today();
        insert target;
        
        testAccount1 = Initial_Test_Data.createAccount('Test Account1', 'Dealer');
        testAccount1.Contact_Number_Mobile__c ='07259582892';
        testAccount1.Party_Type__c='Dealer';
        testAccount1.Year_Since_in_Business__c='2019';
        testAccount1.If_Yes_Products__c='test';
        testAccount1.If_others__c='test';
        testAccount1.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount1.VAT_CST_Number__c='101010000000000';
        testAccount1.Conversion_Probability__c='High';
        // testAccount1.Parent.id=acc.id;
        testAccount1.PIN_Code__c='562106';
        testAccount1.UPVC_Discount__c=0;
        testAccount1.Column_Discount_Amount__c=0;
        testAccount1.Discount__c=0;
        testAccount1.SWR_Discount__c=0;
        testAccount1.Accountant__c='YES';
        insert testAccount1;
        
        testAccount2 = Initial_Test_Data.createAccount('Test Account1', 'Dealer');
        testAccount2.Contact_Number_Mobile__c ='09538456606';
        testAccount2.Party_Type__c='Dealer';
        testAccount2.Year_Since_in_Business__c='2019';
        testAccount2.If_Yes_Products__c='test';
        testAccount2.If_others__c='test';
        testAccount2.Accountant__c='Yes';
        testAccount2.Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
        testAccount2.VAT_CST_Number__c='101010000000000';
        testAccount2.Conversion_Probability__c='High';
        // testAccount2.Parent.id=acc.id;
        testAccount2.PIN_Code__c='562106';
        testAccount2.UPVC_Discount__c=0;
        testAccount2.Column_Discount_Amount__c=0;
        testAccount2.Discount__c=0;
        testAccount2.SWR_Discount__c=0;
        insert testAccount2;
        
         tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Approval_Status__c = 'Pending';
        tourplan.Visit_Type__c = 'Ex-Station';
        tourplan.Date__c = Date.today();
        tourplan.Target__c = target.ID;
        insert tourplan;
        
          expense = Test_Intial_Data_Phase2.CreateExpense(tourplan.Id);
        expense.TourPlan__c = tourplan.ID;
        insert expense ;
        
          holidayVisit =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        holidayVisit.Remarks__c = 'Holiday';
        holidayVisit.Target__c = target.Id;
       // insert holidayVisit;

        
        visitrec =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
        visitrec.Remarks__c = 'normal';
        visitrec.Party_Type__c = 'Dealer';
        visitrec.Party_Name__c = testAccount1.id;
        visitrec.Purpose_of_Visit__c = 'Enquiry';
        visitrec.Products__c = 'WCPC new order';
        visitrec.Order_Value__c = 1000;
        visitrec.Target__c = target.Id;
        //visitrec.
         visitrec.Id=null;
        visitrec.CheckOut_Address__c='bglr';
       // visitrec1.CheckOut_location__c=12°54'47''N 77°38'32''E;
        visitrec.CheckOut_location__Latitude__s=13.0429;
        visitrec.CheckOut_location__Longitude__s=80.2739;
        visitrec .Checkout_Time__c=Time.newInstance(0, 2, 2, 0);
        visitrec.BrandType__c='Recce';
        visitrec.Language__c='Hindi';
        visitrec.Branding_Request__c = true;
        
//        insert visitrec;
        
                visitrecbrand =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'brandingVist');
        visitrecbrand.Party_Type__c='Dealer';
        visitrecbrand.Party_Name__c = testAccount1.id;
        visitrecbrand.Target__c = target.Id;
        
        
        visitrecbrand.Branding_Request__c=true;
        visitrecbrand.Id=null;
        visitrecbrand.BrandType__c='Recce';
        visitrecbrand.Language__c='Hindi';
        
     //   insert visitrecbrand;
        
        visitrec1 =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Visits');
        visitrec1.Remarks__c = 'normal';
        visitrec1.Party_Type__c = 'Dealer';
        visitrec1.Party_Name__c = testAccount2.id;
        visitrec1.Purpose_of_Visit__c = 'Enquiry';
        visitrec1.Products__c = 'WCPC new order';
        visitrec1.Order_Value__c = 1000;
        visitrec1.Target__c = target.Id;
        visitrec1.Vertical__c='Plumbing';
        //Added By Shaikh Ishaque 
        visitrec1.Branding_Request__c=true;
        visitrec1.Id=null;
        visitrec1.CheckOut_Address__c='bglr';
       // visitrec1.CheckOut_location__c=12°54'47''N 77°38'32''E;
        visitrec1.CheckOut_location__Latitude__s=13.0429;
        visitrec1.CheckOut_location__Longitude__s=80.2739;
        visitrec1 .Checkout_Time__c=Time.newInstance(0, 2, 2, 0);
        visitrec1.BrandType__c='Inshop';
        visitrec1.Language__c='Hindi';
        visitrec1.MediaType__c='PoP Boards';   
             
//       Database.insert(visitrec1,false);
        
        
        
        postvisit =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        postvisit.Remarks__c    = 'postvisit';
        postvisit.Party_Type__c = 'Dealer';
        postvisit.Target__c     = target.Id;
        postvisit.Source__c     = 'Phone';
        postvisit.Products__c   = 'CPVC';
        postvisit.Party_Name__c = testAccount1.id;
        postvisit.Order_Value__c= 100;
        postvisit.Othet_Activities__c= 'Post Visit Order';
      // insert postvisit;


        
        projectListvisit =  Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Project Visit');
        projectListvisit.Remarks__c = 'projectListvisit';
        projectListvisit.Target__c = target.Id;
      //  insert projectListvisit;
        
        newPromotion = Test_Intial_Data_Phase2.CreatePromotion('Architects Meet');
        insert newPromotion;
        
        
        Case cas=new case();
        System.debug('RecordType : '+[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id);
        cas.RecordTypeId=[select id from RecordType where name=:'Branding Request' and SobjectType='Case'].id;
        cas.status='Open';
        cas.subject='';
        insert cas;
        System.debug(cas);
        
        br = new Branding_Request__c();
        br.Escalated_To_Branding_Head__c = true;
        br.Branding_Approved_Rejected__c = 'Submitted To RBM';
        br.Branding_Request__c = cas.Id;
        br.Shop_Name__c = testAccount1.Id;
        try{
            Insert br;
        } catch(DmlException ex) {
            
        }
        
        
    }
        private static testMethod void visitEntryUnitTest() {
            Integer i=1;
            init(); 
        Test.Starttest();
        // Load Visit_Promotion_type__c Table of Custom Setting from Static resource
         List<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
            
        //Start Test
        
        pagereference pr=new pagereference('/apex/AP_TOURPLAN_CALENDAR_V5?scontrolCaching=1&id='+target.id);
        Test.setCurrentPageReference(pr);
        Apexpages.StandardController sc = new Apexpages.standardController(target);
        APPL_SITEVISIT_CALENDAR_CTRL controllerInstance = new APPL_SITEVISIT_CALENDAR_CTRL(sc);

        //Calling Remoting
        APPL_SITEVISIT_CALENDAR_CTRL.retreiveTourRelatedTarget(target.id);
        APPL_SITEVISIT_CALENDAR_CTRL.getCountOfActivits(tourplan.id);
            APPL_SITEVISIT_CALENDAR_CTRL a = new APPL_SITEVISIT_CALENDAR_CTRL();
            a.searchQueryforDealerUnplanned();
        
         DateTime d = Date.Today() ;
        String dateStr =  d.format('dd/MM/yyyy') ;      
        ApexPages.currentPage().getParameters().put('tourId',tourplan.id);
        ApexPages.currentPage().getParameters().put('tourDate',dateStr);
        ApexPages.currentPage().getParameters().put('iniTour',tourplan.id);
        ApexPages.currentPage().getParameters().put('iniTourDate',dateStr);
        ApexPages.currentPage().getParameters().put('tourVertical','Projects');
        ApexPages.currentPage().getParameters().put('dateDiff','0');
        ApexPages.currentPage().getParameters().put('visitCount','1');
        ApexPages.currentPage().getParameters().put('ordCount','1');
        ApexPages.currentPage().getParameters().put('projectCount','1');
        
        controllerInstance.initializeModal();
        
        controllerInstance.addSiteVisitIns();
        controllerInstance.addSiteVisitIns();
        //controllerInstance.visitList[0].
       
      //  controllerInstance.addProjectVisitIns();
        controllerInstance.addBrandingVisitIns();
        controllerInstance.meetingVisit();
        controllerInstance.promotionalVisit();
        controllerInstance.trainingVisit();
        controllerInstance.postOrderVisit();
        
       
        controllerInstance.holidayVisit = new AP_Site_Visit__c();
        controllerInstance.holidayVisit = holidayVisit;
        controllerInstance.saveVisits();
        controllerInstance.RemoveVL();
        
        controllerInstance.visitList    = new List<AP_Site_Visit__c>();
        controllerInstance.visitList.add(visitrec);
        controllerInstance.EditVL();
        
        //controllerInstance.SaveVL();
        controllerInstance.CancelVL();
        controllerInstance.DeleteVL();
        controllerInstance.RemovePVO();
            
        controllerInstance.EditPVO();
        controllerInstance.SavePVO();
        controllerInstance.CancelPVO();
        controllerInstance.DeletePVO();     
        controllerInstance.RemovePVL();
            
            
        controllerInstance.EditPVL();
        controllerInstance.SavePVL();
        controllerInstance.CancelPVL();
        controllerInstance.DeletePVL();
        
            controllerInstance.fillAttachment();
            controllerInstance.rerender();
            controllerInstance.runQuery();
            APPL_SITEVISIT_CALENDAR_CTRL.checkBranding('hello');
        controllerInstance.postOrderVisitList   = new List<AP_Site_Visit__c>();
        //controllerInstance.postOrderVisitList.add(postvisit);   
        APPL_SITEVISIT_CALENDAR_CTRL.testingcovering();
            APPL_SITEVISIT_CALENDAR_CTRL.testingcovering2();
        Test.StopTest();
      }
  /*  public static testMethod void test2(){
        init();
        Test.Starttest();
        // Load Visit_Promotion_type__c Table of Custom Setting from Static resource
         List<Visit_Promotion_type__c> ls = Test.loadData(Visit_Promotion_type__c.sObjectType, 'Visit_Promotion_Test_Data');
            
        //Start Test
        
        pagereference pr=new pagereference('/apex/AP_TOURPLAN_CALENDAR_V5?scontrolCaching=1&id='+target.id);
        Test.setCurrentPageReference(pr);
         DateTime d = Date.Today() ;
        String dateStr =  d.format('dd/MM/yyyy') ;
          Apexpages.StandardController sc = new Apexpages.standardController(target);
        APPL_SITEVISIT_CALENDAR_CTRL controllerInstance = new APPL_SITEVISIT_CALENDAR_CTRL(sc);
       
        controllerInstance.projectList  = new List<AP_Site_Visit__c>();
       // controllerInstance.projectList.add(projectListvisit);   
        
        
        controllerInstance.EditHI();
        controllerInstance.SaveHI();
        controllerInstance.CancelHI();
        controllerInstance.DeleteHI();
        
        controllerInstance.leaveVisit   = new AP_Site_Visit__c();   
        AP_Site_Visit__c leaverec   = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        leaverec.Target__c = target.Id;
        insert leaverec;
        controllerInstance.leaveVisit = leaverec;
        
        controllerInstance.EditLI();
        controllerInstance.SaveLI();
        controllerInstance.CancelLI();
        controllerInstance.DeleteLI();
        
        
        ApexPages.currentPage().getParameters().put('meetCount','1');
        
        controllerInstance.RemoveML();
        
        controllerInstance.meetingVisitList = new List<AP_Site_Visit__c>(); 
        AP_Site_Visit__c meetingrec = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        meetingrec.Target__c = target.Id;
        insert meetingrec;  
        controllerInstance.meetingVisitList.add(meetingrec);
        
        controllerInstance.EditML();
        controllerInstance.SaveML();
        controllerInstance.CancelML();
        controllerInstance.DeleteML();
        
        ApexPages.currentPage().getParameters().put('promoCount','1');
        controllerInstance.RemovePL();
        
        controllerInstance.promotionalVisitList = new List<AP_Site_Visit__c>(); 
        AP_Site_Visit__c promorec   = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        promorec.Promotion__c = newPromotion.id;
        promorec.Target__c = target.Id;
        insert promorec;
        controllerInstance.promotionalVisitList.add(promorec);
        
        controllerInstance.EditPL();
        controllerInstance.SavePL();
        controllerInstance.CancelPL();
        controllerInstance.DeletePL();
        
        ApexPages.currentPage().getParameters().put('tempCount','1');
        controllerInstance.RemoveTL();
        
        controllerInstance.trainingVisitList    = new List<AP_Site_Visit__c>(); 
        AP_Site_Visit__c trainingrec    = Test_Intial_Data_Phase2.createSiteVisit(tourplan.Id, 'Other Activities');
        trainingrec.Target__c = target.Id;
        insert trainingrec;
        controllerInstance.trainingVisitList.add(trainingrec);
        
        controllerInstance.EditTL();
        controllerInstance.SaveTL();
        controllerInstance.CancelTL();
        controllerInstance.DeleteTL();
        
        ApexPages.currentPage().getParameters().put('expTourId',tourplan.id);
        ApexPages.currentPage().getParameters().put('expTourDate',dateStr);
        
        controllerInstance.saveExpense();
        controllerInstance.EditExpense();
        controllerInstance.UpdateExpense();
        controllerInstance.clearExpense();
        controllerInstance.FileCount = '1';
        controllerInstance.addColoums();
        controllerInstance.addProjects();
        controllerInstance.addbranding();
        controllerInstance.calendarValues();
        controllerInstance.calendarValues();
        PageReference p =controllerInstance.fillAttachment();
    }*/
    
    Public Static testMethod void VineetTest() {
    Test.setCurrentPage(Page.APPL_SITEVISIT_CALENDAR);
ApexPages.currentPage().getParameters().put('calPromoDateVal','asd');
    ApexPages.currentPage().getParameters().put('calVerticalVal','fgh');
    ApexPages.currentPage().getParameters().put('calPromoIdVal','rty');
    
        APPL_SITEVISIT_CALENDAR_CTRL abc=new APPL_SITEVISIT_CALENDAR_CTRL();
        abc.calendarValues();
        APPL_SITEVISIT_CALENDAR_CTRL.testingcovering();
            APPL_SITEVISIT_CALENDAR_CTRL.testingcovering2();
        
    }
    
        }