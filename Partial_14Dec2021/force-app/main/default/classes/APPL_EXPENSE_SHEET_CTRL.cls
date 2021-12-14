public with sharing class APPL_EXPENSE_SHEET_CTRL {
    
    //************* Taking Lists***********
    public list<AP_Expenses__c> ExpensesList{get;set;}
    public list<AP_Tour_Plan__c> tourplanList{get;set;}
    public User userData {get;set;}
    public list<Target__c> targetlist {get;set;}
    public Id TargetId;
    public list<id> tourPlanIds;
    
    //*********variables for get the subtotals in page 
    public Decimal fareTotal {get;set;}
    public Decimal hotelStayTotal {get;set;}
    public Decimal notInvolvingOvernight {get;set;}
    public Decimal sundriesHotelBills {get;set;}
    public Decimal telephone {get;set;}
    public Decimal courier {get;set;}
    public Decimal stationary {get;set;}
    public Decimal miscPromotion {get;set;}
    public Decimal total {get;set;}
    public Integer tourPlanHQ {get;set;}
    public Integer tourPlanExStation {get;set;}
    public Integer tourPlanOutStation {get;set;}
    
    //********Constructor************
    
    public APPL_EXPENSE_SHEET_CTRL(ApexPages.StandardController controller) {
        TargetId = ApexPages.CurrentPage().getparameters().get('Id');
        tourplanList = new list<AP_Tour_Plan__c>();
        ExpensesList = new list<AP_Expenses__c>();
        tourPlanIds = new list<id>();
        userData  = new User();
        targetlist = new list<target__c>();
        system.debug('TargetId******'+TargetId);
        tourPlanHQ = [select count() from AP_Tour_Plan__c where OwnerId = : UserInfo.getUserId() and Visit_Type__c = 'Head Quarter'];
        system.debug('#################'+tourPlanHQ);
        tourPlanExStation = [select count() from AP_Tour_Plan__c where OwnerId = : UserInfo.getUserId() and Visit_Type__c = 'Ex-station'];
        system.debug('$$$$$$$$$$$$$$$$$$$'+tourPlanExStation);
        tourPlanOutStation = [select count() from AP_Tour_Plan__c where OwnerId = : UserInfo.getUserId() and Visit_Type__c = 'Out Station'];
        system.debug('@@@@@@@@@@@@@@@@'+tourPlanOutStation);
        
        targetlist = [select id ,DOC_CODE__c,Rev_No__c from Target__c where ID=:TargetId limit 1 ];
        //target = targetlist[0];
        system.debug('$$$$$$$$$$$$$$$$$$$$$$'+targetlist);
        
        tourplanList  = [select id,Add_Visit__c,Approval_Status__c,Approver__c,Date__c,Day_of_date__c,District__c,
                         Holiday_Market_Closed__c,Location__c,Market_Type__c,Planned_Value__c,Promotional_Type__c,State__c,
                         Target__c,Visit_Type__c,OwnerId,Target__r.OwnerId  from  AP_Tour_Plan__c where Target__c=:TargetId];
        
        if(tourplanList.size() > 0) {
            for(AP_Tour_Plan__c tourPlan : tourplanList) {
                
                tourPlanIds.add(tourPlan.Id);
            }
            system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'+tourplanList);
            userData = [select id,Name,State__c,User_State__c,EmployeeNumber,Title from User where id=: tourplanList[0].OwnerId];
        }
        
        if(tourPlanIds.size() > 0) {
            
            ExpensesList = [select id,Actual_District__c,Actual_Location__c,Actual_State__c,BD_Name__c,Courier__c,
                            Expense_Date__c,Time_To__c,Expense_Details__c,Expens_Visit_Type__c,Fare_Local_Conveyance__c,Fare_Amount_Local_Conveyance__c ,Food_and_Boarding__c,From__c,
                            Local_Conveyance__c,KM__c,Lodge__c,Miscellaneous__c,Miscellaneous_Details__c,Mode_Of_Travel__c,
                            Not_Involving_Overnight_Stay_DA__c,Rate_Per_KM__c,Remarks_for_Not_meeting_the_Visit_Target__c,
                            Start_Time__c,Stationery_and_Photocopy__c,Sundries_in_addition_to_Hotel_Bills__c,Telephone_Fax_Internet__c,
                            To__c,Total_Expenses__c,TourPlan__c,Remarks__c from AP_Expenses__c where TourPlan__c IN: tourPlanIds order by Expense_Date__c];
            system.debug('****************************'+ExpensesList);
            
            //******Taking Intial values for get the subtotal
            
            fareTotal = 0;
            hotelStayTotal = 0;
            notInvolvingOvernight = 0;
            sundriesHotelBills = 0;
            telephone = 0;
            courier = 0;
            stationary = 0;
            miscPromotion = 0;
            total = 0;
            
            //****Iterating Expenses for loop for calcutaing the subtotal in page
            
            for(AP_Expenses__c apExp :ExpensesList ){
                
                fareTotal += apExp.Fare_Local_Conveyance__c != null ? apExp.Fare_Local_Conveyance__c : 0;
                hotelStayTotal += apExp.Local_Conveyance__c != null ? apExp.Local_Conveyance__c : 0;
                notInvolvingOvernight += apExp.Not_Involving_Overnight_Stay_DA__c != null ? apExp.Not_Involving_Overnight_Stay_DA__c : 0;
                sundriesHotelBills += apExp.Sundries_in_addition_to_Hotel_Bills__c != null ? apExp.Sundries_in_addition_to_Hotel_Bills__c : 0;
                telephone += apExp.Telephone_Fax_Internet__c != null ?  apExp.Telephone_Fax_Internet__c :0;
                courier += apExp.Courier__c != null ?  apExp.Courier__c :0;
                stationary += apExp.Stationery_and_Photocopy__c !=null ? apExp.Stationery_and_Photocopy__c:0 ;
                miscPromotion += apExp.Miscellaneous__c !=null ? apExp.Miscellaneous__c:0;
                total += apExp.Total_Expenses__c !=null ?apExp.Total_Expenses__c:0 ;
            }
        }
        
    }
}