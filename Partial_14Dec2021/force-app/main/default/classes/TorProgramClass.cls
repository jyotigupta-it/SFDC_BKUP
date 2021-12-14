public with sharing class TorProgramClass 
{
    Public Id TPId;
    Public Integer ExStation{get;set;}
    Public Integer OutStation{get;set;}
    Public Integer HeadQuarter{get;set;}
    Public Tour_Program__c TourProgrm{get;set;}
    Public User user{get;set;}
    Public List<Tour_Plan1__c> TourPlans{get;set;}
    public TorProgramClass(ApexPages.StandardController controller) 
        {
            TPId=ApexPages.CurrentPage().getParameters().get('Id');
            TourProgrm=[SELECT id,Name,OwnerId,H_Q_Visit_Days__c,Out_Station_Visit_Days__c,Ex_Station_Visit_Days__c,From_Date__c,To_Date__c FROM Tour_Program__c WHERE id=:TPId];
            user=[SELECT id,Name,State,Head_Quarter__c,EmployeeNumber,User_State__c FROM User WHERE id=:TourProgrm.OwnerId];
            TourPlans=[SELECT id,Name,Courier__c,
                        Date__c,District__c,
                        District_1__c,Expenses_Approved__c,Expenses_Details__c,Fare__c,
                        Farmers_Meet_Actuals__c,Builders_Meet_Actuals__c,Food_and_Boarding__c,From__c,Jeep_Campaign_Actuals__c,Local_Conveyance__c,Location__c,Location_1__c,
                        Lodge__c,Market_Type__c,Mechanics_Meet_Actuals__c,Mini_Meet_Actuals__c,Miscellaneous__c,Miscellaneous_Details__c,Mode_of_Travel__c,No_of_Architects1__c,
                        No_of_Consultant__c,No_of_Dealer__c,
                        Plumber_Mechanic_Engineers_Factory_Visit__c,Plumbers_Meet_Actuals__c,Remarks__c,
                        Remarks_for_Not_meeting_the_Visit_Target__c,Shandy_Show_Actuals__c,State__c,Stationery_and_Photocopy__c,Telephone_Fax_Internet__c,To__c,
                        Total_Expenses__c,Total_Visits_Target__c,Tour_Program__c,Tour_Program_Approved__c,Tractor_Show_Actuals__c,Visit_Type__c FROM Tour_Plan1__c WHERE Tour_Program__c=:TourProgrm.id Order By Date__c ASC ];
           System.Debug('###*****@@@@@@@@@@-------->>>>>>>>'+TourPlans);             
        }
   

}