@isTest
private class TestMultipleDLsTrigger{
    static testmethod void validateMDLs(){
        Opportunity testOpp = new Opportunity(Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(),CSG_Account__c='8783200012135622');
        insert testOpp;
        
        PQ__c testPQ = new PQ__c(Opportunity__c = testOpp.id, Service_Provider__c = 'test',Multiple_DLs_Complete__c =true);
        insert testPQ;
        
        MultipleDL__c testMDL = new MultipleDL__c(PQ_Lookup__c = testPQ.id);
        insert testMDL;
        
        delete testMDL;
    }
}