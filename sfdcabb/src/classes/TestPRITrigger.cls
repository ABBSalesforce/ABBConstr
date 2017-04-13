@isTest
private class TestPRITrigger{
    static testmethod void validatePRIs(){
        List<RecordType> recTest = [SELECT id,DeveloperName FROM RecordType WHERE DeveloperName='PRI_Service' LIMIT 1];
        Opportunity testOpp = new Opportunity(Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(),
                                              recordtypeId = recTest[0].id,CSG_Account__c='8783200012135622');
        insert testOpp;
                       
        PRI__c testPRI = new PRI__c(Name='testPRI',Opportunity__c=testOpp.id);
        insert testPRI;
        
        delete testPRI; 
    }
}