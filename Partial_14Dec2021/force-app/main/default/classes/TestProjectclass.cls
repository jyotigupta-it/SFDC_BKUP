@isTest
public class TestProjectclass 
{
     Static TestMethod Void TestProject()
     {
     Test.StartTest();
     Account a=new Account();
     a.Name='test Project';
     a.Contact_Number_Mobile__c = '7891234560';
     insert a;
     Order__c o=new Order__c();
     o.Projects__c=a.Id;
     insert o;
     PageReference pageRef = Page.Projectsformat;
              Test.setCurrentPage(pageRef);
              pageRef.setredirect(true);
              pageRef .getParameters().put('id',a.id);
              
            ProjectClass t= new ProjectClass (new ApexPages.StandardController(a));
     Test.StopTest();
     }
     }