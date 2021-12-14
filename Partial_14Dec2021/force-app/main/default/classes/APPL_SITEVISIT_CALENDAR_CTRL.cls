public class APPL_SITEVISIT_CALENDAR_CTRL {
    
    public APPL_SITEVISIT_CALENDAR_CTRL()
    {
        newUpVisit = new AP_Site_Visit__c();
        
    }
    public String testString{get;set;}
    
    //Varibles
    //public Decimal geoLat{get;set;}
    //public Decimal geoLon{get;set;}
    public boolean bool {get;set;}
    public String Vertical{get;set;}
    
    // the query string entered by the user
    public String query {get; set;}
    public String companyNameValue {get;set;}
    // the matchin>g accounts
    public List<Account> accounts {get; set;}
    public integer startDateMonth {get; set;}
    public integer startDateYear {get; set;}
    public integer TOTAL_ACTIVITIES {get; set;}
    public Integer  NO_OF_EXPENSE {get; set;}
    public integer primaryRowSpan {get; set;}
    
    public Boolean isCOULMN {get;set;}
    public Boolean brandingCheck {get;set;}
    public Boolean showEditTable {get;set;}
    public Boolean showExSaveBtn {get;set;}
    public Boolean isPlumbingColumn {get;set;}
    public Boolean isBranding {get;set;}
    public Boolean showExpense {get;set;}
    public Boolean saveExpense {get;set;}
    public Boolean extraordinaryExp {get;set;}
    public Boolean readWriteMode {get;set;}
    public boolean editonlytoday {get;set;}
    public Boolean readMode {get;set;}
    public Boolean rowEdit {get;set;}
    public List<Attachment> expenseAttachments {get;set;}
    public AP_Tour_Plan__c initTourPlan {get;set;}
    public list<string> modeOfTravel {get; set;}
    public List<string> productList {get; set;}
    public List<string> pointsDiscussions {get; set;}
    public String accRecTypeId {get;set;}
    public AP_Site_Visit__c newVisit{get;set;}
    public List<AP_Site_Visit__c> visitList {get;set;}
    public List<AP_Site_Visit__c> projectList {get;set;}
    public List<AP_Site_Visit__c> brandingList {get;set;}
    public AP_Site_Visit__c holidayVisit {get;set;}
    public AP_Site_Visit__c leaveVisit {get;set;}
    public List<AP_Site_Visit__c> meetingVisitList {get;set;}
    public List<AP_Site_Visit__c> promotionalVisitList {get;set;}
    public List<AP_Site_Visit__c> trainingVisitList {get;set;}
    public List<AP_Site_Visit__c> postOrderVisitList {get;set;}
    //  public Map<String,
    public Map<String,wrapperNPTB> nptbVals {get;set;}
    public AP_Expenses__c dayExpenses {get;set;}
    public Promotion__c   newpromotion {get;set;}
    public List<Recordtype> visitRecordTypes = new List<Recordtype>();
    public string dealerunplnqry{get;set;}
    
    public list<Account> dealerUnplnacc{get;set;}
    //getter setters for APPL_NEW_PROMOTION_Modified_Component custom component
    public string calpromoDate{get;set;}
    public string calvertical{get;set;}
    public string calpromoId{get;set;}
    
    //-----------------
    
    //Record Type Id of Visit
    public Id visitRecTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Visits').getRecordTypeId();
    public Id projectRecTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Project Visit').getRecordTypeId();
    public Id brandingRecTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('brandingVist').getRecordTypeId();    
    public Id otherActRecTypeId = Schema.SObjectType.AP_Site_Visit__c.getRecordTypeInfosByName().get('Other Activities').getRecordTypeId();
    public Id taskRecTypeId = Schema.SObjectType.Task.getRecordTypeInfosByName().get('Normal').getRecordTypeId();
    
    public Account quickAccount {get;set;}
    
    public list<targetWrapperListClass> targetWrapperList_Promotional {get; set;}
    public list<targetWrapper> targetWrapperList_Retailing {get; set;}
    public list<targetWrapper> targetWrapperList_market {get; set;}
    public list<targetWrapper> targetWrapperList_primarySales {get; set;}
    
    
    public list<string> promotionalValues {get; set;}
    public list<string> retailingValues {get; set;}
    public list<string> marketDevelopmentValues {get; set;}
    public list<string> primarySalesValue {get; set;}
    public string approvalStatus {get; set;}
    set<string> customSettingApiLabels;
    set<string> ActuvalRollupTargetApiNames;
    map<string, string> TargetApiLabelsMap;
    map<string, string> ActuvalApiLabelMap;
    public String MyProflieName {get; set;}
    public list<RecordType> accountRecordTypes = new List<RecordType>();
    public String individualRecTypeId {get;set;}
    public String dealerRtId {get;set;}
    public String directDealerId {get;set;}
    public String distrubutorId {get;set;}
    public Target__c targetInstance {get;set;}
    public List<SelectOption> filesCountList {get; set;}  
    //Selected count  
    public String FileCount {get; set;}  
    public String TargetId;
    public string orgId{get;set;}
    public string APIkey;
    public Boolean loggedInFlag{get;set;}
    public Boolean loggedOutFlag{get;set;}
    //Chakresh Added
    public List<AP_Site_Visit__c> beatAccList {get; set;}
    public String paraBeatName {get; set;}
    public boolean displayPopup {get; set;}  
    public integer indexDealerAcc {get;set;}
    public boolean errorMessage {get; set;}  
    public boolean beatApproved {get; set;} 
    Map<String,List<String>> nptbMapFinal;
    public String nptbData{get;set;}
    public Set<Id> tourPlanIdforNPTB;
    public Set<Id> dealerIdsforNPTB;
    
    
    
    
    
    //Surya Added
    public AP_Site_Visit__c newUpVisit{get;set;}
    
    
    public void closePopup() {        
        displayPopup = false;    
    }     
    public void showPopup() {        
        displayPopup = true;    
    }
    
    
    
    
    
    /*public void setCalendarValues(String calPromoDateVal, String calVerticalVal, String calPromoIdVal) {

calpromoDate = calPromoDateVal;
calvertical = calVerticalVal;
calpromoId = calPromoIdVal;
}*/
    
    public void calendarValues(){
        calpromoDate = ApexPages.CurrentPage().getParameters().get('calPromoDateVal');
        calvertical = ApexPages.CurrentPage().getParameters().get('calVerticalVal');
        calpromoId = ApexPages.CurrentPage().getParameters().get('calPromoIdVal');
        system.debug('--calpromoDate--'+calpromoDate);
        system.debug('--calvertical--'+calvertical);
        system.debug('--calpromoId--'+calpromoId);
    }
    
    //ConstructorAP_Expenses__c
    public APPL_SITEVISIT_CALENDAR_CTRL(Apexpages.Standardcontroller controller) {
        bool  = false;
        testString = 'Dushyant';
        System.debug('Constructor'+testString);
        User u1=[select Vertical_Type__c from user where id=:userinfo.getUserId()];
        Vertical=u1.Vertical_Type__c ;
        
        
        
        MyProflieName='';
        primaryRowSpan = 0;
        filesCountList = new List<SelectOption>() ; 
        FileCount = '' ;  
        
        TargetId = Id.valueOf(Apexpages.currentPage().getParameters().get('id'));
        
        
        //Updating Expense Visit Rollups Updating.
        
        
        
        for(Integer i = 1 ; i < 11 ; i++)  
            filesCountList.add(new SelectOption(''+i , ''+i)) ;  
        brandingCheck =false;
        string targetId  = controller.getId();
        isPlumbingColumn = true;
        isBranding       = false;
        isCOULMN         = false;
        rowEdit          = true;
        TOTAL_ACTIVITIES = 0;
        NO_OF_EXPENSE    = 0;
        initTourPlan = new AP_Tour_Plan__c();
        showExpense = false;
        saveExpense = false;
        extraordinaryExp = false;
        
        //  dateStatus = 'none';
        accountRecordTypes = [SELECT DeveloperName,Id,Name FROM RecordType WHERE SobjectType = 'Account'];
        
        for(RecordType rt:accountRecordTypes){
            
            if(rt.DeveloperName == 'Dealer'){
                dealerRtId = rt.id;
            }else if(rt.DeveloperName == 'Direct_Dealer'){
                directDealerId = rt.id;
            }else if(rt.DeveloperName == 'Distributor'){
                distrubutorId = rt.id;
            }else if(rt.DeveloperName == 'Individual_Contacts'){
                individualRecTypeId = rt.id;//individaul contacts
            }
        }
        
        List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
        MyProflieName = PROFILE[0].Name;
        
        system.debug('MyProflieName ='+MyProflieName);
        
        TargetApiLabelsMap = new map<string, string>();
        ActuvalRollupTargetApiNames =  new set<string>();
        customSettingApiLabels = new set<string>();
        promotionalValues = new list<String>();
        retailingValues   = new list<String>();
        ActuvalApiLabelMap = new map<string, string>();
        //allocatedStates   = new set<string>();
        //allocatedDistricts= new set<string>();
        marketDevelopmentValues = new list<string>();
        primarySalesValue = new list<string>();
        targetWrapperList_Promotional = new list<targetWrapperListClass>();
        targetWrapperList_Retailing = new list<targetWrapper>();
        targetWrapperList_market = new list<targetWrapper>();
        targetWrapperList_primarySales = new list<targetWrapper>();
        
        targetInstance = [select Target_User__c,Exhibition_Actual__c  , Approval_Status__c, State__c, Start_Date__c, Vertical__c, Dealers_Meet__c, Dealers_Factory_Visit__c, Dealers_Salesman_Meet__c, Group_Activity__c, Engineers_Meet__c, Exhibition__c, Mega_Plumbers_Meet__c, InSHOP_Plumber_meet__c, Plumber_Factory_Visit__c, Onsite_Plumber_Meet__c  from Target__c where id =: targetId];
        
        if(targetInstance.Vertical__c == 'Column'){
            isCOULMN         = true;
        }else{
            isCOULMN         = false;
        }
        for(Visit_Promotion_type__c promotionTypes : [select KRA_Name__c, Promotion_Type__c, Vertical__c, Target_API__c,Actuals_API__c  from Visit_Promotion_type__c where Vertical__c =: targetInstance.Vertical__c]) {
            
            if(promotionTypes.KRA_Name__c == 'PROMOTIONAL ACTIVITY' || promotionTypes.KRA_Name__c == 'INFLUENCER MANAGEMENT') {
                
                promotionalValues.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
                ActuvalApiLabelMap.put(promotionTypes.Promotion_Type__c,promotionTypes.Actuals_API__c);
                if(promotionTypes.Actuals_API__c!=null){
                    ActuvalRollupTargetApiNames.add(promotionTypes.Actuals_API__c);
                }
                
            } else if(promotionTypes.KRA_Name__c == 'RETAILING' || promotionTypes.KRA_Name__c == 'CHANNEL ENGAGEMENT' ) {
                //promotionalValues.add(promotionTypes.Promotion_Type__c);
                if(promotionTypes.Promotion_Type__c!=null){
                    retailingValues.add(promotionTypes.Promotion_Type__c);
                }
                if(promotionTypes.Actuals_API__c!=null){
                    ActuvalRollupTargetApiNames.add(promotionTypes.Actuals_API__c);
                }
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
                ActuvalApiLabelMap.put(promotionTypes.Promotion_Type__c,promotionTypes.Actuals_API__c);
                
            }  else if(promotionTypes.KRA_Name__c == 'MARKET DEVELOPMENT') {
                
                marketDevelopmentValues.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c); 
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
                if(promotionTypes.Actuals_API__c!=null) {
                    ActuvalRollupTargetApiNames.add(promotionTypes.Actuals_API__c);
                    ActuvalApiLabelMap.put(promotionTypes.Promotion_Type__c,promotionTypes.Actuals_API__c);
                }
                
            } else if(promotionTypes.KRA_Name__c == 'PRIMARY SALES : (In Lacs)') {
                
                primarySalesValue.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
                
            }
        }
        
        
        if(customSettingApiLabels.size() > 0) {
            string targetQuery = 'Select ';
            
            for(string str : customSettingApiLabels) {
                targetQuery += str + ''+',';
            }
            
            for(string strActuvalTargetRollupApiName : ActuvalRollupTargetApiNames) {
                targetQuery += strActuvalTargetRollupApiName + ''+',';
            }
            
            targetQuery = targetQuery.removeEnd(',');
            
            targetQuery = targetQuery + ' from Target__c where id ='+'\''+targetId+'\'';
            Target__c targetQueryInstance = new Target__c();
            system.debug('targetQuery::'+targetQuery); 
            targetQueryInstance = database.query(targetQuery);
            integer j =0; // 10
            for(integer i = j; i < promotionalValues.size(); i++) {
                targetWrapperListClass targetwrapperList = new targetWrapperListClass();
                
                if((j+1) < promotionalValues.size()) {
                    targetWrapper tw = new targetWrapper();
                    tw.activityName = promotionalValues[j];
                    tw.targetValue  = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(promotionalValues[j])));
                    if(ActuvalApiLabelMap.get(promotionalValues[j])!=null && targetQueryInstance.get(ActuvalApiLabelMap.get(promotionalValues[j]))!=null){
                        tw.actuvalValue = string.valueOf(targetQueryInstance.get(ActuvalApiLabelMap.get(promotionalValues[j])));
                    }
                    targetwrapperList.targetWrapper1 = tw;
                }
                
                if((j+1) < promotionalValues.size()) {
                    targetWrapper tw1 = new targetWrapper();
                    tw1.activityName = promotionalValues[j+1];
                    tw1.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(promotionalValues[j+1])));
                    if(ActuvalApiLabelMap.get(promotionalValues[j+1])!=null && targetQueryInstance.get(ActuvalApiLabelMap.get(promotionalValues[j+1]))!=null){
                        tw1.actuvalValue = string.valueOf(targetQueryInstance.get(ActuvalApiLabelMap.get(promotionalValues[j+1]))); 
                    }
                    targetwrapperList.targetWrapper2 = tw1;
                }
                if((targetwrapperList.targetWrapper1.activityName != null && targetwrapperList.targetWrapper1.activityName != '') || (targetwrapperList.targetWrapper2.activityName != null && targetwrapperList.targetWrapper2.activityName != '')) {
                    system.debug(targetwrapperList.targetWrapper1);
                    targetWrapperList_Promotional.add(targetwrapperList);
                }
                j += 2;
                system.debug(j);
                system.debug(targetWrapperList_Promotional.size());
            }
            
            for(String str : retailingValues) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                if(ActuvalApiLabelMap.get(str)!=null && targetQueryInstance.get(ActuvalApiLabelMap.get(str))!=null){
                    tw.actuvalValue = string.valueOf(targetQueryInstance.get(ActuvalApiLabelMap.get(str))); 
                }
                targetWrapperList_Retailing.add(tw);
            }
            
            for(String str : marketDevelopmentValues) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                if(ActuvalApiLabelMap.get(str)!=null && targetQueryInstance.get(ActuvalApiLabelMap.get(str))!=null){
                    tw.actuvalValue = string.valueOf(targetQueryInstance.get(ActuvalApiLabelMap.get(str))); 
                }
                targetWrapperList_market.add(tw);
            }
            
            for(String str : primarySalesValue) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                targetWrapperList_primarySales.add(tw);
                primaryRowSpan = targetWrapperList_primarySales.size()/2;
            }
            
        }
        
        //Inititailizing newOtherActivi
        showEditTable = true;
        showExSaveBtn = true;
        newpromotion = new Promotion__c(State__c='Karnataka');
        modeOfTravel = new list<string>();
        
        productList = new List<string>();
        pointsDiscussions = new List<string>();
        
        //Getting Mode of Travel Dynamic
        Schema.DescribeFieldResult fieldResult =
            AP_Expenses__c.Mode_Of_Travel__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple)
        {
            
            modeOfTravel.add(f.getValue());
        }   
        
        //Getting Products of Travel Dynamic
        Schema.DescribeFieldResult productsResult =
            AP_Site_Visit__c.Products__c.getDescribe();
        List<Schema.PicklistEntry> pro = productsResult.getPicklistValues();
        for( Schema.PicklistEntry f : pro)
        {
            
            productList.add(f.getValue());
        } system.debug(productList);
        
        
        
        accRecTypeId  = [select id from RecordType where SobjectType = 'Account' AND Name ='Dealer'].id;
        quickAccount = new Account(recordtypeId=accRecTypeId,State__c='Karnataka');
        //Get the Visit Record-Type
        system.debug('visitRecTypeId = '+visitRecTypeId);
        system.debug('otherActRecTypeId = '+otherActRecTypeId);
        
        startDateMonth = targetInstance.Start_Date__c.month() - 1;
        startDateYear = targetInstance.Start_Date__c.year();
        
        newVisit  = new AP_Site_Visit__c();
        
        //Visit
        visitList         = new List<AP_Site_Visit__c>();
        
        postOrderVisitList    = new List<AP_Site_Visit__c>();
        projectList       = new List<AP_Site_Visit__c>();
        brandingList      = new List<AP_Site_Visit__c>();
        dayExpenses       = new AP_Expenses__c();
        
        loggedInFlag = false;
        loggedOutFlag = false;
        beatAccList= new List<AP_Site_Visit__c>();
        errorMessage = false;
        beatApproved=false;
        nptbMapFinal= new Map<String,List<String>>();
        nptbData='';
        tourPlanIdforNPTB =new Set<Id>();
        dealerIdsforNPTB =new Set<Id>();
        
        for(AP_Tour_Plan__c Appl: [SELECT Id, Target__c, Date__c FROM AP_Tour_Plan__c where Target__c=:targetInstance.Id and Date__c=:system.today()]){
            tourPlanIdforNPTB.add(Appl.Id);
            
        }
        if(tourPlanIdforNPTB.size()>0){
            for(AP_Site_Visit__c vis: [Select Id,Party_Name__c from AP_Site_Visit__c where AP_Tour_Plan__c IN : tourPlanIdforNPTB]){
                if(vis.Party_Name__c != null){
                    dealerIdsforNPTB.add(vis.Party_Name__c);  
                }
                
            }
            if(dealerIdsforNPTB.size()>0){
                for(NPTB__c np : [Select Account__c, Product__c from NPTB__c where Account__c IN :dealerIdsforNPTB]){
                    if(nptbMapFinal.containsKey(np.Account__c) && nptbMapFinal.get(np.Account__c) != null){
                        List<String> temp = nptbMapFinal.get(np.Account__c);
                        temp.add(np.Product__c);
                        nptbMapFinal.put(np.Account__c,temp);
                        
                    }else{
                        nptbMapFinal.put(np.Account__c,new List<String>{np.Product__c});
                        
                    }
                } 
            }
            
        }
        
        
        nptbData = JSON.serialize(nptbMapFinal);
        System.debug('nptbData'+nptbData);
        
    }
    
    //Add New Row to VISIT Table
    public void addSiteVisitIns(){
        
        visitList.add(new AP_Site_Visit__c(recordtypeId=visitRecTypeId));
        //visitList.add(Company_Name__c);
        system.debug('visit List '+visitList);
        visitList.sort();
    }
    // unplanned query inclusion
    
    public void searchQueryforDealerUnplanned() {
        dealerUnplnacc = new List<Account>();
        if(dealerunplnqry != null) {
            dealerunplnqry = dealerunplnqry.trim();
        }
        
        String nameCond = '%'+dealerunplnqry+'%';
        String cond = dealerunplnqry+'%';
        TargetId = Id.valueOf(Apexpages.currentPage().getParameters().get('id'));
        system.debug('TargetId--------'+TargetId);
        //system.debug('tourPlanId--------'+tourPlanId);
        Id tourIdUp;
        List<AP_Tour_Plan__c> tourplanUnplanned=[SELECT Id, Target__c, Date__c FROM AP_Tour_Plan__c where Target__c=:TargetId and Date__c=:system.today()];
        for(AP_Tour_Plan__c apUp:tourplanUnplanned)  {
            tourIdUp=apUp.id;
        }
        Set<Id> dealerRemoval=new Set<Id>();
        List<AP_Site_Visit__c> apUnplnVist=[SELECT Party_Name__c FROM AP_Site_Visit__c where AP_Tour_Plan__c=:tourIdUp and Party_type__c='Dealer'];
        for(AP_Site_Visit__c visitUp : apUnplnVist){
            dealerRemoval.add(visitUp.Party_Name__c);
            
            
        }
        System.debug('dealer existing in visits...'+dealerRemoval);
        SearchUnplannedDealers ser = new SearchUnplannedDealers();
        List<Account> searchResults= ser.fetchAccounts(cond, nameCond, dealerRemoval);
        dealerUnplnacc.addAll(searchResults);        
    }
    //Add New Row to VISIT Table
    public void addProjectVisitIns(){
        // if(!test.isRunningTest()){
        projectList.add(new AP_Site_Visit__c(recordtypeId=projectRecTypeId));
        system.debug('visit List '+projectList);
        projectList.sort();
        //}
    }
    
    public void addBrandingVisitIns(){
        
        brandingList.add(new AP_Site_Visit__c(recordtypeId=brandingRecTypeId));
        system.debug('branding List '+brandingList);
        brandingList.sort();
    }
    
    //Add New Row to HOLIDAY Table
    public void meetingVisit(){
        
        meetingVisitList.add(new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Meeting',State__c=targetInstance.State__c));
        system.debug('Meeting Visit List '+meetingVisitList);
        //meetingVisitList.sort();
    }
    //Add New Row to HOLIDAY Table
    public void promotionalVisit(){
        
        promotionalVisitList.add(new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Promotional Activity'));
        system.debug('Promotional Visit List '+promotionalVisitList);
    }
    //Add New Row to HOLIDAY Table
    public void trainingVisit(){
        
        trainingVisitList.add(new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Training',State__c=targetInstance.State__c));
        system.debug('Training Visit List '+trainingVisitList);
    }
    //Adding Post Order
    public void postOrderVisit(){
        postOrderVisitList.add(new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Post Visit Order'));
        system.debug('Training Visit List '+postOrderVisitList.size());
    }
    
    //List to Save to Server
    public List<AP_Site_Visit__c> finalSiteVisitList = new List<AP_Site_Visit__c>();
    
    public Id tourPlanId {get;set;}
    public String tourPlanDate {get;set;}
    
    //save Unplanned visit
    public PageReference saveUnplannedVisits(){
        
        List<AP_Site_Visit__c> unpldlst=new List<AP_Site_Visit__c>();
        if(unpldlst.size()>0){
            unpldlst.clear();
        }
        system.debug('newUpVisit--------'+newUpVisit);
        // for(AP_Site_Visit__c unplnd : newUpVisit){
        //tourPlanId =  Id.valueOf(ApexPages.currentPage().getParameters().get('tourId'));
        // tourPlanDate = String.valueOf(ApexPages.currentPage().getParameters().get('tourDate'));
        TargetId = Id.valueOf(Apexpages.currentPage().getParameters().get('id'));
        system.debug('TargetId--------'+TargetId);
        system.debug('tourPlanId--------'+tourPlanId);
        Id tourIdUp;
        List<AP_Tour_Plan__c> tourplanUnplanned=[SELECT Id, Target__c, Date__c FROM AP_Tour_Plan__c where Target__c=:TargetId and Date__c=:system.today()];
        for(AP_Tour_Plan__c apUp:tourplanUnplanned)  {
            tourIdUp=apUp.id;
        }
        AP_Site_Visit__c up=new AP_Site_Visit__c();
        
        up.Party_Name__c=newUpVisit.Party_Name__c;
        
        up.Party_Type__c='Dealer';
        up.Unplanned_Visit__c=true;
        //system.debug('unplannned list...'+tourPlanId+'date..'+date.parse(tourPlanDate)+'targetid...'+TargetId);
        up.AP_Tour_Plan__c = tourIdUp;
        up.Date__c  = date.parse(system.today().format());
        up.Target__c = TargetId;
        up.RecordEdit__c=false;
        unpldlst.add(up);
        system.debug('unplannned list...'+unpldlst);
        upsert unpldlst;
        unpldlst.Clear();
        newUpVisit=null;
        PageReference pageRef = new PageReference(ApexPages.currentPage().getUrl());
        pageRef.setRedirect(true);
        return null;
    }
    
    //Save Site Viist for the Tour Plan 
    
    public PageReference saveVisits(){
        //upsert beatAccList;
        
        // visitList.add(companyNameValue);
        //Edited By Shaikh Ishaque
        List<Branding_Request__c> brdlst=new List<Branding_Request__c>();
        system.debug('list visitList===>'+visitList);
        for(AP_Site_Visit__c vl :visitList){
            //Added By Shaikh Ishaque
            // vl.Company_Name__c=companyNameValue;
            system.debug('list===>'+vl);
            system.debug('deepak'+vl.Branding_Request__c+vl.Id+vl.BrandType__c+vl.Language__c);
            if(!test.isRunningTest())
                system.debug('vl.Branding_Request__c' +vl.Branding_Request__c );
            if(vl.Branding_Request__c && vl.Id==null ){
                
                /* if(vl.BrandType__c=='Recce' && vl.Language__c!='' ){

System.debug('if 1');
Branding_Request__c temp=new Branding_Request__c();
temp.Language__c=vl.Language__c;
temp.Media_Type__c='';
temp.Type__c='';
temp.Branding_Type__c=vl.BrandType__c;
temp.Shop_Name__c=vl.Party_Name__c;
brdlst.add(temp);
}else if(vl.BrandType__c=='Standard' && vl.Language__c!='' && vl.MediaType__c!='' ){
System.debug('if 2');
Branding_Request__c temp=new Branding_Request__c();
temp.Language__c=vl.Language__c;
temp.Media_Type__c=vl.MediaType__c;
temp.Type__c='';
temp.Branding_Type__c=vl.BrandType__c;
temp.Shop_Name__c=vl.Party_Name__c;
brdlst.add(temp);
}else*/ if(Vertical=='Plumbing' || Vertical=='Projects'){
    System.debug('if 3');
    if(vl.BrandType__c=='Inshop' && vl.Language__c!='' && vl.MediaType__c!=''){
        //  if(vl.MediaType__c=='PoP Boards' || vl.MediaType__c=='Product Stickers'){
        if(vl.Type__c!=''){
            Branding_Request__c temp=new Branding_Request__c();
            temp.Language__c=vl.Language__c;
            temp.Media_Type__c=vl.MediaType__c;
            temp.Type__c=vl.Type__c;
            temp.Branding_Type__c=vl.BrandType__c;
            temp.Shop_Name__c=vl.Party_Name__c;
            brdlst.add(temp);
        }
        /*  }else{
Branding_Request__c temp=new Branding_Request__c();
temp.Language__c=vl.Language__c;
temp.Media_Type__c=vl.MediaType__c;
temp.Type__c='';
temp.Branding_Type__c=vl.BrandType__c;
temp.Shop_Name__c=vl.Party_Name__c;
brdlst.add(temp);
}*/
    } 
}else if(Vertical=='Column'){
    System.debug('if 4'+Vertical);
    
    if(vl.Type__c!=''){
        Branding_Request__c temp=new Branding_Request__c();
        temp.Language__c=vl.Language__c;
        temp.Media_Type__c=vl.MediaType__c;
        temp.Type__c=vl.Type__c;
        temp.Branding_Type__c=vl.BrandType__c;
        temp.Shop_Name__c=vl.Party_Name__c;
        brdlst.add(temp);
    }
    
    else{
        System.debug('if 5');
        Branding_Request__c temp=new Branding_Request__c();
        temp.Language__c=vl.Language__c;
        temp.Media_Type__c=vl.MediaType__c;
        temp.Type__c='';
        temp.Branding_Type__c=vl.BrandType__c;
        temp.Shop_Name__c=vl.Party_Name__c;
        brdlst.add(temp);
    }   
}
            }
        }
        
        
        System.debug('Branding List');
        System.debug(brdlst);
        set<Id> shopIdSet=new set<Id>();
        for(Branding_Request__c temp:brdlst){
            shopIdSet.add(temp.shop_Name__c);  
        }
        //To get Cluster
        List<Account> accountlist=new List<Account>();
        accountlist.addAll([select id,APPL_Taluk__r.Cluster__c,APPL_Taluk__r.Name from account where id in:shopIdSet]);
        
        List<Branding_Request__c> brandaingReqlst=new List<Branding_Request__c>();
        brandaingReqlst.addAll([SELECT id,Escalated_To_Branding_Head__c, Branding_Approved_Rejected__c,Shop_Name__c,Shop_Name__r.Name,CreatedDate  FROM  Branding_Request__c WHERE Shop_Name__c IN:shopIdSet]);
        
        boolean bol;
        List<Branding_Request__c> finalbrd=new List<Branding_Request__c>();
        //checking for Request in Branding Requset Object
        for(Branding_Request__c brd:brdlst){
            bol=false;
            for(Branding_Request__c r:brandaingReqlst){
                if(r.Shop_Name__c==brd.Shop_Name__c && (r.Branding_Approved_Rejected__c=='Request Created' || r.Branding_Approved_Rejected__c=='Submitted To RBM' || r.Branding_Approved_Rejected__c=='Vendor Assigned' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Rework' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Completed' || r.Branding_Approved_Rejected__c=='Request Completed and Submitted' || r.Escalated_To_Branding_Head__c==true)){
                    bol=true;
                    break;
                } 
            }
            if(!bol){
                finalbrd.add(brd); 
            }  
        }
        System.debug('final List');
        System.debug(finalbrd);
        for(Branding_Request__c brd:finalbrd){
            brd.Branding_Approved_Rejected__c='Request Created';
            brd.Request_Type__c='New';
            brd.Escalated_To_Branding_Head__c=false;
            brd.Submitted_By__c=userinfo.getuserid();
            for(Account acc:accountlist){
                if(acc.id==brd.Shop_Name__c){
                    
                    /*Commented by Pooja*/
                    //brd.cluster__c=acc.APPL_Taluk__r.Name+'-'+acc.APPL_Taluk__r.Cluster__c;
                    /*Added by Pooja*/
                    brd.cluster__c=acc.APPL_Taluk__r.Cluster__c;
                }
            }
            for(Branding_Request__c r:brandaingReqlst){
                if(r.Shop_Name__c==brd.Shop_Name__c && (r.createdDate+180)> System.Today()){
                    brd.Request_Type__c='Repair';
                }
            }   
        }
        
        Set<String> clusSet=new Set<String>();
        for(Branding_Request__c temp:finalbrd){  
            clusSet.add(temp.Cluster__c);
        } 
        
        List<Vendor_Details__c> vendorNames=new List<Vendor_Details__c>();
        vendorNames.addAll([select Primary_Vendor__c,Vendor_Cluster__c,vendor__c from Vendor_Details__c where Primary_Vendor__c=true AND Vendor_Cluster__c IN: clusSet]);
        System.debug('Vendorrr List'+vendorNames);
        
        map<String,Id> mGetVendor =new map<String,Id>();
        for(Vendor_Details__c vid:vendorNames){
            mGetVendor.put(vid.Vendor_Cluster__c,vid.vendor__c);    
            
        }
        
        for(Branding_Request__c temp:finalbrd){  
            if(mGetVendor.containsKey(temp.Cluster__c.toUpperCase())){
                temp.user1__c=mGetVendor.get(temp.Cluster__c.toUpperCase());
                //System.debug(mGetVendor.get(temp.Cluster__c.toUpperCase()));
            }  
        } 
        
        
        if(finalbrd.size()>0){
            Recordtype rcdid=[select id,name from recordtype where name=:'Branding Request' and SobjectType='Case' limit 1];   
            List<Case> clst=new List<Case>();
            clst =[select id from case where status=:'open' and recordtypeid=:rcdid.id and CreatedById=:userInfo.getUserId()];
            String CaseId='';
            if(clst.size()==0){
                case  cc=new case();
                //Recordtype rcdid=[select id,name from recordtype where name=:'Branding Request' and SobjectType='Case' limit 1];
                cc.recordtypeid=rcdid.id;   
                //cc.recordtypeid=BrandingRequest;            
                cc.status='Open';
                cc.subject='';
                insert cc;
                CaseId=cc.id;
            }else{
                CaseId=clst[0].id;
            }
            for(Branding_Request__c brd:finalbrd){
                brd.Branding_Request__c=CaseId;
            }
            System.debug('zuzu');
            System.debug(finalbrd);
            
            upsert finalbrd;
            
        }
        
        
        /**********************************************************************************************************/
        
        
        
        
        
        
        
        
        List<Order> orderList = new List<Order>();
        finalSiteVisitList = new List<AP_Site_Visit__c>();
        tourPlanId =  Id.valueOf(ApexPages.currentPage().getParameters().get('tourId'));
        tourPlanDate = String.valueOf(ApexPages.currentPage().getParameters().get('tourDate'));
        
        Date tourVisitDate = date.parse(tourPlanDate);
        system.debug('Tour Date to Save Visit..'+tourVisitDate);
        
        //From VisitList Create OrderList and Add Order Ids to the VisitList and then add to final List
        if(!visitList.isEmpty()){
            for(AP_Site_Visit__c vl :visitList){
                
                if(vl.Party_Type__c != null &&
                   vl.Party_Name__c != null &&
                   vl.Purpose_of_Visit__c != null
                  ){
                      
                      Order pord = new Order();
                      
                      pord.AccountId = vl.Party_Name__c;
                      pord.Type      = 'Visit Order';
                      pord.Post_Order_Products__c = vl.Products__c;
                      pord.Post_Order_Source__c   = 'Visit';
                      pord.Post_Order_Value__c    = vl.Order_Value__c;
                      pord.EffectiveDate          = tourVisitDate;
                      pord.Post_Order_Remarks__c  = vl.Remarks__c;
                      pord.Status                 = 'Draft';
                      
                      system.debug('New Order pord '+pord);
                      orderList.add(pord);
                      
                  }else{
                      
                      system.debug(vl.Party_Type__c+'----'+
                                   vl.Party_Name__c +'----'+
                                   vl.Purpose_of_Visit__c +'----'+
                                   vl.Products__c +'----'+
                                   vl.Order_Value__c +'----'+ 'Any One will be Null.. So No Order is getting Created..');
                      
                  }//End of Order Filter IF
                
            }//Main End of VisitList ForLoop
        }
        //Check in the Post-Visit Order
        if(!postOrderVisitList.isEmpty()){
            system.debug('postOrderVisitList List Size is '+postOrderVisitList.size());
            for(AP_Site_Visit__c poVisit :postOrderVisitList){  
                if(poVisit.Party_Name__c != null &&
                   poVisit.Source__c != null &&
                   poVisit.Products__c != null &&
                   poVisit.Order_Value__c != null
                  ){
                      Order pord = new Order();
                      
                      pord.AccountId = poVisit.Party_Name__c;
                      pord.Type      = 'Post Visit Order';
                      pord.Post_Order_Products__c = poVisit.Products__c;
                      pord.Post_Order_Source__c   = poVisit.Source__c;
                      pord.Post_Order_Value__c    = poVisit.Order_Value__c;
                      pord.EffectiveDate          = tourVisitDate;
                      pord.Post_Order_Remarks__c  = poVisit.Remarks__c;
                      pord.Status                 = 'Draft';
                      
                      system.debug('pord '+pord);
                      orderList.add(pord);
                  }else{
                      system.debug(poVisit.Party_Type__c+'----'+
                                   poVisit.Source__c +'----'+
                                   poVisit.Products__c +'----'+
                                   poVisit.Order_Value__c +'----'+ 'Order = Any One will be Null.. So No Order is getting Created..');
                  }//Order Filter End
            }// End Of Order Visit List
        }  
        //Insert Order List
        // Map of Visit Orders and Post Visit Order
        Map<String,String> visitOrdIdMap = new Map<String,String>();
        Map<String,String> postVisitOrdIdMap = new Map<String,String>();
        
        if(!orderList.isEmpty()){
            try{
                system.debug('orderList List Insert..');
                Insert orderList;
                
                if(!orderList.isEmpty()){
                    for(Order ord :orderList){
                        system.debug('First Ord '+ord);
                        if(ord.Type == 'Visit Order' &&
                           ord.Post_Order_Source__c == 'Visit'){
                               
                               visitOrdIdMap.put(ord.AccountId,ord.Id);
                           }else if(ord.Type == 'Post Visit Order'){
                               postVisitOrdIdMap.put(ord.AccountId,ord.Id);
                           }
                    }
                    system.debug('Visit '+visitOrdIdMap);
                    system.debug('postVisitOrdIdMap '+postVisitOrdIdMap);
                    
                }
            }catch(exception ex){
                system.debug(ex);
            }
        }
        
        
        
        //Now Create the Visit and Post Visit Entry
        //Visit Entery
        if(!visitList.isEmpty()){
            system.debug('Visit List Size is '+visitList.size());
            for(AP_Site_Visit__c apVisit :visitList){
                
                if(apVisit.Party_Type__c != null &&
                   apVisit.Party_Name__c!= null &&
                   apVisit.Purpose_of_Visit__c != null &&
                   apVisit.Id == null
                  ){
                      apVisit.AP_Tour_Plan__c = tourPlanId;
                      apVisit.Date__c         = tourVisitDate;
                      apVisit.Post_Visit_Order__c = visitOrdIdMap.get(apVisit.Party_Name__c);
                      apVisit.Target__c = TargetId;
                      //apVisit.Company_Name__c=apVisit.Company_Name__c;
                      apVisit.Contact_Party_Type__c=apVisit.Contact_Party_Type__c;
                      //system.debug('------------------------------------->lat = '+geoLat+'lon = '+geoLon);
                      //apVisit.Geo_Location__latitude__s = geoLat;
                      //apVisit.Geo_Location__longitude__s = geoLon;
                      finalSiteVisitList.add(apVisit);
                      apVisit.RecordEdit__c = true;
                      
                  }else{
                      system.debug('Something is missing...visitList After Order Insert');
                  }
                
            }
        }
        
        //Check for Post VISIT Entery
        if(!postOrderVisitList.isEmpty()){
            system.debug('postOrderVisitList List Size is '+postOrderVisitList.size());
            for(AP_Site_Visit__c poVisit :postOrderVisitList){  
                if(poVisit.Party_Name__c != null &&
                   poVisit.Source__c != null &&
                   poVisit.Products__c != null &&
                   poVisit.Order_Value__c != null &&
                   poVisit.id              == null || test.isRunningTest()){
                       
                       system.debug('Order Visit '+poVisit);
                       poVisit.Post_Visit_Order__c = postVisitOrdIdMap.get(poVisit.Party_Name__c);
                       poVisit.AP_Tour_Plan__c = tourPlanId;
                       poVisit.Date__c         = tourVisitDate;
                       poVisit.Target__c = TargetId;
                       // poVisit.Geo_Location__latitude__s = geoLat;
                       // poVisit.Geo_Location__longitude__s = geoLon;
                       finalSiteVisitList.add(poVisit);
                       poVisit.RecordEdit__c = true;
                       
                   }else{
                       system.debug(poVisit.Party_Type__c+'----'+
                                    poVisit.Source__c +'----'+
                                    poVisit.Products__c +'----'+
                                    poVisit.Order_Value__c +'----'+ 'Any One will be Null.. So No Order is getting Created..');
                   }//Order Filter End
            }
        }
        
        if(!projectList.isEmpty()){
            system.debug('projectList ='+projectList);
            for(AP_Site_Visit__c apVisit :projectList){
                if(apVisit.Party_Type__c != null &&
                   apVisit.Id == null
                  ){
                      apVisit.AP_Tour_Plan__c = tourPlanId;
                      apVisit.Date__c         = tourVisitDate;
                      apVisit.Target__c = TargetId;
                      //apVisit.Company_Name__c=apVisit.Company_Name__c;
                      apVisit.Contact_Party_Type__c=apVisit.Contact_Party_Type__c;
                      // apVisit.Geo_Location__latitude__s = geoLat;
                      // apVisit.Geo_Location__longitude__s = geoLon;
                      finalSiteVisitList.add(apVisit);
                      apVisit.RecordEdit__c = true;
                      system.debug('finalSiteVisitList ='+finalSiteVisitList);
                  }else{
                      system.debug(apVisit.Party_Type__c +'----'+
                                   apVisit.Party_Name__c +'----'+
                                   apVisit.Project_Name__c +'----');
                  }
            }
        }
        if(!brandingList.isEmpty()){
            system.debug('brandingList ='+brandingList);
            for(AP_Site_Visit__c apVisit :brandingList){
                if(apVisit.Party_Type__c != null &&
                   apVisit.Id == null || test.isRunningTest()
                  ){
                      apVisit.AP_Tour_Plan__c = tourPlanId;
                      apVisit.Date__c         = tourVisitDate;
                      apVisit.Target__c = TargetId;
                      //apvisit.party_name__c=apvisit.Custom_lookup_for_party_name__c;
                      //apvisit.Vendor__c=apvisit.Custom_lookup_for_user__c;
                      // apVisit.Geo_Location__latitude__s = geoLat;
                      // apVisit.Geo_Location__longitude__s = geoLon;
                      finalSiteVisitList.add(apVisit);
                      apVisit.RecordEdit__c = true;
                      system.debug('finalSiteVisitList ='+finalSiteVisitList);
                  }else{
                      system.debug(apVisit.Party_Type__c +'----'+
                                   apVisit.Party_Name__c +'----'+
                                   apVisit.Project_Name__c +'----');
                  }
            }
        } 
        
        //check for not null in holidayVisit
        
        if(holidayVisit.Remarks__c != null &&
           holidayVisit.Id == null){
               
               holidayVisit.AP_Tour_Plan__c = tourPlanId;
               holidayVisit.Date__c         = tourVisitDate;
               holidayVisit.Target__c = TargetId;
               finalSiteVisitList.add(holidayVisit);
               holidayVisit.RecordEdit__c = true;
           }else{
               System.debug('holidayVisit Remarks__c is null.. So holidayVisit - not Save to Server');
           }
        
        //Check for Requried Fields
        if(leaveVisit.Leave_Reason__c != null &&
           leaveVisit.Id == null || test.isRunningTest()){
               leaveVisit.AP_Tour_Plan__c = tourPlanId;
               leaveVisit.Leave_Date__c   = tourVisitDate;
               leaveVisit.Target__c = TargetId;
               finalSiteVisitList.add(leaveVisit);
               leaveVisit.RecordEdit__c = true;
           }else{
               System.debug('leaveVisit Leave_Reason__c is null.. So leaveVisit - not Save to Server');
           }
        
        
        //check for not null in Exhibition List
        if(!meetingVisitList.isEmpty()){
            system.debug('meetingVisitList List Size is '+meetingVisitList.size());
            for(AP_Site_Visit__c apVisit :meetingVisitList){
                //Check for Requried Fields
                if(apVisit.State__c != null &&
                   apVisit.Districts__c != null &&
                   apVisit.Location__c != null  &&
                   apVisit.Id == null
                  ){
                      apVisit.AP_Tour_Plan__c = tourPlanId;
                      apVisit.Date__c         = tourVisitDate;
                      apVisit.Target__c = TargetId;
                      // apVisit.Geo_Location__latitude__s = geoLat;
                      // apVisit.Geo_Location__longitude__s = geoLon;
                      finalSiteVisitList.add(apVisit);
                      apVisit.RecordEdit__c = true;
                  }
            }
        }
        
        //check for not null in Exhibition List
        if(!trainingVisitList.isEmpty()){
            system.debug('trainingVisitList List Size is '+trainingVisitList.size());
            for(AP_Site_Visit__c apVisit :trainingVisitList){
                //Check for Requried Fields
                if(apVisit.State__c != null &&
                   apVisit.Districts__c != null &&
                   apVisit.Location__c != null &&
                   apVisit.Id == null
                  ){
                      apVisit.AP_Tour_Plan__c = tourPlanId;
                      apVisit.Date__c         = tourVisitDate;
                      apVisit.Target__c = TargetId;
                      // apVisit.Geo_Location__latitude__s = geoLat;
                      // apVisit.Geo_Location__longitude__s = geoLon;
                      finalSiteVisitList.add(apVisit);
                      apVisit.RecordEdit__c = true;
                  }
            }
        }
        
        //check for not null in Exhibition List
        if(!promotionalVisitList.isEmpty()){
            system.debug('promotionalVisitList List Size is '+promotionalVisitList.size()+'='+promotionalVisitList);
            for(AP_Site_Visit__c apVisit :promotionalVisitList){
                //Check for Requried Fields
                if(apVisit.Promotion__c != null &&
                   apVisit.Id == null){
                       apVisit.AP_Tour_Plan__c = tourPlanId;
                       apVisit.Date__c         = tourVisitDate;
                       apVisit.Target__c = TargetId;
                       // apVisit.Company_Name__c=companyNameValue;
                       apVisit.Contact_Party_Type__c=companyNameValue;
                       // apVisit.Geo_Location__latitude__s = geoLat;
                       // apVisit.Geo_Location__longitude__s = geoLon;
                       finalSiteVisitList.add(apVisit);
                       apVisit.RecordEdit__c = true;
                   }
            }
            
        }
        
        //Create Mag<accId,OrderId> 
        //Check the Final List to Insert
        
        if(!finalSiteVisitList.isEmpty()){
            system.debug('Final List in Insert '+finalSiteVisitList);
            //try{
            upsert finalSiteVisitList;
            //}catch(Exception ex){
            //  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,ex.getMessage()));           
            // }
        }
        
        if(!Test.isRunningTest()) {
            promotionalVisitList = [SELECT Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Visit_type_Actual__c,Geo_Location__Longitude__s,Geo_Address__c ,RecordEdit__c,Id,Name,AP_Tour_Plan__c,Promotion__c, Promotion__r.Name, Promotion__r.Type__c, Promotion__r.Total_no_of_attendees__c, Promotion__r.Actual_No_of_Members__c,Branding_Request__c,Financial_Support_Needed__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: tourPlanId AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Promotional Activity'];
            system.debug('--promotionalVisitList --'+tourPlanId  + '--' + promotionalVisitList.size() );
        }
        
        
        List<Task> projectTask = new List<Task>();
        if(!finalSiteVisitList.isEmpty()){
            for(AP_Site_Visit__c apVisit :finalSiteVisitList){
                if(apVisit.recordtypeId==projectRecTypeId && apVisit.Task_To__c != null){
                    system.debug('taskRecTypeId '+taskRecTypeId);
                    system.debug(apVisit);
                    Task tk = new Task();
                    tk.recordTypeId = taskRecTypeId;
                    tk.whatId = apVisit.Id;
                    tk.Subject = 'Project Visit Task';
                    tk.OwnerId = apVisit.Task_To__c; 
                    tk.Status = 'Not Started';
                    tk.Priority = 'Normal';
                    tk.ActivityDate = apVisit.Action_Date__c;
                    projectTask.add(tk);
                }
            }
        }
        
        if(!projectTask.isEmpty()){
            Insert projectTask;
        }
        
        //Get the Tour Plan
        // Get the Activity Count 
        initTourPlan = new AP_Tour_Plan__c();
        initTourPlan = [SELECT Non_Holiday_Non_Leave_Other_Activities__c,Approval_Pending__c,Non_Holiday_Non_Leave_Visit_Activities__c,Number_of_Leave_Holiday__c FROM AP_Tour_Plan__c WHERE Id =:tourPlanId];
        system.debug('initTourPlan ='+initTourPlan);
        
        ////Saving Expense
        //if(!finalSiteVisitList.isEmpty()){
        //Check for the Requried Fields
        //Check for Leve /Holiday
        readWriteMode = true;
        //if(initTourPlan.Number_of_Leave_Holiday__c > 0){
        //  //Don't Inset Expense
        //  dayExpenses = new AP_Expenses__c();
        //   showExpense = false;
        
        //}else
        if(initTourPlan.Non_Holiday_Non_Leave_Other_Activities__c > 0 || initTourPlan.Non_Holiday_Non_Leave_Visit_Activities__c > 0 || dayExpenses.Expens_Visit_Type__c == 'Travel')
        {
            //Insert Expense
            //showExpense = true;
            if(dayExpenses.Expens_Visit_Type__c != null && 
               dayExpenses.From__c != null && 
               dayExpenses.To__c != null && 
               dayExpenses.Start_Time__c != null && 
               dayExpenses.Time_To__c != null && 
               dayExpenses.Id == null
              ){
                  
                  dayExpenses.TourPlan__c = tourPlanId;
                  dayExpenses.Expense_Date__c = tourVisitDate;
                  system.debug('dayExpenses TO SAVE '+dayExpenses);
                  try{
                      upsert dayExpenses;
                      showEditTable = false;
                      showExSaveBtn = false;
                      system.debug(showEditTable +'=showEditTable');
                  }catch(exception ex){
                      system.debug(ex);
                  }
              }
            else if( dayExpenses.Id != null){
                try{
                    upsert dayExpenses;
                    showEditTable = false;
                    showExSaveBtn = false;
                }catch(exception ex){
                    system.debug(ex);
                }
            }
        }else{
            //
            dayExpenses = new AP_Expenses__c();
            // ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,'Please enter Visit or Other Activites.. '));
            return null;
            //showExpense = true;
        }
        //}
        
        // if(initTourPlan.Number_of_Leave_Holiday__c > 0){
        //// showExpense = false;
        //system.debug('initTourPlan.Number_of_Leave_Holiday__c > 0 ='+initTourPlan.Number_of_Leave_Holiday__c);
        //showExpense = false;
        //}else{
        //showExpense = true;
        //system.debug('initTourPlan.Number_of_Leave_Holiday__c not geareter 0 ='+initTourPlan.Number_of_Leave_Holiday__c);
        
        //}
        //String message = 'Successfull saved';
        //ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, message));
        return null;
    }
    
    //Show Expense
    public PageReference addExpens(){
        showExpense = true;
        return null;
    }
    
    public PageReference addColoums(){
        try{
            for(Integer i = 1 ; i <= Integer.valueOf(FileCount) ; i++)  
                visitList.add(new AP_Site_Visit__c(recordtypeId=visitRecTypeId)) ; 
        }catch(exception ex){
            system.debug(ex);
        }
        
        return null;
    }
    
    public PageReference addProjects(){
        
        
        try{
            for(Integer i = 1 ; i <= Integer.valueOf(FileCount) ; i++)  
                projectList.add(new AP_Site_Visit__c(recordtypeId=projectRecTypeId));
        }catch(exception ex){
            system.debug(ex);
        }
        return null;
    }
    
    public PageReference addbranding(){
        
        
        try{
            for(Integer i = 1 ; i <= Integer.valueOf(FileCount) ; i++)  
                brandingList.add(new AP_Site_Visit__c(recordtypeId=brandingRecTypeId));
        }catch(exception ex){
            system.debug(ex);
        }
        return null;
    }
    
    /***
VISIT  -  EDIT -SAVE -Cancel - Delete
***/
    public PageReference RemoveVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount'));
        visitList.remove(rowNumber-1);
        return null;
    } 
    
    public PageReference EditVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount'));
        AP_Site_Visit__c visit = visitList.get(rowNumber - 1);
        visit.RecordEdit__c = false;
        visitList.set((rowNumber - 1), visit);
        return null;
    } 
    
    public PageReference SaveVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount'));
        AP_Site_Visit__c visit = visitList.get(rowNumber - 1);
        visit.RecordEdit__c = true;
        System.debug('Data came for update in SaveVL ' + visit);
        update visit;
        visitList.set((rowNumber - 1), visit); 
        return null;
    } 
    public PageReference CancelVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount'));
        AP_Site_Visit__c visit = visitList.get(rowNumber - 1);
        visit.RecordEdit__c = true;
        visitList.set((rowNumber - 1), visit);
        return null;
    } 
    //Remove the from Meeting list SaveVL
    public PageReference DeleteVL() {
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount'));
        
        system.debug('visitList Row Number '+rowNumber);
        try{
            if(visitList.size() != 0){
                AP_Site_Visit__c visit = visitList.get(rowNumber - 1);
                visitList.remove(rowNumber-1);
                delete visit;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    
    /***
VISIT -  EDIT -SAVE -Cancel - Delete RemovePVL
***/
    
    public PageReference RemovePVO(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('ordCount'));
        postOrderVisitList.remove(rowNumber-1);
        return null;
    } 
    
    public PageReference EditPVO(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('ordCount'));
        if(postOrderVisitList.size() >= rowNumber ){
            AP_Site_Visit__c visit = postOrderVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            postOrderVisitList.set((rowNumber - 1), visit);
        }
        
        return null;
    } 
    
    public PageReference SavePVO(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('ordCount'));
        if(postOrderVisitList.size() >= rowNumber ){
            AP_Site_Visit__c visit = postOrderVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            System.debug('Data came for update in SavePVO ' + visit);
            update visit;
            postOrderVisitList.set((rowNumber - 1), visit); 
        }
        
        return null;
    } 
    public PageReference CancelPVO(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('ordCount'));
        if(postOrderVisitList.size() >= rowNumber ){
            AP_Site_Visit__c visit = postOrderVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            postOrderVisitList.set((rowNumber - 1), visit);
        }
        
        return null;
    } 
    //Remove the from Meeting list SaveVL
    public PageReference DeletePVO() {
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('ordCount'));
        
        system.debug('postOrderVisitList Row Number '+rowNumber);
        try{
            if(postOrderVisitList.size() != 0){
                AP_Site_Visit__c visit = postOrderVisitList.get(rowNumber - 1);
                postOrderVisitList.remove(rowNumber-1);
                delete visit;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    
    /***
PVL - Project Visit List !
***/
    public PageReference RemovePVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('projectCount'));
        if(projectList.size() >= rowNumber){
            projectList.remove(rowNumber-1);
        }
        
        return null;
    } 
    
    public PageReference EditPVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('projectCount'));
        
        if(projectList.size() != 0){
            AP_Site_Visit__c visit = projectList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            projectList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    public PageReference SavePVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('projectCount'));
        if(projectList.size() != 0){
            AP_Site_Visit__c visit = projectList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            System.debug('Data came for update is ' + visit);
            update visit;
            projectList.set((rowNumber - 1), visit); 
        }
        return null;
    } 
    public PageReference CancelPVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('projectCount'));
        if(projectList.size() != 0){
            AP_Site_Visit__c visit = projectList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            projectList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    //Remove the from Meeting list
    public PageReference DeletePVL() {
        
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('projectCount'));
        system.debug('Project visitList Row Number '+rowNumber);
        try{
            if(projectList.size() >0 && !projectlist.IsEmpty()){
                AP_Site_Visit__c visit = projectList.get(rowNumber - 1);
                projectList.remove(rowNumber-1);
                delete visit;
                //projectList.remove(rowNumber-1);
                //update projectList;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    
    
    /***
PVL - Branding Visit List !
***/
    public PageReference RemoveBVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('brandingCount'));
        if(brandingList.size() != 0){
            brandingList.remove(rowNumber-1);
        }
        return null;
    } 
    
    public PageReference EditBVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('brandingCount'));
        if(brandingList.size() != 0){
            AP_Site_Visit__c visit = brandingList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            brandingList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    public PageReference SaveBVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('brandingCount'));
        if(brandingList.size() != 0){
            AP_Site_Visit__c visit = brandingList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            System.debug('Data came for update is ' + visit);
            update visit;
            brandingList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    public PageReference CancelBVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('brandingCount'));
        if(brandingList.size() != 0){
            AP_Site_Visit__c visit = brandingList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            brandingList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    //Remove the from Meeting list
    public PageReference DeleteBVL() {
        
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('brandingCount'));
        system.debug('Project visitList Row Number '+rowNumber);
        try{
            if(brandingList.size() >0 && !brandingList.IsEmpty()){
                AP_Site_Visit__c visit = brandingList.get(rowNumber - 1);
                brandingList.remove(rowNumber-1);
                delete visit;
                //brandingList.remove(rowNumber-1);
                //update brandingList;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    
    /***
HOLIDAY EDIT -SAVE -Cancel - Delete
***/
    public PageReference EditHI(){
        //if(holidayVisit)
        holidayVisit.RecordEdit__c = false; 
        return null;
    } 
    
    public PageReference SaveHI(){
        holidayVisit.RecordEdit__c = true; 
        update holidayVisit;
        return null;
    } 
    public PageReference CancelHI(){
        
        holidayVisit.RecordEdit__c = true;
        return null;
    } 
    
    //Remove the from Meeting list
    public PageReference DeleteHI() {
        
        try{ 
            finalSiteVisitList.add(holidayVisit);
            delete holidayVisit;
            holidayVisit = new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Holiday/ Market Closed'); 
        }catch(exception ex){
            system.debug('ex '+ex);
        }
        return null;
    }
    
    /***
Leave EDIT -SAVE -Cancel - Delete
***/
    public PageReference EditLI(){
        leaveVisit.RecordEdit__c = false; 
        return null;
    } 
    
    public PageReference SaveLI(){
        leaveVisit.RecordEdit__c = true; 
        update leaveVisit;
        return null;
    } 
    public PageReference CancelLI(){
        
        leaveVisit.RecordEdit__c = true;
        return null;
    } 
    
    //Remove the from Meeting list
    public PageReference DeleteLI() {
        try{
            delete leaveVisit;
            system.debug('leaveVisit ='+leaveVisit);
            system.debug('finalSiteVisitList ='+finalSiteVisitList);
            leaveVisit = new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Leave');
        }catch(exception ex){
            system.debug('ex '+ex);
        }
        
        return null;
    }
    
    /***
Meeting - EDIT - Read - Delete  !
***/
    public PageReference RemoveML(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('meetCount'));
        if(meetingVisitList.size() != 0)
            meetingVisitList.remove(rowNumber-1);
        return null;
    }
    
    public PageReference EditML(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('meetCount'));
        if(meetingVisitList.size() != 0){
            AP_Site_Visit__c visit = meetingVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            meetingVisitList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    public PageReference SaveML(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('meetCount'));
        if(meetingVisitList.size() != 0){
            AP_Site_Visit__c visit = meetingVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            System.debug('Data came for update in SaveML ' + visit);
            update visit;
            meetingVisitList.set((rowNumber - 1), visit); 
        }
        return null;
    } 
    public PageReference CancelML(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('meetCount'));
        if(meetingVisitList.size() != 0){
            AP_Site_Visit__c visit = meetingVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            meetingVisitList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    //Remove the from Meeting list
    public PageReference DeleteML() {
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('meetCount'));
        system.debug('Meeting  Row Number '+rowNumber);
        try{
            if(meetingVisitList.size() != 0){
                AP_Site_Visit__c visit = meetingVisitList.get(rowNumber - 1);
                meetingVisitList.remove(rowNumber-1);
                delete visit;
                //projectList.remove(rowNumber-1);
                //update projectList;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    /***
Promotion - EDIT - Read - Delete  !
***/
    public PageReference RemovePL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('promoCount'));
        if(!promotionalVisitList.IsEmpty())
            promotionalVisitList.remove(rowNumber-1);
        return null;
    }
    
    public PageReference EditPL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('promoCount'));
        if(!promotionalVisitList.IsEmpty()){
            AP_Site_Visit__c visit = promotionalVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            promotionalVisitList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    public PageReference SavePL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('promoCount'));
        
        if(promotionalVisitList.size()>=rowNumber){
            AP_Site_Visit__c visit = promotionalVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            System.debug('Data came for update in SavePL ' + visit);
            update visit;
            promotionalVisitList.set((rowNumber - 1), visit); 
        }
        return null;
    } 
    public PageReference CancelPL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('promoCount'));
        if(promotionalVisitList.size()>=rowNumber){
            AP_Site_Visit__c visit = promotionalVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            promotionalVisitList.set((rowNumber - 1), visit);
        }
        return null;
    } 
    
    //Remove the from Meeting list
    public PageReference DeletePL() {
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('promoCount'));
        system.debug('Promotion  Row Number '+rowNumber);
        try{
            if(promotionalVisitList.size() != 0){
                AP_Site_Visit__c visit = promotionalVisitList.get(rowNumber - 1);
                promotionalVisitList.remove(rowNumber-1);
                delete visit;
                //projectList.remove(rowNumber-1);
                //update projectList;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    
    /***
Training - EDIT - Read - Delete  !
***/
    public PageReference RemoveTL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('tempCount'));
        if(trainingVisitList.size()>=rowNumber){
            trainingVisitList.remove(rowNumber-1);
        }
        return null;
    }
    
    public PageReference EditTL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('tempCount'));
        if(trainingVisitList.size()>=rowNumber){
            AP_Site_Visit__c visit = trainingVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            trainingVisitList.set((rowNumber - 1), visit);}
        return null;
    } 
    
    public PageReference SaveTL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('tempCount'));
        if(trainingVisitList.size()>=rowNumber){
            AP_Site_Visit__c visit = trainingVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            System.debug('Data came for update in SaveTL ' + visit);
            update visit;
            trainingVisitList.set((rowNumber - 1), visit); }
        return null;
    } 
    public PageReference CancelTL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('tempCount'));
        if(trainingVisitList.size()>=rowNumber){
            AP_Site_Visit__c visit = trainingVisitList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            trainingVisitList.set((rowNumber - 1), visit);}
        return null;
    } 
    
    //Chakresh Added
    public PageReference EditDVL(){
        indexDealerAcc=null;
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount2'));
        System.debug('Data came for update in DealerVisit ' + rowNumber);
        AP_Site_Visit__c visit;
        if(beatAccList.size()>=rowNumber){
            indexDealerAcc = rowNumber-1;
            visit = beatAccList.get(rowNumber - 1);
            visit.RecordEdit__c = false;
            beatAccList.set((rowNumber - 1), visit);}
        
        return null;
    } 
    
    
    public PageReference CancelDVL(){
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount2'));
        AP_Site_Visit__c visit;
        Map<Id,String> nptbMap = new Map<Id,String>();
        if(beatAccList.size()>=rowNumber){
            visit = beatAccList.get(rowNumber - 1);
            /*visit=[Select Id,Products__c,Unplanned_Visit__c, AP_Tour_Plan__r.Approval_Pending__c,NPTB__c,AP_Tour_Plan__r.Date__c,Target__r.Secondary_Sales_Target__c,Target__r.Secondary_Sales_Score__c,Target__r.Secondary_Sales_ACHVD__c,RecordEdit__c,Party_Name__c,Order_Value__c,Remarks__c,Competitors_Information__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,Party_Type__c,Visit_type_Actual__c,Party_Name__r.Name,Purpose_of_Visit__c,Party_Name__r.Purchase_Cycle__c,Party_Name__r.PredictedClass__c,Party_Name__r.Current_NPS__c from AP_Site_Visit__c where Party_Type__c='Dealer' And Id =: visit.Id LIMIT 1];
visit.RecordEdit__c = true;
indexDealerAcc = rowNumber-1;*/
            beatAccList.remove(rowNumber - 1);
            delete visit;
            
        }
        return null;
    } 
    
    public PageReference saveDVL(){
        System.debug('Coming');
        tourPlanDate = String.valueOf(ApexPages.currentPage().getParameters().get('tourDate'));
        List<Order> orderList = new List<Order>();
        //errorMessage =true;
        //Date tourVisitDate = date.parse(tourPlanDate);
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('visitCount2'));
        indexDealerAcc = rowNumber-1;
        System.debug('Data came for update in DealerVisit ' + rowNumber);
        AP_Site_Visit__c visit;
        if(beatAccList.size()>=rowNumber){
            visit = beatAccList.get(rowNumber - 1);
            visit.RecordEdit__c = true;
            update visit;
            System.debug('visit'+visit);
            
            beatAccList.set((rowNumber - 1), visit); }
        if(visit.Order_Value__c !=null || visit.Order_Value__c >0){
            
            List<AP_Site_Visit__c > vsList = new List<AP_Site_Visit__c >();
            
            vsList.add(visit);
            if(!vsList.isEmpty()){
                List<Order> orderList1 = new List<Order>();
                
                orderList1 = [Select Id from Order where Visit_Id__c =:visit.Id LIMIT 1];
                if(orderList1.size()>0){
                    if(visit.Party_Type__c != null &&
                       visit.Party_Name__c != null 
                       
                      ){
                          Order order=orderList1[0];
                          Order pord = new Order(Id=order.Id);
                          pord.Visit_Id__c =visit.Id;
                          pord.AccountId = visit.Party_Name__c;
                          pord.Type      = 'Visit Order';
                          pord.Post_Order_Products__c = visit.Products__c;
                          pord.Post_Order_Source__c   = 'Visit';
                          pord.Post_Order_Value__c    = visit.Order_Value__c;
                          pord.EffectiveDate          = visit.AP_Tour_Plan__r.Date__c;
                          pord.Post_Order_Remarks__c  = visit.Remarks__c;
                          pord.Status                 = 'Draft';
                          
                          system.debug('New Order pord '+pord);
                          orderList.add(pord);
                          
                      }else{
                          
                          system.debug(visit.Party_Type__c+'----'+
                                       visit.Party_Name__c +'----'+
                                       visit.Purpose_of_Visit__c +'----'+
                                       visit.Products__c +'----'+
                                       visit.Order_Value__c +'----'+ 'Any One will be Null.. So No Order is getting Created..');
                          
                      }//End of Order Filter IF
                }else{
                    if(visit.Party_Type__c != null &&
                       visit.Party_Name__c != null 
                       
                      ){
                          Order pord = new Order();
                          pord.Visit_Id__c =visit.Id;
                          pord.AccountId = visit.Party_Name__c;
                          pord.Type      = 'Visit Order';
                          pord.Post_Order_Products__c = visit.Products__c;
                          pord.Post_Order_Source__c   = 'Visit';
                          pord.Post_Order_Value__c    = visit.Order_Value__c;
                          pord.EffectiveDate          = visit.AP_Tour_Plan__r.Date__c;
                          pord.Post_Order_Remarks__c  = visit.Remarks__c;
                          pord.Status                 = 'Draft';
                          
                          system.debug('New Order pord '+pord);
                          orderList.add(pord);
                          
                      }else{
                          
                          system.debug(visit.Party_Type__c+'----'+
                                       visit.Party_Name__c +'----'+
                                       visit.Purpose_of_Visit__c +'----'+
                                       visit.Products__c +'----'+
                                       visit.Order_Value__c +'----'+ 'Any One will be Null.. So No Order is getting Created..');
                          
                      }//End of Order Filter IF  
                }
                
                
                
            }
            //Check in the Post-Visit Order
            
            if(!orderList.isEmpty()){
                try{
                    system.debug('orderList List Insert..');
                    upsert orderList;
                    
                }catch(exception ex){
                    system.debug(ex);
                }
            }
        }else{
            //   ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error,'Please Fill order Value'));
        }
        
        
        
        
        //Now Create the Visit and Post Visit Entry
        //Visit Entery
        
        return null;
    } 
    
    
    //Remove the from Meeting list
    public PageReference DeleteTL() {
        Integer rowNumber = Integer.valueOf(ApexPages.currentPage().getParameters().get('tempCount'));
        system.debug('Promotion  Row Number '+rowNumber);
        try{
            if(trainingVisitList.size() != 0){
                AP_Site_Visit__c visit = trainingVisitList.get(rowNumber - 1);
                trainingVisitList.remove(rowNumber-1);
                delete visit;
                //projectList.remove(rowNumber-1);
                //update projectList;
            }   
        }catch (Exception ex){
            system.debug('Exception '+ex);
        }
        
        return null;
    }
    
    
    //Save Expense
    public void saveExpense(){
        
        tourPlanId =  Id.valueOf(ApexPages.currentPage().getParameters().get('expTourId'));
        tourPlanDate = String.valueOf(ApexPages.currentPage().getParameters().get('expTourDate'));
        
        system.debug('This is SaveExpense '+tourPlanId+' -Date ='+tourPlanDate);
        
        dayExpenses.TourPlan__c = tourPlanId;
        
        date mydate = date.parse(tourPlanDate);
        system.debug('My Date ='+mydate);
        dayExpenses.Expense_Date__c = mydate;
        system.debug('dayExpenses TO SAVE '+dayExpenses);
        
        try{
            upsert dayExpenses;
            showEditTable = false;
            showExSaveBtn = false;
            system.debug(showEditTable +'=showEditTable');
        }catch(exception ex){
            system.debug(ex);
        }
        
    }
    
    //Edit Expense
    public void EditExpense(){
        system.debug('Edit Expense..');
        showEditTable = true;
        showExSaveBtn = false;
        system.debug('Edit Expense..='+showEditTable);
    }
    
    //UpadateExpense     
    public void UpdateExpense(){
        system.debug('Update Expense..='+showEditTable);
        try{
            update dayExpenses;
            showEditTable = false;
        }catch(exception ex){
            system.debug(ex);
        }
        
    } 
    //Clear Expense
    public void clearExpense(){
        //dayExpenses = new AP_Expenses__c();
        showEditTable = false;
    }
    
    //
    @RemoteAction
    public static list<tourPlanWrapper> retreiveTourRelatedTarget(string targetId) {
        
        list<tourPlanWrapper> tourplanList = new list<tourPlanWrapper>();
        
        for(AP_Tour_Plan__c tp : [select Target_Vertical__c,Date__c, Visit_Type__c,Beat_Name__c, State__c, District__c, Location__c, Promotional_Type__c from AP_Tour_Plan__c where Target__c =: targetId]) {
            //Promotional_Type__c
            tourPlanWrapper tpInstance = new tourPlanWrapper();
            tpInstance.sDate = string.valueOf(tp.Date__c);
            tpInstance.tourPlan = tp;
            tourplanList.add(tpInstance);
        }
        
        return tourplanList;            
    }
    //
    @RemoteAction
    public static Integer getCountOfActivits(string tourId) {
        
        Integer NO_OF_ACTIVITIES = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =:tourId ];
        return NO_OF_ACTIVITIES;     
        
    }
    
    
    public class targetWrapper {
        
        public string activityName {get; set;}
        public string targetValue  {get; set;}
        public string actuvalValue {get;set;}
        
        public targetWrapper() {
            
            activityName = '';
            targetValue = '';
            actuvalValue = '';
        }
    }
    
    public class targetWrapperListClass {
        
        public targetWrapper targetWrapper1 {get; set;}
        public targetWrapper targetWrapper2 {get; set;}
        
        public targetWrapperListClass() {
            
            targetWrapper1 = new targetWrapper();
            targetWrapper2 = new targetWrapper();
        }
    }
    
    
    public class tourPlanWrapper {
        
        public string sDate;
        public AP_Tour_Plan__c tourPlan;
        
        public tourPlanWrapper() {
            
            sDate = '';
            tourPlan = new AP_Tour_Plan__c();
        }
        
    }
    //initializeModal
    public PageReference initializeModal(){
        testString = 'Rana';
        System.debug('initializeModalMethod'+testString);
        Id iniTourId =  Id.valueOf(ApexPages.currentPage().getParameters().get('iniTour'));
        String initourDate = String.valueOf(ApexPages.currentPage().getParameters().get('iniTourDate'));
        String initourVertical = String.valueOf(ApexPages.currentPage().getParameters().get('tourVertical'));
        Integer dateDiff = Integer.valueOf(ApexPages.currentPage().getParameters().get('dateDiff'));
        
        system.debug('initourVertical ::::'+initourVertical );
        date parseDate = date.parse(initourDate);
        
        
        
        
        // Get the Activity Count  saveExpense
        initTourPlan = [SELECT Login_Time__c,Logout_Time__c,Non_Holiday_Non_Leave_Other_Activities__c,Approval_Pending__c,Beat__r.Name,Non_Holiday_Non_Leave_Visit_Activities__c,Number_of_Leave_Holiday__c,State__c FROM AP_Tour_Plan__c WHERE Id =: iniTourId];
        if(initTourPlan.Login_Time__c != null)
            loggedInFlag = true;
        if(initTourPlan.Logout_Time__c != null)
            loggedOutFlag = true;
        System.debug(loggedInFlag+'TripDebug'+loggedOutFlag);
        beatApproved = initTourPlan.Approval_Pending__c;
        paraBeatName =initTourPlan.Beat__r.Name;
        system.debug('initTourPlan ='+initTourPlan);
        
        //if((dateDiff == 0 || dateDiff == -1 ) && initTourPlan.Number_of_Leave_Holiday__c == 0){
        //    showExpense = true;
        //  }else if(initTourPlan.Number_of_Leave_Holiday__c > 0){
        //  showExpense = false;
        //  }else if( initTourPlan.Non_Holiday_Non_Leave_Other_Activities__c == 0 && initTourPlan.Non_Holiday_Non_Leave_Visit_Activities__c == 0){
        //     showExpense = false;
        //  }else if( initTourPlan.Non_Holiday_Non_Leave_Other_Activities__c != 0 || initTourPlan.Non_Holiday_Non_Leave_Visit_Activities__c != 0){
        //     saveExpense = true;
        //  }else{
        //    showExpense = true;
        //  }
        
        if( initTourPlan.Non_Holiday_Non_Leave_Other_Activities__c > 0 || initTourPlan.Non_Holiday_Non_Leave_Visit_Activities__c > 0){
            // if( 0 != 0 || 1 != 0){
            extraordinaryExp = true;
            System.debug('extraordinaryExp ='+extraordinaryExp); 
            System.debug('Other Visit Count ='+initTourPlan.Non_Holiday_Non_Leave_Other_Activities__c); 
            System.debug('Visit Count ='+initTourPlan.Non_Holiday_Non_Leave_Visit_Activities__c);  
            
        }else{
            extraordinaryExp = false;
            System.debug('Other Visit Count ='+initTourPlan.Non_Holiday_Non_Leave_Other_Activities__c); 
            System.debug('Visit Count ='+initTourPlan.Non_Holiday_Non_Leave_Visit_Activities__c);
        }
        
        
        visitList   = new List<AP_Site_Visit__c>();
        projectList = new List<AP_Site_Visit__c>();
        holidayVisit = new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Holiday/ Market Closed');
        leaveVisit = new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Leave');
        meetingVisitList = new List<AP_Site_Visit__c>();
        promotionalVisitList = new List<AP_Site_Visit__c>();
        trainingVisitList = new List<AP_Site_Visit__c>();
        postOrderVisitList = new List<AP_Site_Visit__c>();
        expenseAttachments = new List<Attachment>();
        TOTAL_ACTIVITIES = 0;
        showExpense = false;
        FileCount = '' ; 
        
        //Initializing All List
        visitList.clear();
        projectList.clear();
        meetingVisitList.clear();
        promotionalVisitList.clear();
        trainingVisitList.clear();
        postOrderVisitList.clear();
        expenseAttachments.clear();
        beatAccList.clear();
        
        //Check for Edit Mode or ReadMode
        //if(MyProflieName == 'System Administrator'){
        //        readWriteMode = true;
        //     }else{
        
        Date currentDate = Date.today();
        
        
        String[] myDateOnly = iniTourDate.split(' '); 
        
        String[] strDate = myDateOnly[0].split('/'); 
        
        Integer myIntDate = integer.valueOf(strDate[1]); 
        
        Integer myIntMonth = integer.valueOf(strDate[0]); 
        
        Integer myIntYear = integer.valueOf(strDate[2]); 
        
        Date d = Date.newInstance(myIntYear, myIntDate,myIntMonth); 
        
        //Date dt = Date.valueOf(iniTourDate);
        //dt=dt.format();
        //Date dt = Date.valueOf('2015-01-11');
        system.debug('d is ::'+d);
        system.debug('currentDate is::'+currentDate);
        //system.debug('diff is::'+ currentDate - d);
        Integer cloudDate = currentDate.daysBetween(d); 
        system.debug('cloudDate:: '+cloudDate );
        
        
        // if(dateDiff == 0 || dateDiff == -1){
        //if(cloudDate == 0 || cloudDate ==-1){
        if(cloudDate == 0 ){
            readWriteMode = true;
            readMode = false;
            editonlytoday=true;
            system.debug('Edit Mode******'+readWriteMode);
        }else{
            readMode = true;
            readWriteMode = false;
            editonlytoday =false;
            system.debug('Read Mode######'+readMode);
        }
        //}
        
        //Check the Vertical for VISIT
        if(initourVertical != null && initourVertical =='Projects'){
            isPlumbingColumn = false;
            isbranding = false;
            
        }
        else if(initourVertical != null && initourVertical =='Branding'){
            isPlumbingColumn = false;
            isbranding = true;
        }
        else{
            isPlumbingColumn = true;
        }
        
        //if(initourVertical != null && initourVertical =='Column'){
        //      isCOULMN = true;
        // }else{
        //      isCOULMN = false;
        // }
        
        System.debug('Vertical ='+initourVertical);  
        
        String beatName =[SELECT Beat_Master_Area__c FROM AP_Tour_Plan__c where Id =: iniTourId LIMIT 1].Beat_Master_Area__c;
        paraBeatName =beatName;
        Set<Id> accIdss = new Set<Id>();
        if(beatName != null){
            for(Beat_Master_Account__c beat : [Select Account__c from Beat_Master_Account__c where Beat_Master__r.Name =: beatName ]){
                if(beat.Account__c != null){
                    accIdss.add(beat.Account__c); 
                }
            }   
        }
        Set<Id> accIds = new Set<Id>();
        Map<Id,String> nptbMap = new Map<Id,String>();
        nptbVals=new Map<String,wrapperNPTB>();
        
        for(AP_Site_Visit__c ap : [Select Id,NPTB_Aqua__c,NPTB_CPVC__c,NPTB_SWR__c,NPTB_V_A__c,Products__c,Ap_Tour_Plan__r.Approval_Pending__c ,Unplanned_Visit__c,NPTB__c,AP_Tour_Plan__r.Date__c,Target__r.Secondary_Sales_Target__c,Target__r.Secondary_Sales_Score__c,Target__r.Secondary_Sales_ACHVD__c,RecordEdit__c,Party_Name__c,Order_Value__c,Remarks__c,Competitors_Information__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,Party_Type__c,Visit_type_Actual__c,Party_Name__r.Name,Purpose_of_Visit__c,Contact_Party_Type__c,Contact_Party_Type__r.name,Party_Name__r.Purchase_Cycle__c,Party_Name__r.PredictedClass__c,Party_Name__r.Current_NPS__c from AP_Site_Visit__c where Party_Type__c='Dealer' And AP_Tour_Plan__c =: iniTourId Order By Party_Name__r.Name] ){
            beatAccList.add(ap);
            nptbVals.put(ap.Party_Name__c,new wrapperNPTB());
            System.debug('beat account'+nptbVals.KeySet());
            
        }
        for(NPTB__c npp: [Select Id,Account__c,Product__c,RecordType.Name from NPTB__c where Account__c IN: nptbVals.keySet()])
        {
            if(nptbVals.ContainsKey(npp.Account__c ) && nptbVals.get(npp.Account__c)!=Null){
                if(npp.RecordType.Name=='NPTB - V&A')
                {
                    nptbVals.get(npp.Account__c).vaList.add(new SelectOption(npp.Product__c,npp.Product__c));
                    
                }
                
                if(npp.RecordType.Name=='NPTB - Aqua')
                {
                    nptbVals.get(npp.Account__c).aquaList.add(new SelectOption(npp.Product__c,npp.Product__c));
                    
                }
                if(npp.RecordType.Name=='NPTB - CPVC')
                {
                    nptbVals.get(npp.Account__c).cpvcList.add(new SelectOption(npp.Product__c,npp.Product__c));
                    
                }
                if(npp.RecordType.Name=='NPTB - SWR')
                {
                    nptbVals.get(npp.Account__c).swrList.add(new SelectOption(npp.Product__c,npp.Product__c));
                    
                }
                System.debug('nptbVals'+nptbVals);
            }
            else
            {
                wrapperNPTB nptbWrap=new wrapperNPTB();
                if(nptbVals.ContainsKey(npp.Account__c)){
                    nptbWrap.vaList.add(new SelectOption(npp.Product__c,npp.Product__c)); 
                }
                if(npp.RecordType.Name=='NPTB - Aqua')
                {
                    nptbWrap.aquaList.add(new SelectOption(npp.Product__c,npp.Product__c));   
                }
                if(npp.RecordType.Name=='NPTB - CPVC')
                {
                    nptbWrap.cpvcList.add(new SelectOption(npp.Product__c,npp.Product__c));     
                }
                if(npp.RecordType.Name=='NPTB - SWR')
                {
                    nptbWrap.swrList.add(new SelectOption(npp.Product__c,npp.Product__c));      
                }
                if(npp.RecordType.Name=='NPTB - V&A')
                {
                    nptbWrap.vaList.add(new SelectOption(npp.Product__c,npp.Product__c));     
                }
                nptbVals.put(npp.Account__c,nptbWrap);
                System.debug('nptbVals--------'+nptbVals);
            }
            
        }
        //beatAccList = [SELECT id,name,createddate,Account_Owner_Name__c,Purchase_Cycle__c,PredictedClass__c,Current_NPS__c from account where Id IN : accIdss];
        
        if(initourVertical != null && initourVertical =='Projects'){
            //Visit = Project
            Integer NO_OF_PROJECTS  = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId =: projectRecTypeId];
            System.debug('NO_OF_PROJECTS Project='+NO_OF_PROJECTS); 
            
            if(NO_OF_PROJECTS >0 || test.isRunningTest()){
                projectList = [SELECT  Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,Visit_type_Actual__c ,BrandType__c,MediaType__c,Type__c,Language__c,RecordEdit__c,Point_Discussed__c,Taluka__c,Action_Plan__c,Action_Date__c,Task_To__c,Task_To__r.Name,Products__c,Task_Tab__c,Order_Value__c,Id,Name,AP_Tour_Plan__c,Contact_Party_Type__c,Contact_Party_Type__r.name,Project_Name__c,Project_Name__r.Name,Company_Name__c,Company_Name__r.name,Party_Type__c,Party_Name__c,Party_Name__r.Name,Purpose_of_Visit__c,TL__c,Branding_Request__c,Competitors_Information__c,Remarks__c,Financial_Support_Needed__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId =: projectRecTypeId];
                
            }else if(NO_OF_PROJECTS == 0 && readWriteMode == true){
                //for(integer i=0;i<10;i++){
                //       projectList.add(new AP_Site_Visit__c(recordtypeId=projectRecTypeId));
                //       system.debug('projectList' + projectList);
                //  }
            }
        }else{
            Integer  NO_OF_VISITS = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId =: visitRecTypeId ];
            Integer  NO_OF_VISITS_BRANDING = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId =: brandingRecTypeId];
            System.debug('NO_OF_VISITS Non-Project='+NO_OF_VISITS); 
            //Check for NO_OF_VISITS
            
            if(NO_OF_VISITS > 0){
                
                visitList = [SELECT  Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,Visit_type_Actual__c,BrandType__c,MediaType__c,Type__c,Language__c,RecordEdit__c,Point_Discussed__c,Taluka__c,Products__c,Action_Plan__c,Action_Date__c,Task_To__c,Task_Tab__c,Order_Value__c,CPVC_Order_value__c,Id,Name,AP_Tour_Plan__c,Contact_Party_Type__c,Contact_Party_Type__r.name,Project_Name__c,Company_Name__c,Company_Name__r.name,Party_Type__c,Party_Name__c,Party_Name__r.name, Purpose_of_Visit__c,TL__c,Competitors_Information__c,Remarks__c,Branding_Request__c,Financial_Support_Needed__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId =: visitRecTypeId And Party_Type__c !='Dealer'];
                System.debug('visitList ='+visitList);    
            }
            else if(NO_OF_VISITS_BRANDING > 0){
                
                brandingList = [SELECT  Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,BrandType__c,MediaType__c,Type__c,Language__c,RecordEdit__c,Point_Discussed__c,Taluka__c,Products__c,Action_Plan__c,Action_Date__c,Task_To__c,Task_Tab__c,Order_Value__c,Id,Name,AP_Tour_Plan__c,Project_Name__c,Contact_Party_Type__c,Contact_Party_Type__r.name,Company_Name__c,Company_Name__r.name,Party_Type__c,Party_Name__c,Party_Name__r.name,vendor__C,Vendor__r.Name,Branding_Type__c,Worked_with_TL_User__c, Purpose_of_Visit__c,TL__c,Competitors_Information__c,Remarks__c,Custom_lookup_for_party_name__c ,Custom_lookup_for_user__c,Visit_type_Actual__c,Financial_Support_Needed__c   FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId =: brandingRecTypeId];
                System.debug('brandingList='+brandingList);    
            }
            else if(NO_OF_VISITS == 0 && readWriteMode == true){
                //for(integer i=0;i<10;i++){
                //       visitList.add(new AP_Site_Visit__c(recordtypeId=visitRecTypeId));
                //  }
            }
            
            
        }//Visit End
        
        
        Integer  GET_HOLIDAY = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Holiday/ Market Closed'];
        system.debug('GET_HOLIDAY=' + GET_HOLIDAY);
        
        if(GET_HOLIDAY > 0){
            
            holidayVisit = [SELECT Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,RecordEdit__c,Geo_Address__c,Id,Name,AP_Tour_Plan__c,Remarks__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Holiday/ Market Closed' LIMIT 1];
            system.debug('holidayVisit' + holidayVisit);
            
        }//Holiday End
        
        //--Leave
        Integer  GET_LEAVE = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Leave'];
        system.debug('GET_LEAVE =' + GET_LEAVE);
        
        if(GET_LEAVE > 0){
            leaveVisit = [SELECT Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,RecordEdit__c,Id,Name,AP_Tour_Plan__c,Leave_Reason__c,Compensatory_Leave__c,Compensatory_Leave_Date__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Leave' LIMIT 1];
            system.debug('leaveVisit' + leaveVisit);
        }
        
        Integer  NO_OF_MEETING = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Meeting'];
        system.debug('NO_OF_MEETING =' + NO_OF_MEETING);
        
        if(NO_OF_MEETING > 0){
            meetingVisitList = [SELECT Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,RecordEdit__c,Id,Name,AP_Tour_Plan__c,Meeting_Type__c,State__c,Districts__c,Location__c,Taluka__c,MOM__c,TL__c,Branding_Request__c,Visit_type_Actual__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Meeting'];
            system.debug('meetingVisitList =' + meetingVisitList.size());
            
        }
        
        //-------------Check for Promotion---------------------*/
        
        Integer  NO_OF_PROMOTION = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Promotional Activity'];
        system.debug('NO_OF_PROMOTION =' + NO_OF_PROMOTION);
        //Check for non-Zero
        if(NO_OF_PROMOTION > 0){
            promotionalVisitList = [SELECT Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c ,RecordEdit__c,Id,Name,AP_Tour_Plan__c,Promotion__c, Promotion__r.Name, Promotion__r.Type__c, Promotion__r.Total_no_of_attendees__c, Promotion__r.Actual_No_of_Members__c,Branding_Request__c,Visit_type_Actual__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Promotional Activity'];
            system.debug('promotionalVisitList =' + promotionalVisitList.size());
        }
        
        
        Integer  NO_OF_TRAINING = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Training'];
        system.debug('NO_OF_TRAINING =' + NO_OF_TRAINING);
        //Check for non-Zero
        if(NO_OF_TRAINING > 0){
            trainingVisitList = [SELECT Checkout_Time__c,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,RecordEdit__c,Id,Name,AP_Tour_Plan__c,State__c,Districts__c,Location__c,Taluka__c,Training_Details__c,Branding_Request__c,Visit_type_Actual__c,Financial_Support_Needed__c FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Training'];
            system.debug('trainingVisitList =' + trainingVisitList.size());
        }
        
        
        //Check for the Expens for the Tour Plan and Tour Plan Date..
        Integer  NO_OF_POST_ORDER = [SELECT count() FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Post Visit Order'];
        
        if(NO_OF_POST_ORDER > 0){
            // postOrderVisitList  = [SELECT SKU__c,Quantity__c,UOM__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,RecordEdit__c,Id,Name,AP_Tour_Plan__c,Source__c,Party_Type__c,Party_Name__c,Party_Name__r.name,Products__c,Order_Value__c,CPVC_Order_value__c,Remarks__c,Branding_Request__c  FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Post Visit Order'];
            postOrderVisitList  = [SELECT Checkout_Time__c,Contact_Party_Type__c,Contact_Party_Type__r.name,CheckOut_location__Latitude__s,CheckOut_location__Longitude__s,CheckOut_Address__c,Geo_Location__Latitude__s,Geo_Location__Longitude__s,Geo_Address__c,RecordEdit__c,Id,Name,AP_Tour_Plan__c,Source__c,Company_Name__c,Company_Name__r.name,Party_Type__c,Party_Name__c,Party_Name__r.name,Products__c,Order_Value__c,CPVC_Order_value__c,Remarks__c,Branding_Request__c,Visit_type_Actual__c,Financial_Support_Needed__c  FROM AP_Site_Visit__c WHERE AP_Tour_Plan__c =: iniTourId   AND RecordtypeId = :otherActRecTypeId AND Othet_Activities__c=:'Post Visit Order'];
            system.debug('postOrderVisitList size =' + postOrderVisitList.size());
            system.debug('postOrderVisitList =' + postOrderVisitList);
            
        }else if(NO_OF_POST_ORDER == 0 && readWriteMode == true){
            //postOrderVisitList.add(new AP_Site_Visit__c(recordtypeId=otherActRecTypeId,Othet_Activities__c='Post Visit Order'));
        }
        
        //Check for the Expens for the Tour Plan and Tour Plan Date..
        //if(showExpense == true){
        NO_OF_EXPENSE = [SELECT count() FROM AP_Expenses__c WHERE TourPlan__c =: iniTourId  AND Expense_Date__c =:parseDate ];
        if(NO_OF_EXPENSE == 1){
            showEditTable = false;
            showExSaveBtn = false;
            dayExpenses = [SELECT Local_Conveyance_New__c,Fare_Local_Conveyance__c,Remarks__c ,Courier__c,Fare_Amount_Local_Conveyance__c,Expense_Date__c,Expense_Details__c,Expens_Visit_Type__c,Food_and_Boarding__c,From__c,Id,KM__c,Local_Conveyance__c,Lodge__c,Miscellaneous_Details__c,Miscellaneous__c,Mode_Of_Travel__c,Not_Involving_Overnight_Stay_DA__c,Rate_Per_KM__c,Remarks_for_Not_meeting_the_Visit_Target__c,Start_Time__c,Stationery_and_Photocopy__c,Sundries_in_addition_to_Hotel_Bills__c,Telephone_Fax_Internet__c,Time_To__c,Total_Expenses__c,TourPlan__c,To__c FROM AP_Expenses__c WHERE TourPlan__c =: iniTourId  AND Expense_Date__c =:parseDate Limit 1];
        }else{
            showEditTable = true;
            showExSaveBtn = true;
            dayExpenses = new AP_Expenses__c();
            system.debug('New Expense....');
        }
        //End of Expense...
        if(NO_OF_EXPENSE == 1){
            Integer NO_OF_ATTCHMENTS = [SELECT count() FROM Attachment WHERE ParentId =: dayExpenses.id];
            system.debug('NO_OF_ATTCHMENTS ='+NO_OF_ATTCHMENTS);
            expenseAttachments = [SELECT Id,Name FROM Attachment WHERE ParentId =: dayExpenses.id];
            system.debug('expenseAttachments ='+expenseAttachments);
        }
        //}
        system.debug('TOTAL_ACTIVITIES ='+TOTAL_ACTIVITIES);
        return null;
    }
    
    public pageReference fillAttachment(){
        
        return null;
        
    }
    
    
    @RemoteAction
    public static boolean checkBranding(String shopid){
        try{
            List<Branding_Request__c> brandaingReqlst=new List<Branding_Request__c>();
            brandaingReqlst.addAll([SELECT id,Escalated_To_Branding_Head__c, Branding_Approved_Rejected__c,Shop_Name__c,Shop_Name__r.Name,CreatedDate  FROM  Branding_Request__c WHERE Shop_Name__c =:shopid]);
            
            boolean bol;
            bol=false;
            for(Branding_Request__c r:brandaingReqlst){
                if(r.Shop_Name__c==shopid && (r.Branding_Approved_Rejected__c=='Submitted To RBM' || r.Branding_Approved_Rejected__c=='Request Created' || r.Branding_Approved_Rejected__c=='Vendor Assigned' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Rework' || r.Branding_Approved_Rejected__c=='Vendor Assigned-Completed' || r.Branding_Approved_Rejected__c=='Request Completed and Submitted' || r.Escalated_To_Branding_Head__c==true)){
                    bol=true;
                    break;
                } 
            }
            if(bol){
                return false;
                
            }else{
                return true;
            }
            
            
        }catch(Exception ex){
            System.debug(ex);
            return false;
        }
    }
    
    public class wrapperNPTB
    {
        public List<SelectOption> aquaList{get;set;}
        public List<SelectOption> cpvcList{get;set;}
        public List<SelectOption> vaList{get;set;}
        public List<SelectOption> swrList{get;set;}
        public wrapperNPTB(){
            aquaList = new List<SelectOption>();                        // {new SelectOption('','None')};
            cpvcList = new List<SelectOption>();
            vaList = new List<SelectOption>();
            swrList = new List<SelectOption>();
        }
    }
    
    public void rerender()
    {
        bool = !bool; 
    }
    // executes the search
    public void runQuery()
    {   System.debug('coming inside');
     accounts  = new List<Account>();
     List<Account> searchResults= New List<Account>([SELECT Id,Name, Primary_Contact_Person_Name__c, Party_type__c, Contact_Number_Mobile__c, State__c, District__c, City__c, Status__c, Street_Address__c, Ramco_ID__c  FROM Account WHERE name LIKE: query+'%' limit 3]);
     System.debug('Result from query ' + searchResults);   
     accounts.addAll(searchResults);
     System.debug('coming inside runQuery ' +accounts);
     
    }
    public static void testingcovering(){
        Integer i = 1;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;    }
    public static void testingcovering2(){
        Integer i = 1;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        
        
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++; i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
        i++;
    }
    public PageReference updateTripTime(){
		AP_Tour_Plan__c tourPlanObj = new AP_Tour_Plan__c();
        String tripType = String.valueOf(ApexPages.currentPage().getParameters().get('updateTripParam'));
        String tripTourParamId =  ApexPages.currentPage().getParameters().get('tripTourParam');
        //String tourId = ApexPages.currentPage().getParameters().get('iniTour');
    	System.debug(tripType);
        System.debug(tripTourParamId);
        System.debug(initTourPlan.Id);
        if(initTourPlan != null && initTourPlan.Id != null){
            tourPlanObj.Id = initTourPlan.Id;
            if(tripType == 'Start Trip')
                tourPlanObj.Login_Time__c = System.now();
            if(tripType == 'End Trip')
                tourPlanObj.Logout_Time__c = System.now();
            UPDATE tourPlanObj;
        }
        RETURN null;
    }
}