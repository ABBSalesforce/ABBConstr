@isTest (SeeAllData = true)
public class TestcarrierPricebookOpp {
    Public static testmethod void validatepric(){
    Id pbID = null;

    pbID = [Select Name, Description From Pricebook2 where Name = 'Carrier Channel'].Id;
    List<RecordType> recordtypId =  [Select SobjectType, Name, Id, DeveloperName From RecordType  Where SobjectType = 'Opportunity' And  Name = 'p) Carrier Channel'];
Account obj = new Account( Name = 'Test123', BillingPostalCode='21666');
insert obj;

Opportunity objOpp = new Opportunity(Name = 'newTest',recordtypeId=recordtypId[0].Id,AccountId = obj.Id,StageName ='Prospecting',CloseDate=Date.today());
        objOpp.Pricebook2Id=pbID;       
insert objOpp;

Opportunity objUOppt = new opportunity(Id =objOpp.Id );
update objUOppt ;

}
}