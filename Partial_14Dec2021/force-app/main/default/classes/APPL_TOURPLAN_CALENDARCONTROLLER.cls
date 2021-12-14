/*  
    Author: Satyanarayana
    Description : Tour Plan Page Controller : Create TourPlan for the Month and submit for approval to the Manager.
    Date : 01/03/2015    */
global class APPL_TOURPLAN_CALENDARCONTROLLER {
    
    public String UsrRolNme{get;set;}
    public String Rolepicklst{get;set;}
    public String UsrProfile{get;set;}
    public integer startDateMonth {get; set;}
    public integer startDateYear {get; set;}
    //public integer NO_OF_TOURPLANS {get; set;}
    public AP_Tour_Plan__c tourPlanInstance {get; set;}
    //public list<PromotionTypeWrapper> promotionWrapperSetting {get; set;}
    public string targetState {get; set;}
    public string lookupstring{get;set;}
    
    public list<string> promotionalValues {get; set;}
    public list<string> retailingValues {get; set;}
    public list<string> industrialValues {get; set;}
    public list<string> marketDevelopmentValues {get; set;}
    public list<string> primarySalesValue {get; set;}
    public string approvalStatus {get; set;}
    set<string> customSettingApiLabels;
    map<string, string> TargetApiLabelsMap;
    
    public string targetName {get; set;}
    public list<targetWrapperListClass> targetWrapperList_Promotional {get; set;}
    public list<targetWrapper> targetWrapperList_Retailing {get; set;}
    public list<targetWrapper> targetWrapperList_Industrial {get; set;}
    public list<targetWrapper> targetWrapperList_market {get; set;}
    public list<targetWrapper> targetWrapperList_primarySales {get; set;}
    
    public string PromotionType {get; set;}
    public list<string> allocatedStates {get; set;}
    public set<string> allocatedDistricts {get; set;}
    public Account account {get;set;}
   public List<SelectOption> Options {get; set;}
   
    //--------from lookuppopup page controller------------------------------------------------
   // the query string entered by the user
    public String query {get; set;}
    public String query2 {get; set;}
    public string dpacc{get;set;}
    // the matchin>g accounts
    public List<Account> accounts {get; set;}
     public List<User> userMeetingList {get; set;}
     public String searchUser {get; set;}  
    // has a search been executed?
    public Boolean doneLookup {get; set;}
    public static String BeatMasterName {get; set; }
   
      public List<Account> dealeraccounts {get; set;}
    
    // executes the search
    public void runQuery()
    {  
     System.debug('coming inside');
     System.debug('coming QUERY...'+query);
        accounts  = new List<Account>();
        query = query.trim();
        String nameCond = '%'+query+'%';
        String cond = query+'%';
        List<Account> searchResults= New List<Account>([SELECT Id,Name,District__c, State__c, Status__c, Party_type__c,Contact_Number_Mobile__c,city__C FROM Account WHERE status__c ='Existing' AND Party_Type__c = 'Distributor' AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR Contact_Number_Mobile__c LIKE :cond ) limit 500]);
           
        accounts.addAll(searchResults);
        System.debug('coming inside runQuery ' +accounts);
        
    }
        // executes the search
    public void runDealerQuery()
    {   System.debug('coming inside');
        dealeraccounts = new List<Account>();
        query2 = query2.trim();
        String nameCond = '%'+query2+'%';
        String cond = query2+'%';
        List<Account> searchResults= New List<Account>([SELECT Id,Name,District__c, State__c, Status__c, Party_type__c,Contact_Number_Mobile__c,city__C FROM Account WHERE status__c ='Existing' AND Recordtype.Name= 'Dealer' AND (Name LIKE :nameCond OR City__c LIKE :cond OR District__c LIKE :cond OR Contact_Number_Mobile__c LIKE :cond ) limit 500]);
           
        dealeraccounts .addAll(searchResults);
        System.debug('coming inside runQuery ' +dealeraccounts );
        
    }
 
     // executes the search
    public void runUserQuery()
    {   System.debug('coming inside');
     userMeetingList  = new List<User>();
     List<User> searchMeetingResults= New List<User>([SELECT id, Name, title,phone,Email  FROM User 
                                                      WHERE name LIKE: searchUser+'%' AND isActive=true limit 200]);
     
     userMeetingList.addAll(searchMeetingResults);
     System.debug('coming inside runQuery ' +userMeetingList);
     
    }
    //------------------------------------------------------
    
    public void distTest(){
        
        System.debug('$$$$$ tpl $$$$$'+ tourPlanInstance);
        
            
    }
    
   

  
  
   @RemoteAction
    public static string marketvalue(String dist){
   
    System.debug('*****'+dist);
    
    Map<String,NewDisitrictList__c> custMarket=NewDisitrictList__c.getAll();
   System.debug(dist);
   System.debug(custMarket.containsKey(dist.toUpperCase()));
    if(custMarket.containsKey(dist.toUpperCase())){
        return('New');
    }
    return('Existing');
    
    
        /*List<NewDisitrictList__c> lstdists=NewDisitrictList__c.get
        lstdists.addAll([select id from AP_Tour_Plan__c where State__c =:state AND District__c =:dist]);
        System.debug('ZZZZZ '+lstTour);
        if(lstTour.size()==0){
           return false;
        }else{
            return true;
        }*/
}
    
    
    
    
    
    public APPL_TOURPLAN_CALENDARCONTROLLER(Apexpages.Standardcontroller controller) {
        
        PromotionType = '';
        approvalStatus = '';
        targetName = '';
        Target__c targetInstance = new Target__c();
        targetWrapperList_Promotional = new list<targetWrapperListClass>();
        targetWrapperList_Retailing = new list<targetWrapper>();
        targetWrapperList_Industrial = new list<targetWrapper>();
        targetWrapperList_market = new list<targetWrapper>();
        targetWrapperList_primarySales = new list<targetWrapper>();
        TargetApiLabelsMap = new map<string, string>();
        customSettingApiLabels = new set<string>();
        promotionalValues = new list<String>();
        retailingValues   = new list<String>();
        industrialValues   = new list<String>();
        allocatedStates   = new list<string>();
        allocatedDistricts= new set<string>();
        marketDevelopmentValues = new list<string>();
        primarySalesValue = new list<string>();
        targetState = '';
        account = new Account();
        ///BeatMasterName=new String();
        beatMasters();
        tourPlanInstance = new AP_Tour_Plan__c();
        string targetId = controller.getId();
        if(targetId != null && targetId != '') {
        targetInstance = [select Name, Target_User__c, Approval_Status__c, State__c, Start_Date__c, Vertical__c, Dealers_Meet__c, Dealers_Factory_Visit__c, Dealers_Salesman_Meet__c, Group_Activity__c, Engineers_Meet__c, Exhibition__c, Mega_Plumbers_Meet__c, InSHOP_Plumber_meet__c, Plumber_Factory_Visit__c, Onsite_Plumber_Meet__c  from Target__c where id =: targetId];
        approvalStatus = targetInstance.Approval_Status__c;
        targetName = targetInstance.Name;
        targetState = targetInstance.State__c;
        tourPlanInstance.State__c = targetInstance.State__c;
        startDateMonth = targetInstance.Start_Date__c.month() - 1;
        startDateYear = targetInstance.Start_Date__c.year();
        User usr = new User();
        usr = [SELECT ID,UserRole.Name,Profile.Name,role__C FROM User WHERE ID =: UserInfo.getUserId()];
        UsrRolNme = usr.UserRole.Name;
        UsrProfile = usr.Profile.Name;
        Rolepicklst=usr.role__C;
        system.debug('-----------------------------My Role---------------------------------->'+UsrRolNme);
        system.debug('-----------------------------UsrProfile ---------------------------------->'+UsrProfile );
        system.debug('-----------------------------role__C ---------------------------------->'+Rolepicklst );
        
        } else {
            
            ApexPages.addMessage(new Apexpages.Message(ApexPages.Severity.Error,'[ERROR]Please populate TargetId.'));
        }
        // promotionWrapperSetting = new list<PromotionTypeWrapper>();
        
        /*if(targetInstance != null) {
for(User_Taluk_Master_Junction__c userTaluk : [select Record_Vertical__c, AP_Taluk_Master__r.State__c, AP_Taluk_Master__r.District__c from User_Taluk_Master_Junction__c where User__c =: targetInstance.Target_User__c and Record_Vertical__c =: targetInstance.Vertical__c]) {

allocatedStates.add(userTaluk.AP_Taluk_Master__r.State__c);
allocatedDistricts.add(userTaluk.AP_Taluk_Master__r.District__c);
}
}*/
        /*---accounts  = new List<Account>();
        List<Account> searchResults= New List<Account>([SELECT Id,Name,District__c, State__c, Status__c, Party_type__c FROM Account WHERE status__c ='Existing' AND Party_Type__c = 'Distributor' limit 500]);
           
        accounts.addAll(searchResults);---*/
        
        for(Visit_Promotion_type__c promotionTypes : [select KRA_Name__c, Promotion_Type__c, Vertical__c, Target_API__c from Visit_Promotion_type__c where Vertical__c =: targetInstance.Vertical__c]) {
            
            if(promotionTypes.KRA_Name__c == 'INFLUENCER MANAGEMENT' || promotionTypes.KRA_Name__c == 'PROMOTIONAL ACTIVITY' ) {
                //|| promotionTypes.KRA_Name__c == 'PROJECT DEVELOPMENT') {
                
                //PromotionType = (promotionTypes.KRA_Name__c == 'PROJECT DEVELOPMENT' ? 'Project Development' : promotionTypes.KRA_Name__c);
                promotionalValues.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
            } else if(promotionTypes.KRA_Name__c == 'RETAILING' || promotionTypes.KRA_Name__c == 'CHANNEL ENGAGEMENT' ) {
                
                retailingValues.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
            }   else if(promotionTypes.KRA_Name__c == 'INDUSTRIAL VISITS') {
                
                industrialValues.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
            }  else if(promotionTypes.KRA_Name__c == 'MARKET DEVELOPMENT' || promotionTypes.KRA_Name__c == 'PROJECT DEVELOPMENT') {
                
                PromotionType = promotionTypes.KRA_Name__c;
                marketDevelopmentValues.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
            } else if(promotionTypes.KRA_Name__c == 'PRIMARY SALES : (In Lacs)') {
                
                primarySalesValue.add(promotionTypes.Promotion_Type__c);
                customSettingApiLabels.add(promotionTypes.Target_API__c);
                TargetApiLabelsMap.put(promotionTypes.Promotion_Type__c, promotionTypes.Target_API__c);
            }
        }
        /*List<SelectOption> options = new List<SelectOption>();    
Schema.DescribeFieldResult fieldResult = Schema.sObjectType.Account.fields.Type.getSObjectField().getDescribe();    
List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();       
for( Schema.PicklistEntry f : ple)  {       
options .add(new SelectOption(f.getLabel(), f.getValue()));  
}*/
        //system.debug(customSettingApiLabels);
        if(customSettingApiLabels.size() > 0) {
            string targetQuery = 'Select ';
            
            for(string str : customSettingApiLabels) {
                targetQuery += str + ''+',';
            }
            targetQuery = targetQuery.removeEnd(',');
            targetQuery = targetQuery + ' from Target__c where id ='+'\''+targetId+'\'';
            Target__c targetQueryInstance = new Target__c();
            //System.debug('*********Interface Log object**************'+targetQuery);
            targetQueryInstance = database.query(targetQuery);
            integer j =0; // 10
            for(integer i = j; i < promotionalValues.size(); i++) {
                targetWrapperListClass targetwrapperList = new targetWrapperListClass();
                
                if((j+1) < promotionalValues.size()) {
                    targetWrapper tw = new targetWrapper();
                    tw.activityName = promotionalValues[j];
                    tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(promotionalValues[j])));
                    targetwrapperList.targetWrapper1 = tw;
                }
                
                if((j+1) < promotionalValues.size()) {
                    targetWrapper tw1 = new targetWrapper();
                    tw1.activityName = promotionalValues[j+1];
                    tw1.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(promotionalValues[j+1])));
                    targetwrapperList.targetWrapper2 = tw1;
                }
                if((targetwrapperList.targetWrapper1.activityName != null && targetwrapperList.targetWrapper1.activityName != '') || (targetwrapperList.targetWrapper2.activityName != null && targetwrapperList.targetWrapper2.activityName != '')) {
                    system.debug(targetwrapperList.targetWrapper1);
                    targetWrapperList_Promotional.add(targetwrapperList);
                }
                j += 2;
                //system.debug(j);
                //system.debug(targetWrapperList_Promotional.size());
                //system.debug(targetWrapperList_Promotional);
            }
            
            for(String str : retailingValues) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                targetWrapperList_Retailing.add(tw);
            }
            for(String str : industrialValues) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                targetWrapperList_Industrial.add(tw);
            }
            for(String str : marketDevelopmentValues) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                targetWrapperList_market.add(tw);
            }
            
            for(String str : primarySalesValue) {
                targetWrapper tw = new targetWrapper();
                tw.activityName = str;
                tw.targetValue = string.valueOf(targetQueryInstance.get(TargetApiLabelsMap.get(str)));
                targetWrapperList_primarySales.add(tw);
            }
            
        }
        
        
        /*for(Visit_Promotion_type__c promotionCusSetting : [select Promotion_Type__c, Target_API__c from Visit_Promotion_type__c where Vertical__c =: targetInstance.Vertical__c order by Sort_Order__c]) {

PromotionTypeWrapper proWrapperInstance = new PromotionTypeWrapper();
proWrapperInstance.promotionName = promotionCusSetting.Promotion_Type__c;
proWrapperInstance.targetValue = Integer.valueOf(targetInstance.get(promotionCusSetting.Target_API__c));
promotionWrapperSetting.add(proWrapperInstance);
system.debug(promotionWrapperSetting);

} */
    }
    
    public class targetWrapperListClass {
        
        public targetWrapper targetWrapper1 {get; set;}
        public targetWrapper targetWrapper2 {get; set;}
        
        public targetWrapperListClass() {
            
            targetWrapper1 = new targetWrapper();
            targetWrapper2 = new targetWrapper();
        }
    }
    
    //Target Wrapper Class.
    public class targetWrapper {
        
        public string activityName {get; set;}
        public string targetValue {get; set;}
        
        public targetWrapper() {
            
            activityName = '';
            targetValue = '';
        }
    }
    
    /*public class PromotionTypeWrapper {

public string promotionName {get; set;}
public integer targetValue {get; set;}
public integer planningValue {get; set;}
public integer remainingValue {get; set;}

public PromotionTypeWrapper() {

promotionName = '';
targetValue = 0;
planningValue = 0;
remainingValue = 0;
}
}*/
 


   // Retreive state values
   @RemoteAction
   global static set<String> retreiveStateValues(string targetId) {
    
                //Getting State picklist values.
     Schema.DescribeFieldResult StateResult = User.Allocated_State__c.getDescribe();
     list<Schema.PicklistEntry> pro = StateResult.getPicklistValues();
     set<String> hiddenStates = new set<String>();
     for( Schema.PicklistEntry f : pro) {
        hiddenStates.add(f.getValue());
     }
     
     
        if(targetId != null) {
       User userData = [select Allocated_State__c from User where id =: [select Target_User__c from Target__c where id =: targetId].Target_User__c];
            //allocatedStates.remove(userData.Allocated_State__c);  
            for(string str : userData.Allocated_State__c.split(';')) {
                 hiddenStates.remove(str);
            }
        }
        return hiddenStates;
   } 
    
    //OnLoad retreive all the TourPlan records related to the Target.
    @RemoteAction
    global static list<tourPlanWrapper> retreiveTourRelatedTarget(string targetId) {
        
        list<tourPlanWrapper> tourplanList = new list<tourPlanWrapper>();
        
        for(AP_Tour_Plan__c tp : [select Date__c, Visit_Type__c,Beat_Name__c,Beat__c ,State__c, District__c, Location__c, Comments__c, Working_with__c, Promotional_Type__c, Holiday_Market_Closed__c ,Account__c from AP_Tour_Plan__c where Target__c =: targetId]) {
            
            System.debug('*********tp**************'+tp );
            tourPlanWrapper tpInstance = new tourPlanWrapper();
            tpInstance.sDate = string.valueOf(tp.Date__c);
            tpInstance.tourPlan = tp;
            tourplanList.add(tpInstance);
        }
        
        return tourplanList;   
    }
    
    //Change Status of Target on submission to Approval/Reject from AP_TOURPLAN_CALENDAR_APPROVAL Page. 
    @RemoteAction
    global static void saveTargetonApproval(string targetId, string Status, string approvedComments) {
        
        Target__c targetInstance = new Target__c(id=targetId, Approval_Status__c=Status, Approval_Comments__c=approvedComments);
        update targetInstance;
        
       /* if(taskId != null) {
            Task taskInstance = new Task(id=taskId, Status='Completed');
            update taskInstance;
        }*/
        
    }
    
    //Change Status of Target on submission to Reject from AP_TOURPLAN_CALENDAR_APPROVAL Page. 
    @RemoteAction
    global static void saveTargetonRejection(string targetId, string Status, string rejectComments) {
        
        Target__c targetInstance = new Target__c(id=targetId, Approval_Status__c=Status, Rejection_Comments__c=rejectComments);
        update targetInstance;
        
        /*if(taskId != null) {
            Task taskInstance = new Task(id=taskId, Status='Completed');
            update taskInstance;
        }*/    
    }
    
    @RemoteAction
    global static Target__c  returnTarget(string targetId) {
    
         Target__c tr = [SELECT ID,vertical__c FROM Target__c WHERE Id =:targetId];
         return tr;    
    }
    
    //Upsert TourPlan. 
    @RemoteAction
    global static tourPlanWrapper saveTourPlan(string tourPlanId,string targetId,string selectedDate, string prompType, string visitType, string x_State, string x_district, boolean holidayflag, boolean leaveflag, boolean mettingFlag, string mettingComments, string accId,string dealeraccId, String beatMasterVal) {
   // global static tourPlanWrapper saveTourPlan(string tourPlanId,string targetId,string selectedDate, string prompType, string visitType, string x_State, string x_district, string x_location, boolean holidayflag, boolean leaveflag, boolean mettingFlag, string mettingComments, string accId) {
        System.debug(targetId+'***&&*&&*');
        
        System.debug('holidayflag............'+holidayflag);
        System.debug('beatMasterVal@@@@@@..............................'+beatMasterVal);
        System.debug('leaveflag............'+leaveflag);
        System.debug('Dealer Name lookup............'+dealeraccId);
        System.debug('mettingFlag............'+mettingFlag);
        System.debug('mettingComments............'+mettingComments);
        tourPlanWrapper tpInstance;
       Target__c tr = [SELECT ID,vertical__c FROM Target__c WHERE Id =:targetId];
        System.debug(tr+'tr.......');
        try {
            AP_Tour_Plan__c tourPlanInstance = new AP_Tour_Plan__c();
            tourPlanInstance.Target__c = targetId;
            tourPlanInstance.Date__c = date.parse(selectedDate);
            if(!holidayflag && !leaveflag && !mettingflag) {
                
                string promVal = '';
                if(prompType != null && prompType != '') {
                    if(prompType.Substring(0,1)=='[')
                        prompType=prompType.Substring(1,prompType.length()-1);
                    for(string str : prompType.split(',')) {
                        promVal += str +';';
                    }
                    tourPlanInstance.Promotional_Type__c = promVal;
                }
                string visitVal = '';
                if(visitType != null && visitType != '' && visitType != '--None--') {
                    if(visitType.Substring(0,1)=='[')
                        visitType=visitType.Substring(1,visitType.length()-1);
                    for(string str : visitType.split(',')) {
                        for(string str1 : str.split('/')) {
                            visitVal += str1 +';';
                        }
                    }
                    tourPlanInstance.Visit_Type__c = visitVal;
                    system.debug(visitVal);
                    system.debug(tourPlanInstance.Visit_Type__c);
                } else {
                    
                    tourPlanInstance.Visit_Type__c = null;
                }
                
                tourPlanInstance.State__c = x_State;
                tourPlanInstance.District__c = x_district;
               // tourPlanInstance.Location__c = x_location;
                tourPlanInstance.Comments__c = '';
                /*..if(workinguser!=null){
                 tourPlanInstance.Working_with__c= workinguser;
                 system.debug(tourPlanInstance.Working_with__c);
                }--*/
                //tourPlanInstance.Account__c  = accId;
                if(dealeraccId != NULL && dealeraccId != '') {
                    tourPlanInstance.Dealer__c= dealeraccId;
                } 
            
                if(accId != NULL && accId != '') {
                    tourPlanInstance.Account__c = accId;
                } 
            } else {
                tourPlanInstance.Holiday_Market_Closed__c = holidayflag;
                System.debug('holiday checkbox od tourplan in record level............'+tourPlanInstance.Holiday_Market_Closed__c);
                 if(holidayflag) {
                 System.debug('holidayflag............'+holidayflag);
                
                    tourPlanInstance.Visit_Type__c = 'Holiday';
                    tourPlanInstance.Comments__c = '';
                } else if(leaveflag) {
                    tourPlanInstance.Visit_Type__c = 'Leave';
                    tourPlanInstance.Comments__c = '';
                } else if(mettingflag) {
                    tourPlanInstance.Visit_Type__c = 'Meetings/Training/Others';
                    tourPlanInstance.Comments__c = mettingComments;
                }
                tourPlanInstance.District__c = '';
                tourPlanInstance.Location__c = '';
                tourPlanInstance.Promotional_Type__c = '';
               /*if(accId != Null && accId != '') {
                    tourPlanInstance.Account__c =accId;
                } */
            }
            if(tourPlanId != null && tourPlanId != '') {
                tourPlanInstance.Id = tourPlanId;
            }
            if(beatMasterVal !=null && beatMasterVal !=''){
                System.debug('BeatMasterName'+BeatMasterName);
                      tourPlanInstance.Beat__c= beatMasterVal;

            }
           
            system.debug('tourPlanInstance...........'+tourPlanInstance);
            upsert tourPlanInstance;
            
            tpInstance = new tourPlanWrapper();
            tpInstance.sDate = string.valueOf(tourPlanInstance.Date__c);
            tpInstance.tourPlan =  [select Date__c,Beat__c, Visit_Type__c,Beat_Name__c, State__c, District__c, Location__c, Comments__c, Working_with__c, Promotional_Type__c, Holiday_Market_Closed__c ,Account__c from AP_Tour_Plan__c where Id =: tourPlanInstance.Id LIMIT 1];
           tpInstance.targt = tr; 
        } catch(Exception e) { system.debug('error---'+e.getMessage()); System.debug('Line number---'+e.getLineNumber()); }
        System.debug(tpInstance+'tpInstance@@@@@@@@@');
        return tpInstance;
    }
     
    
    global class tourPlanWrapper {
        
        public string sDate;
        public AP_Tour_Plan__c tourPlan;
        public Target__c targt;
        
        public tourPlanWrapper() {
            
            sDate = '';
            tourPlan = new AP_Tour_Plan__c();
            targt = new Target__c();
        }       
    }
    
    public void beatMasters(){
        
        Options=new List<SelectOption>();
        Options.add(new selectOption('--None--','--None--'));
        for(Beat_Master__c bmm:[select id,name From Beat_Master__c where OwnerId=: userInfo.getUserId()])
            
            Options.add(new selectOption(bmm.Id,bmm.name));
   
   
  // return Options;
    }
}