@isTest
public class TestRejectionReasonPicklist {
    Static testMethod void rejectionReasonPicklist(){
        Meeting_Atendee__c testMA = new Meeting_Atendee__c();        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/rejection-reason-picklist/';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        RestContext.request = req;
        RestContext.response = res;
        Map<String, List<String>> rejectionReasonList = RejectionReasonPickList.getAddress();
        System.debug(rejectionReasonList);
        System.assertEquals(rejectionReasonList.isEmpty(), false);
    }

}