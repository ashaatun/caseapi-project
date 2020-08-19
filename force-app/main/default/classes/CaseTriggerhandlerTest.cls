@isTest
public class CaseTriggerhandlerTest {
    @testSetUp
    private static void setUp(){
        Case c = new case(status='New');
        insert c ;
    }
    
     @isTest
    public static void testCaseUpdate() {
        Test.setMock(HttpCalloutMock.class, new CaseClosedMockResponse());
        case c = [Select id, status from case limit 1];
        c.status = 'Closed';
        Test.startTest();
        update c;
        Test.stopTest();
        case cs = [Select Secret_Key__c from case limit 1];
        system.assertEquals('secret key', cs.Secret_Key__c);
    }

}