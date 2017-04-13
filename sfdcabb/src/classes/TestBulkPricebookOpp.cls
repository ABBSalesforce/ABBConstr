@isTest (SeeAllData = true)
public class TestBulkPricebookOpp {
    Public static testmethod void validatepric(){
    Id pbID = null;

    pbID = [Select Name, Description From Pricebook2 where Name = 'Bulk Price Book'].Id;
    List<RecordType> recordtypId =  [Select SobjectType, Name, Id, DeveloperName From RecordType  Where SobjectType = 'Opportunity' And  Name = 'k) Bulk Services'];
Account obj = new Account( Name = 'Test', BillingPostalCode='33141');
insert obj;

Opportunity objOpp = new Opportunity(Name = 'newTest',recordtypeId=recordtypId[0].Id,AccountId = obj.Id,StageName ='Prospecting',CloseDate=Date.today());
        objOpp.Pricebook2Id=pbID;       
insert objOpp;

Opportunity objUOppt = new opportunity(Id =objOpp.Id );
update objUOppt ;

}
}