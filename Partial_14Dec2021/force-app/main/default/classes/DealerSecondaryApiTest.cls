@isTest // to open up data access to records in your organization.
private class DealerSecondaryApiTest {
    /*@isTest static void testCallout() {
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorSecondary()); 
        
        //HttpResponse res = DealerSecondaryApi.invoke();
        
        DealerSecondaryApiBatch obj = new DealerSecondaryApiBatch();
        DataBase.executeBatch(obj);
        
        test.stopTest();
        
    }*/
    
    @isTest static void testCallout() {
        test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorSecondary()); 
        
        String CRON_EXP = '0 0 0 28 2 ? 2022';
        String jobId = System.schedule('Schedule Secondary',
                                       CRON_EXP,
                                       new ScheduleSecondaryBatch());
        
        test.stopTest();
        
    }
}