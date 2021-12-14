@isTest
public class MapAccountUtilityTestClass {
    
    testmethod static void testMethod1(){
        Test.startTest();
        Beat_Master__c bc = new Beat_Master__c();
        bc.Name='Test';
        insert bc;
         
        ApexPages.StandardController sc = new ApexPages.StandardController(bc);
        MapAccountUtility mc = new MapAccountUtility(sc);
        mc.usrtgtId='Test';
        mc.selectedStringValList.add('Test');
        // mc.Geolocation__c='0121';
        mc.geocode_longitude='20.5937';
        mc.geocode_latitude='78.9629';
        mc.accVar=true;
        mc.sel='Test';
        mc.test='Test';
        mc.BeatMsName='Test';
        mc.BeatId='Test';
        mc.BtId='Test';
        mc.displayPopupbeat2=true;
        mc.beatplan=new Beat_Plan__c();
        mc.setbeatmst(bc);
        mc.radius=5;
        
        MapAccountUtility.currentChurn='Churned';
        MapAccountUtility.currentNPS='8';
        MapAccountUtility.recPhNo='123456789';
        MapAccountUtility.recName='Test';
        
        
        //mc.mapVal.put('Name','Test');
        mc.selectedPickListValList.add('Plumber');
        mc.selectedFieldList.add('Name');
        mc.selectedOperatorList.add('LIKE');
        mc.selectedOperatorList.add('LIKE');
        mc.selectedOperatorList.add('LIKE1');
        
        mc.allSelecttedValues.add('Test');
        mc.selectedField='Name';
        
        mc.getAccountFields();
        mc.getOperators();
        mc.getAccountLatLong1();
        mc.accFilter();
        mc.addListMethod();
        mc.getBeatRecords();
        mc.filterAddValMeth();
        mc.getFileId();
        mc.testFunction();
        mc.getTarget();
        mc.getVisitData();
        mc.redirectProject();
        //mc.BeatplanVisitmethod();
        //============================================
       /*  MapAccountUtility mc22 = new MapAccountUtility(sc);
     ;
        */
        Target__c target = new Target__c();
        target.state__c='Karnataka';
        target.vertical__c = 'Column';
        insert target;
        AP_Tour_Plan__c tourplan = new AP_Tour_Plan__c(
            Market_Type__c = 'New',
            Promotional_Type__c = 'Boarers Meet',
            Target__c = target.ID
            
        );
        insert tourplan;
        AP_Site_Visit__c sitevisit = new AP_Site_Visit__c();
        
       
         
         Account testAccount1 = new Account();
         testAccount1 = Initial_Test_Data.createAccount('Testount1', 'Dealer');
        testAccount1 .Name = 'Kvp';
         testAccount1.Name_of_software__c='hbkj';
        testAccount1.Total_working_capital_investment__c=133;
        testAccount1.Borrowed_capital__c=133;
        testAccount1.Total_Annual_Turnover__c=150;
        testAccount1 .Primary_Contact_Person_Name__c = 'KvpTest';
        testAccount1 .Party_Type__c = 'Dealer';
        testAccount1 .Contact_Number_Mobile__c = '9859000000';
        testAccount1 .State__c = 'Rajasthan';
        testAccount1 .District__c = 'Jaipur';
        testAccount1.Expected_AA_contribution_in_total_busi__c=10;
        testAccount1 .City__c = 'Jaipur';
        testAccount1 .Status__c = 'Prospective';
        testAccount1 .Street_Address__c = 'HSR';
        testAccount1 .Ramco_ID__c = '54';
        testAccount1.Distribution_as_a_part_of_total_business__c=15;
         testAccount1.Size_of_Dedicated_godown_for_Ashirvad__c=15;
         testAccount1.Avg_Credit_days_offered_in_market__c=10;
        testAccount1 .Year_Since_in_Business__c='2019';
            testAccount1 .If_Yes_Products__c='test';
           testAccount1 .If_others__c='test';
            testAccount1 .Reason_for_not_buying_Ashirvad__c='Poor DP relationship';
            testAccount1 .VAT_CST_Number__c='101010000000000';
            testAccount1 .Conversion_Probability__c='High';
           // testAccount1 .Parent.id=acc.id;
            testAccount1 .PIN_Code__c='562106';
            testAccount1 .UPVC_Discount__c=0;
            testAccount1 .Column_Discount_Amount__c=0;
            testAccount1 .Discount__c=0;
            testAccount1 .SWR_Discount__c=0;
           testAccount1.Accountant__c='Yes';
        testAccount1.Accounting_software_installed__c='Yes';
         testAccount1.Dedicated_office_space__c='Yes';
        insert testAccount1;
        
        mc.CurrentId=testAccount1.ID;        
        sitevisit.Target__c = target.ID;
        sitevisit.AP_Tour_Plan__c = tourplan.Id;
        sitevisit.Date__c = system.today();
        sitevisit.Party_Name__c = mc.CurrentId;
       // sitevisit.Location__c='test';
        
        
        insert sitevisit;
        
        mc.CheckinData();
        //processSelected
        mc.beatDate=System.today();
        mc.processSelected();
        
        
        MapAccountUtility mce = new MapAccountUtility(sc);
        mce.selectedStringValList.add('Test');
        //mc.mapVal.put('Name','Test');
        mce.selectedPickListValList.add('Plumber');
        mce.selectedFieldList.add('Name');
        mce.selectedOperatorList.clear();
        mce.selectedOperatorList.add('LIKE1');
        mce.selectedOperatorList.add('LIKE');
        
        mce.allSelecttedValues.add('Test');
        mce.selectedField='Name';
        
        mce.getAccountFields();
        mce.getOperators();
        //mce.getAccountLatLong1();
        mce.accFilter();
        mce.addListMethod();
        mce.getBeatRecords();
        mce.filterAddValMeth();
        mce.getFileId();
        mce.testFunction();
        mce.getTarget();
        mce.getVisitData();
        mce.redirectProject();
        mce.CheckinData();
        //processSelected
        mce.beatDate=System.today();
        Beat_Master__c wbm = new Beat_Master__c();
        wbm.Checked__c=true;
        insert wbm;
        mce.beatMasterList.add(wbm);
        mce.processSelected();
        NPTB__c np= new NPTB__c(); 
        np.Product__c='Testddddddddddgfdgdfgsdfsdfsddffsfsfsdf';
        insert np;
        mce.getMapReportCustom();
        mce.getnptbList();
        
        
        MapAccountUtility mcq = new MapAccountUtility(sc);
        mcq.selectedStringValList.add('Test');
        //mc.mapVal.put('Name','Test');
        mcq.selectedPickListValList.add('Plumber');
        mcq.selectedFieldList.add('Name');
        mcq.selectedOperatorList.add('=');
        
        mcq.allSelecttedValues.add('Test');
        mcq.selectedField='Name';
        
        mcq.getAccountFields();
        mcq.getOperators();
       //mcq.getAccountLatLong1();
        mcq.accFilter();
        mcq.addListMethod();
        mcq.getBeatRecords();
        mcq.filterAddValMeth();
        mcq.getFileId();
        mcq.testFunction();
        mcq.getTarget();
        mcq.getVisitData();
        mcq.redirectProject();
        mcq.CheckinData();
        //processSelected
        mcq.beatDate=System.today();
        mcq.processSelected();
        
        MapAccountUtility mc1 = new MapAccountUtility(sc);
        
        mc1.selectedField='Party_type__c';
        mc1.pickListValues.add('Plumber');
        mc1.operatorVal='IN';
        //mc1.pickListValuesList.add('Plumber');
        mc1.selectedFieldList.add('Party_type__c');
        mc1.selectedOperatorList.add('IN');
        mc1.selectedValByPickList='Plumber';
        mc1.getAccountFields();
        mc1.getOperators();
        //mc1.getAccountLatLong1();
        mc1.accFilter();
        //mc1.addListMethod();
        mc1.getBeatRecords();
        
        
        
        MapAccountUtility mc2 = new MapAccountUtility(sc);
        mc2.selectedField='AnnualRevenue';
        mc2.allSelecttedValues.add(1000);
        mc2.selectedValByInteger=100;
        
        mc2.getAccountFields();
        mc2.getOperators();
        //mc2.getAccountLatLong1();
        mc2.accFilter();
        mc2.addListMethod();
        mc2.getBeatRecords();
       
        
        
        
        MapAccountUtility mc3 = new MapAccountUtility(sc);
        mc3.selectedField='NumberOfEmployees';
        mc3.allSelecttedValues.add(4);
        
        mc3.getAccountFields();
        mc3.getOperators();
        //mc3.getAccountLatLong1();
        mc3.accFilter();
        mc3.addListMethod();
        mc3.getBeatRecords();
        
        
        MapAccountUtility mc4 = new MapAccountUtility(sc);
        mc4.selectedField='IsPartner';
        mc4.allSelecttedValues.add(true);
        
        mc4.getAccountFields();
        mc4.getOperators();
        //mc4.getAccountLatLong1();
        mc4.accFilter();
        mc4.addListMethod();
        mc4.getBeatRecords();
        
        
        MapAccountUtility mc5 = new MapAccountUtility(sc);
        
        mc5.selectedField='Anniversary_Date__c';
      //  mc5.allSelecttedValues.add(System.today());
        
        mc5.getAccountFields();
        mc5.getOperators();
        //mc5.getAccountLatLong1();
        mc5.accFilter();
        mc5.addListMethod();
        mc5.getBeatRecords();
        
        
        MapAccountUtility mc6 = new MapAccountUtility(sc);
        mc6.selectedField='Account_Status_Change_Date__c';
      //  mc5.allSelecttedValues.add(System.now());
        
        mc6.getAccountFields();
        mc6.getOperators();
        //mc6.getAccountLatLong1();
        mc6.accFilter();
        mc6.addListMethod();
       // mc6.getBeatRecords();
        
        MapAccountUtility mc7 = new MapAccountUtility(sc);
        mc7.selectedField='billinglongitude';
        mc7.allSelecttedValues.add(System.now());
        
        mc7.getAccountFields();
        mc7.getOperators();
        mc7.getAccountLatLong1();
        mc7.accFilter();
        mc7.addListMethod();
        
        //mc7.getBeatRecords();
        
        MapAccountUtility mcCheck= new MapAccountUtility(sc);
        mcCheck.closePopupBeat();
        mcCheck.getAccDispFields();
       
        
        mcCheck.OpenPopupBeat();
        mcCheck.closePopup();
        mcCheck.OpenPopup();
        mcCheck.BeatList();
        mcCheck.redirectPopup();
        Beat_Master__c btm = new Beat_Master__c();
        btm.Name='Check';
        insert btm;
        
        Beat_Master_Account__c bm= new Beat_Master_Account__c();
        //bm.Name= 'Test';
        
        bm.Beat_Master__c=btm.ID;
        /*Account account_Obj = new Account(Name = 'Name179',VAT_CST_Number__c='29AAHFL2269D1Z9',Party_type__c='Dealer',Year_Since_in_Business__c='2015', Contact_Number_Mobile__c = '9999999999', BillingStreet = 'PratapNagar', BillingCity = 'Jaipur', BillingState = 'Raj', BillingPostalCode = '302022', BillingCountry = 'India', Salesforce_Data_Not_in_Ramco__c = false, Inactive_Mobile_No__c = false, System_Flag__c = false, Account_Status_Flag__c = false, Geolocation__Latitude__s = 0, Geolocation__Longitude__s = 0);
        Insert account_Obj;*/ 
        bm.Account__c=testAccount1.ID;
        
        insert bm;
        Beat_Master_Account__c bm1= new Beat_Master_Account__c();
       /* Account account_Obj1 = new Account(Name = 'Name179',VAT_CST_Number__c='29AAHFL2269D1Z9',Party_type__c='Dealer',Year_Since_in_Business__c='2016', Contact_Number_Mobile__c = '9999999999', BillingStreet = 'PratapNagar', BillingCity = 'Jaipur', BillingState = 'Raj', BillingPostalCode = '302022', BillingCountry = 'India', Salesforce_Data_Not_in_Ramco__c = false, Inactive_Mobile_No__c = false, System_Flag__c = false, Account_Status_Flag__c = false, Geolocation__Latitude__s = 0, Geolocation__Longitude__s = 0);
        Insert account_Obj1; */
        // bm1.Name= 'Test';
        bm1.Beat_Master__c=btm.ID;
        bm1.Account__c=testAccount1.ID;
        
        insert bm1;
        Beat_Plan__c bplan=new Beat_Plan__c();
        bplan.Beat_Date__c=system.today();
        bplan.Beat_Master__c=btm.Id;
        insert bplan;
        Beat_Plan_Account__c bbp=new Beat_Plan_Account__c();
        bbp.Account__c=testAccount1.ID;
        bbp.Beat_Plan__c=bplan.Id;
        insert bbp;
        
        String BmID=bm.Account__c+'/'+bm1.Account__c;
        mcCheck.BtName=BmID;
        mcCheck.doUpdate();
        mcCheck.redirectUser();
        mcCheck.actfunmethod();
        mcCheck.search();
        mcCheck.accVar();
        //mcCheck.removeFilter();
        
        
        MapAccountUtility mcCheck1= new MapAccountUtility(sc);
        Schema.DisplayType fielddataType;
        // string fieldlable;
        string fieldlable;
        mcCheck1.selectedField='Name';
        mcCheck1.selectedValByString='Test';
        
        mcCheck1.tempSelectedfield='Name';
        mcCheck1.selectedFieldList.add('Name');
        mcCheck1.selectedFieldList.add('Name');
        mcCheck1.selectedOperatorList.add('!=');
        mcCheck1.selectedOperatorList.add('=');
        mcCheck1.mapVal.put('Party_type__c','Plumber');
        mcCheck1.mapVal.put('Party_type__c','Dealer');
        mcCheck1.selectedFieldList.add('-None-');
        mcCheck1.selectedFieldList.add('Name');
        
        mcCheck1.filteredList.add('Plumber');
        mcCheck1.filteredList.add('Plumber');
        
        mcCheck1.allSelecttedValues.add('Plumber');
        mcCheck1.allSelecttedValues.add('Plumber');
        
        
        mcCheck1.allSchema=Schema.getGlobalDescribe();
        mcCheck1.allfield= mcCheck1.allSchema.get('Account').getDescribe().fields.getMap();
        fielddataType = mcCheck1.allfield.get('Party_type__c').getDescribe().getType();
        fieldlable=mcCheck1.allfield.get('Party_type__c').getDescribe().getLabel();
        ApexPages.currentPage().getParameters().put('prmVal', '1');
        
        mcCheck1.addListMethod();
        
        mcCheck1.removeFilter();
        
        MapAccountUtility mcCheck2= new MapAccountUtility(sc);
        Schema.DisplayType fielddataType3;
        // string fieldlable;
        string fieldlable3;
        mcCheck2.selectedField='Party_type__c';
        mcCheck2.pickListValues.add('Plumber');
        mcCheck2.pickListValues.add('Dealer');
        
        
        mcCheck2.tempSelectedfield='Party_type__c';
        mcCheck2.selectedFieldList.add('Party_type__c');
        mcCheck2.selectedFieldList.add('Party_type__c');
        mcCheck2.selectedOperatorList.add('IN');
        mcCheck2.selectedOperatorList.add('NOT IN');
        mcCheck2.mapVal.put('Party_type__c','Plumber');
        mcCheck2.mapVal.put('Party_type__c','Dealer');
        mcCheck2.selectedFieldList.add('-None-');
        mcCheck2.selectedFieldList.add('Name');
        
        mcCheck2.filteredList.add('Plumber');
        mcCheck2.filteredList.add('Plumber');
        
        mcCheck2.allSelecttedValues.add('Plumber');
        mcCheck2.allSelecttedValues.add('Plumber');
        
        
        mcCheck2.allSchema=Schema.getGlobalDescribe();
        mcCheck2.allfield= mcCheck2.allSchema.get('Account').getDescribe().fields.getMap();
        fielddataType3 = mcCheck2.allfield.get('Party_type__c').getDescribe().getType();
        fieldlable3=mcCheck2.allfield.get('Party_type__c').getDescribe().getLabel();
        ApexPages.currentPage().getParameters().put('prmVal', '1');
        
        mcCheck2.addListMethod();
        
        mcCheck2.removeFilter();
     //   SecondaryWrapper scw=new SecondaryWrapper('jan',7.8);
       
        Test.stopTest(); 
        
        
    }
    
    
}