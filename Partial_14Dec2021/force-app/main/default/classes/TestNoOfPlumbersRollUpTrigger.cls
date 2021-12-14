@isTest
Public Class TestNoOfPlumbersRollUpTrigger
{
    Static TestMethod Void NoOfPlumbersRollUp()
    {
        Test.StartTest();
         Distributor_Dealer__c disti=new Distributor_Dealer__c();
         
         disti.name='Tesrere';
         disti.No_of_Mechanics__c=0;
         disti.No_of_Plumbers__c=0;
         insert disti;
            
        Contacts__c con =new Contacts__c();
         con.Name='Test';
         con.Type__c='Plumber';
         con.State__c='Karnataka';
         con.Mobile__c='9898989899';
         con.Visit_Type__c='Out Station';
         con.Distributor__c=disti.id;
         insert con;
         
         Distributor_Dealer__c disti1=new Distributor_Dealer__c();
         
         disti1.name='Tesrere';
         disti1.No_of_Mechanics__c=0;
         disti1.No_of_Plumbers__c=1;
         insert disti1;
         update disti;
         
          Contacts__c con1 =new Contacts__c();
         con1.Name='Test';
         con1.Type__c='Plumber';
         con1.State__c='Karnataka';
         con1.Mobile__c='9898989899';
         con1.Visit_Type__c='Out Station';
         con1.Distributor__c=disti1.id;
         insert con1;
         update disti1;
          delete con1;  
        Test.StopTest();
    }
}