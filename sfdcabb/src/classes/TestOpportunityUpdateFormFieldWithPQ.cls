@isTest(seeallData=true)
private class TestOpportunityUpdateFormFieldWithPQ{
    static testmethod void validateTrgg(){
        
        List<RecordType> recTest = [SELECT id,DeveloperName FROM RecordType WHERE DeveloperName = 'Vid_HSD_Phone' LIMIT 1];
        Opportunity testOpp = new Opportunity(Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(),
                                              recordtypeId = recTest[0].id,CSG_Account__c='8783200012135622');
        insert testOpp;
        
        PQ__c testPQ = new PQ__c(Opportunity__c = testOpp.id,isHosted1__c=false,Multiple_DL__c=true,Tollfree_Number__c=true,
                                 Telephone_System__c=true,Contractor_Required__c=true,External_Integrator__c='TestIntegrator',
                                 External_Integrator_TN__c='1234567892');
        insert testPQ;
        
        PQ__C testPQtoUpdate = new PQ__c(id=testPQ.id,X_Connect_Complete__c= true, LOA_Complete__c= true,
                                         Toll_Free_Complete__c= true, Multiple_DLs_Complete__c= true);
        update testPQtoUpdate;
    }
}