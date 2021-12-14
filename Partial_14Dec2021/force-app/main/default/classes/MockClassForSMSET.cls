@isTest(SeeAllData=true)
global class MockClassForSMSET implements HttpCalloutMock {
  global HttpResponse respond(HTTPRequest req){
       //Http h = new Http();
       HttpResponse res =new HttpResponse(); //h.send(req)
        res.setStatus('OK');
        res.setStatusCode(200);
       
        res.setBody('{"status":"OK","data":{"group_id":4253206015,"0":{"id":"4253206015-1","customid":"","customid1":"","customid2":"","mobile":"9482488066","status":"AWAITED-DLR"}},"message":"Campaign of 1 numbers Submitted successfully."}');
        return res;
    }
}