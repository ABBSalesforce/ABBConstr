@isTest(seeAllData=true)
private class TestUpdateFieldWithZipCode{
    static testmethod void validateUpdateFieldWithZipCode(){
    
        Zip_Code__c zipRec = new Zip_Code__c(name = '15901',Opp_System__c ='Johnstown, PA', PriceBook_Name__c ='WPA-D3',
                                              Service_Type__c = 'D3',City__c ='JOHNSTOWN', State__c ='PA', System__c = 'WPA');
        insert zipRec;
        Account testacc = new Account(name='TestAcc',BillingPostalCode= zipRec.Name);
        insert testacc;
       
        Opportunity testOpp = new Opportunity(name='TestOpp',accountid=testacc.id,StageName='Closed Won', CloseDate=Date.today());
        insert testOpp;
       
        
        Zip_Code__c zipRec1 = new Zip_Code__c(name = '33141',Opp_System__c = 'Miami, FL', PriceBook_Name__c = 'Miami',
                                              Service_Type__c = 'D3',City__c = 'MIAMI BEACH',State__c = 'FL',System__c = 'Miami');
        insert zipRec1;
        
        Account testacctoUpdate = [SELECT id,BillingPostalCode FROM Account WHERE id=: testacc.id LIMIT 1];
        testacctoUpdate.BillingPostalCode= zipRec1.Name;
        update testacctoUpdate;
        
        
             
    }
}