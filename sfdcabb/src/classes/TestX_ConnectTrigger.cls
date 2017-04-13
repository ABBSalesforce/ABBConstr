@isTest
private class TestX_ConnectTrigger{
    
    static testmethod void validateXConnects(){
        
        Opportunity testOpp = new Opportunity(Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(),CSG_Account__c='8783200012135622');
        insert testOpp;
        
        PQ__c testPQ = new PQ__c(Opportunity__c = testOpp.id, Service_Provider__c = 'test',LOA_Complete__c=true);
        insert testPQ;
        
        X_Connect__c testXc = new X_Connect__c(Name='testXc', PQ__c = testPQ.id);
        insert testXc;
        
        delete testXc;                                      
    }
}