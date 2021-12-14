/** Company - Epeople Bespoke Consulting Private Limited.
     Description -Test Class for SetPrimaryContact
     Created By  -Prabha.K 20/02/2014
     Modified By  -Prabha.K 21/02/2014
**/
@isTest
public class TestCreateTourplan
{
static testmethod void TestgetTour()
{
Test.StartTest();
Tour_Program__c tp1=new Tour_Program__c();

tp1.From_Date__c=Date.newInstance(2014 , 10 ,01);
tp1.To_Date__c=Date.newInstance(2014 , 10 ,15);
insert tp1;
 Tour_Plan1__c top=new Tour_Plan1__c(Name='test12', Tour_Program__c=tp1.id,Date__c=System.Today(),State__c='TamilNadu',District__c='Tirunelveli',Location__c='local');
   insert top;

Test.StopTest();
}
}