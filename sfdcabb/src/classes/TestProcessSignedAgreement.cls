@isTest
private class TestProcessSignedAgreement{
    static testmethod void validateAgreements(){
        
         Opportunity testOpp = new Opportunity(Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(),CSG_Account__c='8783200012135622');
        insert testOpp;
         
         echosign_dev1__SIGN_Agreement__c testAgree = new   echosign_dev1__SIGN_Agreement__c();
         testAgree.echosign_dev1__Status__c ='Out for Signature';
         testAgree.echosign_dev1__Opportunity__c = testOpp.id;
         testAgree.Name = 'Site Survey for ';
         Insert testAgree;
                       
    }
}