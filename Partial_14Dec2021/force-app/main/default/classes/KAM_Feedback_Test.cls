@isTest
public class KAM_Feedback_Test {
    
    static testMethod void testKAM_feedback()
    {            
      Account ac=new Account();
      ac.Name='Bangalore TRADERS';
      ac.State__c='Karnataka';
      ac.Mobile_No_Status__c='Invalid';
      ac.Contact_Number_Mobile__c='9876543210';
      insert ac;
     
      KAM_Feedback_Master__c kfm1=new KAM_Feedback_Master__c();
      kfm1.Name='KAM Feedback Master Test ';
      kfm1.Active__c=true;
      kfm1.Applicable_State__c='Karnataka';
      kfm1.Checkbox__c = True;
      insert kfm1;       
     
      KAM_Feedback_Master_Line_Item__c kfmli1=new KAM_Feedback_Master_Line_Item__c();
      kfmli1.KAM_Feedback_Master__c=kfm1.Id;
      kfmli1.Display_Order__c=1;
      kfmli1.Answer__c='test Answer';
      kfmli1.Question__c='How is Post sales support?';
      insert kfmli1;
         
      KAM_Feedback__c kf10=new KAM_Feedback__c();
      kf10.Name='Feedback Class';
      kf10.Account__c=ac.Id;
      kf10.Status__c='Feedback Given';
      kf10.Date__c=System.Today();
      kf10.KAM_Feedback_Master__c = kfm1.id;
      insert kf10;  
      
      KAM_Feedback_Line_Item__c kfli1=new KAM_Feedback_Line_Item__c();
      kfli1.KAM_Feedback__c=kf10.Id;
      kfli1.Display_Order__c=kfmli1.Display_Order__c;
      kfli1.Answer__c=kfmli1.Answer__c;
      kfli1.Question__c=kfmli1.Question__c;
      
      insert kfli1;      
        
      PageReference pageRef = Page.KAMFeedback;
      Test.setCurrentPage(pageRef);
      pageRef.setredirect(true);
      pageRef.getParameters().put('id',ac.Id);
      Test.startTest();       
      KAM_feedback kfdb = new KAM_feedback(new ApexPages.StandardController(ac));
       
        kfdb.kf.Status__c='Feedback Given';
        kfdb.Next();
        kfdb.kf.Status__c='';
        kfdb.Next();
        kfdb.Add();
        kfdb.Saveall();
        kfdb.Cancel();
        Test.StopTest();   
    }
}