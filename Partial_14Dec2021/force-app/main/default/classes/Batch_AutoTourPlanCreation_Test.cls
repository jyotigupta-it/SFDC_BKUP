@isTest
public class Batch_AutoTourPlanCreation_Test {
    @isTest
    Public static void TestBatchMethod() {
        User userObj =[select id,Name from User Limit 1];
        List<Beat_Master__c> beatList = new List<Beat_Master__c>();
        Beat_Master__c beatObj = new Beat_Master__c(Name='Test Class Record',Beat_Frequency__c='Monday Week1;Monday Week2',OwnerId=userObj.id);
        beatList.add(beatObj);
        INSERT beatList;
        Target__c tergetObj = new Target__c(Start_Date__c=date.newInstance(2021,12,1),End_Date__c=date.newInstance(2021,12,31),Approval_Status__c='Not Submitted',Vertical__c='Column',State__c='Karnataka',OwnerId=userObj.id);
        INSERT tergetObj;
        Batch_AutoTourPlanCreation TargBatch = new Batch_AutoTourPlanCreation(null,'');
        Database.executeBatch(TargBatch,1);
    }
}