@isTest (SeeAllData = true)
public class TestNewcarrier {
    Public static testmethod void validatepric(){
	
	Zip_Code__c zipRec = new Zip_Code__c(name = '33141',Opp_System__c = 'Miami, FL', PriceBook_Name__c = 'Miami',
                                              Service_Type__c = 'D3',City__c = 'MIAMI BEACH',State__c = 'FL',System__c = 'Miami');
        insert zipRec;
		
    Id pbID = null;

    pbID = [Select Name, Description From Pricebook2 where Name = 'Carrier Channel'].Id;
    List<RecordType> recordtypId =  [Select SobjectType, Name, Id, DeveloperName From RecordType  Where SobjectType = 'Opportunity' And  Name = 'p) Carrier Channel'];
    Account acc = new Account(name='TestAcc',BillingPostalCode= zipRec.Name);
        insert acc;
		
		Pricebook2  standardPb = [SELECT id, name, isActive FROM Pricebook2 WHERE IsStandard = true LIMIT 1];
        
        Pricebook2 customPb;
        List<Pricebook2> customPbList = [SELECT id, name, isActive FROM Pricebook2 WHERE Name = 'Carrier Channel' LIMIT 1];
        if(customPbList.isEmpty()) {
            customPb = new Pricebook2 (Name='Carrier Channel', Description='Test Pricebook Entry 1', isActive=true);
            insert customPb;
        }else {
            customPb = customPbList[0];
        }

Opportunity objOpp = new Opportunity(Name = 'newTest',recordtypeId=recordtypId[0].Id,AccountId = acc.Id,StageName ='Prospecting',CloseDate=Date.today());
        objOpp.Pricebook2Id=pbID;       
insert objOpp;

Opportunity objUOppt = new opportunity(Id =objOpp.Id );
update objUOppt ;

}
}