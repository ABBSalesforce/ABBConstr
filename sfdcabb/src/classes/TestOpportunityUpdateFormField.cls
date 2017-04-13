@isTest(seeAllData = true)
private class TestOpportunityUpdateFormField {

        static testMethod void TestOpportunityUpdateField() {
    
        Zip_Code__c zipRec = new Zip_Code__c(name = '33141',Opp_System__c = 'Miami, FL', PriceBook_Name__c = 'Miami',
                                              Service_Type__c = 'D3',City__c = 'MIAMI BEACH',State__c = 'FL',System__c = 'Miami');
        insert zipRec;
        
        Account acc = new Account(name='TestAcc',BillingPostalCode= zipRec.Name,CSG_Account__c='8783200012135622');
        insert acc;
        
        Pricebook2  standardPb = [SELECT id, name, isActive FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
        
        Pricebook2 customPb;
        List<Pricebook2> customPbList = [SELECT id, name, isActive FROM Pricebook2 WHERE Name = 'Miami Price Book' LIMIT 1];
        if(customPbList.isEmpty()) {
            customPb = new Pricebook2 (Name='Miami Price Book', Description='Test Pricebook Entry 1', isActive=true);
            insert customPb;
        }else {
            customPb = customPbList[0];
        }
        
        Product2 prod1 = new Product2 (Name='Test Product1', Description='Test Product1', productCode = 'ABC',isActive = true);
        insert prod1;
        
        PricebookEntry pbe1 = new PricebookEntry (Product2ID=prod1.id, Pricebook2ID=standardPb.id, UnitPrice=50,isActive=true);
        insert pbe1;
        
        PricebookEntry pbe2 = new PricebookEntry(Product2ID=prod1.id,Pricebook2ID=customPb.id,UnitPrice=50,isActive=true); 
        insert pbe2;
        
        Opportunity oppTest = new Opportunity (Name='TestOpp1', StageName='Closed Won', CloseDate=Date.today(), 
                                               AccountId=acc.id,CSG_Account__c='8783200012135622');
        insert oppTest;
        
        
        OpportunityLineItem opplineItem1 = new OpportunityLineItem (OpportunityID=oppTest.id, PriceBookEntryID=pbe2.id,
                                                                     quantity=4, TotalPrice=200);
        insert opplineItem1;
        PricebookEntry str1 = [SELECT id,Pricebook2Id FROM PricebookEntry WHERE id=:opplineItem1.PriceBookEntryID];
        Opportunity str2 = [SELECT id,Pricebook2Id FROM Opportunity WHERE id=:oppTest.id];
        System.debug('==str1'+str1);
        System.debug('==str2'+str2);
        //System.assertNotEquals(str1.Pricebook2Id,str2.Pricebook2Id);
        
        }
}