@RestResource(urlMapping='/createCase/*')
global with sharing class CreateCaseRestResource {
    @HttpPost
    global static void doPost() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String body = req.requestBody.toString();

        try {
            Case newCase = (Case) JSON.deserialize(body, Case.class);
            insert as user newCase;

            res.statusCode = 201;
            res.responseBody = Blob.valueOf('{"caseId" : ' + newCase.Id + '}');
        } catch (Exception e) {
            res.statusCode = 404;
            res.responseBody = Blob.valueOf('Something went wrong...' + ' ' + e.getMessage());
        }
    }
}
