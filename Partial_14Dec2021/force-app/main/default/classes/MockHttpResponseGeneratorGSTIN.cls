@isTest
global class MockHttpResponseGeneratorGSTIN implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://www.knowyourgst.com/developers/gstincall/?gstin=101010000000000', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{ "status": "Active", "business": "test", "status_code": 1, "trade-name": "INDIAN RAILWAYS", "registration-date": "2017-07-02", "entity-type": "Government Department", "gstin": "32AAAGM0289C1ZS", "legal-name": "Ministry of Railways", "adress": { "lg": "", "bname": "", "street": "Thycaud", "bno": "Office of the Divl.Raly.Manager", "location": "Trivandrum", "lt": "", "floor": "2nd Floor", "city": "Thiruvananthapuram", "state": "Kerala", "pincode": "695014" }, "pan": "12123", "dealer-type": "Regular" }');
        res.setStatusCode(200);
        return res;
    }
}