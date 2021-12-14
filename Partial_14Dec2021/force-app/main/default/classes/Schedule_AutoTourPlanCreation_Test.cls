@isTest
public class Schedule_AutoTourPlanCreation_Test{
     @isTest
    public static void method1(){
        Test.StartTest();
        Schedule_AutoTourPlanCreation sct= new Schedule_AutoTourPlanCreation();      
        String sct1 = '0 0 23 * * ?';
        System.schedule('Test',sct1,sct);
        Test.stopTest();
    }
}