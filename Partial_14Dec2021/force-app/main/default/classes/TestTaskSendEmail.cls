@isTest (seeAllData=true)
public class TestTaskSendEmail {

static testMethod void myUnitTest(){


Test.startTest();

Task testTask = new Task ();
testTask.OwnerId='00530000009VMM3';
testTask.Type='Email';
testTask.Subject='Test';
testTask.ActivityDate=system.Today();
testTask.Priority='Normal';
testTask.Status='Not Started';
//testTask.RecordTypeId = '012S00000004f2e';
insert testTask;

testTask.Status ='Completed';
testTask.BD_Comments__c='Donee';
update testTask;

System.assertEquals (testTask.Status,'Completed');
Test.stopTest();

}
}