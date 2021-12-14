public with sharing class DisplayTourPlansClass {
    Public Id TourProgramId;
    Public Tour_Program__c TourProgram{get;set;}
    Public List<Tour_Plan1__c> TourPlans{get;set;}
    

    public DisplayTourPlansClass(ApexPages.StandardController controller) {
        
        TourProgramId=ApexPages.CurrentPage().getParameters().get('Id');
        TourProgram=[SELECT id,Name From Tour_Program__c WHERE id=:TourProgramId];
        TourPlans=[SELECT id,Name,Date__c,State__c,District__c,Market_Type__c,User__r.Name,User_2__r.Name,User_3__r.Name,Tour_Program__c,No_of_Architects__c,No_of_Consultants__c,No_of_Dealers__c,
                    No_of_Distributors__c,Other_Contacts_if_any__c,Tour_Plans_2__r.Other_Contacts_if_any__c,Tour_Plans_3__r.Other_Contacts_if_any__c,No_of_Builders_Planned__c,No_of_Plumbing_Contractor__c,Location__c,Location_1__c,District_1__c,User__c,No_of_Engineers__c,Visit_Type__c,Tour_Plans_2__r.Name,Tour_Plans_2__r.Date__c,Tour_Plans_2__r.State__c,Tour_Plans_2__r.District__c,Tour_Plans_2__r.Market_Type__c,Tour_Plans_2__r.Tour_Program__c,Tour_Plans_2__r.No_of_Architects__c,Tour_Plans_2__r.No_of_Consultants__c,Tour_Plans_2__r.No_of_Dealers__c,
                    Tour_Plans_2__r.No_of_Distributors__c,Tour_Plans_2__r.No_of_Builders_Planned__c,Tour_Plans_2__r.No_of_Plumbing_Contractor__c,Tour_Plans_2__r.Location__c,Tour_Plans_2__r.Location_1__c,Tour_Plans_2__r.District_1__c,Tour_Plans_2__r.User__c,Tour_Plans_2__r.No_of_Engineers__c,Tour_Plans_2__r.Visit_Type__c,Tour_Plans_3__r.Name,Tour_Plans_3__r.Date__c,Tour_Plans_3__r.State__c,Tour_Plans_3__r.District__c,Tour_Plans_3__r.Market_Type__c,Tour_Plans_3__r.Tour_Program__c,Tour_Plans_3__r.No_of_Architects__c,Tour_Plans_3__r.No_of_Consultants__c,Tour_Plans_3__r.No_of_Dealers__c,
                    Tour_Plans_3__r.No_of_Distributors__c,Tour_Plans_3__r.No_of_Builders_Planned__c,Tour_Plans_3__r.No_of_Plumbing_Contractor__c,Tour_Plans_3__r.Location__c,Tour_Plans_3__r.Location_1__c,Tour_Plans_3__r.District_1__c,Tour_Plans_3__r.User__c,Tour_Plans_3__r.No_of_Engineers__c,Tour_Plans_3__r.Visit_Type__c,BD_Tour_Plans_1__r.Name,BD_Tour_Plans_1__r.Date__c,BD_Tour_Plans_1__r.State__c,BD_Tour_Plans_1__r.District__c,BD_Tour_Plans_1__r.Market_Type__c,BD_Tour_Plans_1__r.Tour_Program__c,BD_Tour_Plans_1__r.No_of_Architects__c,BD_Tour_Plans_1__r.No_of_Consultants__c,BD_Tour_Plans_1__r.No_of_Dealers__c,
                    BD_Tour_Plans_1__r.No_of_Distributors__c,BD_Tour_Plans_1__r.Other_Contacts_if_any__c,BD_Tour_Plans_1__r.No_of_Builders_Planned__c,BD_Tour_Plans_1__r.No_of_Plumbing_Contractor__c,BD_Tour_Plans_1__r.Location__c,BD_Tour_Plans_1__r.Location_1__c,BD_Tour_Plans_1__r.District_1__c,BD_Tour_Plans_1__r.User__c,BD_Tour_Plans_1__r.No_of_Engineers__c,BD_Tour_Plans_1__r.Visit_Type__c FROM Tour_Plan1__c WHERE Tour_Program__c=:TourProgram.id Order By Date__c ASC];
    }

}