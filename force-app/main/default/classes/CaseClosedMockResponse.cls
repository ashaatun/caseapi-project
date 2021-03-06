@isTest
Global class CaseClosedMockResponse implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
        
        System.assertEquals('https://nfapihub.herokuapp.com', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"success":true,"secretKey":"secret key"}');
        res.setStatusCode(200);
        return res;
    }
}