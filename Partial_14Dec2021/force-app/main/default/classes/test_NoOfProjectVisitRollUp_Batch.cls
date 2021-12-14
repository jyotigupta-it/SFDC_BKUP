@isTest
public class test_NoOfProjectVisitRollUp_Batch{
    public static User userdata;
     @isTest static void testmethodbatch(){
    Test.startTest();
     AP_Tour_Plan__c a1 = new AP_Tour_Plan__c();
      insert a1;
       target__c tc=new target__C(No_of_Visits_Actual_Project__c=7);
       
      
       insert tc;
         system.debug('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'+tc.No_of_Visits_Actual_Project__c);
         AP_Site_Visit__c visit1= new AP_Site_Visit__c(AP_Tour_Plan__c=a1.id,target__c=tc.id,Party_type__C='farmer' );
     
       insert visit1;
      userdata= Initial_Test_Data.createUser('test111','test','BD');
       userdata.EmployeeNumber='123';
       userdata.id=a1.ownerid;
       insert userdata;
       
          Map<id, AP_Site_Visit__c> visitmap= new Map<id, AP_Site_Visit__c>();
          visitmap.put(userdata.id,visit1);
         visitmap.get(userdata.id);
    

          NoOfProjectVisitRollUp_Batch obj = new NoOfProjectVisitRollUp_Batch ();
            DataBase.executebatch(obj); 
            
        
        
     
     NoOfProjectVisitRollUp_scheduler abc = new NoOfProjectVisitRollUp_scheduler ();
      String sch = '0 0 10 1/1 * ? *'; //schedule interval time
        system.schedule('ProjectVisitWarningmail',sch , abc); //system method to schedule apex class
        
         Test.stopTest();

  }
}