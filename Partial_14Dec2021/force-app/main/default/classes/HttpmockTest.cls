@isTest
public class HttpmockTest{
static testMethod void test_1 () {
        Test.startTest();
        //Test.setMock(HttpCalloutMock.class, new HttpCalloutRequestClass());
        Map<String,String> headerMap = new Map<String, String>();
        headerMap.put('Content-Type', 'application/json');
    	HttpResponse res = HttpCalloutRequestClass.httpRequest('POST', 
                                  'http://dummy.restapiexample.com/api/v1/create',headerMap,
                                   'qwerty',120); 
        Test.stopTest();
        //System.assertEquals(200, res.getStatusCode());   
    }
}