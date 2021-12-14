@isTest(SeeAllData=False)
public class Test_TriggerTopopluateOrderValue {
Public static TestMethod void test1(){

RecordType recrd=[Select Id,RecordType.Name From RecordType  Where SobjectType = 'Task' And RecordType.Name='Normal' limit 1];
//Task tasklist1=[Select WhatId ,RecordType.Name From Task where RecordType.Name='Normal'  AND What.type='Enquiry__c' limit 1];
System.debug('recrd'+recrd);
Enquiry__c acc =new Enquiry__c ();
acc.Name='test1';
insert acc;
Task tasklist=new Task();

tasklist.OwnerId=UserInfo.getUserId();//'00530000007uDS6AAM';
tasklist.ActivityDate=Date.Today();

tasklist.RecordTypeId=recrd.Id;//'01230000001DIvX';
tasklist.WhatId= acc.Id;//'a014C000000dJVmQAM';
tasklist.Order_value__c=123;
System.debug(tasklist);


Target__c newTarget =new Target__c();
newTarget.OwnerId=UserInfo.getUserId();//'00530000007uDS6AAM';
newTarget.End_Date__c=Date.Today();
newTarget.End_Date__c.addDays(37);
newTarget.Order_value_from_task__c =6;



tasklist.OwnerId = UserInfo.getUserId();
/*
  update tasklist;
List<Task>tsk=new List<Task>();
    tsk.add(tasklist);
*/
insert newTarget ;
    insert tasklist;
system.debug('Target'+newTarget );
system.debug('Task'+tasklist);
test.startTest();
try{
//Trigger_ToPopulateOrderValueFromTask.PopulateOrderValue(tsk);

}
catch(Exception exs){
System.debug(exs.getMessage());
}
test.StopTest();
}
}