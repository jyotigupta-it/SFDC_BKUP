@isTest public class ChangeBeatControllerTest {
    
    @isTest public static void test(){
        User userdata;
        userdata = Test_Intial_Data_Phase2.ColumnRH('First','Last','System Administrator');
        insert userdata ;
        Target__c target;
        target = Test_Intial_Data_Phase2.CreateTarget(userdata);
        target.Start_Date__c = Date.today();
        insert target;
        AP_Tour_Plan__c tourplan;
        tourplan  = Test_Intial_Data_Phase2.CreateTourPlan(target.Id);
        tourplan.Change_Beat_Approval__c = 'Approved';
        tourplan.Visit_Type__c = 'Ex-Station';
        tourplan.Date__c = Date.today();
        tourplan.Target__c = target.ID;
        insert tourplan;
        Beat_Master__c beat = new Beat_Master__c();
        beat.Name = 'Testt';
        insert beat;
        ChangeBeatController.fetchBeats();
        ChangeBeatController.fetchSelectedDateBeat(System.today());
        
        
        ChangeBeatController.saveChanges(tourplan.Id,beat.Id);
    }
    
}