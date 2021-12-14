/**********************         Author: Upendar Shivanadri
Modified Date 18/06/2015 
Description : To generate the PDF of Expense Details of one month  
into two pages i.e; first 15 records in  first page and rest records in second page.                          

***************/
public with sharing class AP_Expenses_Controller {
    
    //************* Taking Lists***********
    public list<AP_Expenses__c> ExpensesList{get;set;}
    public list<AP_Tour_Plan__c> tourplanList{get;set;}
    public User userData {get;set;}
    public list<Target__c> targetlist {get;set;}
    public Id TargetId;
    public Id targetUserId;
    public list<id> tourPlanIds;
    
    // variables to get the roll up values in page/
    
    private static final string VAR_HEADQUARTER = 'Headquarter';
    private static final string VAR_EXSTATION = 'Ex-station';
    private static final string VAR_OUTSTATION = 'Outstation';
    private static final string VAR_HEADQUARTERSTATECAPITAL = 'Headquarter-State Capital';
    private static final string VAR_HEADQUARTERMETRo = 'Headquarter-Metro';
    
    
    public String fortnight1{get;set;} // variable for  period of tour 1 to 15
    public String fortnight2{get;set;} // variable for  period of tour 16 to 30 or 31
    
  
    // Taking two lists for divide one month's records into two pages
    
    public list<AP_Expenses__c> expense1to15list{get;set;}
    public list<AP_Expenses__c> expense16to30list{get;set;}
    
    //*********variables to get the subtotals in page from 1 to 15 records
    
    public Decimal fareTotal1to15 {get;set;}
    public Decimal localConveyance1to15 {get;set;}
    public Decimal hotelStayTotal1to15 {get;set;}
    public Decimal notInvolvingOvernight1to15 {get;set;}
    public Decimal sundriesHotelBills1to15 {get;set;}
    public Decimal telephone1to15 {get;set;}
    public Decimal courier1to15 {get;set;}
    public Decimal stationary1to15 {get;set;}
    public Decimal miscPromotion1to15 {get;set;}
    public Decimal total1to15 {get;set;}
    
    //*********variables to get the subtotals in page from 16 to 30 records
    
    public Decimal fareTotal16to30 {get;set;}
    public Decimal localConveyance16to30 {get;set;}
    public Decimal hotelStayTotal16to30 {get;set;}
    public Decimal notInvolvingOvernight16to30 {get;set;}
    public Decimal sundriesHotelBills16to30 {get;set;}
    public Decimal telephone16to30 {get;set;}
    public Decimal courier16to30 {get;set;}
    public Decimal stationary16to30 {get;set;}
    public Decimal miscPromotion16to30 {get;set;}
    public Decimal total16to30 {get;set;}
    
    // variables to get the roll up values from 1 to 15 days
    
    public Integer expenseHQ1to15{get;set;}
    public Integer expenseExStation1to15{get;set;}
    public Integer expenseOutStation1to15{get;set;}
    public Integer expenseHQStateCapital1to15{get;set;}
    public Integer expenseHQMetro1to15{get;set;}
    
    // variables to get the roll up values from 16 to 30 days
    
    public Integer expenseHQ16to30{get;set;}
    public Integer expenseExStation16to30{get;set;}
    public Integer expenseOutStation16to30{get;set;}
    public Integer expenseHQStateCapital16to30{get;set;}
    public Integer expenseHQMetro16to30{get;set;}
    
    //********Constructor************
    
    public AP_Expenses_Controller(ApexPages.StandardController controller) {
        TargetId = ApexPages.CurrentPage().getparameters().get('Id');
        tourplanList = new list<AP_Tour_Plan__c>();
        expensesList = new list<AP_Expenses__c>();
        tourPlanIds = new list<id>();
        userData  = new User();
        targetlist = new list<target__c>();
        
        // Taking Intial values for roll up from 1 to 15 days
        expenseHQ1to15 = 0;
        expenseExStation1to15 = 0;
        expenseOutStation1to15 = 0;
        expenseHQStateCapital1to15 = 0;
        expenseHQMetro1to15 = 0;
        
        // Taking Intial values for roll up from 16 to 30 days
        
        expenseHQ16to30 = 0;
        expenseExStation16to30 = 0;
        expenseOutStation16to30 = 0;
        expenseHQStateCapital16to30 = 0;
        expenseHQMetro16to30 = 0;
        
        targetlist = [select id ,DOC_CODE__c,Rev_No__c,OwnerId from Target__c where ID=:TargetId limit 1 ];
        tourplanList  = [select id,Add_Visit__c,Approval_Status__c,Approver__c,Date__c,Day_of_date__c,District__c,
                         Holiday_Market_Closed__c,Location__c,Market_Type__c,Planned_Value__c,Promotional_Type__c,State__c,
                         Target__c,Visit_Type__c,OwnerId,Target__r.OwnerId  from  AP_Tour_Plan__c where Target__c=:TargetId];
        
        if(tourplanList.size() > 0) {
            for(AP_Tour_Plan__c tourPlan : tourplanList) {
                
                tourPlanIds.add(tourPlan.Id);
            }
           
            userData = [select id,Name,State__c,User_State__c,SAP_ID__C,Head_Quarter__c,EmployeeNumber,Title from User where id=: targetlist[0].ownerId];
        }
 
        if(tourPlanIds.size() > 0) {
            expense1to15list = new list<AP_Expenses__c >();
            expense16to30list = new list<AP_Expenses__c >();
            
            expensesList = [select id,Actual_District__c,Actual_Location__c,Actual_State__c,BD_Name__c,Courier__c, Rate_Per_KM__c,
                            Expense_Date__c,Time_To__c,Expense_Details__c,Expens_Visit_Type__c,Fare_Local_Conveyance__c,Local_Conveyance_New__c,Fare_Amount_Local_Conveyance__c ,Food_and_Boarding__c,From__c,
                            Local_Conveyance__c,Fare_and_Local__c,KM__c,Lodge__c,Miscellaneous__c,Miscellaneous_Details__c,Mode_Of_Travel__c,
                            Not_Involving_Overnight_Stay_DA__c,Remarks_for_Not_meeting_the_Visit_Target__c,
                            Start_Time__c,Stationery_and_Photocopy__c,Sundries_in_addition_to_Hotel_Bills__c,Telephone_Fax_Internet__c,
                            To__c,Total_Expenses__c,TourPlan__c,Remarks__c,Expense_Day__c,Month_Of_Date__c from AP_Expenses__c where TourPlan__c IN: tourPlanIds order by Expense_Date__c];
            
            string monthofdate = '';  //  Intial value to get the month
            Integer x_month = 0; //Intial value to get the month
            Integer x_year = 0;  //Intial value to get the year
                    
            for(AP_Expenses__c apExp :expensesList) {
                
                    if( apExp.From__c!= null) {
                  apExp.From__c = apExp.From__c.replace(',' ,', ');  // for the data should come line by line in page.
                    }       
                    if(apExp.To__c != null) {                                   
                  apExp.To__c = apExp.To__c.replace(',' ,', ');
                    }
                // String s1 = apExp.From__c.leftpad(14);
                if(apExp.Expense_Day__c <= 15) {
                    if(monthofdate == '') {
                        monthofdate = apExp.Month_Of_Date__c;
                        x_month = apExp.Expense_Date__c.Month();
                        x_year = apExp.Expense_Date__c.year();
                    }
                    if(apExp.Expens_Visit_Type__c == VAR_HEADQUARTER) {
                        expenseHQ1to15 +=1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_EXSTATION ) {
                        expenseExStation1to15 += 1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_OUTSTATION ) {
                        expenseOutStation1to15 += 1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_HEADQUARTERSTATECAPITAL ) {
                        expenseHQStateCapital1to15 += 1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_HEADQUARTERMETRo ) {
                        expenseHQMetro1to15 += 1;
                    }
                    expense1to15list.add(apExp) ;              
                }
                else if(apExp.Expense_Day__c >= 16) {
                    
                    if(apExp.Expens_Visit_Type__c == VAR_HEADQUARTER) {
                        expenseHQ16to30 +=1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_EXSTATION ) {
                        expenseExStation16to30 += 1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_OUTSTATION ) {
                        expenseOutStation16to30 += 1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_HEADQUARTERSTATECAPITAL ) {
                        expenseHQStateCapital16to30 += 1;
                    }
                    else if(apExp.Expens_Visit_Type__c == VAR_HEADQUARTERMETRo ) {
                        expenseHQMetro16to30 += 1;
                    }
                    
                    
                    expense16to30list.add(apExp);
                }  
            }
            
            Integer numberDays = date.daysInMonth(x_year, x_month);      // to get the end date for every month
            fortnight1 = '1 '+ monthofdate + ' to 15 '+ monthofdate;     // to get the dates from 1 to 15
            fortnight2 = '16 '+ monthofdate + ' to '+ numberDays +' ' + monthofdate;   //to get the dates from 16 th end date 
            
            /******Taking Intial values for get the subtotal****/
            
            fareTotal1to15 = 0;
            localConveyance1to15  = 0;
            hotelStayTotal1to15 = 0;
            notInvolvingOvernight1to15 = 0;
            sundriesHotelBills1to15 = 0;
            telephone1to15 = 0;
            courier1to15 = 0;
            stationary1to15 = 0;
            miscPromotion1to15 = 0;
            total1to15 = 0;
            
            /****Iterating Expenses for loop for calculataing the subtotal in page****/
            
            for(AP_Expenses__c apExp :expense1to15list){
                
                fareTotal1to15 += apExp.Fare_and_Local__c!= null ? apExp.Fare_and_Local__c: 0;
                localConveyance1to15  += apExp.Local_Conveyance_New__c != null ? apExp.Local_Conveyance_New__c  : 0;
                system.debug('*************'+apExp.Fare_Local_Conveyance__c);
                hotelStayTotal1to15 += apExp.Local_Conveyance__c != null ? apExp.Local_Conveyance__c : 0;
                notInvolvingOvernight1to15 += apExp.Not_Involving_Overnight_Stay_DA__c != null ? apExp.Not_Involving_Overnight_Stay_DA__c : 0;
                sundriesHotelBills1to15 += apExp.Sundries_in_addition_to_Hotel_Bills__c != null ? apExp.Sundries_in_addition_to_Hotel_Bills__c : 0;
                telephone1to15 += apExp.Telephone_Fax_Internet__c != null ?  apExp.Telephone_Fax_Internet__c :0;
                courier1to15 += apExp.Courier__c != null ?  apExp.Courier__c :0;
                stationary1to15 += apExp.Stationery_and_Photocopy__c !=null ? apExp.Stationery_and_Photocopy__c:0 ;
                miscPromotion1to15 += apExp.Miscellaneous__c !=null ? apExp.Miscellaneous__c:0;
                total1to15 += apExp.Total_Expenses__c !=null ?apExp.Total_Expenses__c:0 ;
            }
            
            /* Intial values for get the subtotals */
            
            fareTotal16to30 = 0;
            localConveyance16to30  = 0;
            hotelStayTotal16to30 = 0;
            notInvolvingOvernight16to30 = 0;
            sundriesHotelBills16to30 = 0;
            telephone16to30 = 0;
            courier16to30 = 0;
            stationary16to30 = 0;
            miscPromotion16to30 = 0;
            total16to30 = 0;
            
            /* Taking the terinary operators for do not get the null values */
            
            for(AP_Expenses__c apExp :expense16to30list) {
                
                fareTotal16to30 += apExp.Fare_and_Local__c!= null ? apExp.Fare_and_Local__c: 0;
                localConveyance16to30  += apExp.Local_Conveyance_New__c != null ? apExp.Local_Conveyance_New__c  : 0;
                hotelStayTotal16to30 += apExp.Local_Conveyance__c != null ? apExp.Local_Conveyance__c : 0;
                notInvolvingOvernight16to30 += apExp.Not_Involving_Overnight_Stay_DA__c != null ? apExp.Not_Involving_Overnight_Stay_DA__c : 0;
                sundriesHotelBills16to30 += apExp.Sundries_in_addition_to_Hotel_Bills__c != null ? apExp.Sundries_in_addition_to_Hotel_Bills__c : 0;
                telephone16to30 += apExp.Telephone_Fax_Internet__c != null ?  apExp.Telephone_Fax_Internet__c :0;
                courier16to30 += apExp.Courier__c != null ?  apExp.Courier__c :0;
                stationary16to30 += apExp.Stationery_and_Photocopy__c !=null ? apExp.Stationery_and_Photocopy__c:0 ;
                miscPromotion16to30 += apExp.Miscellaneous__c !=null ? apExp.Miscellaneous__c:0;
                total16to30 += apExp.Total_Expenses__c !=null ?apExp.Total_Expenses__c:0 ;
            }
            
        }
        
    }
    
}