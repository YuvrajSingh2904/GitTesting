public class ApexRestCalloutDemo {
    public static void getUserFromExternalSys(){
        HTTP httpObj = new HTTP();
        HTTPRequest req = new HTTPRequest();
        
        req.setEndpoint('https://reqres.in/api/users');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('GET');
        //req.setBody('');
        
        HTTPResponse res = new HTTPResponse();
        res = httpObj.send(req);
        
        System.debug('@@@@Response Body --> ' + res.getBody());
    }
}