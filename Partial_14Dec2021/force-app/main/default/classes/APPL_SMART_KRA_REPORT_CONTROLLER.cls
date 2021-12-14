/*  
    Author: Satyanarayana
    Description : SMART KRA Controller : Generate SMART KRA Report for particular Month based on the User.
    Date : 21/06/2015    */

public class APPL_SMART_KRA_REPORT_CONTROLLER {
    
    public static integer NUMBER_OF_YEARS = 2; // Smart KRA Report to access no. of years.
    private map<Integer, String> monthsMap = new map<Integer, String>{1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May',6 => 'June', 7 => 'July', 8 => 'August', 9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December'};
        
    public Target__c target                                   {get; set;}
    public String selectedMonth                               {get; set;}
    public String selectedYear                                {get; set;}
    public list<SelectOption> months                          {get; set;}
    public list<SelectOption> years                           {get; set;}
    public list<PromotionalWrapper> retailing_WrapperList     {get; set;}
    public list<PromotionalWrapper> promotional_WrapperList   {get; set;}
    public list<PromotionalWrapper> market_WrapperList        {get; set;}
    public list<PromotionalWrapper> sales_WrapperList         {get; set;}
    public list<PromotionalWrapper> branding_WrapperList      {get; set;}
    public boolean plumbingFlag                               {get; set;}
    public boolean projectFlag                                {get; set;}
    public boolean columnFlag                                 {get; set;}
    public string targetVertical                              {get; set;}
    public string targetUser                                  {get; set;}
    public string targetUserId                                {get; set;}
    public Boolean SelectSubordinates                         {get; set;}
    public list<selectOption> UsersList                       {get; set;}
    public string profileName                                 {get; set;}
    public list<user> usersIdList     =   new list<user>();
    public double retailPercent                               {get; set;}
    public double promotionalPercent                          {get; set;}
    public double networkPercent                              {get; set;}
    public double salesPercent                                {get; set;}
    public double brandingPercent                             {get; set;}
    
    //list<SelectOption> otherValues = new list<SelectOption>();
    /***************************/
    public static List<User> userList;
    public static Map<Id,User> mapUser;
    
    /******************************/
    public APPL_SMART_KRA_REPORT_CONTROLLER() {
        
        Date currentDate           =   Date.today();
        selectedMonth              =   string.valueOf(currentDate.Month());
        selectedYear               =   string.valueOf(currentDate.year());
        plumbingFlag               =   false;
        columnFlag                 =   false;
        projectFlag                =   false;
        targetVertical             =   '';
        targetUser                 =   '';
        targetUserId               =   '';
        profileName                =   '';
        populateMonths();
        UsersList                  =   new list<selectOption>();
        User LoggedInUser          =   new User();
        Id profileId               =   userinfo.getProfileId();
        profileName                =   [Select Id,Name from Profile where Id=:profileId].Name;
        
        if(profileName != 'System Administrator' && profileName != 'HO NEW' && profileName != 'Customer Support Team') {
          
        LoggedInUser               =   [select id, Name, Role__c from User where id =: UserInfo.getUserid()];
        UsersList.add(new SelectOption('', '--None--'));
        if(LoggedInUser.get('Role__c') != null) {
        UsersList.add(new SelectOption(LoggedInUser.Id, LoggedInUser.Name +' - '+LoggedInUser.Role__c));
        }
        usersIdList.add(LoggedInUser);
        
                while(usersIdList.size() > 0) {
                  
                  //usersIdList = querySubordinates(usersIdList);
                  for(User u :querySubordinates(usersIdList)) {
                    if(u.get('Role__c') != null) {
                    UsersList.add(new selectOption(u.Id, u.Name +' - '+u.Role__c));
                    }
                    usersIdList.add(u);
                  }
                }
        } else {
          
          target                    =    new Target__c();
        }
    }
   public static void initializeList(){
   String type1,type2,type3;
   type1='BDM';
   type2='SR-BDM';
   type3='BDE';
       userList=[select id,ManagerId,Role__c from User where isActive=true and ManagerId!='' AND ( Role__c=:type1 OR Role__c=:type2 OR Role__c=:type3)];
       mapUser=new Map<Id,User>();
   }
   public static void getAllUsers(String usrId ){
       for(User u:userList){
           if((u.ManagerId==usrId ) && (u.ManagerId!=null)){
                mapUser.put(u.Id,u);
                getAllUsers(u.Id);
           }
      }
   }
   
    //Query Users based on the Users
    public list<User> querySubordinates (list<User> userIds) {
      
      usersIdList = new list<User>();
      list<user> userTempId = new list<User>();
      for(User userData : [select id, Name, Role__c from user where ManagerId IN: userIds And isActive=true]) {
        userTempId.add(userData);
      }
      return userTempId;
    }
    //Populate Months & Years in the Picklist.
    public void populateMonths() {
        
        months                    =    new List<SelectOption>();
        years                     =    new List<SelectOption>();
        months.add(new SelectOption('','--None--'));
        years.add(new SelectOption('','--None--'));
        
        for(Integer monthVal : monthsMap.keySet()) {
          
            months.add(new SelectOption(string.valueOf(monthVal), monthsMap.get(monthVal)));
        }
        
        for(integer i = NUMBER_OF_YEARS-1; i > -1 ; i--) {
            
            integer currentYear = Date.today().year();
            integer x = currentYear-i;
            years.add(new SelectOption(string.valueOf(x), string.valueOf(x))); 
        }
    }
    //Retrive KRA data from the DB.
    public void rertieveKRAData() {
        
        
        Integer KRA_SelectedYear           =  Integer.valueOf(SelectedYear);
        Integer KRA_SelectedMonth          =  Integer.valueOf(SelectedMonth);
        Integer KRA_NumberOfDays           =  date.daysInMonth(KRA_SelectedYear, KRA_SelectedMonth);
        string KRA_TargetUserId            =  '';
        
        if(profileName != 'System Administrator' && profileName != 'HO NEW' && profileName != 'Customer Support Team') {
            KRA_TargetUserId               =  targetUserId;//target.Target_User__c;
          
        } else {
          KRA_TargetUserId               =  target.Target_User__c;
        }
        Retailing_WrapperList              =  new list<PromotionalWrapper>();
        Promotional_WrapperList            =  new list<PromotionalWrapper>();
        Market_WrapperList                 =  new list<PromotionalWrapper>();
        Sales_WrapperList                  =  new list<PromotionalWrapper>();
        Branding_WrapperList               =  new list<PromotionalWrapper>();
        Date startDateOfMonth              =  Date.newInstance(KRA_SelectedYear, KRA_SelectedMonth, 1);
        Date endDateOfMonth                =  Date.newInstance(KRA_SelectedYear, KRA_SelectedMonth, KRA_NumberOfDays);
        string targetQuery                 =  'Select ';
        Decimal actual1                    =0.0;
        Target__c targetInstance           =  new Target__c();
        List<Target__c > targetInstanceList=new List<Target__c >();
       try {
          targetInstance = [select Vertical__c from Target__c where ownerId =: KRA_TargetUserId and Start_Date__c =: startDateOfMonth AND End_Date__c =: endDateOfMonth limit 1];
       
       
        } catch(Exception e) {
          
        }
           /*******************************************************/
           
           PromotionalWrapper  Retailing_Wrapper=new PromotionalWrapper();
            PromotionalWrapper  Wrapper_Visits=new PromotionalWrapper();
             PromotionalWrapper  Wrapper_ContactVisits   =new PromotionalWrapper();   
              PromotionalWrapper   Wrapper_Influencers=new PromotionalWrapper();
                      
            PromotionalWrapper    Wrapper_MegaMeet =new PromotionalWrapper();
             PromotionalWrapper   Wrapper_MiniMeet=new PromotionalWrapper();
              PromotionalWrapper  Wrapper_primaryCPVC  =new PromotionalWrapper();
           PromotionalWrapper   Wrapper_KeyContacts=new PromotionalWrapper();
           PromotionalWrapper    Wrapper_primaryAqua=new PromotionalWrapper();
      PromotionalWrapper    Wrapper_primarySWR=new PromotionalWrapper();
            PromotionalWrapper     Wrapper_secondary=new PromotionalWrapper();
         PromotionalWrapper     Wrapper_newMarket =new PromotionalWrapper();
        PromotionalWrapper     Wrapper_primary_Column  =new PromotionalWrapper();
         PromotionalWrapper     Wrapper_ISM  =new PromotionalWrapper();
      PromotionalWrapper        Wrapper_exhibition  =new PromotionalWrapper();
       PromotionalWrapper        wrapper_one =new PromotionalWrapper();
       PromotionalWrapper        wrapper_Two =new PromotionalWrapper();
       PromotionalWrapper        wrapper_Three =new PromotionalWrapper();
       PromotionalWrapper        wrapper_Four =new PromotionalWrapper();
        PromotionalWrapper       wrapper_Five=new PromotionalWrapper();
     //initialize all variables to zero
     Retailing_Wrapper.Target=0;
     Retailing_Wrapper.Actual=0;
      Retailing_Wrapper.Achvd=0;
     Retailing_Wrapper.Weightage=0;
     Retailing_Wrapper.Score=0;
     
      Wrapper_Visits.Target=0;
     Wrapper_Visits.Actual=0;
     Wrapper_Visits.Achvd=0;
     Wrapper_Visits.Weightage=0;
      Wrapper_Visits.Score=0;
     
   
        Wrapper_ContactVisits.Target=0;
       Wrapper_ContactVisits.Actual=0;
       Wrapper_ContactVisits.Achvd=0;
       Wrapper_ContactVisits.Weightage=0;
        Wrapper_ContactVisits.Score=0;
        
         Wrapper_Influencers.Target=0;
       Wrapper_Influencers.Actual=0;
       Wrapper_Influencers.Achvd=0;
       Wrapper_Influencers.Weightage=0;
        Wrapper_Influencers.Score=0;
        
      
       
          Wrapper_MegaMeet.Target=0;
       Wrapper_MegaMeet.Actual=0;
       Wrapper_MegaMeet.Achvd=0;
       Wrapper_MegaMeet.Weightage=0;
        Wrapper_MegaMeet.Score=0;
       
        
           Wrapper_MiniMeet.Target=0;
        Wrapper_MiniMeet.Actual=0;
        Wrapper_MiniMeet.Achvd=0;
        Wrapper_MiniMeet.Weightage=0;
         Wrapper_MiniMeet.Score=0;
         
        
         Wrapper_primaryCPVC.Target=0;
         Wrapper_primaryCPVC.Actual=0;
        Wrapper_primaryCPVC.Achvd=0;
         Wrapper_primaryCPVC.Weightage=0;
          Wrapper_primaryCPVC.Score=0;
          
           
           
         Wrapper_KeyContacts.Target=0;
         Wrapper_KeyContacts.Actual=0;
        Wrapper_KeyContacts.Achvd=0;
         Wrapper_KeyContacts.Weightage=0;
          Wrapper_KeyContacts.Score=0;
          
          
            Wrapper_primaryAqua.Target=0;
         Wrapper_primaryAqua.Actual=0;
        Wrapper_primaryAqua.Achvd=0;
         Wrapper_primaryAqua.Weightage=0;
          Wrapper_primaryAqua.Score=0;
          
          
            Wrapper_primaryAqua.Target=0;
         Wrapper_primaryAqua.Actual=0;
        Wrapper_primaryAqua.Achvd=0;
         Wrapper_primaryAqua.Weightage=0;
          Wrapper_primaryAqua.Score=0;
          
          
            Wrapper_primarySWR.Target=0;
         Wrapper_primarySWR.Actual=0;
         Wrapper_primarySWR.Achvd=0;
          Wrapper_primarySWR.Weightage=0;
           Wrapper_primarySWR.Score=0;
          
             Wrapper_secondary.Target=0;
         Wrapper_secondary.Actual=0;
         Wrapper_secondary.Achvd=0;
          Wrapper_secondary.Weightage=0;
           Wrapper_secondary.Score=0;
           
           
           
           
              Wrapper_newMarket .Target=0;
         Wrapper_newMarket .Actual=0;
         Wrapper_newMarket .Achvd=0;
          Wrapper_newMarket .Weightage=0;
           Wrapper_newMarket .Score=0;
           
            
             Wrapper_primary_Column.Target=0;
         Wrapper_primary_Column.Actual=0;
         Wrapper_primary_Column.Achvd=0;
          Wrapper_primary_Column.Weightage=0;
           Wrapper_primary_Column.Score=0;
         
           
          Wrapper_ISM.Target=0;
         Wrapper_ISM.Actual=0;
         Wrapper_ISM.Achvd=0;
          Wrapper_ISM.Weightage=0;
           Wrapper_ISM.Score=0;
           
            Wrapper_exhibition .Target=0;
         Wrapper_exhibition .Actual=0;
         Wrapper_exhibition .Achvd=0;
          Wrapper_exhibition .Weightage=0;
           Wrapper_exhibition .Score=0;
           
           
wrapper_one.Target=0;
wrapper_one.Actual=0;
wrapper_Two.Target=0;
wrapper_Three.Target=0;
wrapper_Four.Target=0;
wrapper_Five.Achvd=0; 
wrapper_Five.Weightage=0;
 wrapper_Five.Score=0;       
        
          
     //end
           if(SelectSubordinates){
           try{
           APPL_SMART_KRA_REPORT_CONTROLLER.initializeList();
              APPL_SMART_KRA_REPORT_CONTROLLER.getAllUsers(KRA_TargetUserId);
               targetInstanceList.addAll([select id ,Retailing_days_Target_field_work__c,Retailing_days_field_work_ACHVD__c,Retailing_days_field_work__c,Retailing_days_field_work_Weightage__c,Retailing_days_Score_field_work__c,No_of_visits_Target_total_visits__c,No_of_visits_total_visits__c,No_of_visits_total_visits_ACHVD__c,No_of_visits_Weightage_total_visits__c,No_of_visits_Score_field_work__c,Contacts_visit_Target_Plumbers__c,
                                            Contacts_visit_Plumbers_etc__c,Contacts_visit_Plumbers_ACHVD__c,Contacts_visit_Weightage_Plumbers__c,Contacts_visit_Score_Plumbers__c,Key_influencers_Target_Arch_consultant__c,
                                            Key_influencers_contact_Arch_consultant__c ,Key_influencers_Arch_consultant_ACHVD__c,Key_influencers_Weighta_Arch_consultant__c,Key_influencers_Score_Arch_consultant__c,
                                             Mega_Meets_Plumbing__c,Mega_Meets_Plumbing_Actual__c,Mega_Meets_ACHVD__c,Mega_Meets_Weightage__c,Mega_Meets_Score__c,
                                             ISP_Meets_Plumbing__c,Inshop_Plumber_Meets_Actual__c,Inshop_Plumber_Meet_ACHVD__c,Inshop_Plumber_Meet_Weightage__c,Inshop_Plumber_Meet_Score__c,PRIMARY_SALES_CPVC__c,Primary_Sales_CPVC_Actuals__c,Primary_Sales_CPVC_ACHVD__c,
                                              Primary_Sales_CPVC_Weightage__c,Primary_Sales_CPVC_Score__c,PRIMARY_SALES_UPVC__c,Primary_Sales_Aqua_Actuals__c,Primary_Sales_Aqua_ACHVD__c,Primary_Sales_Aqua_Weightage__c,Primary_Sales_Aqua_Score__c,
                                              PRIMARY_SALES_SWR__c,Primary_Sales_SWR_Actuals__c,Primary_Sales_SWR_ACHVD__c,Primary_Sales_SWR_Weightage__c,Primary_Sales_SWR_Score__c,   Secondary_Sales_Target__c,Secondary_Sales_Actual_In_Lacs__c,Secondary_Sales_ACHVD__c,
                                              Secondary_Sales_Weightage__c,Secondary_Sales_Score__c,NEW_DIRECT_DEALER_TO_DEPOT__c,New_Direct_Dealer_To_Depot_Actual__c,
                                              New_Markets_Opened_ACHVD__c,New_Markets_Opened_Weightage__c,New_Markets_Opened_Score__c,
                                                Primary_Sales_Target__c,Primary_Sales_Actuals__c,Primary_Sales_ACHVD__c,Primary_Sales_Weightage__c,Primary_Sales_Score__c,                                             
                                              InShop_Mechanic_Meet__c,Plumbing_DSM_Meet_Training_ACHVD__c,Plumbing_DSM_Meet_Training_Weightage__c,Plumbing_DSM_Meet_Training_Score__c,
                                              Exhibition__c,Exhibition_Actual__c,Exhibitions_ACHVD__c,Exhibitions_Weightage__c,Exhibitions_Score__c,
                                              Plumbing_DSM_Meet_Training__c,Plumbing_DSM_Meet_Training_Actual__c,New_markets_opened__c,New_dealers_activation__c,New_distributer_activation__c,New_dealers_activation_ACHVD__c,New_dealers_activation_Score__c,New_dealers_activation_Weightage__c
                                              from Target__c where ownerId in: mapUser.keyset() and Start_Date__c =: startDateOfMonth AND End_Date__c =: endDateOfMonth]);
            
           System.debug( '^^^^^^^^^^^^^^^^^^$$$$$$$$ targetInstanceList%%%%%%%%%%%%%%%%'+  targetInstanceList);
           
            }catch(Exception ex){  System.debug(ex.getMessage());}
              
               if(targetInstanceList.size()>0){
               try{
                   for(Target__c  temp:targetInstanceList){
                   //Retail
              
    Retailing_Wrapper.Target                    =  Retailing_Wrapper.Target +  ((temp.Retailing_days_Target_field_work__c==null)?0:temp.Retailing_days_Target_field_work__c);  //Head_Quarter_No_of_Days__c + HEAD_QUARTER_METRO_No_Of_Days__c + Head_Quarter_State_Capital_No_of_days__c + Ex_Station_No_of_Days__c + Out_Station_No_of_Days__c
                Retailing_Wrapper.Actual                    =   Retailing_Wrapper.Actual+((temp.Retailing_days_field_work__c==null)?0:temp.Retailing_days_field_work__c)  ; // Total Visits where Record Type equals to Visits. 
                Retailing_Wrapper.Achvd                     =    Retailing_Wrapper.Achvd+(( temp.Retailing_days_field_work_ACHVD__c==null)?0: temp.Retailing_days_field_work_ACHVD__c) ;               
                Retailing_Wrapper.Weightage                 =   Retailing_Wrapper.Weightage+(( temp.Retailing_days_field_work_Weightage__c==null)?0: temp.Retailing_days_field_work_Weightage__c) ;
                Retailing_Wrapper.Score                     =   Retailing_Wrapper.Score+(( temp.Retailing_days_Score_field_work__c==null)?0:temp.Retailing_days_Score_field_work__c) ;
                //Visits

                Wrapper_Visits.Target                       =   Wrapper_Visits.Target  +((temp.No_of_visits_Target_total_visits__c==null)?0:temp.No_of_visits_Target_total_visits__c); //Head_Quarter_Daily_Calls__c + HEAD_QUARTER_METRO_Daily_Calls__c + Head_Quarter_State_Capital_Daily_Calls__c + Out_Station_Daily_Calls__c + Ex_Station_Daily_Calls__c
                Wrapper_Visits.Actual                       =    Wrapper_Visits.Actual+(( temp.No_of_visits_total_visits__c==null)?0: temp.No_of_visits_total_visits__c); //Total Visits under Target.
                Wrapper_Visits.Achvd                        =     Wrapper_Visits.Achvd+(( temp.No_of_visits_total_visits_ACHVD__c==null)?0:temp.No_of_visits_total_visits_ACHVD__c) ;     
                Wrapper_Visits.Weightage                    =   Wrapper_Visits.Weightage +((  temp.No_of_visits_Weightage_total_visits__c==null)?0: temp.No_of_visits_Weightage_total_visits__c) ;
                Wrapper_Visits.Score                        =   Wrapper_Visits.Score+((  temp.No_of_visits_Score_field_work__c==null)?0: temp.No_of_visits_Score_field_work__c) ;
                //ContactVisits
        Wrapper_ContactVisits.Target=Wrapper_ContactVisits.Target+ ((temp.Contacts_visit_Target_Plumbers__c==null)?0:temp.Contacts_visit_Target_Plumbers__c);
       Wrapper_ContactVisits.Actual= Wrapper_ContactVisits.Actual+((temp.Contacts_visit_Plumbers_etc__c==null)?0:temp.Contacts_visit_Plumbers_etc__c) ;
       Wrapper_ContactVisits.Achvd=  Wrapper_ContactVisits.Achvd+((temp.Contacts_visit_Plumbers_ACHVD__c==null)?0:temp.Contacts_visit_Plumbers_ACHVD__c); 
       Wrapper_ContactVisits.Weightage=Wrapper_ContactVisits.Weightage+((temp.Contacts_visit_Weightage_Plumbers__c==null)?0:temp.Contacts_visit_Weightage_Plumbers__c);
        Wrapper_ContactVisits.Score=  Wrapper_ContactVisits.Score  +(( temp.Contacts_visit_Score_Plumbers__c==null)?0:temp.Contacts_visit_Score_Plumbers__c);
        //Influencers
        
           Wrapper_Influencers.Target= Wrapper_Influencers.Target+(( temp.Key_influencers_Target_Arch_consultant__c==null)?0: temp.Key_influencers_Target_Arch_consultant__c);
       Wrapper_Influencers.Actual=  Wrapper_Influencers.Actual+((temp.Key_influencers_contact_Arch_consultant__c ==null)?0:temp.Key_influencers_contact_Arch_consultant__c ) ;
       Wrapper_Influencers.Achvd= Wrapper_Influencers.Achvd+((temp.Key_influencers_Arch_consultant_ACHVD__c ==null)?0:temp.Key_influencers_Arch_consultant_ACHVD__c );
       Wrapper_Influencers.Weightage=   Wrapper_Influencers.Weightage+((temp.Key_influencers_Weighta_Arch_consultant__c ==null)?0:temp.Key_influencers_Weighta_Arch_consultant__c ) ;
        Wrapper_Influencers.Score=Wrapper_Influencers.Score+((temp.Key_influencers_Score_Arch_consultant__c==null)?0:temp.Key_influencers_Score_Arch_consultant__c ) ;
      
        
        //MegaMeet
       
          Wrapper_MegaMeet.Target= Wrapper_MegaMeet.Target+((temp.Mega_Meets_Plumbing__c==null)?0:temp.Mega_Meets_Plumbing__c);
           Wrapper_MegaMeet.Actual= Wrapper_MegaMeet.Actual+((temp.Mega_Meets_Plumbing_Actual__c==null)?0:temp.Mega_Meets_Plumbing_Actual__c) ;
            Wrapper_MegaMeet.Achvd= Wrapper_MegaMeet.Achvd+((temp.Mega_Meets_ACHVD__c==null)?0:temp.Mega_Meets_ACHVD__c) ;
             Wrapper_MegaMeet.Weightage= Wrapper_MegaMeet.Weightage+ ((temp.Mega_Meets_Weightage__c==null)?0:temp.Mega_Meets_Weightage__c);
            Wrapper_MegaMeet.Score=Wrapper_MegaMeet.Score+((temp.Mega_Meets_Score__c==null)?0:temp.Mega_Meets_Score__c); 
            
            
            //Minimeet
   Wrapper_MiniMeet.Target=  Wrapper_MiniMeet.Target+((temp.ISP_Meets_Plumbing__c==null)?0:temp.ISP_Meets_Plumbing__c);
      Wrapper_MiniMeet.Actual= Wrapper_MiniMeet.Actual+((temp.Inshop_Plumber_Meets_Actual__c==null)?0:temp.Inshop_Plumber_Meets_Actual__c);
        Wrapper_MiniMeet.Achvd=  Wrapper_MiniMeet.Achvd+((temp.Inshop_Plumber_Meet_ACHVD__c==null)?0:temp.Inshop_Plumber_Meet_ACHVD__c) ;
        Wrapper_MiniMeet.Weightage=  Wrapper_MiniMeet.Weightage+(( temp.Inshop_Plumber_Meet_Weightage__c==null)?0: temp.Inshop_Plumber_Meet_Weightage__c);
         Wrapper_MiniMeet.Score= Wrapper_MiniMeet.Score+((  temp.Inshop_Plumber_Meet_Score__c==null)?0:  temp.Inshop_Plumber_Meet_Score__c);
      
      //Sales Volume.
  
        
         Wrapper_primaryCPVC.Target= Wrapper_primaryCPVC.Target+(( temp.PRIMARY_SALES_CPVC__c==null)?0:temp.PRIMARY_SALES_CPVC__c);
         Wrapper_primaryCPVC.Actual= Wrapper_primaryCPVC.Actual+(( temp.Primary_Sales_CPVC_Actuals__c==null)?0:temp.Primary_Sales_CPVC_Actuals__c);
        Wrapper_primaryCPVC.Achvd= Wrapper_primaryCPVC.Achvd+(( temp.Primary_Sales_CPVC_ACHVD__c==null)?0:temp.Primary_Sales_CPVC_ACHVD__c);
         Wrapper_primaryCPVC.Weightage=  Wrapper_primaryCPVC.Weightage+(( temp.Primary_Sales_CPVC_Weightage__c==null)?0:temp.Primary_Sales_CPVC_Weightage__c);
          Wrapper_primaryCPVC.Score=Wrapper_primaryCPVC.Score+(( temp.Primary_Sales_CPVC_Score__c==null)?0:temp.Primary_Sales_CPVC_Score__c);
     

    Wrapper_primaryAqua.Target= Wrapper_primaryAqua.Target+(( temp.PRIMARY_SALES_UPVC__c==null)?0: temp.PRIMARY_SALES_UPVC__c);
         Wrapper_primaryAqua.Actual=Wrapper_primaryAqua.Actual+(( temp.Primary_Sales_Aqua_Actuals__c==null)?0: temp.Primary_Sales_Aqua_Actuals__c);
        Wrapper_primaryAqua.Achvd=Wrapper_primaryAqua.Achvd+(( temp.Primary_Sales_Aqua_ACHVD__c==null)?0: temp.Primary_Sales_Aqua_ACHVD__c);
         Wrapper_primaryAqua.Weightage= Wrapper_primaryAqua.Weightage+(( temp.Primary_Sales_Aqua_Weightage__c==null)?0: temp.Primary_Sales_Aqua_Weightage__c);
          Wrapper_primaryAqua.Score=Wrapper_primaryAqua.Score+(( temp.Primary_Sales_Aqua_Score__c==null)?0: temp.Primary_Sales_Aqua_Score__c);
  
  
  
             Wrapper_primarySWR.Target=Wrapper_primarySWR.Target+(( temp.PRIMARY_SALES_SWR__c==null)?0: temp.PRIMARY_SALES_SWR__c);
          Wrapper_primarySWR.Actual=Wrapper_primarySWR.Actual+(( temp.Primary_Sales_SWR_Actuals__c==null)?0: temp.Primary_Sales_SWR_Actuals__c);
         Wrapper_primarySWR.Achvd= Wrapper_primarySWR.Achvd+(( temp.Primary_Sales_SWR_ACHVD__c==null)?0: temp.Primary_Sales_SWR_ACHVD__c);
          Wrapper_primarySWR.Weightage= Wrapper_primarySWR.Weightage+(( temp.Primary_Sales_SWR_Weightage__c==null)?0: temp.Primary_Sales_SWR_Weightage__c);
           Wrapper_primarySWR.Score=Wrapper_primarySWR.Score+(( temp.Primary_Sales_SWR_Score__c==null)?0: temp.Primary_Sales_SWR_Score__c);
          
          
           //secondary sales
           
          
             Wrapper_secondary.Target= Wrapper_secondary.Target+((temp.Secondary_Sales_Target__c==null)?0:temp.Secondary_Sales_Target__c);
         Wrapper_secondary.Actual=   Wrapper_secondary.Actual+((temp.Secondary_Sales_Actual_In_Lacs__c==null)?0:temp.Secondary_Sales_Actual_In_Lacs__c);
         Wrapper_secondary.Achvd=  Wrapper_secondary.Achvd+((temp.Secondary_Sales_ACHVD__c==null)?0:temp.Secondary_Sales_ACHVD__c);
          Wrapper_secondary.Weightage=Wrapper_secondary.Weightage+((temp.Secondary_Sales_Weightage__c==null)?0:temp.Secondary_Sales_Weightage__c);
           Wrapper_secondary.Score=Wrapper_secondary.Score+((temp.Secondary_Sales_Score__c==null)?0:temp.Secondary_Sales_Score__c);
        
        
      //vertical==column//.
        
   Wrapper_KeyContacts.Target=Wrapper_KeyContacts.Target+((temp.Contact_Visit_Target_MECHANICS_WINDERS__c==null)?0:temp.Contact_Visit_Target_MECHANICS_WINDERS__c) + ((temp.Contact_Visits_Target_BOREWELL_OPERATOR__c ==null)?0:temp.Contact_Visits_Target_BOREWELL_OPERATOR__c)+((temp.Contact_Visits_Target_FARMERS_PANCHAYAT__c==null)?0:temp.Contact_Visits_Target_FARMERS_PANCHAYAT__c);
     Wrapper_KeyContacts.Actual=Wrapper_KeyContacts.Actual+((temp.Contact_Visit_Actual_MECHANICS_WINDERS__c==null)?0:temp.Contact_Visit_Actual_MECHANICS_WINDERS__c) + ((temp.Contact_Visits_Actual_BOREWELL_OPERATOR__c ==null)?0:temp.Contact_Visits_Actual_BOREWELL_OPERATOR__c )+((temp.Contact_Visits_Actual_FARMERS_PANCHAYAT__c==null)?0:temp.Contact_Visits_Actual_FARMERS_PANCHAYAT__c);
   Wrapper_KeyContacts.Achvd=Wrapper_KeyContacts.Achvd+(( temp.Contact_Visit_ACHVD_MECHANICS_WINDERS__c==null)?0: temp.Contact_Visit_ACHVD_MECHANICS_WINDERS__c) + ((temp.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c ==null)?0:temp.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c )+((temp.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c==null)?0:temp.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c);
      Wrapper_KeyContacts.Weightage=Wrapper_KeyContacts.Weightage+(( temp.Contact_Visit_Weighta_MECHANICS_WINDERS__c==null)?0: temp.Contact_Visit_Weighta_MECHANICS_WINDERS__c) + ((temp.Contact_Visit_Weighta_BOREWELL_OPERATOR__c ==null)?0:temp.Contact_Visit_Weighta_BOREWELL_OPERATOR__c )+((temp.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c==null)?0:temp.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c);
     Wrapper_KeyContacts.Score=Wrapper_KeyContacts.Score+(( temp.Contact_Visit_Score_MECHANICS_WINDERS__c==null)?0: temp.Contact_Visit_Score_MECHANICS_WINDERS__c) + ((temp.Contact_Visit_Score_BOREWELL_OPERATOR__c ==null)?0:temp.Contact_Visit_Score_BOREWELL_OPERATOR__c )+((temp.Contact_Visit_Score_FARMERS_PANCHAYAT__c==null)?0:temp.Contact_Visit_Score_FARMERS_PANCHAYAT__c);
 
  ////Market Development
         Wrapper_newMarket.Target= Wrapper_newMarket.Target+(( temp.NEW_DIRECT_DEALER_TO_DEPOT__c==null)?0: temp.NEW_DIRECT_DEALER_TO_DEPOT__c);
         Wrapper_newMarket .Actual= Wrapper_newMarket .Actual+((temp.New_Direct_Dealer_To_Depot_Actual__c==null)?0: temp.New_Direct_Dealer_To_Depot_Actual__c);
         Wrapper_newMarket .Achvd=  Wrapper_newMarket .Achvd+((temp.New_Markets_Opened_ACHVD__c==null)?0: temp.New_Markets_Opened_ACHVD__c);
          Wrapper_newMarket .Weightage= Wrapper_newMarket .Weightage+((temp.New_Markets_Opened_Weightage__c==null)?0: temp.New_Markets_Opened_Weightage__c);
           Wrapper_newMarket .Score=Wrapper_newMarket.Score+((temp.New_Markets_Opened_Score__c==null)?0: temp.New_Markets_Opened_Score__c);
          
          //sales
           
        Wrapper_primary_Column.Target=Wrapper_primary_Column.Target+((temp.Primary_Sales_Target__c==null)?0:temp.Primary_Sales_Target__c);
         Wrapper_primary_Column.Actual=Wrapper_primary_Column.Actual+((temp.Primary_Sales_Actuals__c==null)?0:temp.Primary_Sales_Actuals__c);
         Wrapper_primary_Column.Achvd=Wrapper_primary_Column.Achvd+((temp.Primary_Sales_ACHVD__c==null)?0:temp.Primary_Sales_ACHVD__c);
          Wrapper_primary_Column.Weightage=Wrapper_primary_Column.Weightage+((temp.Primary_Sales_Weightage__c==null)?0:temp.Primary_Sales_Weightage__c);
           Wrapper_primary_Column.Score=Wrapper_primary_Column.Score+((temp.Primary_Sales_Score__c==null)?0:temp.Primary_Sales_Score__c);
   
   //Plumbing
     
          Wrapper_ISM.Target=Wrapper_ISM.Target+((temp.InShop_Mechanic_Meet__c==null)?0:temp.InShop_Mechanic_Meet__c);
        // Wrapper_ISM.Actual=Wrapper_ISM.Actual+((target.Inshop_Mechanic_Meets_Actual__c==null)?0:target.Inshop_Mechanic_Meets_Actual__c);
        
         Wrapper_ISM.Achvd=Wrapper_ISM.Achvd+((temp.Plumbing_DSM_Meet_Training_ACHVD__c==null)?0:temp.Plumbing_DSM_Meet_Training_ACHVD__c);
              Wrapper_ISM.Weightage=Wrapper_ISM.Weightage+((temp.Plumbing_DSM_Meet_Training_Weightage__c==null)?0:temp.Plumbing_DSM_Meet_Training_Weightage__c);
            Wrapper_ISM.Score=Wrapper_ISM.Score+((temp.Plumbing_DSM_Meet_Training_Score__c==null)?0:temp.Plumbing_DSM_Meet_Training_Score__c);
           
   
   //exhibition
     Wrapper_exhibition.Target=Wrapper_exhibition.Target+((temp.Exhibition__c==null)?0:temp.Exhibition__c);
         Wrapper_exhibition.Actual=Wrapper_exhibition.Actual+((temp.Exhibition_Actual__c==null)?0:temp.Exhibition_Actual__c);
         Wrapper_exhibition.Achvd=Wrapper_exhibition.Achvd+((temp.Exhibitions_ACHVD__c==null)?0:temp.Exhibitions_ACHVD__c);
  Wrapper_exhibition.Weightage=Wrapper_exhibition.Weightage+((temp.Exhibitions_Weightage__c==null)?0:temp.Exhibitions_Weightage__c);
     Wrapper_exhibition.Score=Wrapper_exhibition.Score+((temp.Exhibitions_Score__c==null)?0:temp.Exhibitions_Score__c);
           
      //
      wrapper_one.Target=wrapper_one.Target+((temp.Plumbing_DSM_Meet_Training__c==null)?0:temp.Plumbing_DSM_Meet_Training__c);
wrapper_one.Actual=wrapper_one.Target+((temp.Plumbing_DSM_Meet_Training_Actual__c==null)?0:temp.Plumbing_DSM_Meet_Training_Actual__c);
wrapper_Two.Target=wrapper_Two.Target+((temp.New_markets_opened__c==null)?0:temp.New_markets_opened__c);
wrapper_Three.Target=wrapper_Three.Target+((temp.New_dealers_activation__c==null)?0:temp.New_dealers_activation__c);
wrapper_Four.Target=wrapper_Four.Target+((temp.New_distributer_activation__c==null)?0:temp.New_distributer_activation__c);
wrapper_Five.Achvd=wrapper_Five.Achvd+((temp.New_dealers_activation_ACHVD__c==null)?0:temp.New_dealers_activation_ACHVD__c);
wrapper_Five.Weightage=wrapper_Five.Weightage+((temp.New_dealers_activation_Weightage__c==null)?0:temp.New_dealers_activation_Weightage__c);
wrapper_Five.Score=wrapper_Five.Score+((temp.New_dealers_activation_Score__c==null)?0:temp.New_dealers_activation_Score__c);
   
  
                   } 
                   }
                   catch(Exception ex){
                   System.debug(ex.getMessage());
                   }  
               }
           }                         
           
           
           /***********************************************************************/
        
        
        if(targetInstance.Vertical__c == 'Plumbing') {
        set<id> accountIdSet = new set<id>();
                
                for(AccountHistory accHistory : [select accountId, CreatedDate, NewValue, OldValue from AccountHistory where CreatedById =: KRA_TargetUserId and CALENDAR_YEAR(CreatedDate) =: KRA_SelectedYear and CALENDAR_MONTH(CreatedDate) =: KRA_SelectedMonth and Account.Status__c = 'Existing'] ) {
                   if((accHistory.NewValue == 'Existing') || (accHistory.NewValue == null)) {
                  accountIdSet.add(accHistory.accountId);
                   }
                }
                
                if(accountIdSet.size() > 0) {
                  
                  string [] recordTypeIdList     =  new String[2]; 
                  string dealerRecordTypeId      =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(); 
                  string distributorRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
                  recordTypeIdList.add(dealerRecordTypeId);
                  recordTypeIdList.add(distributorRecordTypeId);
                  Integer dealerRecordCount      = 0;
                  Integer distributorRecordCount = 0;
                  
                for(Account acc : [select id, recordTypeId from Account where id IN: accountIdSet and RecordTypeId IN: recordTypeIdList]) {
                  
                  if(acc.RecordTypeId == dealerRecordTypeId) {
                    system.debug('DealerXXXX');
                    dealerRecordCount += 1;
                    } else if(acc.RecordTypeId == distributorRecordTypeId) {
                      distributorRecordCount += 1;
                      system.debug('DistributorXXXX');
                    }
                }
                
                targetInstance.New_dealers_activation_Actual__c           =    dealerRecordCount;
                targetInstance.New_Distributer_Activation_Actuals__c      =    distributorRecordCount;
                update targetInstance;
            }
        } else if(targetInstance.Vertical__c == 'Column') {
          set<id> accountIdSet = new set<id>();
                
                for(AccountHistory accHistory : [select accountId, CreatedDate, NewValue, OldValue from AccountHistory where CreatedById =: KRA_TargetUserId and CALENDAR_YEAR(CreatedDate) =: KRA_SelectedYear and CALENDAR_MONTH(CreatedDate) =: KRA_SelectedMonth]) {
                   if(accHistory.NewValue == 'Existing') {
                  accountIdSet.add(accHistory.accountId);
                   }
                }
                
                if(accountIdSet.size() > 0) {
                  
                  string [] recordTypeIdList      =  new String[3]; 
                  string dealerRecordTypeId       =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Dealer').getRecordTypeId(); 
                  string distributorRecordTypeId  =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Distributor').getRecordTypeId();
                  string directDealerRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByName().get('Direct Dealer').getRecordTypeId();
                  
                  recordTypeIdList.add(dealerRecordTypeId);
                  recordTypeIdList.add(distributorRecordTypeId);
                  recordTypeIdList.add(directDealerRecordTypeId);
                  
                  Integer dealerRecordCount       =  0;
                  Integer distributorRecordCount  =  0;
                  Integer directDealerRecordCount =  0;
                  
                for(Account acc : [select id, recordTypeId from Account where id IN: accountIdSet and RecordTypeId IN: recordTypeIdList]) {
                  
                  if(acc.RecordTypeId == dealerRecordTypeId) {                 
                    dealerRecordCount += 1;
                    } else if(acc.RecordTypeId == distributorRecordTypeId) {
                      distributorRecordCount += 1;
                    } else if(acc.RecordTypeId == directDealerRecordTypeId) {
                      directDealerRecordCount += 1;
                    }
                }
                
                targetInstance.New_dealers_activation_Actual__c           =    dealerRecordCount;
                targetInstance.New_Distributer_Activation_Actuals__c      =    distributorRecordCount;
                update targetInstance;
            }          
        }
        
        Schema.DescribeSObjectResult r = Target__c.sObjectType.getDescribe();
        
        for(string apiName : r.fields.getMap().keySet()){
            targetQuery += apiName +',';
        }
        
        targetQuery = targetQuery.subString(0, targetQuery.length() - 1);
        targetQuery += ' FROM Target__c WHERE Start_Date__c =: startDateOfMonth AND End_Date__c =: endDateOfMonth And OwnerId =: KRA_TargetUserId Limit 1';
        
       
        try {
            // Make your dynamic call
            target                     =   Database.query(targetQuery);
            targetVertical             =   target.Vertical__c.toUpperCase();
            targetUser                 =   target.Owner_Name__c.toUpperCase();
           
            //Plumbing Vertical ------------------- KRA Report.
            if(target.Vertical__c == 'Plumbing') {
              
              retailPercent=0;
              networkPercent =0;
              promotionalPercent=0;
              salesPercent =0;
              brandingPercent=0;
              plumbingflag = true;
              columnflag = false;
                projectFlag = false;
                
              //RETAILING - START
                PromotionalWrapper promotionWrap_retailing        =    new PromotionalWrapper();
                promotionWrap_retailing.promotionalActivity       =    'Retailing Days (Field Work)';
               promotionWrap_retailing.Target                    =     Retailing_Wrapper.Target +((target.Retailing_days_Target_field_work__c==null)?0:target.Retailing_days_Target_field_work__c);  //Head_Quarter_No_of_Days__c + HEAD_QUARTER_METRO_No_Of_Days__c + Head_Quarter_State_Capital_No_of_days__c + Ex_Station_No_of_Days__c + Out_Station_No_of_Days__c
                promotionWrap_retailing.Actual                    =   Retailing_Wrapper.Actual+(( target.Retailing_days_field_work__c==null)?0: target.Retailing_days_field_work__c) ; // Total Visits where Record Type equals to Visits. 
                promotionWrap_retailing.Achvd                     =    Retailing_Wrapper.Achvd+(( target.Retailing_days_field_work_ACHVD__c==null)?0: target.Retailing_days_field_work_ACHVD__c);                 
                promotionWrap_retailing.Weightage                 =   Retailing_Wrapper.Weightage+(( target.Retailing_days_field_work_Weightage__c==null)?0:  target.Retailing_days_field_work_Weightage__c) ;
                promotionWrap_retailing.Score                     =    Retailing_Wrapper.Score+(( target.Retailing_days_Score_field_work__c==null)?0:target.Retailing_days_Score_field_work__c) ;
                
                PromotionalWrapper promotionWrap_Visits           =    new PromotionalWrapper();
                promotionWrap_Visits.promotionalActivity          =    'No. Of Visits (Total Visits)';
               promotionWrap_Visits.Target                       =    Wrapper_Visits.Target  +((target.No_of_visits_Target_total_visits__c==null)?0:target.No_of_visits_Target_total_visits__c); //Head_Quarter_Daily_Calls__c + HEAD_QUARTER_METRO_Daily_Calls__c + Head_Quarter_State_Capital_Daily_Calls__c + Out_Station_Daily_Calls__c + Ex_Station_Daily_Calls__c
                promotionWrap_Visits.Actual                       =     Wrapper_Visits.Actual+((target.No_of_visits_total_visits__c==null)?0:target.No_of_visits_total_visits__c)  ; //Total Visits under Target.
                promotionWrap_Visits.Achvd                        =    Wrapper_Visits.Achvd+((target.No_of_visits_total_visits_ACHVD__c==null)?0:target.No_of_visits_total_visits_ACHVD__c);     
                promotionWrap_Visits.Weightage                    =     Wrapper_Visits.Weightage +((target.No_of_visits_Weightage_total_visits__c==null)?0:target.No_of_visits_Weightage_total_visits__c) ;
                promotionWrap_Visits.Score                        =     Wrapper_Visits.Score+((target.No_of_visits_Score_field_work__c==null)?0:target.No_of_visits_Score_field_work__c)  ;
                 
                PromotionalWrapper promotionWrap_ContactVisits    =    new PromotionalWrapper();
                promotionWrap_ContactVisits.promotionalActivity   =    'Contacts Visit (Plumbers etc)';
                  promotionWrap_ContactVisits.Target                =   Wrapper_ContactVisits.Target+(( target.Contacts_visit_Target_Plumbers__c==null)?0:target.Contacts_visit_Target_Plumbers__c); //40% of total visits(Target)
                promotionWrap_ContactVisits.Actual                =   Wrapper_ContactVisits.Actual +(( target.Contacts_visit_Plumbers_etc__c==null)?0:target.Contacts_visit_Plumbers_etc__c) ;
                promotionWrap_ContactVisits.Achvd                 =  Wrapper_ContactVisits.Achvd + ((target.Contacts_visit_Plumbers_ACHVD__c==null)?0:target.Contacts_visit_Plumbers_ACHVD__c);               
                promotionWrap_ContactVisits.Weightage             =  Wrapper_ContactVisits.Weightage+(( target.Contacts_visit_Weightage_Plumbers__c==null)?0: target.Contacts_visit_Weightage_Plumbers__c);
                promotionWrap_ContactVisits.Score                 =  Wrapper_ContactVisits.Score+((target.Contacts_visit_Score_Plumbers__c==null)?0:target.Contacts_visit_Score_Plumbers__c);
              
                PromotionalWrapper promotionWrap_Influencers      =    new PromotionalWrapper();
                promotionWrap_Influencers.promotionalActivity     =    'Key Influencers Contact(Arch/consultant)';
                promotionWrap_Influencers.Target                  =    Wrapper_Influencers.Target +((target.Key_influencers_Target_Arch_consultant__c==null)?0:target.Key_influencers_Target_Arch_consultant__c); //10% of contact vist(Target)
                promotionWrap_Influencers.Actual                  =    Wrapper_Influencers.Actual +((target.Key_influencers_contact_Arch_consultant__c==null)?0:target.Key_influencers_contact_Arch_consultant__c)  ;
                promotionWrap_Influencers.Achvd                   =     Wrapper_Influencers.Achvd+((target.Key_influencers_Arch_consultant_ACHVD__c==null)?0:target.Key_influencers_Arch_consultant_ACHVD__c)  ;               
                promotionWrap_Influencers.Weightage               =     Wrapper_Influencers.Weightage+((target.Key_influencers_Weighta_Arch_consultant__c==null)?0:target.Key_influencers_Weighta_Arch_consultant__c)  ;
                promotionWrap_Influencers.Score                   =      Wrapper_Influencers.Score+((target.Key_influencers_Score_Arch_consultant__c==null)?0:target.Key_influencers_Score_Arch_consultant__c)  ;
                
                retailPercent=(100 * (promotionWrap_Influencers.Actual + promotionWrap_ContactVisits.Actual+promotionWrap_Visits.Actual+ promotionWrap_retailing.Actual)/(promotionWrap_Influencers.Weightage+promotionWrap_ContactVisits.Weightage +  promotionWrap_Visits.Weightage + promotionWrap_retailing.Weightage)).setscale(2);
                
                Retailing_WrapperList.add(promotionWrap_retailing);
                Retailing_WrapperList.add(promotionWrap_Visits);
                Retailing_WrapperList.add(promotionWrap_ContactVisits);
                Retailing_WrapperList.add(promotionWrap_Influencers);
                
                PromotionalWrapper branding   =    new PromotionalWrapper();
                branding.promotionalActivity   =    '';
                branding.Target                =    0; //40% of total visits(Target)
                branding.Actual                =    0;
                branding.Achvd                 =    0;               
                branding.Weightage             =    5;
                branding.Score                 =    0;
                brandingPercent= (100*(branding.Actual)/(branding.Weightage)).setscale(2);
                Branding_WrapperList.add(branding);
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
                
                PromotionalWrapper promotionWrap_MegaMeet        =     new PromotionalWrapper();
                promotionWrap_MegaMeet.promotionalActivity       =     'Mega Meets (incl dealer meet)';
                promotionWrap_MegaMeet.Target                    =   Wrapper_MegaMeet.Target+((target.Mega_Meets_Plumbing__c==null)?0:target.Mega_Meets_Plumbing__c);
                promotionWrap_MegaMeet.Actual                    =     Wrapper_MegaMeet.Actual+((target.Mega_Meets_Plumbing_Actual__c==null)?0:target.Mega_Meets_Plumbing_Actual__c) ;
                promotionWrap_MegaMeet.Achvd                     =    Wrapper_MegaMeet.Achvd+((target.Mega_Meets_ACHVD__c==null)?0:target.Mega_Meets_ACHVD__c) ;
                promotionWrap_MegaMeet.Weightage                 = Wrapper_MegaMeet.Weightage+ ((target.Mega_Meets_Weightage__c==null)?0:target.Mega_Meets_Weightage__c);
                promotionWrap_MegaMeet.Score                     = Wrapper_MegaMeet.Score+((target.Mega_Meets_Score__c==null)?0:target.Mega_Meets_Score__c); 
                
                
                PromotionalWrapper promotionWrap_MiniMeet        =     new PromotionalWrapper();
                promotionWrap_MiniMeet.promotionalActivity       =     'Mini Meets';
                promotionWrap_MiniMeet.Target                    =     Wrapper_MiniMeet.Target+((target.ISP_Meets_Plumbing__c==null)?0:target.ISP_Meets_Plumbing__c);               
                promotionWrap_MiniMeet.Actual                    =     Wrapper_MiniMeet.Actual+((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
                promotionWrap_MiniMeet.Weightage                 =  Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_MiniMeet.Achvd                     =   Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
                promotionWrap_MiniMeet.Score                     =    Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                
                promotionalPercent =(100 * (promotionWrap_MiniMeet.Actual+ promotionWrap_MegaMeet.Actual)/(promotionWrap_MiniMeet.Weightage + promotionWrap_MegaMeet.Weightage)).setscale(2);
                //Promotional_WrapperList.add(promotionWrap_Exhibition);
               // Promotional_WrapperList.add(promotionWrap_Dealers);
                Promotional_WrapperList.add(promotionWrap_MegaMeet);
                Promotional_WrapperList.add(promotionWrap_MiniMeet);
                
                //Market Development
               /* PromotionalWrapper promotionWrap_newMarket       =     new PromotionalWrapper();
                promotionWrap_newMarket.promotionalActivity      =     'New Markets Opened';
                promotionWrap_newMarket.Target                   =     target.New_markets_opened__c;
                promotionWrap_newMarket.Actual                   =     0;
                //New_Markets_Opened_Actuals__c;
                promotionWrap_newMarket.Achvd                    =     target.New_Markets_Opened_ACHVD__c;
                promotionWrap_newMarket.Weightage                =     target.New_Markets_Opened_Weightage__c;
                promotionWrap_newMarket.Score                    =     target.New_Markets_Opened_Score__c;*/
                
                PromotionalWrapper promotionWrap_newDealer       =     new PromotionalWrapper();
                promotionWrap_newDealer.promotionalActivity      =     'Retail outlet activation';
                promotionWrap_newDealer.Target                   =     wrapper_Three.Target+((target.New_dealers_activation__c==null)?0:target.New_dealers_activation__c);
                if(target.New_dealers_activation_Actual__c == null){
                target.New_dealers_activation_Actual__c =0;}
                promotionWrap_newDealer.Actual                   =     target.New_dealers_activation_Actual__c;
                promotionWrap_newDealer.Achvd                    =     wrapper_Five.Achvd+((target.New_dealers_activation_ACHVD__c==null)?0:target.New_dealers_activation_ACHVD__c);
                promotionWrap_newDealer.Weightage                =     wrapper_Five.Weightage+((target.New_dealers_activation_Weightage__c==null)?0:target.New_dealers_activation_Weightage__c);
                promotionWrap_newDealer.Score                    =     wrapper_Five.Score+((target.New_dealers_activation_Score__c==null)?0:target.New_dealers_activation_Score__c);

                networkPercent =(100 * promotionWrap_newDealer.Actual/promotionWrap_newDealer.Weightage).setscale(2);
              /*PromotionalWrapper promotionWrap_newDistributor  =     new PromotionalWrapper();
                promotionWrap_newDistributor.promotionalActivity =     'New Distributer Activation';
                promotionWrap_newDistributor.Target              =     target.New_distributer_activation__c;
                promotionWrap_newDistributor.Actual              =     target.New_Distributer_Activation_Actuals__c;
                promotionWrap_newDistributor.Achvd               =     target.New_Distributer_Activation_ACHVD__c;
                promotionWrap_newDistributor.Weightage           =     target.New_Distributer_Activation_Weightage__c;
                promotionWrap_newDistributor.Score               =     target.New_Distributor_Activation_Score__c;*/
               
       // Market_WrapperList.add(promotionWrap_newMarket);
        Market_WrapperList.add(promotionWrap_newDealer);
       // Market_WrapperList.add(promotionWrap_newDistributor);
        
        //Sales Volume.
        PromotionalWrapper promotionWrap_primaryCPVC         =     new PromotionalWrapper();
        promotionWrap_primaryCPVC.promotionalActivity        =     'Primary Sales - CPVC';
        promotionWrap_primaryCPVC.Target                     =   Wrapper_primaryCPVC.Target+(( target.PRIMARY_SALES_CPVC__c==null)?0:target.PRIMARY_SALES_CPVC__c) ;
        if(target.Primary_Sales_CPVC_Actuals__c == null){
        target.Primary_Sales_CPVC_Actuals__c =0;}
        promotionWrap_primaryCPVC.Actual                     =   Wrapper_primaryCPVC.Actual+(( target.Primary_Sales_CPVC_Actuals__c==null)?0:target.Primary_Sales_CPVC_Actuals__c);
        promotionWrap_primaryCPVC.Achvd                      = Wrapper_primaryCPVC.Achvd+(( target.Primary_Sales_CPVC_ACHVD__c==null)?0:target.Primary_Sales_CPVC_ACHVD__c);
        promotionWrap_primaryCPVC.Weightage                  =   Wrapper_primaryCPVC.Weightage+(( target.Primary_Sales_CPVC_Weightage__c==null)?0:target.Primary_Sales_CPVC_Weightage__c);
        promotionWrap_primaryCPVC.Score                      =   Wrapper_primaryCPVC.Score+(( target.Primary_Sales_CPVC_Score__c==null)?0:target.Primary_Sales_CPVC_Score__c);
          
       
        PromotionalWrapper promotionWrap_primaryAqua         =     new PromotionalWrapper();
        promotionWrap_primaryAqua.promotionalActivity        =     'Primary Sales - Aqua';
        promotionWrap_primaryAqua.Target                     =   Wrapper_primaryAqua.Target+(( target.PRIMARY_SALES_UPVC__c==null)?0: target.PRIMARY_SALES_UPVC__c);

        if(target.Primary_Sales_Aqua_Actuals__c == null){
        target.Primary_Sales_Aqua_Actuals__c=0;}
        promotionWrap_primaryAqua.Actual                     = Wrapper_primaryAqua.Actual+(( target.Primary_Sales_Aqua_Actuals__c==null)?0: target.Primary_Sales_Aqua_Actuals__c);
        promotionWrap_primaryAqua.Achvd                      =   Wrapper_primaryAqua.Achvd+(( target.Primary_Sales_Aqua_ACHVD__c==null)?0: target.Primary_Sales_Aqua_ACHVD__c);
        promotionWrap_primaryAqua.Weightage                  =   Wrapper_primaryAqua.Weightage+(( target.Primary_Sales_Aqua_Weightage__c==null)?0: target.Primary_Sales_Aqua_Weightage__c);
        promotionWrap_primaryAqua.Score                      =  Wrapper_primaryAqua.Score+(( target.Primary_Sales_Aqua_Score__c==null)?0: target.Primary_Sales_Aqua_Score__c);
  
        
       
        
        PromotionalWrapper promotionWrap_primarySWR         =     new PromotionalWrapper();
        promotionWrap_primarySWR.promotionalActivity        =     'Primary Sales -SWR';
        promotionWrap_primarySWR.Target                     =    Wrapper_primarySWR.Target+(( target.PRIMARY_SALES_SWR__c==null)?0: target.PRIMARY_SALES_SWR__c);
          if(target.Primary_Sales_SWR_Actuals__c == null){
        target.Primary_Sales_SWR_Actuals__c =0;
        }
        promotionWrap_primarySWR.Actual                    =Wrapper_primarySWR.Actual + (( target.Primary_Sales_SWR_Actuals__c==null)?0: target.Primary_Sales_SWR_Actuals__c);
        promotionWrap_primarySWR.Achvd                     = Wrapper_primarySWR.Achvd+(( target.Primary_Sales_SWR_ACHVD__c==null)?0: target.Primary_Sales_SWR_ACHVD__c);
         promotionWrap_primarySWR.Weightage                = Wrapper_primarySWR.Weightage+ (( target.Primary_Sales_SWR_Weightage__c==null)?0: target.Primary_Sales_SWR_Weightage__c);
         promotionWrap_primarySWR.Score                    = Wrapper_primarySWR.Score +(( target.Primary_Sales_SWR_Score__c==null)?0: target.Primary_Sales_SWR_Score__c);
          
        
        
       
        
        PromotionalWrapper promotionWrap_secondary       =     new PromotionalWrapper();
        promotionWrap_secondary.promotionalActivity      =     'Secondary Sales (Rs. In Lacs)';
        promotionWrap_secondary.Target                   =      Wrapper_secondary.Target+((target.Secondary_Sales_Target__c==null)?0:target.Secondary_Sales_Target__c);
        promotionWrap_secondary.Actual                   =     Wrapper_secondary.Actual+((target.Secondary_Sales_Actual_In_Lacs__c==null)?0:target.Secondary_Sales_Actual_In_Lacs__c);
        promotionWrap_secondary.Achvd                    =    Wrapper_secondary.Achvd+((target.Secondary_Sales_ACHVD__c==null)?0:target.Secondary_Sales_ACHVD__c);
        promotionWrap_secondary.Weightage                =   Wrapper_secondary.Weightage+((target.Secondary_Sales_Weightage__c==null)?0:target.Secondary_Sales_Weightage__c);
        promotionWrap_secondary.Score                    =  Wrapper_secondary.Score+((target.Secondary_Sales_Score__c==null)?0:target.Secondary_Sales_Score__c);
            
          system.debug('target.Secondary_Sales_Actual_In_Lacs__c ;;;;'+ target.Secondary_Sales_Actual_In_Lacs__c);
                 system.debug('Wrapper_primaryAqua.Actual ;;;;'+ Wrapper_primaryAqua.Actual); 
         system.debug('promotionWrap_secondary.Actual ;;;;'+ promotionWrap_secondary.Actual);
        Sales_WrapperList.add(promotionWrap_primaryCPVC);
        Sales_WrapperList.add(promotionWrap_primaryAqua);
        Sales_WrapperList.add(promotionWrap_primarySWR);
        Sales_WrapperList.add(promotionWrap_secondary);
        
        system.debug('Sales_WrapperList:::'+ Sales_WrapperList);
        salesPercent = (100 *(promotionWrap_secondary.Actual+promotionWrap_primarySWR.Actual+promotionWrap_primaryAqua.Actual+promotionWrap_primaryCPVC.Actual)/(promotionWrap_secondary.Weightage+promotionWrap_primarySWR.Weightage+promotionWrap_primaryAqua.Weightage+promotionWrap_primaryCPVC.Weightage)).setscale(2);
            } else if(target.Vertical__c == 'Column') {
              
              plumbingflag                                     =     false;
              columnflag                                       =     true;
                projectFlag                                      =     false;
              
              //RETAILING - START
               PromotionalWrapper promotionWrap_retailing        =    new PromotionalWrapper();
                promotionWrap_retailing.promotionalActivity       =    'Retailing Days (Field Work)';
               promotionWrap_retailing.Target                    =     Retailing_Wrapper.Target +((target.Retailing_days_Target_field_work__c==null)?0:target.Retailing_days_Target_field_work__c);  //Head_Quarter_No_of_Days__c + HEAD_QUARTER_METRO_No_Of_Days__c + Head_Quarter_State_Capital_No_of_days__c + Ex_Station_No_of_Days__c + Out_Station_No_of_Days__c
                promotionWrap_retailing.Actual                    =   Retailing_Wrapper.Actual+(( target.Retailing_days_field_work__c==null)?0: target.Retailing_days_field_work__c) ; // Total Visits where Record Type equals to Visits. 
                promotionWrap_retailing.Achvd                     =    Retailing_Wrapper.Achvd+(( target.Retailing_days_field_work_ACHVD__c==null)?0: target.Retailing_days_field_work_ACHVD__c);                 
                promotionWrap_retailing.Weightage                 =   Retailing_Wrapper.Weightage+(( target.Retailing_days_field_work_Weightage__c==null)?0:  target.Retailing_days_field_work_Weightage__c) ;
                promotionWrap_retailing.Score                     =    Retailing_Wrapper.Score+(( target.Retailing_days_Score_field_work__c==null)?0:target.Retailing_days_Score_field_work__c) ;
                
                PromotionalWrapper promotionWrap_Visits           =    new PromotionalWrapper();
                promotionWrap_Visits.promotionalActivity          =    'No. Of Visits (Total Visits)';
               promotionWrap_Visits.Target                       =    Wrapper_Visits.Target  +((target.No_of_visits_Target_total_visits__c==null)?0:target.No_of_visits_Target_total_visits__c); //Head_Quarter_Daily_Calls__c + HEAD_QUARTER_METRO_Daily_Calls__c + Head_Quarter_State_Capital_Daily_Calls__c + Out_Station_Daily_Calls__c + Ex_Station_Daily_Calls__c
                promotionWrap_Visits.Actual                       =     Wrapper_Visits.Actual+((target.No_of_visits_total_visits__c==null)?0:target.No_of_visits_total_visits__c)  ; //Total Visits under Target.
                promotionWrap_Visits.Achvd                        =    Wrapper_Visits.Achvd+((target.No_of_visits_total_visits_ACHVD__c==null)?0:target.No_of_visits_total_visits_ACHVD__c);     
                promotionWrap_Visits.Weightage                    =     Wrapper_Visits.Weightage +((target.No_of_visits_Weightage_total_visits__c==null)?0:target.No_of_visits_Weightage_total_visits__c) ;
                promotionWrap_Visits.Score                        =     Wrapper_Visits.Score+((target.No_of_visits_Score_field_work__c==null)?0:target.No_of_visits_Score_field_work__c)  ;
                 
                PromotionalWrapper promotionWrap_ContactVisits    =    new PromotionalWrapper();
                promotionWrap_ContactVisits.promotionalActivity   =    'Contacts Visit (Plumbers etc)';
                  promotionWrap_ContactVisits.Target                =   Wrapper_ContactVisits.Target+(( target.Contacts_visit_Target_Plumbers__c==null)?0:target.Contacts_visit_Target_Plumbers__c); //40% of total visits(Target)
                promotionWrap_ContactVisits.Actual                =   Wrapper_ContactVisits.Actual +(( target.Contacts_visit_Plumbers_etc__c==null)?0:target.Contacts_visit_Plumbers_etc__c) ;
                promotionWrap_ContactVisits.Achvd                 =  Wrapper_ContactVisits.Achvd + ((target.Contacts_visit_Plumbers_ACHVD__c==null)?0:target.Contacts_visit_Plumbers_ACHVD__c);               
                promotionWrap_ContactVisits.Weightage             =  Wrapper_ContactVisits.Weightage+(( target.Contacts_visit_Weightage_Plumbers__c==null)?0: target.Contacts_visit_Weightage_Plumbers__c);
                promotionWrap_ContactVisits.Score                 =  Wrapper_ContactVisits.Score+((target.Contacts_visit_Score_Plumbers__c==null)?0:target.Contacts_visit_Score_Plumbers__c);
               
                PromotionalWrapper promotionWrap_KeyContacts        =     new PromotionalWrapper();
                promotionWrap_KeyContacts.promotionalActivity       =     'Key Influencers Contact (Panchayat Head, Mechanics, Borers, Borewell office)';
                promotionWrap_KeyContacts.Target                    =   Wrapper_KeyContacts.Target+((target.Contact_Visit_Target_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_Target_MECHANICS_WINDERS__c) + ((target.Contact_Visits_Target_BOREWELL_OPERATOR__c ==null)?0:target.Contact_Visits_Target_BOREWELL_OPERATOR__c)+((target.Contact_Visits_Target_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visits_Target_FARMERS_PANCHAYAT__c);
                promotionWrap_KeyContacts.Actual                    =    Wrapper_KeyContacts.Target+((target.Contact_Visit_Actual_MECHANICS_WINDERS__c==null)?0:target.Contact_Visit_Actual_MECHANICS_WINDERS__c) + ((target.Contact_Visits_Actual_BOREWELL_OPERATOR__c ==null)?0:target.Contact_Visits_Actual_BOREWELL_OPERATOR__c )+((target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c);
                promotionWrap_KeyContacts.Achvd                     =     Wrapper_KeyContacts.Target+(( target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c==null)?0: target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c) + ((target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c ==null)?0:target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c )+((target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c);
                promotionWrap_KeyContacts.Weightage                 =  Wrapper_KeyContacts.Target+(( target.Contact_Visit_Weighta_MECHANICS_WINDERS__c==null)?0: target.Contact_Visit_Weighta_MECHANICS_WINDERS__c) + ((target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c ==null)?0:target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c )+((target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c);
                promotionWrap_KeyContacts.Score                     =  Wrapper_KeyContacts.Target+(( target.Contact_Visit_Score_MECHANICS_WINDERS__c==null)?0: target.Contact_Visit_Score_MECHANICS_WINDERS__c) + ((target.Contact_Visit_Score_BOREWELL_OPERATOR__c ==null)?0:target.Contact_Visit_Score_BOREWELL_OPERATOR__c )+((target.Contact_Visit_Score_FARMERS_PANCHAYAT__c==null)?0:target.Contact_Visit_Score_FARMERS_PANCHAYAT__c);
      
                /* 
                PromotionalWrapper promotionWrap_Mechanic        =     new PromotionalWrapper();
                promotionWrap_Mechanic.promotionalActivity       =     'MECHANICS';
                promotionWrap_Mechanic.Target                    =     target.Contact_Visit_Target_MECHANICS_WINDERS__c;
                promotionWrap_Mechanic.Actual                    =     target.Contact_Visit_Actual_MECHANICS_WINDERS__c ;
                promotionWrap_Mechanic.Achvd                     =     target.Contact_Visit_ACHVD_MECHANICS_WINDERS__c;               
                promotionWrap_Mechanic.Weightage                 =     target.Contact_Visit_Weighta_MECHANICS_WINDERS__c;
                promotionWrap_Mechanic.Score                     =     target.Contact_Visit_Score_MECHANICS_WINDERS__c;
                
                
                PromotionalWrapper promotionWrap_Borewell        =     new PromotionalWrapper();
                promotionWrap_Borewell.promotionalActivity       =     'BOREWELL OPERATORS';
                promotionWrap_Borewell.Target                    =     target.Contact_Visits_Target_BOREWELL_OPERATOR__c;
                promotionWrap_Borewell.Actual                    =     target.Contact_Visits_Actual_BOREWELL_OPERATOR__c;
                promotionWrap_Borewell.Achvd                     =     target.Contact_Visit_ACHVD_BOREWELL_OPERATOR__c;               
                promotionWrap_Borewell.Weightage                 =     target.Contact_Visit_Weighta_BOREWELL_OPERATOR__c;
                promotionWrap_Borewell.Score                     =     target.Contact_Visit_Score_BOREWELL_OPERATOR__c;
                
                
                PromotionalWrapper promotionWrap_farmer          =     new PromotionalWrapper();
                promotionWrap_farmer.promotionalActivity         =     'PANCHAYAT HEAD';
                promotionWrap_farmer.Target                      =     target.Contact_Visits_Target_FARMERS_PANCHAYAT__c;
                promotionWrap_farmer.Actual                      =     target.Contact_Visits_Actual_FARMERS_PANCHAYAT__c;
                promotionWrap_farmer.Achvd                       =     target.Contact_Visit_ACHVD_FARMERS_PANCHAYAT__c;               
                promotionWrap_farmer.Weightage                   =     target.Contact_Visit_Weighta_FARMERS_PANCHAYAT__c;
                promotionWrap_farmer.Score                       =     target.Contact_Visit_Score_FARMERS_PANCHAYAT__c; 
                
                */
                
                
                Retailing_WrapperList.add(promotionWrap_retailing);
                Retailing_WrapperList.add(promotionWrap_Visits);
                Retailing_WrapperList.add(promotionWrap_ContactVisits);
                Retailing_WrapperList.add(promotionWrap_KeyContacts);
                //Retailing_WrapperList.add(promotionWrap_Borewell);
                //Retailing_WrapperList.add(promotionWrap_farmer);
                
                //PROMOTIONAL ACTIVITY - Start
               //actual code of column MegaMeets 
               /*
                PromotionalWrapper promotionWrap_MegaMeet        =     new PromotionalWrapper();
                promotionWrap_MegaMeet.promotionalActivity       =     'Mega Meets (incl dealer meet)';
                promotionWrap_MegaMeet.Target                    =   ((target.Mega_Meets_Plumbing__c==null)?0:target.Mega_Meets_Plumbing__c);
                promotionWrap_MegaMeet.Actual                    =     ((target.Mega_Meets_Plumbing_Actual__c==null)?0:target.Mega_Meets_Plumbing_Actual__c) ;
                promotionWrap_MegaMeet.Achvd                     =    ((target.Mega_Meets_ACHVD__c==null)?0:target.Mega_Meets_ACHVD__c) ;
                promotionWrap_MegaMeet.Weightage                 = ((target.Mega_Meets_Weightage__c==null)?0:target.Mega_Meets_Weightage__c);
                promotionWrap_MegaMeet.Score                     = ((target.Mega_Meets_Score__c==null)?0:target.Mega_Meets_Score__c); 
                
                
                PromotionalWrapper promotionWrap_MiniMeet        =     new PromotionalWrapper();
                promotionWrap_MiniMeet.promotionalActivity       =     'Mini Meets';
                promotionWrap_MiniMeet.Target                    =     ((target.ISP_Meets_Plumbing__c==null)?0:target.ISP_Meets_Plumbing__c);               
                promotionWrap_MiniMeet.Actual                    =    ((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
                promotionWrap_MiniMeet.Weightage                 =  (( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_MiniMeet.Achvd                     =   ((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
                promotionWrap_MiniMeet.Score                     =    ((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
               */
                //ends here
                
                //code copied from Plumbing Megameet 
                  PromotionalWrapper promotionWrap_MegaMeet        =     new PromotionalWrapper();
                promotionWrap_MegaMeet.promotionalActivity       =     'Mega Meets (incl dealer meet)';
                promotionWrap_MegaMeet.Target                    =   Wrapper_MegaMeet.Target+((target.Mega_Meets_Plumbing__c==null)?0:target.Mega_Meets_Plumbing__c);
                promotionWrap_MegaMeet.Actual                    =     Wrapper_MegaMeet.Actual+((target.Mega_Meets_Plumbing_Actual__c==null)?0:target.Mega_Meets_Plumbing_Actual__c) ;
                promotionWrap_MegaMeet.Achvd                     =    Wrapper_MegaMeet.Achvd+((target.Mega_Meets_ACHVD__c==null)?0:target.Mega_Meets_ACHVD__c) ;
                promotionWrap_MegaMeet.Weightage                 = Wrapper_MegaMeet.Weightage+ ((target.Mega_Meets_Weightage__c==null)?0:target.Mega_Meets_Weightage__c);
                promotionWrap_MegaMeet.Score                     = Wrapper_MegaMeet.Score+((target.Mega_Meets_Score__c==null)?0:target.Mega_Meets_Score__c); 
                
                
                PromotionalWrapper promotionWrap_MiniMeet        =     new PromotionalWrapper();
                promotionWrap_MiniMeet.promotionalActivity       =     'Mini Meets';
                promotionWrap_MiniMeet.Target                    =     Wrapper_MiniMeet.Target+((target.ISP_Meets_Plumbing__c==null)?0:target.ISP_Meets_Plumbing__c);               
                promotionWrap_MiniMeet.Actual                    =     Wrapper_MiniMeet.Actual+((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
                promotionWrap_MiniMeet.Weightage                 =  Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_MiniMeet.Achvd                     =   Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
                promotionWrap_MiniMeet.Score                     =    Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                
             
                //
               
                /*
                PromotionalWrapper promotionWrap_TractorShow     =     new PromotionalWrapper();
                promotionWrap_TractorShow.promotionalActivity    =     'Tractor Show';
                promotionWrap_TractorShow.Target                 =     target.Tractor_Show__c;
                promotionWrap_TractorShow.Actual                 =     target.Tractor_Show_Actual__c;
                promotionWrap_TractorShow.Achvd                  =     target.Tractor_Show_ACHVD__c;
                promotionWrap_TractorShow.Weightage              =     target.Tractor_Show_Column_Weightage__c;
                promotionWrap_TractorShow.Score                  =     target.Tractor_Show_Column_Score__c;
                
                PromotionalWrapper promotionWrap_JeepCampaign    =     new PromotionalWrapper();
                promotionWrap_JeepCampaign.promotionalActivity   =     'Jeep Campaign';
                promotionWrap_JeepCampaign.Target                =     target.Jeep_Campaign__c;
                promotionWrap_JeepCampaign.Actual                =     target.Jeep_Campaign_Actual__c;
                promotionWrap_JeepCampaign.Achvd                 =     target.Jeep_Campaign_ACHVD__c;
                promotionWrap_JeepCampaign.Weightage             =     target.Jeep_Campaign_Weightage__c;
                promotionWrap_JeepCampaign.Score                 =     target.Jeep_Campaign_Score__c;
                
                
                PromotionalWrapper promotionWrap_sandyshow       =     new PromotionalWrapper();
                promotionWrap_sandyshow.promotionalActivity      =     'Shandy Shows';
                promotionWrap_sandyshow.Target                   =     target.Shandy_Show__c;
                promotionWrap_sandyshow.Actual                   =     target.Shandy_Shows_Actuals__c;
                promotionWrap_sandyshow.Achvd                    =     target.Shandy_Shows_ACHVD__c;
                promotionWrap_sandyshow.Weightage                =     target.Shandy_Shows_Weightage__c;
                promotionWrap_sandyshow.Score                    =     target.Shandy_Shows_Score__c;
                
                PromotionalWrapper promotionWrap_exhibition = new PromotionalWrapper();
                promotionWrap_exhibition.promotionalActivity = 'Exhibitions';
                promotionWrap_exhibition.Target = target.Exhibition__c;
                promotionWrap_exhibition.Actual = target.Exhibition_Actual__c;
                promotionWrap_exhibition.Achvd = target.Exhibitions_ACHVD__c;
                promotionWrap_exhibition.Weightage = target.Exhibitions_Weightage__c;
                promotionWrap_exhibition.Score = target.Exhibitions_Score__c;  */
                
                              
                
                //Promotional_WrapperList.add(promotionWrap_exhibition);
                //Promotional_WrapperList.add(promotionWrap_JeepCampaign);
                Promotional_WrapperList.add(promotionWrap_MEGAMEET);
                Promotional_WrapperList.add(promotionWrap_MiniMeet);
                //Promotional_WrapperList.add(promotionWrap_sandyshow);
                //Promotional_WrapperList.add(promotionWrap_TractorShow); 
                
                
                //Market Development
                PromotionalWrapper promotionWrap_newMarket       =     new PromotionalWrapper();
                promotionWrap_newMarket.promotionalActivity      =     'No. of Shops';
                promotionWrap_newMarket.Target                   = Wrapper_newMarket.Target+(( target.NEW_DIRECT_DEALER_TO_DEPOT__c==null)?0: target.NEW_DIRECT_DEALER_TO_DEPOT__c);  
                promotionWrap_newMarket.Actual                   = Wrapper_newMarket .Actual+((target.New_Direct_Dealer_To_Depot_Actual__c==null)?0: target.New_Direct_Dealer_To_Depot_Actual__c);
                promotionWrap_newMarket.Achvd                    = Wrapper_newMarket .Achvd+((target.New_Markets_Opened_ACHVD__c==null)?0: target.New_Markets_Opened_ACHVD__c);
                promotionWrap_newMarket.Weightage                = Wrapper_newMarket .Weightage+((target.New_Markets_Opened_Weightage__c==null)?0: target.New_Markets_Opened_Weightage__c);
                promotionWrap_newMarket.Score                    =  Wrapper_newMarket.Score+((target.New_Markets_Opened_Score__c==null)?0: target.New_Markets_Opened_Score__c);
                
                
            
                
                /*
                PromotionalWrapper promotionWrap_newDirectDealer =     new PromotionalWrapper();
                promotionWrap_newDirectDealer.promotionalActivity=     'Activation Of Inactive Direct Dealer';
                promotionWrap_newDirectDealer.Target             =     target.Activation_Of_Inactive_Direct_Dealer__c;
                promotionWrap_newDirectDealer.Actual             =     target.New_Direct_Dealer_Activation__c;
                promotionWrap_newDirectDealer.Achvd              =     target.New_dealers_activation_ACHVD__c;
                promotionWrap_newDirectDealer.Weightage          =     target.New_dealers_activation_Weightage__c;
                promotionWrap_newDirectDealer.Score              =     target.New_dealers_activation_Score__c;
                
                PromotionalWrapper promotionWrap_newDistributor  =     new PromotionalWrapper();
                promotionWrap_newDistributor.promotionalActivity =     'Activation Of Inactive Distributor';
                promotionWrap_newDistributor.Target              =     target.Activation_Of_Inactive_Distributor__c;
                promotionWrap_newDistributor.Actual              =     target.New_Distributer_Activation_Actuals__c;
                promotionWrap_newDistributor.Achvd               =     target.New_Distributer_Activation_ACHVD__c;
                promotionWrap_newDistributor.Weightage           =     target.New_Distributer_Activation_Weightage__c;
                promotionWrap_newDistributor.Score               =     target.New_Distributor_Activation_Score__c;
                
                PromotionalWrapper promotionWrap_newDealer       =     new PromotionalWrapper();
                promotionWrap_newDealer.promotionalActivity      =     'Activation of Inactive Dealer';
                promotionWrap_newDealer.Target                   =     target.New_dealers_activation__c;
                promotionWrap_newDealer.Actual                   =     target.New_dealers_activation_Actual__c;
                promotionWrap_newDealer.Achvd                    =     target.New_dealers_activation_ACHVD__c;
                promotionWrap_newDealer.Weightage                =     target.New_dealers_activation_Weightage__c;
                promotionWrap_newDealer.Score                    =     target.New_dealers_activation_Score__c; */
                
               
        Market_WrapperList.add(promotionWrap_newMarket);
        //Market_WrapperList.add(promotionWrap_newDirectDealer);
        //Market_WrapperList.add(promotionWrap_newDealer);
        //Market_WrapperList.add(promotionWrap_newDistributor);
        
        
        //Sales Volume.
        PromotionalWrapper promotionWrap_primary_Column         =     new PromotionalWrapper();
        promotionWrap_primary_Column.promotionalActivity        =     'Primary Sales - Column (Rs. In Lacs)';
        promotionWrap_primary_Column.Target                     = Wrapper_primary_Column.Target+((target.Primary_Sales_Target__c==null)?0:target.Primary_Sales_Target__c);
        promotionWrap_primary_Column.Actual                     = Wrapper_primary_Column.Actual+((target.Primary_Sales_Actuals__c==null)?0:target.Primary_Sales_Actuals__c);
                promotionWrap_primary_Column.Achvd              = Wrapper_primary_Column.Achvd+((target.Primary_Sales_ACHVD__c==null)?0:target.Primary_Sales_ACHVD__c);
                promotionWrap_primary_Column.Weightage          = Wrapper_primary_Column.Weightage+((target.Primary_Sales_Weightage__c==null)?0:target.Primary_Sales_Weightage__c);
                promotionWrap_primary_Column.Score              = Wrapper_primary_Column.Score+((target.Primary_Sales_Score__c==null)?0:target.Primary_Sales_Score__c);
                
               
            /* //actual code   
        PromotionalWrapper promotionWrap_primary_V4         =     new PromotionalWrapper();
        promotionWrap_primary_V4.promotionalActivity        =     'Primary Sales - V4 (Rs. In Lacs)';
        promotionWrap_primary_V4.Target                     =     target.Primary_Sales_Target__c;
        promotionWrap_primary_V4.Actual                     =     target.Primary_Sales_Actuals__c;
                promotionWrap_primary_V4.Achvd                      =     target.Primary_Sales_ACHVD__c;
                promotionWrap_primary_V4.Weightage                  =     target.Primary_Sales_Weightage__c;
                promotionWrap_primary_V4.Score                      =     target.Primary_Sales_Score__c;
        *///actual code ends here
        //copied from promotionWrap_primary_Column
         PromotionalWrapper promotionWrap_primary_V4         =     new PromotionalWrapper();
        promotionWrap_primary_V4.promotionalActivity        =     'Primary Sales - V4 (Rs. In Lacs)';
        promotionWrap_primary_V4.Target                       =Wrapper_primary_Column.Target+((target.PRIMARY_SALES_V4__c==null)?0:target.PRIMARY_SALES_V4__c);
         promotionWrap_primary_V4.Actual                     = Wrapper_primary_Column.Actual+((target.Primary_Sales_Actuals__c==null)?0:target.Primary_Sales_Actuals__c);
           promotionWrap_primary_V4.Achvd                      = Wrapper_primary_Column.Achvd+((target.Primary_Sales_ACHVD__c==null)?0:target.Primary_Sales_ACHVD__c);
      promotionWrap_primary_V4.Weightage                  =   Wrapper_primary_Column.Weightage+((target.Primary_Sales_Weightage__c==null)?0:target.Primary_Sales_Weightage__c);
                 promotionWrap_primary_V4.Score                      =  Wrapper_primary_Column.Score+((target.Primary_Sales_Score__c==null)?0:target.Primary_Sales_Score__c);
              
                //ENDS HERE!! copied from promotionWrap_primary_Column
                
               /* //Actual code
        PromotionalWrapper promotionWrap_secondary       =     new PromotionalWrapper();
        promotionWrap_secondary.promotionalActivity      =     'Secondary Sales (Rs. In Lacs)';
        promotionWrap_secondary.Target                   =     target.Secondary_Sales_Target__c;
        promotionWrap_secondary.Actual                   =     target.Secondary_Sales_Actual_In_Lacs__c; //Secondary_Sales_Actual_Order_Value__c;
                promotionWrap_secondary.Achvd                    =     target.Secondary_Sales_ACHVD__c;
                promotionWrap_secondary.Weightage                =     target.Secondary_Sales_Weightage__c;
                promotionWrap_secondary.Score                    =     target.Secondary_Sales_Score__c;
                
                //Ends here*/
                                
                
                //
                   
        PromotionalWrapper promotionWrap_secondary       =     new PromotionalWrapper();
        promotionWrap_secondary.promotionalActivity      =     'Secondary Sales (Rs. In Lacs)';
        promotionWrap_secondary.Target                   =      Wrapper_secondary.Target+((target.Secondary_Sales_Target__c==null)?0:target.Secondary_Sales_Target__c);
        promotionWrap_secondary.Actual                   =     Wrapper_primaryAqua.Actual+((target.Secondary_Sales_Actual_In_Lacs__c==null)?0:target.Secondary_Sales_Actual_In_Lacs__c);
        promotionWrap_secondary.Achvd                    =    Wrapper_secondary.Achvd+((target.Secondary_Sales_ACHVD__c==null)?0:target.Secondary_Sales_ACHVD__c);
        promotionWrap_secondary.Weightage                =   Wrapper_secondary.Weightage+((target.Secondary_Sales_Weightage__c==null)?0:target.Secondary_Sales_Weightage__c);
        promotionWrap_secondary.Score                    =  Wrapper_secondary.Score+((target.Secondary_Sales_Score__c==null)?0:target.Secondary_Sales_Score__c);
           
              
                //
        Sales_WrapperList.add(promotionWrap_primary_Column);
        Sales_WrapperList.add(promotionWrap_primary_V4);
        Sales_WrapperList.add(promotionWrap_secondary);
              
              
            } 
            
            
            
            else if(target.Vertical__c == 'Projects') {
              
              plumbingflag = false;
              columnflag = false;
                projectFlag = true;
              system.debug(projectflag+'iiiiiiiiiiii');
              //RETAILING - START
                PromotionalWrapper promotionWrap_retailing        =    new PromotionalWrapper();
                promotionWrap_retailing.promotionalActivity       =    'Retailing Days (Field Work)';
               promotionWrap_retailing.Target                    =     Retailing_Wrapper.Target +((target.Retailing_days_Target_field_work__c==null)?0:target.Retailing_days_Target_field_work__c);  //Head_Quarter_No_of_Days__c + HEAD_QUARTER_METRO_No_Of_Days__c + Head_Quarter_State_Capital_No_of_days__c + Ex_Station_No_of_Days__c + Out_Station_No_of_Days__c
                promotionWrap_retailing.Actual                    =   Retailing_Wrapper.Actual+(( target.Retailing_days_field_work__c==null)?0: target.Retailing_days_field_work__c) ; // Total Visits where Record Type equals to Visits. 
                promotionWrap_retailing.Achvd                     =    Retailing_Wrapper.Achvd+(( target.Retailing_days_field_work_ACHVD__c==null)?0: target.Retailing_days_field_work_ACHVD__c);                 
                promotionWrap_retailing.Weightage                 =   Retailing_Wrapper.Weightage+(( target.Retailing_days_field_work_Weightage__c==null)?0:  target.Retailing_days_field_work_Weightage__c) ;
                promotionWrap_retailing.Score                     =    Retailing_Wrapper.Score+(( target.Retailing_days_Score_field_work__c==null)?0:target.Retailing_days_Score_field_work__c) ;
                
                PromotionalWrapper promotionWrap_Visits           =    new PromotionalWrapper();
                promotionWrap_Visits.promotionalActivity          =    'No. Of Visits (Total Visits)';
               promotionWrap_Visits.Target                       =    Wrapper_Visits.Target  +((target.No_of_visits_Target_total_visits__c==null)?0:target.No_of_visits_Target_total_visits__c); //Head_Quarter_Daily_Calls__c + HEAD_QUARTER_METRO_Daily_Calls__c + Head_Quarter_State_Capital_Daily_Calls__c + Out_Station_Daily_Calls__c + Ex_Station_Daily_Calls__c
                promotionWrap_Visits.Actual                       =     Wrapper_Visits.Actual+((target.No_of_visits_total_visits__c==null)?0:target.No_of_visits_total_visits__c)  ; //Total Visits under Target.
                promotionWrap_Visits.Achvd                        =    Wrapper_Visits.Achvd+((target.No_of_visits_total_visits_ACHVD__c==null)?0:target.No_of_visits_total_visits_ACHVD__c);     
                promotionWrap_Visits.Weightage                    =     Wrapper_Visits.Weightage +((target.No_of_visits_Weightage_total_visits__c==null)?0:target.No_of_visits_Weightage_total_visits__c) ;
                promotionWrap_Visits.Score                        =     Wrapper_Visits.Score+((target.No_of_visits_Score_field_work__c==null)?0:target.No_of_visits_Score_field_work__c)  ;
                 
                PromotionalWrapper promotionWrap_ContactVisits    =    new PromotionalWrapper();
                promotionWrap_ContactVisits.promotionalActivity   =    'Contacts Visit (Plumbers etc)';
                  promotionWrap_ContactVisits.Target                =   Wrapper_ContactVisits.Target+(( target.Contacts_visit_Target_Plumbers__c==null)?0:target.Contacts_visit_Target_Plumbers__c); //40% of total visits(Target)
                promotionWrap_ContactVisits.Actual                =   Wrapper_ContactVisits.Actual +(( target.Contacts_visit_Plumbers_etc__c==null)?0:target.Contacts_visit_Plumbers_etc__c) ;
                promotionWrap_ContactVisits.Achvd                 =  Wrapper_ContactVisits.Achvd + ((target.Contacts_visit_Plumbers_ACHVD__c==null)?0:target.Contacts_visit_Plumbers_ACHVD__c);               
                promotionWrap_ContactVisits.Weightage             =  Wrapper_ContactVisits.Weightage+(( target.Contacts_visit_Weightage_Plumbers__c==null)?0: target.Contacts_visit_Weightage_Plumbers__c);
                promotionWrap_ContactVisits.Score                 =  Wrapper_ContactVisits.Score+((target.Contacts_visit_Score_Plumbers__c==null)?0:target.Contacts_visit_Score_Plumbers__c);
              /*//actual code starts
                PromotionalWrapper promotionWrap_Mechanic = new PromotionalWrapper();
                promotionWrap_Mechanic.promotionalActivity = 'CONSULTANTS/Architects';
                promotionWrap_Mechanic.Target = target.Key_influencers_Target_Arch_consultant__c;
                promotionWrap_Mechanic.Actual = target.Key_influencers_contact_Arch_consultant__c;
                promotionWrap_Mechanic.Achvd = target.Key_influencers_Arch_consultant_ACHVD__c;               
                promotionWrap_Mechanic.Weightage = target.Key_influencers_Weighta_Arch_consultant__c;
                promotionWrap_Mechanic.Score = target.Key_influencers_Score_Arch_consultant__c;
              //actul code ends here  */
              //code copied from influencers from column
                        
         PromotionalWrapper promotionWrap_Mechanic = new PromotionalWrapper();
                 promotionWrap_Mechanic.promotionalActivity = 'CONSULTANTS/Architects';
               promotionWrap_Mechanic.Target                  =    Wrapper_Influencers.Target +((target.Key_influencers_Target_Arch_consultant__c==null)?0:target.Key_influencers_Target_Arch_consultant__c); //10% of contact vist(Target)
                 promotionWrap_Mechanic.Actual                  =    Wrapper_Influencers.Actual +((target.Key_influencers_contact_Arch_consultant__c==null)?0:target.Key_influencers_contact_Arch_consultant__c)  ;
               promotionWrap_Mechanic.Achvd                  =     Wrapper_Influencers.Achvd+((target.Key_influencers_Arch_consultant_ACHVD__c==null)?0:target.Key_influencers_Arch_consultant_ACHVD__c)  ;               
                promotionWrap_Mechanic.Weightage              =     Wrapper_Influencers.Weightage+((target.Key_influencers_Weighta_Arch_consultant__c==null)?0:target.Key_influencers_Weighta_Arch_consultant__c)  ;
                 promotionWrap_Mechanic.Score                  =      Wrapper_Influencers.Score+((target.Key_influencers_Score_Arch_consultant__c==null)?0:target.Key_influencers_Score_Arch_consultant__c)  ;
               
              //Ends here -:code copied from influencers from column
              // Actual code
               /* PromotionalWrapper promotionWrap_Borewell = new PromotionalWrapper();
                promotionWrap_Borewell.promotionalActivity = 'DEVELOPERS';
                promotionWrap_Borewell.Target = target.Key_influencers_Target_Arch_consultant__c;
                promotionWrap_Borewell.Actual = target.Key_influencers_contact_Arch_consultant__c;
                promotionWrap_Borewell.Achvd = target.Key_influencers_Arch_consultant_ACHVD__c;               
                promotionWrap_Borewell.Weightage = target.Key_influencers_Weighta_Arch_consultant__c;
                promotionWrap_Borewell.Score = target.Key_influencers_Score_Arch_consultant__c;
                
                PromotionalWrapper promotionWrap_Contractors = new PromotionalWrapper();
                promotionWrap_Contractors.promotionalActivity = 'CONTRACTORS';
                promotionWrap_Contractors.Target = target.Key_influencers_Target_Arch_consultant__c;
                promotionWrap_Contractors.Actual = target.Key_influencers_contact_Arch_consultant__c;
                promotionWrap_Contractors.Achvd = target.Key_influencers_Arch_consultant_ACHVD__c;               
                promotionWrap_Contractors.Weightage = target.Key_influencers_Weighta_Arch_consultant__c;
                promotionWrap_Contractors.Score = target.Key_influencers_Score_Arch_consultant__c;*/
                
                //
                  PromotionalWrapper promotionWrap_Borewell = new PromotionalWrapper();
                 promotionWrap_Borewell.promotionalActivity = 'DEVELOPERS';
               promotionWrap_Borewell.Target                  =    Wrapper_Influencers.Target +((target.Key_influencers_Target_Arch_consultant__c==null)?0:target.Key_influencers_Target_Arch_consultant__c); //10% of contact vist(Target)
                 promotionWrap_Borewell.Actual                  =    Wrapper_Influencers.Actual +((target.Key_influencers_contact_Arch_consultant__c==null)?0:target.Key_influencers_contact_Arch_consultant__c)  ;
             promotionWrap_Borewell.Achvd                  =     Wrapper_Influencers.Achvd+((target.Key_influencers_Arch_consultant_ACHVD__c==null)?0:target.Key_influencers_Arch_consultant_ACHVD__c)  ;               
                promotionWrap_Borewell.Weightage              =     Wrapper_Influencers.Weightage+((target.Key_influencers_Weighta_Arch_consultant__c==null)?0:target.Key_influencers_Weighta_Arch_consultant__c)  ;
                 promotionWrap_Borewell.Score =      Wrapper_Influencers.Score+((target.Key_influencers_Score_Arch_consultant__c==null)?0:target.Key_influencers_Score_Arch_consultant__c)  ;
                  
            
              
                          
              PromotionalWrapper promotionWrap_Contractors = new PromotionalWrapper();
                  promotionWrap_Contractors.promotionalActivity = 'CONTRACTORS';
               promotionWrap_Contractors.Target =    Wrapper_Influencers.Target +((target.Key_influencers_Target_Arch_consultant__c==null)?0:target.Key_influencers_Target_Arch_consultant__c); //10% of contact vist(Target)
                  promotionWrap_Contractors.Actual =    Wrapper_Influencers.Actual +((target.Key_influencers_contact_Arch_consultant__c==null)?0:target.Key_influencers_contact_Arch_consultant__c)  ;
               promotionWrap_Contractors.Achvd    =     Wrapper_Influencers.Achvd+((target.Key_influencers_Arch_consultant_ACHVD__c==null)?0:target.Key_influencers_Arch_consultant_ACHVD__c)  ;               
               promotionWrap_Contractors.Weightage  =     Wrapper_Influencers.Weightage+((target.Key_influencers_Weighta_Arch_consultant__c==null)?0:target.Key_influencers_Weighta_Arch_consultant__c)  ;
               promotionWrap_Contractors.Score =      Wrapper_Influencers.Score+((target.Key_influencers_Score_Arch_consultant__c==null)?0:target.Key_influencers_Score_Arch_consultant__c)  ;
                  
      
      
            
                
                Retailing_WrapperList.add(promotionWrap_retailing);
                Retailing_WrapperList.add(promotionWrap_Visits);
                Retailing_WrapperList.add(promotionWrap_ContactVisits);
                Retailing_WrapperList.add(promotionWrap_Mechanic);
                Retailing_WrapperList.add(promotionWrap_Borewell);
                Retailing_WrapperList.add(promotionWrap_Contractors);
                
                //PROMOTIONAL ACTIVITY - Start
                PromotionalWrapper promotionWrap_ISM = new PromotionalWrapper();
                promotionWrap_ISM.promotionalActivity = 'Onsite Plumber Meet';
                promotionWrap_ISM.Target =Wrapper_ISM.Target+((target.InShop_Mechanic_Meet__c==null)?0:target.InShop_Mechanic_Meet__c);
                //promotionWrap_ISM.Actual = Wrapper_ISM.Actual+((target.Inshop_Mechanic_Meets_Actual__c==null)?0:target.Inshop_Mechanic_Meets_Actual__c);
                promotionWrap_ISM.Achvd =Wrapper_ISM.Achvd+((target.Plumbing_DSM_Meet_Training_ACHVD__c==null)?0:target.Plumbing_DSM_Meet_Training_ACHVD__c);
                 promotionWrap_ISM.Weightage = Wrapper_ISM.Weightage+((target.Plumbing_DSM_Meet_Training_Weightage__c==null)?0:target.Plumbing_DSM_Meet_Training_Weightage__c);
         promotionWrap_ISM.Score =Wrapper_ISM.Score+((target.Plumbing_DSM_Meet_Training_Score__c==null)?0:target.Plumbing_DSM_Meet_Training_Score__c);

                
                
              /* actual code
               PromotionalWrapper promotionWrap_MiniFarmersMeet = new PromotionalWrapper();
                promotionWrap_MiniFarmersMeet.promotionalActivity = 'CONSULTANTS/BUILDERS EVENTS';
                promotionWrap_MiniFarmersMeet.Target = target.Plumbing_DSM_Meet_Training__c;         //not there
                promotionWrap_MiniFarmersMeet.Actual = target.Plumbing_DSM_Meet_Training_Actual__c;  //not there
                promotionWrap_MiniFarmersMeet.Achvd = target.Plumbing_DSM_Meet_Training_ACHVD__c;
                promotionWrap_MiniFarmersMeet.Weightage = target.Plumbing_DSM_Meet_Training_Weightage__c;
                promotionWrap_MiniFarmersMeet.Score = target.Plumbing_DSM_Meet_Training_Score__c;
              
              */
                
                
                PromotionalWrapper promotionWrap_MiniFarmersMeet = new PromotionalWrapper();
                promotionWrap_MiniFarmersMeet.promotionalActivity = 'CONSULTANTS/BUILDERS EVENTS';
                promotionWrap_MiniFarmersMeet.Target = wrapper_one.Target+((target.Plumbing_DSM_Meet_Training__c==null)?0:target.Plumbing_DSM_Meet_Training__c);         //not there
                promotionWrap_MiniFarmersMeet.Actual = wrapper_one.Target+((target.Plumbing_DSM_Meet_Training_Actual__c==null)?0:target.Plumbing_DSM_Meet_Training_Actual__c); //not there
                promotionWrap_MiniFarmersMeet.Achvd =Wrapper_ISM.Achvd+((target.Plumbing_DSM_Meet_Training_ACHVD__c==null)?0:target.Plumbing_DSM_Meet_Training_ACHVD__c);
                promotionWrap_MiniFarmersMeet.Weightage = Wrapper_ISM.Weightage+((target.Plumbing_DSM_Meet_Training_Weightage__c==null)?0:target.Plumbing_DSM_Meet_Training_Weightage__c);
                promotionWrap_MiniFarmersMeet.Score =Wrapper_ISM.Score+((target.Plumbing_DSM_Meet_Training_Score__c==null)?0:target.Plumbing_DSM_Meet_Training_Score__c);

                
                PromotionalWrapper promotionWrap_exhibition = new PromotionalWrapper();
                promotionWrap_exhibition.promotionalActivity = 'EXHIBITIONS';
                promotionWrap_exhibition.Target =Wrapper_exhibition.Target+((target.Exhibition__c==null)?0:target.Exhibition__c);
                promotionWrap_exhibition.Actual =Wrapper_exhibition.Actual+((target.Exhibition_Actual__c==null)?0:target.Exhibition_Actual__c);
                promotionWrap_exhibition.Achvd =Wrapper_exhibition.Achvd+((target.Exhibitions_ACHVD__c==null)?0:target.Exhibitions_ACHVD__c);
                promotionWrap_exhibition.Weightage =Wrapper_exhibition.Weightage+((target.Exhibitions_Weightage__c==null)?0:target.Exhibitions_Weightage__c);
                promotionWrap_exhibition.Score =Wrapper_exhibition.Score+((target.Exhibitions_Score__c==null)?0:target.Exhibitions_Score__c);
                
                        
                
                
                Promotional_WrapperList.add(promotionWrap_ISM);
                Promotional_WrapperList.add(promotionWrap_MiniFarmersMeet);
                Promotional_WrapperList.add(promotionWrap_exhibition);
                
                //Market Development
                //Actual code
                /*
                PromotionalWrapper promotionWrap_newMarket = new PromotionalWrapper();
                promotionWrap_newMarket.promotionalActivity = 'APPROVALS & ORDERS WITH TOP BUILDERS';
                promotionWrap_newMarket.Target = target.New_markets_opened__c;
                promotionWrap_newMarket.Actual = target.Inshop_Plumber_Meets_Actual__c;
                promotionWrap_newMarket.Achvd = target.Inshop_Plumber_Meet_ACHVD__c;
                promotionWrap_newMarket.Weightage = target.Inshop_Plumber_Meet_Weightage__c;
                promotionWrap_newMarket.Score = target.Inshop_Plumber_Meet_Score__c;
                
                PromotionalWrapper promotionWrap_newDealer = new PromotionalWrapper();
                promotionWrap_newDealer.promotionalActivity = 'PROJECT REFERENCE PPT EVERY QTR - 4 PER YEAR';
                promotionWrap_newDealer.Target = target.New_dealers_activation__c;
                promotionWrap_newDealer.Actual = target.Inshop_Plumber_Meets_Actual__c;
                promotionWrap_newDealer.Achvd = target.Inshop_Plumber_Meet_ACHVD__c;
                promotionWrap_newDealer.Weightage = target.Inshop_Plumber_Meet_Weightage__c;
                promotionWrap_newDealer.Score = target.Inshop_Plumber_Meet_Score__c;
                
                PromotionalWrapper promotionWrap_newDistributor = new PromotionalWrapper();
                promotionWrap_newDistributor.promotionalActivity = 'PROJECT FUNNEL 2016-17';
                promotionWrap_newDistributor.Target = target.New_distributer_activation__c;
                promotionWrap_newDistributor.Actual = target.Inshop_Plumber_Meets_Actual__c;
                promotionWrap_newDistributor.Achvd = target.Inshop_Plumber_Meet_ACHVD__c;
                promotionWrap_newDistributor.Weightage = target.Inshop_Plumber_Meet_Weightage__c;
                promotionWrap_newDistributor.Score = target.Inshop_Plumber_Meet_Score__c;
               
                PromotionalWrapper promotionWrap_factory = new PromotionalWrapper();
                promotionWrap_factory.promotionalActivity = 'FACTROY VISITS';
                promotionWrap_factory.Target = target.New_distributer_activation__c;
                promotionWrap_factory.Actual = target.Inshop_Plumber_Meets_Actual__c;
                promotionWrap_factory.Achvd = target.Inshop_Plumber_Meet_ACHVD__c;
                promotionWrap_factory.Weightage = target.Inshop_Plumber_Meet_Weightage__c;
                promotionWrap_factory.Score = target.Inshop_Plumber_Meet_Score__c;
               
               */
                
       PromotionalWrapper promotionWrap_newMarket = new PromotionalWrapper();
                promotionWrap_newMarket.promotionalActivity = 'APPROVALS & ORDERS WITH TOP BUILDERS';
                promotionWrap_newMarket.Target = wrapper_Two.Target+((target.New_markets_opened__c==null)?0:target.New_markets_opened__c);// have to query
                 promotionWrap_newMarket.Actual  =     Wrapper_MiniMeet.Actual+((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
                 promotionWrap_newMarket.Achvd = Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
               promotionWrap_newMarket.Weightage =   Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_newMarket.Score = Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                
                
                PromotionalWrapper promotionWrap_newDealer = new PromotionalWrapper();
                promotionWrap_newDealer.promotionalActivity = 'PROJECT REFERENCE PPT EVERY QTR - 4 PER YEAR';
                promotionWrap_newDealer.Target = wrapper_Three.Target+((target.New_dealers_activation__c==null)?0:target.New_dealers_activation__c);// have to query
               promotionWrap_newDealer.Actual =     Wrapper_MiniMeet.Actual+((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
               promotionWrap_newDealer.Achvd = Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
               promotionWrap_newDealer.Weightage =   Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_newDealer.Score = Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                 
                
                PromotionalWrapper promotionWrap_newDistributor = new PromotionalWrapper();
                promotionWrap_newDistributor.promotionalActivity = 'PROJECT FUNNEL 2016-17';
                promotionWrap_newDistributor.Target = wrapper_Four.Target+((target.New_distributer_activation__c==null)?0:target.New_distributer_activation__c);// have to query
               promotionWrap_newDistributor.Actual =     Wrapper_MiniMeet.Actual+((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
             promotionWrap_newDistributor.Achvd= Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
                promotionWrap_newDistributor.Weightage =   Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_newDistributor.Score = Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                 
               
               
               
                PromotionalWrapper promotionWrap_factory = new PromotionalWrapper();
                promotionWrap_factory.promotionalActivity = 'FACTROY VISITS';
                promotionWrap_factory.Target = wrapper_Four.Target+((target.New_distributer_activation__c==null)?0:target.New_distributer_activation__c);// have to query
               promotionWrap_factory.Actual =     Wrapper_MiniMeet.Actual+((target.Inshop_Plumber_Meets_Actual__c==null)?0:target.Inshop_Plumber_Meets_Actual__c);
                    promotionWrap_factory.Achvd = Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
                 promotionWrap_factory.Weightage =   Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_factory.Score = Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                
               
        Market_WrapperList.add(promotionWrap_newMarket);
        Market_WrapperList.add(promotionWrap_newDealer);
        Market_WrapperList.add(promotionWrap_newDistributor);
        Market_WrapperList.add(promotionWrap_factory);
        
        //Sales Volume.
        /*
        PromotionalWrapper promotionWrap_primary = new PromotionalWrapper();
        promotionWrap_primary.promotionalActivity = 'ORDERS WITH ALL PRODUCTS';
        promotionWrap_primary.Target = target.Primary_Sales_Target__c;
        promotionWrap_primary.Actual = target.Orders_with_all_Products_A__c;
                promotionWrap_primary.Achvd = target.Primary_Sales_ACHVD__c;
                promotionWrap_primary.Weightage = target.Primary_Sales_Weightage__c;
                promotionWrap_primary.Score = target.Primary_Sales_Score__c;
        
        
        
        
          PromotionalWrapper promotionWrap_secondary = new PromotionalWrapper();
        promotionWrap_secondary.promotionalActivity = 'ORDERS WITH SINGLE PRODUCTS';
        promotionWrap_secondary.Target = target.Secondary_Sales_Target__c;
        promotionWrap_secondary.Actual = target.Orders_with_Single_Product_A__c; //Secondary_Sales_Actual_Order_Value__c;
                promotionWrap_secondary.Achvd = target.Inshop_Plumber_Meet_ACHVD__c;
                promotionWrap_secondary.Weightage = target.Inshop_Plumber_Meet_Weightage__c;
                promotionWrap_secondary.Score = target.Inshop_Plumber_Meet_Score__c;
        
        */
        
        //code copied from Primary_V4
          PromotionalWrapper promotionWrap_primary = new PromotionalWrapper();
        promotionWrap_primary.promotionalActivity = 'ORDERS WITH ALL PRODUCTS';
        promotionWrap_primary.Target                       =Wrapper_primary_Column.Target+((target.Primary_Sales_Target__c==null)?0:target.Primary_Sales_Target__c);
         promotionWrap_primary.Actual                     = target.Orders_with_all_Products_A__c; //have to query not there
           promotionWrap_primary.Achvd                      = Wrapper_primary_Column.Achvd+((target.Primary_Sales_ACHVD__c==null)?0:target.Primary_Sales_ACHVD__c);
     promotionWrap_primary.Weightage                  =   Wrapper_primary_Column.Weightage+((target.Primary_Sales_Weightage__c==null)?0:target.Primary_Sales_Weightage__c);
                promotionWrap_primary.Score                      =  Wrapper_primary_Column.Score+((target.Primary_Sales_Score__c==null)?0:target.Primary_Sales_Score__c);
              
        
        ///ENDS HERE-:code copied from Primary_V4
        
        
          PromotionalWrapper promotionWrap_secondary = new PromotionalWrapper();
        promotionWrap_secondary.promotionalActivity = 'ORDERS WITH SINGLE PRODUCTS';
        promotionWrap_secondary.Target =     Wrapper_secondary.Target+((target.Secondary_Sales_Target__c==null)?0:target.Secondary_Sales_Target__c);
        promotionWrap_secondary.Actual = target.Orders_with_Single_Product_A__c; //Secondary_Sales_Actual_Order_Value__c; // have to query not there
        promotionWrap_secondary.Achvd = Wrapper_MiniMeet.Achvd+((target.Inshop_Plumber_Meet_ACHVD__c==null)?0:target.Inshop_Plumber_Meet_ACHVD__c) ;
     promotionWrap_secondary.Weightage =   Wrapper_MiniMeet.Weightage+(( target.Inshop_Plumber_Meet_Weightage__c==null)?0: target.Inshop_Plumber_Meet_Weightage__c);
                promotionWrap_secondary.Score = Wrapper_MiniMeet.Score+((  target.Inshop_Plumber_Meet_Score__c==null)?0:  target.Inshop_Plumber_Meet_Score__c);
                
                 
      
        
        
      
                
        Sales_WrapperList.add(promotionWrap_primary);
        Sales_WrapperList.add(promotionWrap_secondary);
              
              
              
            }
        } catch(Exception e) {
            if(e.getMessage().contains('List has no rows for assignment to SObject')) {
              plumbingflag = false;
              columnflag = false;
                projectFlag = false;
                User userData = new User();
                userData = [select Name from User where id =: KRA_TargetUserId];
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,'<b>Target is not assigned to '+userData.Name+' for selected Month & Year</b>'));
            }
        }
    } 
    
    
    public class PromotionalWrapper {
      
      public string promotionalActivity {get; set;}
      public decimal Target {get; set;}
      public decimal Actual {get; set;}
      public decimal Achvd {get; set;}
      public decimal Weightage {get; set;}
      public decimal Score {get; set;}
      
      public PromotionalWrapper() {
        
        promotionalActivity = '';
        Target = null;
        Actual = null;
        Achvd = null;
        Weightage = null;
        Score = null;
      }
      
    } 
}