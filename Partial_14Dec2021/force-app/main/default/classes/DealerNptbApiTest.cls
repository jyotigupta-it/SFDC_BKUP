@isTest
private class DealerNptbApiTest {
    /*@isTest static void testCallout() {
test.startTest();

Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorNPTB()); 

//HttpResponse res = DealerNptbApi2.invoke();

DealerNptbApiBatch obj = new DealerNptbApiBatch();
DataBase.executeBatch(obj);

test.stopTest();

}*/
    
    @isTest static void testCallout() {
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorNPTB()); 
        
        String CRON_EXP = '0 0 0 28 2 ? 2022';
        String jobId = System.schedule('Schedule Nptb',
                                       CRON_EXP,
                                       new ScheduleNptbBatch());
        
        test.stopTest();
        
    }
}