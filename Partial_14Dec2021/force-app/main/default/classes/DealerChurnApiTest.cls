@isTest
private class DealerChurnApiTest {
    /*static testMethod void testCallout() {  
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorChurn()); 
        
        //HttpResponse res = DealerChurnAPI.invoke();
        
        DealerChurnAPIBatch obj = new DealerChurnAPIBatch();
        DataBase.executeBatch(obj);
        
        test.stopTest();
    }*/
    
    @isTest static void testCallout() {
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorChurn()); 
        
        String CRON_EXP = '0 0 0 28 2 ? 2022';
        String jobId = System.schedule('Schedule Churn',
                                       CRON_EXP,
                                       new ScheduleChurnBatch());
        
        test.stopTest();
        
    }
}