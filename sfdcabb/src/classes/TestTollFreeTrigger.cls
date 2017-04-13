@isTest
private class TestTollFreeTrigger{
    static testmethod void validateLOA(){
         Opportunity testOpp = new Opportunity(Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(),CSG_Account__c='8783200012135622');
        insert testOpp;
        
        PQ__c testPQ = new PQ__c(Opportunity__c = testOpp.id, Service_Provider__c = 'test', Toll_Free_Complete__c=true);
        insert testPQ;
        
        Tollfree__c testTF = new Tollfree__c(Name='testTF', PQ__c = testPQ.id);
        insert testTF;
        
        delete testTF;     
    }
}