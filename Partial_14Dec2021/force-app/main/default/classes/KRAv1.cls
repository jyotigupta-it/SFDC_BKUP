/*  
    Author: Satyanarayana
    Description : SMART KRA Controller : Generate SMART KRA Report for particular Month based on the User.
    Date : 21/06/2015  
    Modified by:Pooja
    Modified Date:07/12/2018  by SudhaMurthy ..... 13/07/2019  by SudhaMurthy */
    

public class KRAv1 {

 public static integer NUMBER_OF_YEARS = 2; // Smart KRA Report to access no. of years.
 private map < Integer, String > monthsMap = new map < Integer, String > {
  1 => 'January',
  2 => 'February',
  3 => 'March',
  4 => 'April',
  5 => 'May',
  6 => 'June',
  7 => 'July',
  8 => 'August',
  9 => 'September',
  10 => 'October',
  11 => 'November',
  12 => 'December'
 };
 public set < String > sT = new set < String > ();
 public String smartKRAQuery {get; set;}
 public List<User> smartKRAUserList{get;set;}
 public Target__c target {
  get;
  set;
 }
 public String selectedMonth {
  get;
  set;
 }
 public String selectedYear {
  get;
  set;
 }
 public list < SelectOption > months {
  get;
  set;
 }
 public list < SelectOption > years {
  get;
  set;
 }
 public list < PromotionalWrapper > retailing_WrapperList {
  get;
  set;
 }
 public list < PromotionalWrapper > promotional_WrapperList {
  get;
  set;
 }
 public list < PromotionalWrapper > market_WrapperList {
  get;
  set;
 }
 public list < PromotionalWrapper > sales_WrapperList {
  get;
  set;
 }
 public list < PromotionalWrapper > branding_WrapperList {
  get;
  set;
 }
 public boolean plumbingFlag {
  get;
  set;
 }
 public boolean projectFlag {
  get;
  set;
 }
 public boolean columnFlag {
  get;
  set;
 }
 public string targetVertical {
  get;
  set;
 }
 /*public string targetUserMarketype {
  get;
  set;
 }..*/
 public string targetUser {
  get;
  set;
 }
 public static string targetUserId {
  get;
  set;
 }
 public list < selectOption > UsersList {
  get;
  set;
 }
 public string profileName {
  get;
  set;
 }
 public list < user > usersIdList = new list < user > ();
 public double retailPercent {
  get;
  set;
 }
 public double promotionalPercent {
  get;
  set;
 }
 public double networkPercent {
  get;
  set;
 }
 public double salesPercent {
  get;
  set;
 }
 public double brandingPercent {
  get;
  set;
 }
 public Integer KRA_SelectedYear;
 public Integer KRA_SelectedMonth;
 public Integer KRA_NumberOfDays;
 public string KRA_TargetUserId = '';
 public static string UID = '';
 public Date startDateOfMonth;
 public Date endDateOfMonth;
 public string targetQuery;
 public Target__c targetInstance;
 public static List < User > userList;
 public static Map < Id, User > mapUser;
 public static User selectedUSR;
 public boolean selectSubordinates {
  get;
  set;
 }
 public set < string > tes = new set < string > ();
 public static list < target__c > targetLISTTL {
  get;
  set;
 }
 public integer count;
 public integer countVisit;

 //list<SelectOption> otherValues = new list<SelectOption>();
 public Map < String, List <
  case >>credMap = new Map < String, List <
  case >>();

// executes the search for "Smart KRA"
    public void runSmartKRAQuery()
    {    System.debug('coming inside');
       smartKRAUserList = new List<User>();
      list<User> KRAUsers= [select id, Name,title,phone,Email from User where name lIKE:smartKRAQuery +'%' limit 999]; 
           
        smartKRAUserList.addAll(KRAUsers);
        System.debug('coming inside runQuery ' +smartKRAUserList);
        
    }
    
 public KRAv1() {


   count = 0;
   countVisit = 0;
   userList = new List < User > ();
   mapUser = new Map < Id, User > ();
   targetQuery = '';
   targetInstance = new Target__c();
   Date currentDate = Date.today();
   selectedMonth = string.valueOf(currentDate.Month());
   selectedYear = string.valueOf(currentDate.year());
   plumbingFlag = false;
   columnFlag = false;
   projectFlag = false;
   selectSubordinates = false;
   targetVertical = '';
   //targetUserMarketype ='';
   targetUser = '';
   targetUserId = '';
   profileName = '';
   populateMonths();
   UID = targetUserId;
   UsersList = new list < selectOption > ();
   selectedUSR = new User();
   User LoggedInUser = new User();
   Id profileId = userinfo.getProfileId();
   profileName = [Select Id, Name from Profile where Id = : profileId].Name;

   if (profileName != 'System Administrator' && profileName != 'HO NEW' && profileName != 'Customer Support Team') {

    LoggedInUser = [select id, Name, Role__c from User where id = : UserInfo.getUserid()];
    UsersList.add(new SelectOption('', '--None--'));
    if (LoggedInUser.get('Role__c') != null) {
     UsersList.add(new SelectOption(LoggedInUser.Id, LoggedInUser.Name + ' - ' + LoggedInUser.Role__c));
    }
    usersIdList.add(LoggedInUser);

    while (usersIdList.size() > 0) {

     //usersIdList = querySubordinates(usersIdList);
     for (User u: querySubordinates(usersIdList)) {
      if (u.get('Role__c') != null) {
       UsersList.add(new selectOption(u.Id, u.Name + ' - ' + u.Role__c));
      }
      usersIdList.add(u);
     }
    }
   } else {
    targetLISTTL = new list < target__c > ();
    target = new Target__c();
   }
  }
  //***************************For getting all the subordinates*******************************
 public void initializeList() {
  String type1, type2, type3;
  type1 = 'BDM';
  type2 = 'SR-BDM';
  type3 = 'BDE';
  userList = [select id, ManagerId, Role__c from User where isActive = true and ManagerId != ''
   AND(Role__c = : type1 OR Role__c = : type2 OR Role__c = : type3)
  ];
  mapUser = new Map < Id, User > ();
  system.debug('get all users' + userList);
 }
 public void getAllUsers(String usrId) {
   system.debug('entering recursive 1st' + usrId);
   system.debug('get all users in recursive method&&&&&' + userList);
   for (User u: userList) {
    system.debug('current user id###############333' + u.id);
    if ((u.ManagerId == usrId) && (u.ManagerId != null)) {
     // mapUser.put(u.Id,u);
     system.debug('current user id!!!!!!!!!!!!!!!!11' + u.id);
     tes.add(u.id);
     system.debug('tes*************' + tes);
     getAllUsers(u.Id);

    }
   }
  }
  //**********************************************************

 //Query Users based on the Users
 public list < User > querySubordinates(list < User > userIds) {

  usersIdList = new list < User > ();
  list < user > userTempId = new list < User > ();
  for (User userData: [select id, Name, Role__c from user where ManagerId IN: userIds And isActive = true]) {
   userTempId.add(userData);
  }
  return userTempId;
 }

 //Populate Months & Years in the Picklist.
 public void populateMonths() {

  months = new List < SelectOption > ();
  years = new List < SelectOption > ();
  months.add(new SelectOption('', '--None--'));
  years.add(new SelectOption('', '--None--'));

  for (Integer monthVal: monthsMap.keySet()) {

   months.add(new SelectOption(string.valueOf(monthVal), monthsMap.get(monthVal)));
  }

  for (integer i = NUMBER_OF_YEARS - 1; i > -1; i--) {

   integer currentYear = Date.today().year();
   integer x = currentYear - i;
   years.add(new SelectOption(string.valueOf(x), string.valueOf(x)));
  }
 }

 public void callKRA() {
  tes.clear();
  targetQuery = '';
  targetQuery = 'Select ';
  KRA_SelectedYear = Integer.valueOf(SelectedYear);
  KRA_SelectedMonth = Integer.valueOf(SelectedMonth);
  KRA_NumberOfDays = date.daysInMonth(KRA_SelectedYear, KRA_SelectedMonth);
  //KRA_TargetUserId           =  targetUserId;

  startDateOfMonth = Date.newInstance(KRA_SelectedYear, KRA_SelectedMonth, 1);
  endDateOfMonth = Date.newInstance(KRA_SelectedYear, KRA_SelectedMonth, KRA_NumberOfDays);
  Schema.DescribeSObjectResult r = Target__c.sObjectType.getDescribe();

  for (string apiName: r.fields.getMap().keySet()) {
   targetQuery += apiName + ',';
  }

  // targetQuery = targetQuery.subString(0, targetQuery.length() - 1);
  // targetQuery += ' FROM Target__c WHERE Start_Date__c =: startDateOfMonth AND End_Date__c =: endDateOfMonth And OwnerId IN:tes ';

  initializeList();


  try {

   if (profileName != 'System Administrator' && profileName != 'HO NEW' && profileName != 'Customer Support Team') {
    KRA_TargetUserId = targetUserId; //target.Target_User__c;
   } else {
    //target                         =   Database.query('select ');
    KRA_TargetUserId = target.Target_User__c;
   }
   if (selectSubordinates == true) {
    system.debug('entering condition');
    system.debug('targetuserIDD%%%%%%%%' + targetUserId);
    system.debug('target.Target_User__c ^^^^^^^^^^' + target.Target_User__c);
    getAllUsers(KRA_TargetUserId);
   }

   tes.add(KRA_TargetUserId);
   system.debug('tes value' + tes);
   system.debug('id%%%%%%%%%%%%%%' + KRA_TargetUserId);

   targetQuery = targetQuery.subString(0, targetQuery.length() - 1);

   targetQuery += ' FROM Target__c WHERE Start_Date__c =: startDateOfMonth AND End_Date__c =: endDateOfMonth And OwnerId IN:tes ';
   system.debug('targetQuery' + targetQuery);
   system.debug('before list' + targetLISTTL);
   targetLISTTL = Database.query(targetQuery);
   system.debug('after making query' + targetLISTTL);
   //***********To addup all the subordinates***********
   //  
   //**********************
   if (targetLISTTL.size() > 0) {

    for (target__C t: targetLISTTL) {
     sT.add(t.id);
    }
   }
   if (targetLISTTL.isEmpty()) {
    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, '<b>Target is not assigned for selected Month & Year</b>'));
   }






  } catch (Exception e) {
   if (e.getMessage().contains('List has no rows for assignment to SObject')) {
    plumbingflag = false;
    columnflag = false;
    projectFlag = false;
    User userData = new User();
    userData = [select Name from User where id = : KRA_TargetUserId];
    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, '<b>Target is not assigned to ' + userData.Name + ' for selected Month & Year</b>'));
   }
   ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, '<b>Target is not assigned </b>'));
   system.debug('The Error is ' + e.getMessage() + 'at Line Number' + e.getLineNumber());
  }
  //for loop ends here
  try {

   string s1, s2, s3, s4, s5, s6;
   s1 = 'Approved by Team Leader';
   s2 = 'Approved by Regional Branding Manager';
   //count=database.countquery('select count() from case where OwnerId=:KRA_TargetUserId AND (status=:s1 OR status=:s2)');//
   // system.debug('List of cases'+count);
   //for branding multiple users
   List <
    case >visitCount = new list <
    case >();
   visitCount = [select id, OwnerId from
    case where OwnerId IN:
     tes AND(status = : s1 OR status = : s2)
   ];
   //
   if (visitCount.size() > 0) {
    System.debug('visitcount ###@$$#%@%' + visitCount);
    for (
     case vis:
      visitCount) {
     if (credMap.containsKey(vis.OwnerId)) {
      credMap.get(vis.OwnerId).add(vis);
      //System.debug(vis.OwnerId+' ===>> '+ credMap.get(vis.OwnerId));
     } else {
      credMap.put(vis.OwnerId, new List <
       case >{
        vis
       });
      //System.debug(vis.OwnerId+' ===>> '+ credMap.get(vis.OwnerId));
     }

    }
   }
   /* for(string u:tes){
        system.debug('the visit count from case is '+credMap.get(u).size());
      }
       */
   //for branding multiple users ends here
   /* //fields visit
 
          
 
       
        
          List<Ap_site_visit__c> visitCount =new list<Ap_site_visit__c>();
          visitCount =[select id,CreatedById,Target_ID__c from AP_Site_Visit__c where target_ID__c IN:sT AND CALENDAR_Month(date__c)=:KRA_SelectedMonth AND CALENDAR_YEAR(date__c)=:KRA_SelectedYear AND  (Party_Type__c=:s3 OR Party_Type__c=:s4 OR Party_Type__c=:s5 OR Party_Type__c=:s6)];
          //
          if(visitCount.size()>0){
            System.debug('visitcount ###@$$#%@%'+visitCount);
          for(Ap_site_visit__c vis:visitCount){
                if(credMap.containsKey(vis.CreatedById)){
                  credMap.get(vis.Target_ID__c).add(vis);
                  System.debug(vis.Target_ID__c+' ===>> '+ credMap.get(vis.Target_ID__c));
            }else{
                  credMap.put(vis.Target_ID__c, new List<Ap_site_visit__c>{vis});
                  System.debug(vis.Target_ID__c+' ===>> '+ credMap.get(vis.Target_ID__c));
            }

          }
        }
         //credMap.get(u.id).size());

         */




   // fields visit ends here
   rertieveKRAData();
  } catch (exception e) {
   system.debug('error is____________---------' + e.getMessage());
   ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING, '<b>' + e.getMessage() + '</b>'));
   system.debug('line number is ' + e.getLineNumber());
   system.debug('its exception' + e);
   system.debug('its message' + e.getmessage());

  }


 }

 //Retrive KRA data from the DB.
 public void rertieveKRAData() {



  Retailing_WrapperList = new list < PromotionalWrapper > ();
  Promotional_WrapperList = new list < PromotionalWrapper > ();
  Market_WrapperList = new list < PromotionalWrapper > ();
  Sales_WrapperList = new list < PromotionalWrapper > ();
  Branding_WrapperList = new list < PromotionalWrapper > ();


  PromotionalWrapper promotionWrap_retailing = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Visits = new PromotionalWrapper();
  PromotionalWrapper Dealerclub_billing= new PromotionalWrapper();
  PromotionalWrapper promotionWrap_ContactVisits = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Influencers = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Adoption_Plumber = new PromotionalWrapper(); 
  PromotionalWrapper promotionWrap_Adoption_Dealer = new PromotionalWrapper();
  PromotionalWrapper branding = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_MegaMeet = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_MiniMeet = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_influencer_col = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Bombarding = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Bombarding_Column = new PromotionalWrapper();
 // PromotionalWrapper promotionWrap_DP_Activation = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_primaryCPVC = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_primaryAqua = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_primarySWR = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_secondary = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_newDealer = new PromotionalWrapper();
  PromotionalWrapper promotionWarp_DealerClub_col = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Mechanic = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Borewell = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_farmer = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_TractorShow = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_JeepCampaign = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_sandyshow = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_newMarket = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_newDirectDealer = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_newDistributor = new PromotionalWrapper();
  // PromotionalWrapper promotionWrap_newDealer       =     new PromotionalWrapper();
  PromotionalWrapper promotionWrap_primary = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_exhibition = new PromotionalWrapper();
  // PromotionalWrapper promotionWrap_Mechanic = new PromotionalWrapper();
  // PromotionalWrapper promotionWrap_Borewell = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_Contractors = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_ISM = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_MiniFarmersMeet = new PromotionalWrapper();
  // PromotionalWrapper promotionWrap_exhibition = new PromotionalWrapper();
  //PromotionalWrapper promotionWrap_newMarket = new PromotionalWrapper();
  // PromotionalWrapper promotionWrap_newDealer = new PromotionalWrapper();
  //  PromotionalWrapper promotionWrap_newDistributor = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_factory = new PromotionalWrapper();
  // PromotionalWrapper promotionWrap_primary = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_KeyContacts = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_primary_V4 = new PromotionalWrapper();
  PromotionalWrapper promotionWrap_primary_Column = new PromotionalWrapper();



  for (target__c target: targetLISTTL) {


   // Make your dynamic call
   // target                     =   Database.query(targetQuery); 
   targetVertical = target.Vertical__c.toUpperCase();
  // targetUserMarketype =target.Market_type_of_owner__c.toUpperCase();
   targetUser = target.Owner_Name__c.toUpperCase();

   //Plumbing Vertical ------------------- KRA Report.
   if (target.Vertical__c == 'Plumbing') {

    retailPercent = 0;
    networkPercent = 0;
    promotionalPercent = 0;
    salesPercent = 0;
    brandingPercent = 0;
    plumbingflag = true;
    columnflag = false;
    projectFlag = false;

    //RETAILING - START

    promotionWrap_retailing.promotionalActivity = 'Retailing Days (Field Work)';
    promotionWrap_retailing.Target += (target.Retailing_days_Target_field_work__c == null) ? 0 : target.Retailing_days_Target_field_work__c; //Head_Quarter_No_of_Days__c + HEAD_QUARTER_METRO_No_Of_Days__c + Head_Quarter_State_Capital_No_of_days__c + Ex_Station_No_of_Days__c + Out_Station_No_of_Days__c
    promotionWrap_retailing.Actual += (target.Retailing_days_field_work__c == null) ? 0 : target.Retailing_days_field_work__c; // Total Visits where Record Type equals to Visits. 
    promotionWrap_retailing.Achvd += (target.Retailing_days_field_work_ACHVD__c == null) ? 0 : target.Retailing_days_field_work_ACHVD__c;
    promotionWrap_retailing.Weightage += (target.Retailing_days_field_work_Weightage__c == null) ? 0 : target.Retailing_days_field_work_Weightage__c;
    promotionWrap_retailing.Score += (target.Retailing_days_Score_field_work__c == null) ? 0 : target.Retailing_days_Score_field_work__c;


    promotionWrap_Visits.promotionalActivity = 'No. Of Dealer Visits (Total Visits)';
    promotionWrap_Visits.Target += (target.No_of_visits_Target_total_visits__c == null) ? 0 : target.No_of_visits_Target_total_visits__c; //Head_Quarter_Daily_Calls__c + HEAD_QUARTER_METRO_Daily_Calls__c + Head_Quarter_State_Capital_Daily_Calls__c + Out_Station_Daily_Calls__c + Ex_Station_Daily_Calls__c
    promotionWrap_Visits.Actual += (target.No_of_visits_total_visits__c == null) ? 0 : target.No_of_visits_total_visits__c; //Total Visits under Target.
    promotionWrap_Visits.Achvd += (target.No_of_visits_total_visits_ACHVD__c == null) ? 0 : target.No_of_visits_total_visits_ACHVD__c;
    promotionWrap_Visits.Weightage += (target.No_of_visits_Weightage_total_visits__c == null) ? 0 : target.No_of_visits_Weightage_total_visits__c;
    promotionWrap_Visits.Score += (target.No_of_visits_Score_field_work__c == null) ? 0 : target.No_of_visits_Score_field_work__c;


   /* promotionWrap_ContactVisits.promotionalActivity = 'Contacts Visit (Plumbers etc)';
    promotionWrap_ContactVisits.Target += (target.Contacts_visit_Target_Plumbers__c == null) ? 0 : target.Contacts_visit_Target_Plumbers__c; //40% of total visits(Target)
    promotionWrap_ContactVisits.Actual += (target.Contacts_visit_Plumbers_etc__c == null) ? 0 : target.Contacts_visit_Plumbers_etc__c;
    promotionWrap_ContactVisits.Achvd += (target.Contacts_visit_Plumbers_ACHVD__c == null) ? 0 : target.Contacts_visit_Plumbers_ACHVD__c;
    promotionWrap_ContactVisits.Weightage += (target.Contacts_visit_Weightage_Plumbers__c == null) ? 0 : target.Contacts_visit_Weightage_Plumbers__c;
    promotionWrap_ContactVisits.Score += (target.Contacts_visit_Score_Plumbers__c == null) ? 0 : target.Contacts_visit_Score_Plumbers__c; */


    promotionWrap_Influencers.promotionalActivity = 'Site Visits';
    promotionWrap_Influencers.Target += (target.Key_influencers_Target_Arch_consultant__c == null) ? 0 : target.Key_influencers_Target_Arch_consultant__c; //10% of contact vist(Target)
    promotionWrap_Influencers.Actual += (target.Key_influencers_contact_Arch_consultant__c == null) ? 0 : target.Key_influencers_contact_Arch_consultant__c;
    promotionWrap_Influencers.Achvd += (target.Key_influencers_Arch_consultant_ACHVD__c == null) ? 0 : target.Key_influencers_Arch_consultant_ACHVD__c;
    promotionWrap_Influencers.Weightage += (target.Key_influencers_Weighta_Arch_consultant__c == null) ? 0 : target.Key_influencers_Weighta_Arch_consultant__c;
    promotionWrap_Influencers.Score += (target.Key_influencers_Score_Arch_consultant__c == null) ? 0 : target.Key_influencers_Score_Arch_consultant__c;
    
    promotionWrap_Adoption_Dealer.promotionalActivity = 'Adopted Dealers Visit';
    promotionWrap_Adoption_Dealer.Target += (target.Adopted_Dealer_Target__c == null) ? 0 : target.Adopted_Dealer_Target__c; 
    promotionWrap_Adoption_Dealer.Actual += (target.Adopted_Dealer_Actual_Count__c == null) ? 0 : target.Adopted_Dealer_Actual_Count__c;
    promotionWrap_Adoption_Dealer.Achvd += (target.Adopted_Dealer_ACHVD__c == null) ? 0 : target.Adopted_Dealer_ACHVD__c;
    promotionWrap_Adoption_Dealer.Weightage += (target.Adopted_Dealer_Weightage__c == null) ? 0 : target.Adopted_Dealer_Weightage__c;
    promotionWrap_Adoption_Dealer.Score += (target.Adopted_Dealer_Score__c == null) ? 0 : target.Adopted_Dealer_Score__c;
    
    promotionWrap_Adoption_Plumber.promotionalActivity = 'Adopted Plumber Visit';
    promotionWrap_Adoption_Plumber.Target += (target.Adopted_Plumber_Target__c == null) ? 0 : target.Adopted_Plumber_Target__c; 
    promotionWrap_Adoption_Plumber.Actual += (target.Adopted_Plumber_Actual_Count__c == null) ? 0 : target.Adopted_Plumber_Actual_Count__c;
    promotionWrap_Adoption_Plumber.Achvd += (target.Adopted_Plumber_ACHVD__c == null) ? 0 : target.Adopted_Plumber_ACHVD__c;
    promotionWrap_Adoption_Plumber.Weightage += (target.Adopted_Plumber_We__c == null) ? 0 : target.Adopted_Plumber_We__c;
    promotionWrap_Adoption_Plumber.Score += (target.Adopted_Plumber_Score__c == null) ? 0 : target.Adopted_Plumber_Score__c;

    retailPercent = (100 * (promotionWrap_Adoption_Plumber.Actual + promotionWrap_Adoption_Dealer.Actual + promotionWrap_Influencers.Actual + promotionWrap_ContactVisits.Actual + promotionWrap_Visits.Actual + promotionWrap_retailing.Actual) / (promotionWrap_Adoption_Plumber.Weightage + promotionWrap_Adoption_Dealer.Weightage + promotionWrap_Influencers.Weightage + promotionWrap_ContactVisits.Weightage + promotionWrap_Visits.Weightage + promotionWrap_retailing.Weightage)).setscale(2);



    branding.promotionalActivity = '';
    branding.Target = 0; //40% of total visits(Target)
    if (credMap.containsKey(target.OwnerId)) {
     branding.Actual = credMap.get(target.Ownerid).size();
    } else {
     branding.Actual = 0;
    }
    branding.Achvd = 0;
    branding.Weightage = 5;
    branding.Score = 0;
    brandingPercent = (100 * (branding.Actual) / (branding.Weightage)).setscale(2);

    //PROMOTIONAL ACTIVITY - Start
    /* PromotionalWrapper promotionWrap_Exhibition      =     new PromotionalWrapper();
     promotionWrap_Exhibition.promotionalActivity     =     'Exhibition';
     promotionWrap_Exhibition.Target                  =     target.Exhibition__c;
     promotionWrap_Exhibition.Actual                  =     target.Exhibition_Actual__c;
     promotionWrap_Exhibition.Achvd                   =     target.Exhibitions_ACHVD__c;
     promotionWrap_Exhibition.Weightage               =     target.Exhibitions_Weightage__c;
     promotionWrap_Exhibition.Score                   =     target.Exhibitions_Score__c;
     
     PromotionalWrapper promotionWrap_Dealers         =     new PromotionalWrapper();
     promotionWrap_Dealers.promotionalActivity        =     'Dealer Salemen Training';
     promotionWrap_Dealers.Target                     =     target.Plumbing_DSM_Meet_Training__c;
     promotionWrap_Dealers.Actual                     =     target.Plumbing_DSM_Meet_Training_Actual__c;
     promotionWrap_Dealers.Achvd                      =     target.Plumbing_DSM_Meet_Training_ACHVD__c;
     promotionWrap_Dealers.Weightage                  =     target.Plumbing_DSM_Meet_Training_Weightage__c;
     promotionWrap_Dealers.Score                      =     target.Plumbing_DSM_Meet_Training_Score__c;*/


    promotionWrap_MegaMeet.promotionalActivity = 'Mega Meets (incl dealer meet)';
    promotionWrap_MegaMeet.Target += (target.Mega_Meets_Plumbing__c == null) ? 0 : target.Mega_Meets_Plumbing__c;
    promotionWrap_MegaMeet.Actual += (target.Mega_Meets_Plumbing_Actual__c == null) ? 0 : target.Mega_Meets_Plumbing_Actual__c;
    promotionWrap_MegaMeet.Achvd += (target.Mega_Meets_ACHVD__c == null) ? 0 : target.Mega_Meets_ACHVD__c;
    promotionWrap_MegaMeet.Weightage += (target.Mega_Meets_Weightage__c == null) ? 0 : target.Mega_Meets_Weightage__c;
    promotionWrap_MegaMeet.Score += (target.Mega_Meets_Score__c == null) ? 0 : target.Mega_Meets_Score__c;


    promotionWrap_MiniMeet.promotionalActivity = 'Mini Meets';
    promotionWrap_MiniMeet.Target += (target.ISP_Meets_Plumbing__c == null) ? 0 : target.ISP_Meets_Plumbing__c;
    promotionWrap_MiniMeet.Actual += (target.Inshop_Plumber_Meets_Actual__c == null) ? 0 : target.Inshop_Plumber_Meets_Actual__c;
    promotionWrap_MiniMeet.Achvd += (target.Inshop_Plumber_Meet_ACHVD__c == null) ? 0 : target.Inshop_Plumber_Meet_ACHVD__c;
    promotionWrap_MiniMeet.Weightage += (target.Inshop_Plumber_Meet_Weightage__c == null) ? 0 : target.Inshop_Plumber_Meet_Weightage__c;
    promotionWrap_MiniMeet.Score += (target.Inshop_Plumber_Meet_Score__c == null) ? 0 : target.Inshop_Plumber_Meet_Score__c;
    
    promotionWrap_Bombarding.promotionalActivity = 'Bombarding / Spl campaign';
    promotionWrap_Bombarding.Target += (target.Bombarding_Target_Plumbing__c == null) ? 0 : target.Bombarding_Target_Plumbing__c;
    promotionWrap_Bombarding.Actual += (target.Bombarding_Plumber_Actual__c == null) ? 0 : target.Bombarding_Plumber_Actual__c;
    promotionWrap_Bombarding.Achvd += (target.Bombarding_Plumber_ACHVD__c == null) ? 0 : target.Bombarding_Plumber_ACHVD__c;
    promotionWrap_Bombarding.Weightage += (target.Bombarding_Plumber_Weightage__c == null) ? 0 : target.Bombarding_Plumber_Weightage__c;
    promotionWrap_Bombarding.Score += (target.Bombarding_Plumber_Score__c == null) ? 0 : target.Bombarding_Plumber_Score__c;

    promotionalPercent = (100 * (promotionWrap_Bombarding.Actual + promotionWrap_MiniMeet.Actual + promotionWrap_MegaMeet.Actual) / (promotionWrap_Bombarding.Weightage + promotionWrap_MiniMeet.Weightage + promotionWrap_MegaMeet.Weightage)).setscale(2);
    //Promotional_WrapperList.add(promotionWrap_Exhibition);
    // Promotional_WrapperList.add(promotionWrap_Dealers);



    //Market Development
    /* PromotionalWrapper promotionWrap_newMarket       =     new PromotionalWrapper();
     promotionWrap_newMarket.promotionalActivity      =     'New Markets Opened';
     promotionWrap_newMarket.Target                   =     target.New_markets_opened__c;
     promotionWrap_newMarket.Actual                   =     0;
     //New_Markets_Opened_Actuals__c;
     promotionWrap_newMarket.Achvd                    =     target.New_Markets_Opened_ACHVD__c;
     promotionWrap_newMarket.Weightage                =     target.New_Markets_Opened_Weightage__c;
     promotionWrap_newMarket.Score                    =     target.New_Markets_Opened_Score__c;*/


    promotionWrap_newDealer.promotionalActivity = 'Retail outlet activation(Bandhan)';
    promotionWrap_newDealer.Target += (target.New_dealers_activation__c == null) ? 0 : target.New_dealers_activation__c;
    if (target.New_dealers_activation_Actual__c == null) {
     target.New_dealers_activation_Actual__c = 0;
    }
    promotionWrap_newDealer.Actual += (target.New_dealers_activation_Actual__c == null) ? 0 : target.New_dealers_activation_Actual__c;
    promotionWrap_newDealer.Achvd += (target.New_dealers_activation_ACHVD__c == null) ? 0 : target.New_dealers_activation_ACHVD__c;
    promotionWrap_newDealer.Weightage += (target.New_dealers_activation_Weightage__c == null) ? 0 : target.New_dealers_activation_Weightage__c;
    promotionWrap_newDealer.Score += (target.New_dealers_activation_Score__c == null) ? 0 : target.New_dealers_activation_Score__c;

    networkPercent = (100 * promotionWrap_newDealer.Actual / promotionWrap_newDealer.Weightage).setscale(2);  
    /*PromotionalWrapper promotionWrap_newDistributor  =     new PromotionalWrapper();
      promotionWrap_newDistributor.promotionalActivity =     'New Distributer Activation';
      promotionWrap_newDistributor.Target              =     target.New_distributer_activation__c;
      promotionWrap_newDistributor.Actual              =     target.New_Distributer_Activation_Actuals__c;
      promotionWrap_newDistributor.Achvd               =     target.New_Distributer_Activation_ACHVD__c;
      promotionWrap_newDistributor.Weightage           =     target.New_Distributer_Activation_Weightage__c;
      promotionWrap_newDistributor.Score               =     target.New_Distributor_Activation_Score__c;*/

    // Market_WrapperList.add(promotionWrap_newMarket);

    // Market_WrapperList.add(promotionWrap_newDistributor);

    //Sales Volume.

    promotionWrap_primaryCPVC.promotionalActivity = 'Primary Sales - CPVC';
    promotionWrap_primaryCPVC.Target += (target.PRIMARY_SALES_CPVC__c == null) ? 0 : target.PRIMARY_SALES_CPVC__c;
    if (target.Primary_Sales_CPVC_Actuals__c == null) {
     target.Primary_Sales_CPVC_Actuals__c = 0;
    }
    promotionWrap_primaryCPVC.Actual += (target.Primary_Sales_CPVC_Actuals__c == null) ? 0 : target.Primary_Sales_CPVC_Actuals__c;
    promotionWrap_primaryCPVC.Achvd += (target.Primary_Sales_CPVC_ACHVD__c == null) ? 0 : target.Primary_Sales_CPVC_ACHVD__c;
    promotionWrap_primaryCPVC.Weightage += (target.Primary_Sales_CPVC_Weightage__c == null) ? 0 : target.Primary_Sales_CPVC_Weightage__c;
    promotionWrap_primaryCPVC.Score += (target.Primary_Sales_CPVC_Score__c == null) ? 0 : target.Primary_Sales_CPVC_Score__c;


    promotionWrap_primaryAqua.promotionalActivity = 'Primary Sales - Aqua';
    promotionWrap_primaryAqua.Target += (target.PRIMARY_SALES_UPVC__c == null) ? 0 : target.PRIMARY_SALES_UPVC__c;
    if (target.Primary_Sales_Aqua_Actuals__c == null) {
     target.Primary_Sales_Aqua_Actuals__c = 0;
    }
    promotionWrap_primaryAqua.Actual += (target.Primary_Sales_Aqua_Actuals__c == null) ? 0 : target.Primary_Sales_Aqua_Actuals__c;
    promotionWrap_primaryAqua.Achvd += (target.Primary_Sales_Aqua_ACHVD__c == null) ? 0 : target.Primary_Sales_Aqua_ACHVD__c;
    promotionWrap_primaryAqua.Weightage += (target.Primary_Sales_Aqua_Weightage__c == null) ? 0 : target.Primary_Sales_Aqua_Weightage__c;
    promotionWrap_primaryAqua.Score += (target.Primary_Sales_Aqua_Score__c == null) ? 0 : target.Primary_Sales_Aqua_Score__c;


    promotionWrap_primarySWR.promotionalActivity = 'Primary Sales -SWR';
    promotionWrap_primarySWR.Target += (target.PRIMARY_SALES_SWR__c == null) ? 0 : target.PRIMARY_SALES_SWR__c;
    if (target.Primary_Sales_SWR_Actuals__c == null) {
     target.Primary_Sales_SWR_Actuals__c = 0;
    }
    promotionWrap_primarySWR.Actual += (target.Primary_Sales_SWR_Actuals__c == null) ? 0 : target.Primary_Sales_SWR_Actuals__c;
    promotionWrap_primarySWR.Achvd += (target.Primary_Sales_SWR_ACHVD__c == null) ? 0 : target.Primary_Sales_SWR_ACHVD__c;
    promotionWrap_primarySWR.Weightage += (target.Primary_Sales_SWR_Weightage__c == null) ? 0 : target.Primary_Sales_SWR_Weightage__c;
    promotionWrap_primarySWR.Score += (target.Primary_Sales_SWR_Score__c == null) ? 0 : target.Primary_Sales_SWR_Score__c;


    promotionWrap_secondary.promotionalActivity = 'Secondary Sales (Rs. In Lacs)';
    promotionWrap_secondary.Target += (target.Secondary_Sales_Target__c == null) ? 0 : target.Secondary_Sales_Target__c;
    promotionWrap_secondary.Actual += (target.Secondary_Sales_Actual_In_Lacs__c == null) ? 0 : target.Secondary_Sales_Actual_In_Lacs__c; //Secondary_Sales_Actual_Order_Value__c;
    promotionWrap_secondary.Achvd += (target.Secondary_Sales_ACHVD__c == null) ? 0 : target.Secondary_Sales_ACHVD__c;
    promotionWrap_secondary.Weightage += (target.Secondary_Sales_Weightage__c == null) ? 0 : target.Secondary_Sales_Weightage__c;
    promotionWrap_secondary.Score += (target.Secondary_Sales_Score__c == null) ? 0 : target.Secondary_Sales_Score__c;




    system.debug('Sales_WrapperList:::' + Sales_WrapperList);
    salesPercent = (100 * (promotionWrap_secondary.Actual + promotionWrap_primarySWR.Actual + promotionWrap_primaryAqua.Actual + promotionWrap_primaryCPVC.Actual) / (promotionWrap_secondary.Weightage + promotionWrap_primarySWR.Weightage + promotionWrap_primaryAqua.Weightage + promotionWrap_primaryCPVC.Weightage)).setscale(2);
   } else if (target.Vertical__c == 'Column') {

    plumbingflag = false;
    columnflag = true;
    projectFlag = false;

    //branding
    branding.promotionalActivity = '';
    branding.Target = 0; //40% of total visits(Target)
    if (credMap.containsKey(target.OwnerId)) {
     branding.Actual = credMap.get(target.Ownerid).size();
    } else {
     branding.Actual = 0;
    }
    branding.Achvd = 0;
    branding.Weightage = 5;
    branding.Score = 0;
    brandingPercent = (100 * (branding.Actual) / (branding.Weightage)).setscale(2);
    //branding ends here
    //retail outlet activation code for column
    promotionWrap_newDealer.promotionalActivity = 'New DP / Dealer Activation';
    promotionWrap_newDealer.Target += (target.New_DP_Dealer_activation_column_target__c== null) ? 0 : target.New_DP_Dealer_activation_column_target__c;
    if (target.New_dealers_activation_Actual__c == null) {
     target.New_dealers_activation_Actual__c = 0;
    }
    promotionWrap_newDealer.Actual += (target.New_dealers_activation_Actual__c == null) ? 0 : target.New_dealers_activation_Actual__c;
    promotionWrap_newDealer.Achvd += (target.New_dealers_activation_ACHVD__c == null) ? 0 : target.New_dealers_activation_ACHVD__c;
    //promotionWrap_newDealer.Weightage += (target.New_dealers_activation_Weightage__c == null) ? 0 : target.New_dealers_activation_Weightage__c;
    
    /*weightage differs depending on users market_type__C picklist values modified by SudhaMurthy KVP.....*/
    if(target.Market_type_of_owner__c=='CORE'){
    promotionWrap_newDealer.Weightage += (target.New_dealers_activation_Weightage__c == null) ? 0 : target.New_dealers_activation_Weightage__c ;
    }else if(target.Market_type_of_owner__c=='GROWTH'){
         promotionWrap_newDealer.Weightage += (target.New_dealer_activation_Growth__c== null) ? 0 : target.New_dealer_activation_Growth__c;
     }else if(target.Market_type_of_owner__c=='SEED'){
          promotionWrap_newDealer.Weightage += (target.New_dealer_activation_Seed__c== null) ? 0 : target.New_dealer_activation_Seed__c;
      }
      /*weightage differs depending on users market_type__C picklist values modified by SudhaMurthy KVP.....*/
      
    promotionWrap_newDealer.Score += (target.New_dealers_activation_Score__c == null) ? 0 : target.New_dealers_activation_Score__c;
    
    /*promotionWrap_DP_Activation.promotionalActivity = 'DP Activation'; 
    promotionWrap_DP_Activation.Target += (target.DP_Activation_Target__c == null) ? 0 : target.DP_Activation_Target__c;
    promotionWrap_DP_Activation.Actual += (target.DP_Activation_Actual__c == null) ? 0 : target.DP_Activation_Actual__c;
    promotionWrap_DP_Activation.Achvd += (target.DP_Activation_ACHVD__c == null) ? 0 : target.DP_Activation_ACHVD__c;
    promotionWrap_DP_Activation.Weightage += (target.DP_Activation_Weightage__c == null) ? 0 : target.DP_Activation_Weightage__c;
    promotionWrap_DP_Activation.Score += (target.DP_Activation_Score__c == null) ? 0 : target.DP_Activation_Score__c;*/

    /*if (promotionWrap_newDealer.Weightage != 0 || promotionWrap_DP_Activation.Weightage != 0) {
     networkPercent = (100 * (promotionWrap_newDealer.Actual + promotionWrap_DP_Activation.Actual) / (promotionWrap_newDealer.Weightage + promotionWrap_DP_Activation.Weightage)).setscale(2);
    } else {
     networkPercent = 0;
    }*/
     if (promotionWrap_newDealer.Weightage != 0 ) {
     networkPercent = (100 * (promotionWrap_newDealer.Actual ) / (promotionWrap_newDealer.Weightage)).setscale(2);
    } else {
     networkPercent = 0;
    }
    //retaail outlet activation code for column ends here.




    //RETAILING - START
     // PromotionalWrapper promotionWrap_Visits          =     new PromotionalWrapper();
     promotionWrap_retailing.promotionalActivity = 'Productive Visits With Orders';
    promotionWrap_retailing.Target += (target.Productive_visits_with_order_Target__c   == null) ? 0 : target.Productive_visits_with_order_Target__c    ;
    promotionWrap_retailing.Actual += (target.visit_with_new_order_booking__c== null) ? 0 : target.visit_with_new_order_booking__c;
    promotionWrap_retailing.Achvd += (target.Acvd_per_of_productive_visits_with_order__c   == null) ? 0 : target.Acvd_per_of_productive_visits_with_order__c   ;
    promotionWrap_retailing.Weightage += (target.Weightage_for_column_productive_visits__c == null) ? 0 : target.Weightage_for_column_productive_visits__c ;
    promotionWrap_retailing.Score += (target.Score_for_productive_visits_column__c== null) ? 0 : target.Score_for_productive_visits_column__c;
    
     
    promotionWrap_Visits.promotionalActivity = 'Dealer/Distributor Visits';
    promotionWrap_Visits.Target += (target.No_of_visits_Target_total_visits__c == null) ? 0 : target.No_of_visits_Target_total_visits__c;
    promotionWrap_Visits.Actual += (target.No_of_visits_total_visits_column__c == null) ? 0 : target.No_of_visits_total_visits_column__c ;
    promotionWrap_Visits.Achvd += (target.No_of_visits_total_visits_ACHVD__c == null) ? 0 : target.No_of_visits_total_visits_ACHVD__c;
    promotionWrap_Visits.Weightage += (target.No_of_visits_Weightage_total_visits__c == null) ? 0 : target.No_of_visits_Weightage_total_visits__c;
    promotionWrap_Visits.Score += (target.No_of_visits_Score_field_work__c == null) ? 0 : target.No_of_visits_Score_field_work__c;
    
    promotionWrap_Bombarding_Column.promotionalActivity = 'Bombarding'; //column bombarding
    promotionWrap_Bombarding_Column.Target += (target.Bombarding_Column_Target__c == null) ? 0 : target.Bombarding_Column_Target__c;
    promotionWrap_Bombarding_Column.Actual += (target.Bombarding_Plumber_Actual__c == null) ? 0 : target.Bombarding_Plumber_Actual__c;
    promotionWrap_Bombarding_Column.Achvd += (target.Bombarding_Column_ACHVD__c == null) ? 0 : target.Bombarding_Column_ACHVD__c;
    promotionWrap_Bombarding_Column.Weightage += (target.Bombarding_Column_Weightage__c == null) ? 0 : target.Bombarding_Column_Weightage__c;
    promotionWrap_Bombarding_Column.Score += (target.Bombarding_Column_Score__c == null) ? 0 : target.Bombarding_Column_Score__c;
    
    //PromotionalWrapper promotionWrap_retailing       =     new PromotionalWrapper();
    /*promotionWrap_retailing.promotionalActivity = 'Retailing Days (Field Work)';
    promotionWrap_retailing.Target += (target.Retailing_days_Target_field_work__c == null) ? 0 : target.Retailing_days_Target_field_work__c;
    promotionWrap_retailing.Actual += (target.Retailing_days_field_work__c == null) ? 0 : target.Retailing_days_field_work__c;
    promotionWrap_retailing.Achvd += (target.Retailing_days_field_work_ACHVD__c == null) ? 0 : target.Retailing_days_field_work_ACHVD__c;
    promotionWrap_retailing.Weightage += (target.Retailing_days_field_work_Weightage__c == null) ? 0 : target.Retailing_days_field_work_Weightage__c;
    promotionWrap_retailing.Score += (target.Retailing_days_Score_field_work__c == null) ? 0 : target.Retailing_days_Score_field_work__c;*/

   

    //PromotionalWrapper promotionWrap_ContactVisits   =     new PromotionalWrapper();
  /*  promotionWrap_ContactVisits.promotionalActivity = 'Contacts visit';
    promotionWrap_ContactVisits.Target += (target.Contacts_visit_Target_Plumbers__c == null) ? 0 : target.Contacts_visit_Target_Plumbers__c;
    promotionWrap_ContactVisits.Actual += (target.Contacts_visit_Plumbers_etc__c == null) ? 0 : target.Contacts_visit_Plumbers_etc__c;
    promotionWrap_ContactVisits.Achvd += (target.Contacts_visit_Plumbers_ACHVD__c == null) ? 0 : target.Contacts_visit_Plumbers_ACHVD__c;
    promotionWrap_ContactVisits.Weightage += (target.Contacts_visit_Weightage_Plumbers__c == null) ? 0 : target.Contacts_visit_Weightage_Plumbers__c;
    promotionWrap_ContactVisits.Score += (target.Contacts_visit_Score_Plumbers__c == null) ? 0 : target.Contacts_visit_Score_Plumbers__c; */


   /* promotionWrap_KeyContacts.promotionalActivity = 'Key Influencers Contact (Panchayat Head, Mechanics, Borers, Borewell office)';
    promotionWrap_KeyContacts.Target += ((target.Contact_Visit_Target_MECHANICS_WINDERS__c == null) ? 0 : target.Contact_Visit_Target_MECHANICS_WINDERS__c) + ((target.Contact_Visits_Target_BOREWELL_OPERATOR__c == null) ? 0 : target.Contact_Visits_Target_BOREWELL_OPERATOR__c) + ((target.Contact_Visits_Target_FARMERS_PANCHAYAT__c == null) ? 0 : target.Contact_Visits_Target_FARMERS_PANCHAYAT__c);

    promotionWrap_KeyContacts.Actual += ((target.Contact_visit_Actual_Borer__c == null) ? 0 : target.Contact_visit_Actual_Borer__c) + ((target.Contact_Visit_Actual_MECHANICS_WINDERS__c == null) ? 0 : target.Contact_Visit_Actual_MECHANICS_WINDERS__c) + ((target.Contact_Visits_Actual_BOREWELL_OPERATOR__c == null) ? 0 : target.Contact_Visits_Actual_BOREWELL_OPERATOR__c) + ((target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c == null) ? 0 : target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c);
    promotionWrap_KeyContacts.Achvd += ((target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c == null) ? 0 : target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c) + ((target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c == null) ? 0 : target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c) + ((target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c == null) ? 0 : target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c);
    promotionWrap_KeyContacts.Weightage += ((target.Contact_Visit_Weighta_MECHANICS_WINDERS__c == null) ? 0 : target.Contact_Visit_Weighta_MECHANICS_WINDERS__c) + ((target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c == null) ? 0 : target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c) + ((target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c == null) ? 0 : target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c);
    promotionWrap_KeyContacts.Score += ((target.Contact_Visit_Score_MECHANICS_WINDERS__c == null) ? 0 : target.Contact_Visit_Score_MECHANICS_WINDERS__c) + ((target.Contact_Visit_Score_BOREWELL_OPERATOR__c == null) ? 0 : target.Contact_Visit_Score_BOREWELL_OPERATOR__c) + ((target.Contact_Visit_Score_FARMERS_PANCHAYAT__c == null) ? 0 : target.Contact_Visit_Score_FARMERS_PANCHAYAT__c); */
    //(credMap.get(target.ownerId).size()==null)?0:credMap.get(target.ownerId).size();// 

    /*
                 promotionWrap_Mechanic.promotionalActivity       =     'MECHANICS/WINDERS';
                 promotionWrap_Mechanic.Target                    +=     (target.Contact_Visit_Target_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_Target_MECHANICS_WINDERS__c;
                 promotionWrap_Mechanic.Actual                    +=     (target.Contact_Visit_Actual_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_Actual_MECHANICS_WINDERS__c;
                 promotionWrap_Mechanic.Achvd                     +=     (target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c;               
                 promotionWrap_Mechanic.Weightage                 +=     (target.Contact_Visit_Weighta_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_Weighta_MECHANICS_WINDERS__c;
                 promotionWrap_Mechanic.Score                     +=     (target.Contact_Visit_Score_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_Score_MECHANICS_WINDERS__c;
                 
                 
                 promotionWrap_Borewell.promotionalActivity       =     'BOREWELL OPERATORS';
                 promotionWrap_Borewell.Target                    +=     (target.Contact_Visits_Target_BOREWELL_OPERATOR__c==null)?0:target.Contact_Visits_Target_BOREWELL_OPERATOR__c;
                 promotionWrap_Borewell.Actual                    +=     (target.Contact_Visits_Actual_BOREWELL_OPERATOR__c==null)?0:target.Contact_Visits_Actual_BOREWELL_OPERATOR__c;
                 promotionWrap_Borewell.Achvd                     +=     (target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c==null)?0:target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c;               
                 promotionWrap_Borewell.Weightage                 +=     (target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c==null)?0:target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c;
                 promotionWrap_Borewell.Score                     +=     (target.Contact_Visit_Score_BOREWELL_OPERATOR__c==null)?0:target.Contact_Visit_Score_BOREWELL_OPERATOR__c;
                 
                 
                 
                 promotionWrap_farmer.promotionalActivity         =     'FARMERS/PANCHAYAT HEAD';
                 promotionWrap_farmer.Target                      +=     (target.Contact_Visits_Target_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visits_Target_FARMERS_PANCHAYAT__c;
                 promotionWrap_farmer.Actual                      +=     (target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c;
                 promotionWrap_farmer.Achvd                       +=     (target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c;               
                 promotionWrap_farmer.Weightage                   +=     (target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c;
                 promotionWrap_farmer.Score                       +=     (target.Contact_Visit_Score_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visit_Score_FARMERS_PANCHAYAT__c;
                 
                 */

    //PROMOTIONAL ACTIVITY - Start
   // PromotionalWrapper promotionWrap_MiniMeet        =     new PromotionalWrapper();
    

    //PromotionalWrapper promotionWrap_MEGAMEET        =     new PromotionalWrapper();
    promotionWrap_MEGAMEET.promotionalActivity = 'Mega Meets';
    promotionWrap_MEGAMEET.Target += (target.Mega_Meets_Column__c == null) ? 0 : target.Mega_Meets_Column__c;
    promotionWrap_MEGAMEET.Actual += (target.Mega_Meets_Column_Actual__c == null) ? 0 : target.Mega_Meets_Column_Actual__c;
    promotionWrap_MEGAMEET.Achvd += (target.Mega_Meets_ACHVD__c == null) ? 0 : target.Mega_Meets_ACHVD__c;
    promotionWrap_MEGAMEET.Weightage += (target.Mega_Meets_Weightage__c == null) ? 0 : target.Mega_Meets_Weightage__c;
    promotionWrap_MEGAMEET.Score += (target.Mega_Meets_Score__c == null) ? 0 : target.Mega_Meets_Score__c;
    
    
   
    
    
    promotionWrap_MiniMeet.promotionalActivity = 'Mini Meets';
    promotionWrap_MiniMeet.Target += (target.Mini_Meets_Column__c == null) ? 0 : target.Mini_Meets_Column__c;
    promotionWrap_MiniMeet.Actual += (target.Mini_Meets_Column_Actual__c == null) ? 0 : target.Mini_Meets_Column_Actual__c;
    promotionWrap_MiniMeet.Achvd += (target.Mini_Meet_Column_ACHVD__c == null) ? 0 : target.Mini_Meet_Column_ACHVD__c;
    promotionWrap_MiniMeet.Weightage += (target.Mini_Meet_Column_Weightage__c == null) ? 0 : target.Mini_Meet_Column_Weightage__c;
    promotionWrap_MiniMeet.Score += (target.Mini_Meet_Column_Score__c == null) ? 0 : target.Mini_Meet_Column_Score__c;
    
     promotionWrap_influencer_col .promotionalActivity = 'Influencer Visits';
    promotionWrap_influencer_col .Target += (target.Influencer_visit_Target_column__c== null) ? 0 : target.Influencer_visit_Target_column__c;
    promotionWrap_influencer_col .Actual += (target.Influencer_visit_actual_column__c== null) ? 0 : target.Influencer_visit_actual_column__c;
    promotionWrap_MEGAMEET.Achvd += (target.Influencer_visit_column_ACVD__c== null) ? 0 : target.Influencer_visit_column_ACVD__c;
    /*weightage differs depending on users market_type__C picklist values modified by SudhaMurthy KVP.....*/
    if(target.Market_type_of_owner__c=='CORE'){
    promotionWrap_influencer_col .Weightage += (target.Influencer_visit_column_Weightage_core__c== null) ? 0 : target.Influencer_visit_column_Weightage_core__c;
    }else if(target.Market_type_of_owner__c=='GROWTH'){
         promotionWrap_influencer_col .Weightage += (target.Influencer_visit_column_weightage_growt__c== null) ? 0 : target.Influencer_visit_column_weightage_growt__c;
     }else if(target.Market_type_of_owner__c=='SEED'){
          promotionWrap_influencer_col .Weightage += (target.Influencer_visit_column_weightage_seed__c== null) ? 0 : target.Influencer_visit_column_weightage_seed__c;
      }
      /*weightage differs depending on users market_type__C picklist values modified by SudhaMurthy KVP.....*/
    //promotionWrap_influencer_col .Weightage += (target.Influencer_visit_column_Weightage_core__c== null) ? 0 : target.Influencer_visit_column_Weightage_core__c;
    promotionWrap_influencer_col .Score += (target.Influencer_visit_Target_column__c== null) ? 0 : target.Influencer_visit_Target_column__c;
    
    
   /*.... promotionWrap_Bombarding_Column.promotionalActivity = 'Bombarding'; //column bombarding
    promotionWrap_Bombarding_Column.Target += (target.Bombarding_Column_Target__c == null) ? 0 : target.Bombarding_Column_Target__c;
    promotionWrap_Bombarding_Column.Actual += (target.Bombarding_Plumber_Actual__c == null) ? 0 : target.Bombarding_Plumber_Actual__c;
    promotionWrap_Bombarding_Column.Achvd += (target.Bombarding_Column_ACHVD__c == null) ? 0 : target.Bombarding_Column_ACHVD__c;
    promotionWrap_Bombarding_Column.Weightage += (target.Bombarding_Column_Weightage__c == null) ? 0 : target.Bombarding_Column_Weightage__c;
    promotionWrap_Bombarding_Column.Score += (target.Bombarding_Column_Score__c == null) ? 0 : target.Bombarding_Column_Score__c;....*/

    /*// Bombarding_Column_Score__c 
                promotionWrap_TractorShow.promotionalActivity    =     'Tractor Show';
                promotionWrap_TractorShow.Target                 +=     (target.Tractor_Show__c==null)?0:target.Tractor_Show__c;
                promotionWrap_TractorShow.Actual                 +=     (target.Tractor_Show_Actual__c==null)?0:target.Tractor_Show_Actual__c;
                promotionWrap_TractorShow.Achvd                  +=     (target.Tractor_Show_ACHVD__c==null)?0:target.Tractor_Show_ACHVD__c;
                promotionWrap_TractorShow.Weightage              +=     (target.Tractor_Show_Column_Weightage__c==null)?0:target.Tractor_Show_Column_Weightage__c;
                promotionWrap_TractorShow.Score                  +=     (target.Tractor_Show_Column_Score__c==null)?0:target.Tractor_Show_Column_Score__c;
                

                promotionWrap_JeepCampaign.promotionalActivity   =     'Jeep Campaign';
                promotionWrap_JeepCampaign.Target                +=     (target.Jeep_Campaign__c==null)?0:target.Jeep_Campaign__c;
                promotionWrap_JeepCampaign.Actual                +=     (target.Jeep_Campaign_Actual__c==null)?0:target.Jeep_Campaign_Actual__c;
                promotionWrap_JeepCampaign.Achvd                 +=     (target.Jeep_Campaign_ACHVD__c==null)?0:target.Jeep_Campaign_ACHVD__c;
                promotionWrap_JeepCampaign.Weightage             +=     (target.Jeep_Campaign_Weightage__c==null)?0:target.Jeep_Campaign_Weightage__c;
                promotionWrap_JeepCampaign.Score                 +=     (target.Jeep_Campaign_Score__c==null)?0:target.Jeep_Campaign_Score__c;
                
                
                
                promotionWrap_sandyshow.promotionalActivity      =     'Shandy Shows';
                promotionWrap_sandyshow.Target                   +=     (target.Shandy_Show__c==null)?0:target.Shandy_Show__c;
                promotionWrap_sandyshow.Actual                   +=     (target.Shandy_Shows_Actuals__c==null)?0:target.Shandy_Shows_Actuals__c;
                promotionWrap_sandyshow.Achvd                    +=     (target.Shandy_Shows_ACHVD__c==null)?0:target.Shandy_Shows_ACHVD__c;
                promotionWrap_sandyshow.Weightage                +=     (target.Shandy_Shows_Weightage__c==null)?0:target.Shandy_Shows_Weightage__c;
                promotionWrap_sandyshow.Score                    +=     (target.Shandy_Shows_Score__c==null)?0:target.Shandy_Shows_Score__c;
             
                
                promotionWrap_exhibition.promotionalActivity = 'Exhibitions';
                promotionWrap_exhibition.Target += (target.Exhibition__c==null)?0:target.Exhibition__c;
                promotionWrap_exhibition.Actual += (target.Exhibition_Actual__c==null)?0:target.Exhibition_Actual__c;
                promotionWrap_exhibition.Achvd += (target.Exhibitions_ACHVD__c==null)?0:target.Exhibitions_ACHVD__c;
                promotionWrap_exhibition.Weightage += (target.Exhibitions_Weightage__c==null)?0:target.Exhibitions_Weightage__c;
                promotionWrap_exhibition.Score += (target.Exhibitions_Score__c==null)?0:target.Exhibitions_Score__c;
                
                  */


    //Market Development



    promotionWrap_newMarket.promotionalActivity = 'No. of Shops';
    promotionWrap_newMarket.Target += (target.NEW_DIRECT_DEALER_TO_DEPOT__c == null) ? 0 : target.NEW_DIRECT_DEALER_TO_DEPOT__c;
    promotionWrap_newMarket.Actual += (target.New_Direct_Dealer_To_Depot_Actual__c == null) ? 0 : target.New_Direct_Dealer_To_Depot_Actual__c;
    promotionWrap_newMarket.Achvd += (target.New_Markets_Opened_ACHVD__c == null) ? 0 : target.New_Markets_Opened_ACHVD__c;
    promotionWrap_newMarket.Weightage += (target.New_Markets_Opened_Weightage__c == null) ? 0 : target.New_Markets_Opened_Weightage__c;
    promotionWrap_newMarket.Score += (target.New_Markets_Opened_Score__c == null) ? 0 : target.New_Markets_Opened_Score__c;

    /*

                promotionWrap_newDirectDealer.promotionalActivity=     'Activation Of Inactive Direct Dealer';
                promotionWrap_newDirectDealer.Target             +=     (target.Activation_Of_Inactive_Direct_Dealer__c==null)?0:target.Activation_Of_Inactive_Direct_Dealer__c;
                promotionWrap_newDirectDealer.Actual             +=     (target.New_Direct_Dealer_Activation__c==null)?0:target.New_Direct_Dealer_Activation__c;
                promotionWrap_newDirectDealer.Achvd              +=     (target.New_dealers_activation_ACHVD__c==null)?0:target.New_dealers_activation_ACHVD__c;
                promotionWrap_newDirectDealer.Weightage          +=     (target.New_dealers_activation_Weightage__c==null)?0:target.New_dealers_activation_Weightage__c;
                promotionWrap_newDirectDealer.Score              +=     (target.New_dealers_activation_Score__c==null)?0:target.New_dealers_activation_Score__c;
                
                
                promotionWrap_newDistributor.promotionalActivity =     'Activation Of Inactive Distributor';
                promotionWrap_newDistributor.Target              +=     (target.Activation_Of_Inactive_Distributor__c==null)?0:target.Activation_Of_Inactive_Distributor__c;
                promotionWrap_newDistributor.Actual              +=     (target.New_Distributer_Activation_Actuals__c==null)?0:target.New_Distributer_Activation_Actuals__c;
                promotionWrap_newDistributor.Achvd               +=     (target.New_Distributer_Activation_ACHVD__c==null)?0:target.New_Distributer_Activation_ACHVD__c;
                promotionWrap_newDistributor.Weightage           +=     (target.New_Distributer_Activation_Weightage__c==null)?0:target.New_Distributer_Activation_Weightage__c;
                promotionWrap_newDistributor.Score               +=     (target.New_Distributor_Activation_Score__c==null)?0:target.New_Distributor_Activation_Score__c;
                
                
                promotionWrap_newDealer.promotionalActivity      =     'Activation of Inactive Dealer';
                promotionWrap_newDealer.Target                   +=     (target.New_dealers_activation__c==null)?0:target.New_dealers_activation__c;
                promotionWrap_newDealer.Actual                   +=     (target.New_dealers_activation_Actual__c==null)?0:target.New_dealers_activation_Actual__c;
                promotionWrap_newDealer.Achvd                    +=     (target.New_dealers_activation_ACHVD__c==null)?0:target.New_dealers_activation_ACHVD__c;
                promotionWrap_newDealer.Weightage                +=     (target.New_dealers_activation_Weightage__c==null)?0:target.New_dealers_activation_Weightage__c;
                promotionWrap_newDealer.Score                    +=     (target.New_dealers_activation_Score__c==null)?0:target.New_dealers_activation_Score__c;
                
        */


    //Sales Volume.

    promotionWrap_primary_Column.promotionalActivity = 'Primary Sales (Rs. In Lacs)';
    promotionWrap_primary_Column.Target += (target.Primary_Sales_Target__c == null) ? 0 : target.Primary_Sales_Target__c;
    promotionWrap_primary_Column.Actual += (target.Primary_Sales_Actuals__c == null) ? 0 : target.Primary_Sales_Actuals__c;
    promotionWrap_primary_Column.Achvd += (target.Primary_Sales_ACHVD__c == null) ? 0 : target.Primary_Sales_ACHVD__c;
    
    /*weightage differs depending on users market_type__C picklist values modified by SudhaMurthy KVP.....*/
    if(target.Market_type_of_owner__c=='CORE'){
    promotionWrap_primary_Column.Weightage += (target.Primary_Sales_Weightage__c == null) ? 0 : target.Primary_Sales_Weightage__c;
    }else if(target.Market_type_of_owner__c=='GROWTH'){
         promotionWrap_primary_Column.Weightage += (target.Primary_Sales_In_Lacs_Column_Growth__c== null) ? 0 : target.Primary_Sales_In_Lacs_Column_Growth__c;
     }else if(target.Market_type_of_owner__c=='SEED'){
          promotionWrap_primary_Column.Weightage += (target.Primary_Sales_In_Lacs_Column_Seed__c== null) ? 0 : target.Primary_Sales_In_Lacs_Column_Seed__c;
      }
      /*weightage differs depending on users market_type__C picklist values modified by SudhaMurthy KVP.....*/
     
    promotionWrap_primary_Column.Score += (target.Primary_Sales_Score__c == null) ? 0 : target.Primary_Sales_Score__c;


    promotionWrap_primary_V4.promotionalActivity = 'Secondary Sales-Sparsh (Rs. In Lacs)';
    promotionWrap_primary_V4.Target += ((target.PRIMARY_SALES_V4__c == null) ? 0 : target.PRIMARY_SALES_V4__c);
    promotionWrap_primary_V4.Actual += ((target.Primary_Sales_Actuals__c == null) ? 0 : target.Primary_Sales_Actuals__c);
    promotionWrap_primary_V4.Achvd += ((target.Primary_Sales_ACHVD__c == null) ? 0 : target.Primary_Sales_ACHVD__c);
    promotionWrap_primary_V4.Weightage += ((target.Secondary_Sales_Sparsh__c== null) ? 0 : target.Secondary_Sales_Sparsh__c   );
    promotionWrap_primary_V4.Score += ((target.Primary_Sales_Score__c == null) ? 0 : target.Primary_Sales_Score__c);



    //PromotionalWrapper promotionWrap_secondary       =     new PromotionalWrapper();
    promotionWrap_secondary.promotionalActivity = 'Secondary Sales (Rs. In Lacs)';
    promotionWrap_secondary.Target += (target.Secondary_Sales_Target__c == null) ? 0 : target.Secondary_Sales_Target__c;
    promotionWrap_secondary.Actual += (target.Secondary_Sales_Actual_In_Lacs__c == null) ? 0 : target.Secondary_Sales_Actual_In_Lacs__c; //Secondary_Sales_Actual_Order_Value__c;
    promotionWrap_secondary.Achvd += (target.Secondary_Sales_ACHVD__c == null) ? 0 : target.Secondary_Sales_ACHVD__c;
    promotionWrap_secondary.Weightage += (target.Secondary_Sales_Weightage__c == null) ? 0 : target.Secondary_Sales_Weightage__c;
    promotionWrap_secondary.Score += (target.Secondary_Sales_Score__c == null) ? 0 : target.Secondary_Sales_Score__c;
   
   
    //Dealer clubbing section-added dummy feild and for actual field there is no rollup done 
    
    Dealerclub_billing.promotionalActivity = 'Dealer CLUB Billing';
    Dealerclub_billing.Target += (target.Dealer_club_target_column__c== null) ? 0 : target.Dealer_club_target_column__c;
    Dealerclub_billing.Actual += (target.Dealer_club_Actual_column__c== null) ? 0 : target.Dealer_club_Actual_column__c; //Secondary_Sales_Actual_Order_Value__c;
    Dealerclub_billing.Achvd += (target.Dealer_club_ACVD_column__c== null) ? 0 : target.Dealer_club_ACVD_column__c;
    Dealerclub_billing.Weightage += (target.Dealer_club_Weightage_column__c == null) ? 0 : target.Dealer_club_Weightage_column__c;
    Dealerclub_billing.Score += (target.Dealer_club_Score_column__c== null) ? 0 : target.Dealer_club_Score_column__c;


   } else if (target.Vertical__c == 'Projects') {

    plumbingflag = false;
    columnflag = false;
    projectFlag = true;
    system.debug(projectflag + 'iiiiiiiiiiii');
    //RETAILING - START
    //PromotionalWrapper promotionWrap_retailing = new PromotionalWrapper();
    promotionWrap_retailing.promotionalActivity = 'Retailing Days (Field Work)';
    promotionWrap_retailing.Target += (target.Retailing_days_Target_field_work__c == null) ? 0 : target.Retailing_days_Target_field_work__c;
    promotionWrap_retailing.Actual += (target.Retailing_days_field_work__c == null) ? 0 : target.Retailing_days_field_work__c;
    promotionWrap_retailing.Achvd += (target.Retailing_days_field_work_ACHVD__c == null) ? 0 : target.Retailing_days_field_work_ACHVD__c;
    promotionWrap_retailing.Weightage += (target.Retailing_days_field_work_Weightage__c == null) ? 0 : target.Retailing_days_field_work_Weightage__c;
    promotionWrap_retailing.Score += (target.Retailing_days_Score_field_work__c == null) ? 0 : target.Retailing_days_Score_field_work__c;

    // PromotionalWrapper promotionWrap_Visits = new PromotionalWrapper();
    promotionWrap_Visits.promotionalActivity = 'No. Of Visits (Total Visits)';
    promotionWrap_Visits.Target += (target.No_of_visits_Target_total_visits__c == null) ? 0 : target.No_of_visits_Target_total_visits__c;
    promotionWrap_Visits.Actual += (target.No_of_visits_total_visits__c == null) ? 0 : target.No_of_visits_total_visits__c;
    promotionWrap_Visits.Achvd += (target.No_of_visits_total_visits_ACHVD__c == null) ? 0 : target.No_of_visits_total_visits_ACHVD__c;
    promotionWrap_Visits.Weightage += (target.No_of_visits_Weightage_total_visits__c == null) ? 0 : target.No_of_visits_Weightage_total_visits__c;
    promotionWrap_Visits.Score += (target.No_of_visits_Score_field_work__c == null) ? 0 : target.No_of_visits_Score_field_work__c;

    // PromotionalWrapper promotionWrap_ContactVisits = new PromotionalWrapper();
   /* promotionWrap_ContactVisits.promotionalActivity = ' CONTACTS VISIT (Plumbers etc)';
    promotionWrap_ContactVisits.Target += (target.Contacts_visit_Target_Plumbers__c == null) ? 0 : target.Contacts_visit_Target_Plumbers__c;
    promotionWrap_ContactVisits.Actual += (target.Contacts_visit_Plumbers_etc__c == null) ? 0 : target.Contacts_visit_Plumbers_etc__c;
    promotionWrap_ContactVisits.Achvd += (target.Contacts_visit_Plumbers_ACHVD__c == null) ? 0 : target.Contacts_visit_Plumbers_ACHVD__c;
    promotionWrap_ContactVisits.Weightage += (target.Contacts_visit_Weightage_Plumbers__c == null) ? 0 : target.Contacts_visit_Weightage_Plumbers__c;
    promotionWrap_ContactVisits.Score += (target.Contacts_visit_Score_Plumbers__c == null) ? 0 : target.Contacts_visit_Score_Plumbers__c; */




    promotionWrap_Mechanic.promotionalActivity = 'CONSULTANTS/Architects';
    promotionWrap_Mechanic.Target += (target.Key_influencers_Target_Arch_consultant__c == null) ? 0 : target.Key_influencers_Target_Arch_consultant__c;
    promotionWrap_Mechanic.Actual += (target.Key_influencers_contact_Arch_consultant__c == null) ? 0 : target.Key_influencers_contact_Arch_consultant__c;
    promotionWrap_Mechanic.Achvd += (target.Key_influencers_Arch_consultant_ACHVD__c == null) ? 0 : target.Key_influencers_Arch_consultant_ACHVD__c;
    promotionWrap_Mechanic.Weightage += (target.Key_influencers_Weighta_Arch_consultant__c == null) ? 0 : target.Key_influencers_Weighta_Arch_consultant__c;
    promotionWrap_Mechanic.Score += (target.Key_influencers_Score_Arch_consultant__c == null) ? 0 : target.Key_influencers_Score_Arch_consultant__c;


    promotionWrap_Borewell.promotionalActivity = 'DEVELOPERS';
    promotionWrap_Borewell.Target += (target.Key_influencers_Target_Arch_consultant__c == null) ? 0 : target.Key_influencers_Target_Arch_consultant__c;
    promotionWrap_Borewell.Actual += (target.Key_influencers_contact_Arch_consultant__c == null) ? 0 : target.Key_influencers_contact_Arch_consultant__c;
    promotionWrap_Borewell.Achvd += (target.Key_influencers_Arch_consultant_ACHVD__c == null) ? 0 : target.Key_influencers_Arch_consultant_ACHVD__c;
    promotionWrap_Borewell.Weightage += (target.Key_influencers_Weighta_Arch_consultant__c == null) ? 0 : target.Key_influencers_Weighta_Arch_consultant__c;
    promotionWrap_Borewell.Score += (target.Key_influencers_Score_Arch_consultant__c == null) ? 0 : target.Key_influencers_Score_Arch_consultant__c;


    promotionWrap_Contractors.promotionalActivity = 'CONTRACTORS';
    promotionWrap_Contractors.Target += (target.Key_influencers_Target_Arch_consultant__c == null) ? 0 : target.Key_influencers_Target_Arch_consultant__c;
    promotionWrap_Contractors.Actual += (target.Key_influencers_contact_Arch_consultant__c == null) ? 0 : target.Key_influencers_contact_Arch_consultant__c;
    promotionWrap_Contractors.Achvd += (target.Key_influencers_Arch_consultant_ACHVD__c == null) ? 0 : target.Key_influencers_Arch_consultant_ACHVD__c;
    promotionWrap_Contractors.Weightage += (target.Key_influencers_Weighta_Arch_consultant__c == null) ? 0 : target.Key_influencers_Weighta_Arch_consultant__c;
    promotionWrap_Contractors.Score += (target.Key_influencers_Score_Arch_consultant__c == null) ? 0 : target.Key_influencers_Score_Arch_consultant__c;




    //PROMOTIONAL ACTIVITY - Start

    promotionWrap_ISM.promotionalActivity = 'Onsite Plumber Meet';
    promotionWrap_ISM.Target += (target.InShop_Mechanic_Meet__c == null) ? 0 : target.InShop_Mechanic_Meet__c;
    //promotionWrap_ISM.Actual = target.Inshop_Mechanic_Meets_Actual__c;
    promotionWrap_ISM.Achvd += (target.Plumbing_DSM_Meet_Training_ACHVD__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_ACHVD__c;
    promotionWrap_ISM.Weightage += (target.Plumbing_DSM_Meet_Training_Weightage__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_Weightage__c;
    promotionWrap_ISM.Score += (target.Plumbing_DSM_Meet_Training_Score__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_Score__c;


    promotionWrap_MiniFarmersMeet.promotionalActivity = 'CONSULTANTS/BUILDERS EVENTS';
    promotionWrap_MiniFarmersMeet.Target += (target.Plumbing_DSM_Meet_Training__c == null) ? 0 : target.Plumbing_DSM_Meet_Training__c;
    // promotionWrap_MiniFarmersMeet.Actual += (target.Plumbing_DSM_Meet_Training_Actual__c==null)?0:target.Plumbing_DSM_Meet_Training__c;
    promotionWrap_MiniFarmersMeet.Actual += (target.Plumbing_DSM_Meet_Training_Actual__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_Actual__c;
    promotionWrap_MiniFarmersMeet.Achvd += (target.Plumbing_DSM_Meet_Training_ACHVD__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_ACHVD__c;
    promotionWrap_MiniFarmersMeet.Weightage += (target.Plumbing_DSM_Meet_Training_Weightage__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_Weightage__c;
    promotionWrap_MiniFarmersMeet.Score += (target.Plumbing_DSM_Meet_Training_Score__c == null) ? 0 : target.Plumbing_DSM_Meet_Training_Score__c;


    promotionWrap_exhibition.promotionalActivity = 'EXHIBITIONS';
    promotionWrap_exhibition.Target += (target.Exhibition__c == null) ? 0 : target.Exhibition__c;
    promotionWrap_exhibition.Actual += (target.Exhibition_Actual__c == null) ? 0 : target.Exhibition_Actual__c;
    promotionWrap_exhibition.Achvd += (target.Exhibitions_ACHVD__c == null) ? 0 : target.Exhibitions_ACHVD__c;
    promotionWrap_exhibition.Weightage += (target.Exhibitions_Weightage__c == null) ? 0 : target.Exhibitions_Weightage__c;
    promotionWrap_exhibition.Score += (target.Exhibitions_Score__c == null) ? 0 : target.Exhibitions_Score__c;



    //Market Development

    promotionWrap_newMarket.promotionalActivity = 'APPROVALS & ORDERS WITH TOP BUILDERS';
    promotionWrap_newMarket.Target += (target.New_markets_opened__c == null) ? 0 : target.New_markets_opened__c;
    promotionWrap_newMarket.Actual += (target.Inshop_Plumber_Meets_Actual__c == null) ? 0 : target.Inshop_Plumber_Meets_Actual__c;
    promotionWrap_newMarket.Achvd += (target.Inshop_Plumber_Meet_ACHVD__c == null) ? 0 : target.Inshop_Plumber_Meet_ACHVD__c;
    promotionWrap_newMarket.Weightage += (target.Inshop_Plumber_Meet_Weightage__c == null) ? 0 : target.Inshop_Plumber_Meet_Weightage__c;
    promotionWrap_newMarket.Score += (target.Inshop_Plumber_Meet_Score__c == null) ? 0 : target.Inshop_Plumber_Meet_Score__c;


    promotionWrap_newDealer.promotionalActivity = 'PROJECT REFERENCE PPT EVERY QTR - 4 PER YEAR';
    promotionWrap_newDealer.Target += (target.New_dealers_activation__c == null) ? 0 : target.New_dealers_activation__c;
    promotionWrap_newDealer.Actual += (target.Inshop_Plumber_Meets_Actual__c == null) ? 0 : target.Inshop_Plumber_Meets_Actual__c;
    promotionWrap_newDealer.Achvd += (target.Inshop_Plumber_Meet_ACHVD__c == null) ? 0 : target.Inshop_Plumber_Meet_ACHVD__c;
    promotionWrap_newDealer.Weightage += (target.Inshop_Plumber_Meet_Weightage__c == null) ? 0 : target.Inshop_Plumber_Meet_Weightage__c;
    promotionWrap_newDealer.Score += (target.Inshop_Plumber_Meet_Score__c == null) ? 0 : target.Inshop_Plumber_Meet_Score__c;


    promotionWrap_newDistributor.promotionalActivity = 'PROJECT FUNNEL 2016-17';
    promotionWrap_newDistributor.Target += (target.New_distributer_activation__c == null) ? 0 : target.New_distributer_activation__c;
    promotionWrap_newDistributor.Actual += (target.Inshop_Plumber_Meets_Actual__c == null) ? 0 : target.Inshop_Plumber_Meets_Actual__c;
    promotionWrap_newDistributor.Achvd += (target.Inshop_Plumber_Meet_ACHVD__c == null) ? 0 : target.Inshop_Plumber_Meet_ACHVD__c;
    promotionWrap_newDistributor.Weightage += (target.Inshop_Plumber_Meet_Weightage__c == null) ? 0 : target.Inshop_Plumber_Meet_Weightage__c;
    promotionWrap_newDistributor.Score += (target.Inshop_Plumber_Meet_Score__c == null) ? 0 : target.Inshop_Plumber_Meet_Score__c;


    promotionWrap_factory.promotionalActivity = 'FACTROY VISITS';
    promotionWrap_factory.Target += (target.New_distributer_activation__c == null) ? 0 : target.New_distributer_activation__c;
    promotionWrap_factory.Actual += (target.Inshop_Plumber_Meets_Actual__c == null) ? 0 : target.Inshop_Plumber_Meets_Actual__c;
    promotionWrap_factory.Achvd += (target.Inshop_Plumber_Meet_ACHVD__c == null) ? 0 : target.Inshop_Plumber_Meet_ACHVD__c;
    promotionWrap_factory.Weightage += (target.Inshop_Plumber_Meet_Weightage__c == null) ? 0 : target.Inshop_Plumber_Meet_Weightage__c;
    promotionWrap_factory.Score += (target.Inshop_Plumber_Meet_Score__c == null) ? 0 : target.Inshop_Plumber_Meet_Score__c;

    //Sales Volume.

    promotionWrap_primary.promotionalActivity = 'ORDERS WITH ALL PRODUCTS';
    promotionWrap_primary.Target += (target.Primary_Sales_Target__c == null) ? 0 : target.Primary_Sales_Target__c;
    promotionWrap_primary.Actual += (target.Orders_with_all_Products_A__c == null) ? 0 : target.Orders_with_all_Products_A__c;
    promotionWrap_primary.Achvd += (target.Primary_Sales_ACHVD__c == null) ? 0 : target.Primary_Sales_ACHVD__c;
    promotionWrap_primary.Weightage += (target.Primary_Sales_Weightage__c == null) ? 0 : target.Primary_Sales_Weightage__c;
    promotionWrap_primary.Score += (target.Primary_Sales_Score__c == null) ? 0 : target.Primary_Sales_Score__c;

    //PromotionalWrapper promotionWrap_secondary = new PromotionalWrapper();
    promotionWrap_secondary.promotionalActivity = 'ORDERS WITH SINGLE PRODUCTS';
    promotionWrap_secondary.Target += (target.Secondary_Sales_Target__c == null) ? 0 : target.Secondary_Sales_Target__c;
    promotionWrap_secondary.Actual += (target.Orders_with_Single_Product_A__c == null) ? 0 : target.Orders_with_Single_Product_A__c; //Secondary_Sales_Actual_Order_Value__c;
    promotionWrap_secondary.Achvd += (target.Inshop_Plumber_Meet_ACHVD__c == null) ? 0 : target.Inshop_Plumber_Meet_ACHVD__c;
    promotionWrap_secondary.Weightage += (target.Inshop_Plumber_Meet_Weightage__c == null) ? 0 : target.Inshop_Plumber_Meet_Weightage__c;
    promotionWrap_secondary.Score += (target.Inshop_Plumber_Meet_Score__c == null) ? 0 : target.Inshop_Plumber_Meet_Score__c;

   }

  }
  
  Retailing_WrapperList.add(promotionWrap_retailing);
  Retailing_WrapperList.add(promotionWrap_Visits);
 // Retailing_WrapperList.add(promotionWrap_ContactVisits);
 

  
  

  if (plumbingflag == true) {

   Retailing_WrapperList.add(promotionWrap_Influencers);
   Sales_WrapperList.add(promotionWrap_primaryCPVC);
   Sales_WrapperList.add(promotionWrap_primaryAqua);
   Sales_WrapperList.add(promotionWrap_primarySWR);
   Market_WrapperList.add(promotionWrap_newDealer);
   Branding_WrapperList.add(branding);
   Retailing_WrapperList.add(promotionWrap_Adoption_Dealer);
   Retailing_WrapperList.add(promotionWrap_Adoption_Plumber);
   Promotional_WrapperList.add(promotionWrap_MegaMeet);
   Promotional_WrapperList.add(promotionWrap_MiniMeet);
   Promotional_WrapperList.add(promotionWrap_Bombarding);
   
  }
  if (columnflag == true) {
  // Retailing_WrapperList.add(promotionWrap_KeyContacts);
   Sales_WrapperList.add(promotionWrap_primary_V4);
   Sales_WrapperList.add(promotionWrap_primary_Column);
   //Market_WrapperList.add(promotionWrap_newDealer);
   Market_WrapperList.add(Dealerclub_billing);
   Retailing_WrapperList.add(promotionWrap_newDealer);  // added to channel management
   Promotional_WrapperList.add(promotionWrap_MegaMeet);
   Promotional_WrapperList.add( promotionWrap_influencer_col);
  Promotional_WrapperList.add(promotionWrap_MiniMeet);
  // Market_WrapperList.add(promotionWrap_DP_Activation);
   Branding_WrapperList.add(branding);
   //Promotional_WrapperList.add(promotionWrap_Bombarding_Column);
   Retailing_WrapperList.add(promotionWrap_Bombarding_Column);
  
   
  }
  if (projectflag == true) {
   Retailing_WrapperList.add(promotionWrap_Contractors);
   Promotional_WrapperList.add(promotionWrap_ISM);
   Promotional_WrapperList.add(promotionWrap_MiniFarmersMeet);
   Promotional_WrapperList.add(promotionWrap_exhibition);
   Market_WrapperList.add(promotionWrap_factory);
   Market_WrapperList.add(promotionWrap_newDistributor);
   Market_WrapperList.add(promotionWrap_newDealer);
  }
  
  // Retailing_WrapperList.add(promotionWrap_retailing);
  //  Retailing_WrapperList.add(promotionWrap_Visits);
  // Retailing_WrapperList.add(promotionWrap_ContactVisits);

  // Market_WrapperList.add(promotionWrap_newMarket); uncommet
  //Market_WrapperList.add(promotionWrap_newDirectDealer);
  //Market_WrapperList.add(promotionWrap_newDealer);uncommet
  Sales_WrapperList.add(promotionWrap_secondary);
  //Sales_WrapperList.add(promotionWrap_primary);

  //Sales_WrapperList.add(promotionWrap_secondary);
  //Retailing_WrapperList.add(promotionWrap_retailing);
  // Retailing_WrapperList.add(promotionWrap_Visits);
  // Retailing_WrapperList.add(promotionWrap_ContactVisits);
  // Retailing_WrapperList.add(promotionWrap_Mechanic);
  //Retailing_WrapperList.add(promotionWrap_Borewell);

  //  Market_WrapperList.add(promotionWrap_newMarket);
  // Market_WrapperList.add(promotionWrap_newDealer);
  // Market_WrapperList.add(promotionWrap_newDistributor);

  // Sales_WrapperList.add(promotionWrap_primary);
  // Sales_WrapperList.add(promotionWrap_secondary);
  //Promotional_WrapperList.add(promotionWrap_exhibition);
  //Promotional_WrapperList.add(promotionWrap_JeepCampaign);
  //Promotional_WrapperList.add(promotionWrap_MEGAMEET);
  // Promotional_WrapperList.add(promotionWrap_MiniMeet);
  // Promotional_WrapperList.add(promotionWrap_sandyshow);
  // Promotional_WrapperList.add(promotionWrap_TractorShow); 


 }


 public class PromotionalWrapper {

  public string promotionalActivity {
   get;
   set;
  }
  public decimal Target {
   get;
   set;
  }
  public decimal Actual {
   get;
   set;
  }
  public decimal Achvd {
   get;
   set;
  }
  public decimal Weightage {
   get;
   set;
  }
  public decimal Score {
   get;
   set;
  }

  public PromotionalWrapper() {

   promotionalActivity = '';
   Target = 0;
   Actual = 0;
   Achvd = 0;
   Weightage = 0;
   Score = 0;
  }

 }
}