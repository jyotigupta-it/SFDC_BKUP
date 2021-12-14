@isTest
Public Class Testfeedback
{
Static testMethod void testfeedback()
      {
     
      Account a5=new Account();
      a5.Name='Test Feedback Class';
      a5.State__c='Tamil Nadu';
      a5.Mobile_No_Status__c='Invalid';
      a5.Contact_Number_Mobile__c='9874563218';
      insert a5;
     
      Feedback_Master__c fm1=new Feedback_Master__c();
      fm1.Name='Feedback Master Test 1';
      fm1.Active__c=true;
      fm1.Applicable_State__c='Tamil Nadu';
      fm1.Checkbox__c = True;
      insert fm1; 
      
     
      Feedback_Master_Line_Item__c fmli1=new Feedback_Master_Line_Item__c();
      fmli1.Feedback_Master__c=fm1.Id;
      fmli1.Display_Order__c=1;
      fmli1.Answer__c='test Answer';
      fmli1.Question__c='How is Post sales support?';
      insert fmli1;
      
      
      
      Feedback__c f10=new Feedback__c();
      f10.Name='Feedback Class';
      f10.Account__c=a5.Id;
      f10.Status__c='Feedback Given';
      f10.Date__c=System.Today();
      f10.Feedback_Master__c = fm1.id;
      insert f10;
      
    
      
      Feedback_Line_Item__c fli1=new Feedback_Line_Item__c();
      fli1.Feedback__c=f10.Id;
      fli1.Display_Order__c=fmli1.Display_Order__c;
      fli1.Answer__c=fmli1.Answer__c;
      fli1.Question__c=fmli1.Question__c;
      insert fli1;
       
        
         PageReference pageRef = Page.Feedback;
         Test.setCurrentPage(pageRef);
         pageRef.setredirect(true);
         pageRef.getParameters().put('id',a5.Id);
    
        
        feedback fdb = new feedback(new ApexPages.StandardController(a5));
       
        fdb.f.Status__c='Feedback Given';
        fdb.Next();
        fdb.f.Status__c='';
        fdb.Next();
        fdb.Add();
        fdb.Saveall();
        fdb.Cancel();
   
        
      }
      }